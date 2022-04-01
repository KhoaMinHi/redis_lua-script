local cookieid = KEYS[1]
local productid = KEYS[2]
local proName=KEYS[3]
local proImageSource=KEYS[4]
local proPrice=KEYS[5]
local proAmount=KEYS[6]
local command = "hmset"

local key = "users:" .. cookieid .. ":carts:" .. productid
local isvalid = redis.call(command, key, "name", proName, "imagesource", proImageSource, "price", proPrice, "amount", proAmount)

return key
