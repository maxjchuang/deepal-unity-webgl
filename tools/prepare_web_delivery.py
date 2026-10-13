"""Generate compressed, small static chunks for browser-side Unity startup."""
import argparse
import gzip
import json
import pathlib
import hashlib

parser = argparse.ArgumentParser()
parser.add_argument('--directory', type=pathlib.Path, required=True)
args = parser.parse_args()
for name in ['S07DiagnosticWeb.data', 'S07DiagnosticWeb.wasm']:
    source = args.directory / 'Build' / name
    data = gzip.compress(source.read_bytes(), compresslevel=9, mtime=0)
    files = []
    for index, offset in enumerate(range(0, len(data), 4 * 1024 * 1024)):
        target = source.with_name(name + '.part-' + str(index).zfill(3) + '.bin')
        target.write_bytes(data[offset:offset + 4 * 1024 * 1024])
        files.append(target.name)
    source.with_name(name + '.parts.json').write_text(json.dumps({'files': files}) + '\n')
    print(name + ': ' + str(len(files)) + ' compressed chunks')

assets = {}
for folder in ['Build', 'StreamingAssets/VehicleBundles', 'Icons']:
    for path in sorted((args.directory / folder).rglob('*')):
        if not path.is_file() or path.name.endswith(('.manifest', '.meta')):
            continue
        if folder == 'StreamingAssets/VehicleBundles' and not path.name.startswith(('vehicle-', 'environment-')):
            continue
        assets[path.relative_to(args.directory).as_posix()] = {
            'bytes': path.stat().st_size,
            'sha256': hashlib.sha256(path.read_bytes()).hexdigest()
        }
catalog_path = args.directory / 'vehicles.json'
assets['vehicles.json'] = {'bytes': catalog_path.stat().st_size,
                          'sha256': hashlib.sha256(catalog_path.read_bytes()).hexdigest()}
index = {'assets': assets, 'models': json.loads(catalog_path.read_text())['models']}
revision = hashlib.sha256(json.dumps(index, sort_keys=True).encode()).hexdigest()[:16]
index['revision'] = revision
(args.directory / 'asset-index.json').write_text(json.dumps(index, indent=2) + '\n')
worker = pathlib.Path(__file__).resolve().parents[1] / 'WebHost/cache-worker.js'
(args.directory / 'cache-worker.js').write_text('const BUILD_REVISION = ' + json.dumps(revision) + ';\n' + worker.read_text())
print('Static cache manifest: ' + revision)
