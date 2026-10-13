// Only public static resources in this project's manifest are cached.
const root = new URL('./', self.location.href);
const CACHE = 'deepal-static-assets-v1:' + root.pathname;
const LIMIT = 160 * 1024 * 1024;
const CHUNK = 4 * 1024 * 1024;
const pending = new Map();
let manifestPromise;

self.addEventListener('install', () => self.skipWaiting());
self.addEventListener('activate', event => event.waitUntil(self.clients.claim()));

function manifest() {
  if (!manifestPromise) manifestPromise = fetch(new URL('asset-index.json', root), {cache: 'no-store'})
    .then(response => { if (!response.ok) throw new Error('Resource index unavailable'); return response.json(); })
    .catch(error => { manifestPromise = null; throw error; });
  return manifestPromise;
}

async function requestBytes(url, start, end) {
  let error;
  for (let attempt = 0; attempt < 3; attempt++) {
    try {
      const headers = start === undefined ? {} : {Range: `bytes=${start}-${end}`};
      const response = await fetch(url, {headers, cache: 'no-cache'});
      if (!response.ok) throw new Error(`Resource HTTP ${response.status}`);
      const bytes = await response.arrayBuffer();
      if (response.status === 206 && bytes.byteLength !== end - start + 1) throw new Error('Incomplete range');
      return {bytes, status: response.status, headers: response.headers};
    } catch (failure) { error = failure; }
  }
  throw error;
}

async function download(url, entry) {
  const first = await requestBytes(url, entry.bytes > CHUNK ? 0 : undefined, Math.min(CHUNK, entry.bytes) - 1);
  let bytes = first.bytes;
  if (first.status === 206) {
    bytes = new ArrayBuffer(entry.bytes);
    const output = new Uint8Array(bytes); output.set(new Uint8Array(first.bytes));
    let offset = CHUNK;
    async function worker() {
      while (offset < entry.bytes) {
        const start = offset; offset += CHUNK;
        const part = await requestBytes(url, start, Math.min(start + CHUNK, entry.bytes) - 1);
        if (part.status !== 206) throw new Error('Inconsistent range response');
        output.set(new Uint8Array(part.bytes), start);
      }
    }
    await Promise.all([worker(), worker()]);
  }
  if (bytes.byteLength !== entry.bytes) throw new Error('Resource size mismatch');
  const digest = [...new Uint8Array(await crypto.subtle.digest('SHA-256', bytes))]
    .map(value => value.toString(16).padStart(2, '0')).join('');
  if (digest !== entry.sha256) throw new Error('Resource checksum mismatch');
  return new Response(bytes, {headers: {
    'Content-Type': first.headers.get('Content-Type') || 'application/octet-stream',
    'Content-Length': String(entry.bytes), 'X-Deepal-Bytes': String(entry.bytes), 'X-Deepal-Cache': 'miss'
  }});
}

async function prune(cache) {
  const keys = await cache.keys(); let total = 0;
  const rows = await Promise.all(keys.map(async key => {
    const response = await cache.match(key);
    const bytes = Number(response?.headers.get('X-Deepal-Bytes') || 0);
    total += bytes; return {key, bytes};
  }));
  // Keep the small engine/bootstrap working set ahead of old vehicle bundles.
  rows.sort((a, b) => Number(!a.key.url.includes('/VehicleBundles/')) - Number(!b.key.url.includes('/VehicleBundles/')));
  for (const row of rows) {
    if (total <= LIMIT) break;
    await cache.delete(row.key); total -= row.bytes;
  }
}

async function resource(path, entry) {
  const url = new URL(path, root); url.searchParams.set('v', entry.sha256);
  const key = url.href;
  let cache;
  try {
    cache = await caches.open(CACHE);
    const hit = await cache.match(key);
    if (hit) {
      const headers = new Headers(hit.headers); headers.set('X-Deepal-Cache', 'hit');
      return new Response(hit.body, {headers});
    }
  } catch (_) { /* Storage restrictions must not prevent rendering. */ }
  if (!pending.has(key)) pending.set(key, (async () => {
    const response = await download(url, entry);
    if (cache) try { await cache.put(key, response.clone()); await prune(cache); } catch (_) {}
    return response;
  })().finally(() => pending.delete(key)));
  return (await pending.get(key)).clone();
}

self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);
  if (event.request.method !== 'GET' || url.origin !== root.origin || !url.pathname.startsWith(root.pathname)) return;
  const path = url.pathname.slice(root.pathname.length);
  if (!path.startsWith('Build/') && !path.startsWith('StreamingAssets/VehicleBundles/') && !path.startsWith('Icons/') && path !== 'vehicles.json') return;
  event.respondWith((async () => {
    let index;
    try { index = await manifest(); } catch (_) { return fetch(event.request); }
    const entry = index.assets[path];
    return entry ? resource(path, entry) : fetch(event.request);
  })());
});

self.addEventListener('message', event => {
  if (event.data?.type !== 'prefetch-model') return;
  event.waitUntil((async () => {
    const index = await manifest();
    const model = index.models.find(item => item.id === event.data.id);
    if (!model) return;
    const paths = [`StreamingAssets/VehicleBundles/${model.environment}`, `StreamingAssets/VehicleBundles/vehicle-${model.id}`];
    await Promise.all(paths.map(path => resource(path, index.assets[path]).then(response => response.arrayBuffer())));
  })().catch(() => {}));
});
