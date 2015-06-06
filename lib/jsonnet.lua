local ffi = require("ffi")

local _M = { _VERSION = '0.01' }
local mt = { __index = _M }

ffi.cdef[[
struct JsonnetVm *vm;
struct JsonnetVm *jsonnet_make(void);
char *jsonnet_evaluate_file(struct JsonnetVm *vm,
                            const char *filename,
                            int *error);
                            
char *jsonnet_realloc(struct JsonnetVm *vm, char *buf, size_t sz);
void jsonnet_destroy(struct JsonnetVm *vm);

]]

local jsonnet = ffi.load("jsonnet")

function _M.New()
    local vm = jsonnet.jsonnet_make()
    return setmetatable({ vm = vm }, mt)
end

function _M.evaluate_file(self, json_file)
    local err_no = ffi.new("int[?]", 1)
    local out = jsonnet.jsonnet_evaluate_file(self.vm, json_file, err_no)
    
    if 0 ~= err_no[0] then
        jsonnet.jsonnet_realloc(vm, out, 0)
        print(err_no[0]) 
        return nil, "evaluate_file failed"
    end
    
    local json_data = ffi.string(out)
    jsonnet.jsonnet_realloc(vm, out, 0)
    return json_data
end

function _M.close(self)
    jsonnet.jsonnet_destroy(vm)
end

return _M