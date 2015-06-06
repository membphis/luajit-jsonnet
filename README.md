#luajit-jsonnet

use the jsonnet with luajit which make it more easy.

here is a example for parse the jsonnet file
```
local jsonnet=require"lib.jsonnet"
jsonnet = jsonnet.New()
for i=1,10 do
    local json, err = jsonnet:evaluate_file("data.json")
    print(json, " err:", err)
end
jsonnet.close()
```