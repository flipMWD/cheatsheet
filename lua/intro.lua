--[[
    execute:
    $ lua5.X script.lua
]]

-- data types
var_number  = 10            -- real double precision float
var_string  = "string"      -- array of characters
var_bool    = true
var_null    = nil           -- NULL or invalid value

local var_local = "Mix different variable types"

-- I/O library
io.popen("dmenupass")       -- open system process

-- strings
print("print: Ideal for testing and debugging")
io.write("io.write: ", "Used for outputting text to the user", "\n")
io.write(string.format("%s%s %s\n", var_string, ".format:", var_local))

-- conditions and operators
if 1 == 1.0 then
    print(type(1) .. " and " .. type(1.0) .. " are the same")
end

if not (false == nil) and true ~= false then
    print("not equal and different")
end

if var_number >= 20 then
    print("number is greater than 20")
elseif var_number < 6 then
    print("number is lower than 6")
else
    print("number is " .. tostring(var_number))   -- concatenate strings
end

-- loops
i = 0                       -- defining global variable

for i = 1, 35, 2 do         -- from[, to[, step]]
    io.write(i, ' ')        -- the i variable here is local to the block scope
end
print()

while true do
    i = i - 1               -- the i variable here is the global one
    io.write(i, ' ')
    if i < -14 then
        break
    end
end
print()

io.write("global vs local: value of i: ", i, "\n")

-- tables
table_numbers       = {10, 20, 30, 40, 50}
table_keys          = {["key1"] = "string1", ["key2"] = "string2"}
table_keys["key1"]  = "string-start"

print(table_numbers[1])     -- index starts at 1

table.insert(table_numbers, 60)
print(table_numbers[6])

table.remove(table_numbers, 2)
io.write("length operator: ", #table_numbers, "\n") -- like bash arrays

table_numbers[1] = nil    -- delete value, but keep list from 1-5

cat_string = table.concat(table_numbers, ' - ', 2)  -- (list, [sep [, i [, j]]])
io.write(cat_string, " doesn't have the value ", table_keys.key2, "\n")

for key, value in pairs(table_keys) do
    io.write("in " .. key .. " theres a value of " .. value .. "\n")
end

-- functions
function test_func(param1, param2)
    io.write("1: ", param1, ",\t2: ", param2)
end

test_func("first", "words")

