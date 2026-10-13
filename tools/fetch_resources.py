"""Install the release-pinned vehicle resources with SHA-256 verification."""
import argparse
import hashlib
import json
import pathlib
import shutil
import urllib.request
import zipfile

project = pathlib.Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--archive', type=pathlib.Path, help='Use a manually downloaded archive')
args = parser.parse_args()
manifest = json.loads((project / 'resources.json').read_text())
archive = args.archive
if archive is None:
    cache = project / '.resource-cache'
    cache.mkdir(exist_ok=True)
    archive = cache / manifest['file']
    if not archive.exists():
        partial = archive.with_suffix('.zip.part')
        print('Downloading ' + manifest['url'], flush=True)
        request = urllib.request.Request(manifest['url'], headers={'User-Agent': 'DeepalUnityResourceSetup'})
        with urllib.request.urlopen(request, timeout=120) as response, partial.open('wb') as output:
            shutil.copyfileobj(response, output, length=1024 * 1024)
        partial.rename(archive)
archive = archive.expanduser().resolve()
digest = hashlib.sha256()
with archive.open('rb') as stream:
    while chunk := stream.read(1024 * 1024):
        digest.update(chunk)
if archive.stat().st_size != manifest['bytes'] or digest.hexdigest() != manifest['sha256']:
    raise SystemExit('Resource archive checksum mismatch; nothing was extracted.')
with zipfile.ZipFile(archive) as package:
    for info in package.infolist():
        path = pathlib.PurePosixPath(info.filename)
        if path.is_absolute() or '..' in path.parts or not path.parts:
            raise SystemExit('Unsafe path in resource archive')
        if path.parts[0] != 'Assets' and path.parts[:2] != ('WebHost', 'Icons'):
            raise SystemExit('Unexpected resource path: ' + info.filename)
        if (info.external_attr >> 16) & 0o170000 == 0o120000:
            raise SystemExit('Symlink in resource archive')
        target = project / path
        if info.is_dir():
            target.mkdir(parents=True, exist_ok=True)
        else:
            if target.is_symlink():
                raise SystemExit('Refusing to overwrite a symlink: ' + str(target))
            target.parent.mkdir(parents=True, exist_ok=True)
            if target.resolve().is_relative_to(project) is False:
                raise SystemExit('Resource path escapes project')
            with package.open(info) as source, target.open('wb') as output:
                shutil.copyfileobj(source, output)
print('Resources installed. Run build_web.py with Unity 2023.1.17f1.')
