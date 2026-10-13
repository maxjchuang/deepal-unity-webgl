"""Rebuild the recovered Unity WebGL garage with Unity 2023.1.17f1."""
import argparse
import pathlib
import subprocess
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--unity', required=True, help='Absolute path to the Unity executable')
args = parser.parse_args()
project = pathlib.Path(__file__).resolve().parent
logs = project / 'BuildLogs'
logs.mkdir(exist_ok=True)
for phase in ['Import', 'BuildBundles', 'Build']:
    command = [args.unity, '-batchmode', '-quit', '-projectPath', str(project),
               '-executeMethod', 'GarageBuild.' + phase,
               '-logFile', str(logs / (phase + '.log'))]
    if phase != 'Import':
        command += ['-buildTarget', 'WebGL']
    print('Running ' + phase, flush=True)
    subprocess.run(command, check=True)
subprocess.run([sys.executable, str(project / 'tools/prepare_web_delivery.py'),
                '--directory', str(project / 'Builds/S07DiagnosticWeb')], check=True)
print('Web output: ' + str(project / 'Builds/S07DiagnosticWeb'))
