--cookie
local users={"hung", "huyen"}
local orderids={}
local orderid5={}
--dang key:value lưu trữ của đơn hàng lưu vết đã thanh toán: (users:{cookieid}:orders.ispaid):({orderid-value})

--lay các đơn hàng của các user
local key="users:"..users[1]..":orders.ispaid"
local orders

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

--find the orders which contain the product amounts > 5
for i,orderid in pairs(orderids)
do
    local mykey = "orders:"..orderid..":products"
    local products = redis.call("hgetall", mykey)
    local lenProducts = table.maxn(products)
    for j=1,lenProducts,1
    do
        if(j%2==0)
        then
            local amount=tonumber(products[j])
            if(amount>5)
            then
                table.insert(orderid5, orderid)
            end
        end
    end
end
return orderid5