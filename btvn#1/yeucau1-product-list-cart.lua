local cookieid = KEYS[1]
local productid = KEYS[2]

local key = "users:" .. cookieid .. ":carts"
redis.call("rpush", key, productid)

return key .. " " .. productid