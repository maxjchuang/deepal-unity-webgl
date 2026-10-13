"""Copy excluded resources from an explicitly supplied local recovery project."""
import argparse
import pathlib
import shutil

parser = argparse.ArgumentParser()
parser.add_argument('--source', type=pathlib.Path, required=True)
args = parser.parse_args()
source = args.source.expanduser().resolve()
destination = pathlib.Path(__file__).resolve().parents[1]
required = ['Assets/Recovery', 'ShaderReferences', 'WebHost/Icons']
missing = [name for name in required if not (source / name).exists()]
if missing:
    parser.error('Source is missing: ' + ', '.join(missing))
if source == destination:
    parser.error('Source must be a separate local recovery project')

# Keep the public runtime/editor code while copying non-code asset dependencies.
for path in (source / 'Assets').rglob('*'):
    if not path.is_file():
        continue
    relative = path.relative_to(source)
    if path.name.endswith(('.cs', '.cs.meta', '.jslib', '.jslib.meta')):
        continue
    target = destination / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(path, target)
for name in ['ShaderReferences', 'ReflectionShaderReferences',
             'PostShaderReferences', 'SceneShaderReferences', 'WebHost/Icons']:
    path = source / name
    if path.is_dir():
        shutil.copytree(path, destination / name, dirs_exist_ok=True)
print('Local resources prepared. These files remain excluded by .gitignore.')
