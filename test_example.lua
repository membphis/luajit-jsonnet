local jsonnet=require"lib.jsonnet"
jsonnet = jsonnet.New()


local json, err = jsonnet:evaluate_file("data.json")
if err then
    error("err: " .. err)
end
print("json data:\n"..json)

json, err = jsonnet:evaluate_snippet("data.json", "std.assertEqual(({ x: 1, y: self.x } { x: 2 }).y, 2)")
if err then
    error("err: " .. err)
end
print("json data:\n"..json)

jsonnet.close() 