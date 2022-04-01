local X=KEYS[1]
local users={"hung", "huyen"}
local orderids={}
local orderid5={}

--lay các đơn hàng của các user
local key=""
local orders
local countOrders = 0

--get all orderid
for i,user in ipairs(users)
do
    key="users:"..user..":orders"
    orders = redis.call('lrange', key, 0, -1)
    for j,id in pairs(orders)
    do
        table.insert(orderids, id)
    end
end

--count the number of order that contain the X product id
for i,orderid in pairs(orderids)
do
    local mykey = "orders:"..orderid..":products"
    local products = redis.call("hkeys", mykey)
    for j,proID in pairs(products)
    do
        if(proID == X)
        then
            countOrders = countOrders + 1
            break
        end
    end
end
return countOrders