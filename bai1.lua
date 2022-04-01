local khoa = KEYS[1]; 
local array = redis.call("ZRANGE", khoa, 0, -1);
local a = redis.call("ZCARD", khoa)

if(array == nil or array == '')
then
    print("empty array!")
    return tostring(khoa) .. " " .. tostring(a);
end
for key,value in ipairs(array) 
do 
    print(key, value);
end 
return array