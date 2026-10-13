"""Generate compressed, small static chunks for browser-side Unity startup."""
import argparse
import gzip
import json
import pathlib

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
