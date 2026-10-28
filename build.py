from pathlib import Path
import lief

root = Path(__file__).resolve().parent
base = root / 'AutoHotkey64.exe'
if not base.exists():
    base = root.parent / 'build-tools' / 'AutoHotkey64.exe'
binary = lief.PE.parse(str(base))
script = (root / 'SpookyScorchedChat.ahk').read_bytes()
rcdata = next((r for r in binary.resources.childs if r.id == 10), None)
if rcdata is None:
    rcdata = binary.resources.add_child(lief.PE.ResourceDirectory(10))
assert not any(r.id == 1 for r in rcdata.childs), 'Base already contains script ID 1'
entry = lief.PE.ResourceDirectory(1)
data = lief.PE.ResourceData(list(b'\xef\xbb\xbf' + script))
data.id = 1033
entry.add_child(data)
rcdata.add_child(entry)
config = lief.PE.Builder.config_t()
config.resources = True
builder = lief.PE.Builder(binary, config)
builder.build()
builder.write(str(root / 'SpookyScorchedChat.exe'))
print('Built SpookyScorchedChat.exe')
