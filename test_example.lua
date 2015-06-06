local jsonnet=require"lib.jsonnet"
jsonnet = jsonnet.New()

for i=1,10 do
    local json, err = jsonnet:evaluate_file("data.json")
    print(json, " err:", err)
end

jsonnet.close()