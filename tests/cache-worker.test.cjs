const {test} = require('node:test');
const assert = require('node:assert/strict');
const vm = require('node:vm');
const fs = require('node:fs');
const crypto = require('node:crypto');

const code = fs.readFileSync('WebHost/cache-worker.js', 'utf8');
const path = 'StreamingAssets/VehicleBundles/vehicle-test';
const origin = 'https://example.test/garage/';
const bytes = Buffer.alloc(8 * 1024 * 1024 + 97);
for (let i = 0; i < bytes.length; i++) bytes[i] = i % 251;

function fixture({data = bytes, storage = new Map(), corrupt = false, denied = false} = {}) {
  const handlers = {}; let requests = 0;
  const entry = {bytes: data.length, sha256: crypto.createHash('sha256').update(data).digest('hex')};
  const cache = {
    match: async key => storage.get(typeof key === 'string' ? key : key.url)?.clone(),
    put: async (key, response) => storage.set(key, new Response(await response.arrayBuffer(), {headers: response.headers})),
    keys: async () => [...storage.keys()].map(key => new Request(key)),
    delete: async key => storage.delete(key.url)
  };
  const context = {
    self: {location: {href: origin + 'cache-worker.js'},
      addEventListener: (name, handler) => handlers[name] = handler,
      skipWaiting: async () => {}, clients: {claim: async () => {}}},
    URL, Headers, Request, Response, Uint8Array, ArrayBuffer, Map, Promise,
    crypto: crypto.webcrypto,
    caches: {open: async () => {if (denied) throw new Error('Storage denied'); return cache;}},
    fetch: async (url, options = {}) => {
      if (String(url).includes('asset-index.json')) return Response.json({assets: {[path]: entry}, models: []});
      requests++;
      const match = options.headers?.Range?.match(/bytes=(\d+)-(\d+)/);
      const part = match ? Buffer.from(data.subarray(Number(match[1]), Number(match[2]) + 1)) : Buffer.from(data);
      if (corrupt) part[0] ^= 1;
      return new Response(part, {status: match ? 206 : 200, headers: {'Content-Type': 'application/octet-stream'}});
    }
  };
  vm.runInNewContext(code, context);
  return {
    requests: () => requests, storage,
    get: async () => {
      let result;
      handlers.fetch({request: new Request(origin + path), respondWith: value => result = value});
      return result;
    }
  };
}

test('range assembly is byte-exact and the next request performs no asset transfer', async () => {
  const f = fixture(); const response = await f.get();
  assert.deepEqual(Buffer.from(await response.arrayBuffer()), bytes);
  assert.equal(f.requests(), 3);
  const cached = await f.get();
  assert.equal(cached.headers.get('X-Deepal-Cache'), 'hit');
  assert.deepEqual(Buffer.from(await cached.arrayBuffer()), bytes);
  assert.equal(f.requests(), 3);
});

test('new resource digest invalidates the old entry without deleting other resources', async () => {
  const storage = new Map(); const before = fixture({storage}); await (await before.get()).arrayBuffer();
  const changed = Buffer.from(bytes); changed[42] ^= 1;
  const after = fixture({storage, data: changed});
  assert.deepEqual(Buffer.from(await (await after.get()).arrayBuffer()), changed);
  assert.equal(after.requests(), 3); assert.equal(storage.size, 2);
});

test('a damaged range is rejected and is never written to persistent cache', async () => {
  const f = fixture({corrupt: true});
  await assert.rejects(f.get(), /checksum mismatch/);
  assert.equal(f.storage.size, 0);
});

test('denied browser storage still returns the original resource bytes', async () => {
  const f = fixture({denied: true});
  assert.deepEqual(Buffer.from(await (await f.get()).arrayBuffer()), bytes);
});
