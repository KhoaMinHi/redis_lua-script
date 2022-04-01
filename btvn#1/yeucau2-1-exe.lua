--cookie
local users={"hung", "huyen"}
local orderids={}
--dang key:value lưu trữ của đơn hàng lưu vết đã thanh toán: (users:{cookieid}:orders.ispaid):({orderid-value})

--lay các đơn hàng của các user
local key="users:"..users[1]..":orders.ispaid"
local orders
local temps={}
local lenOrders
local noPaidOrderId={} --danh sác các đơn hàng chưa thanh toán
--local ordersHung = redis.call('hgetall', key)
for i,user in ipairs(users)
do
    key="users:"..user..":orders.ispaid"
    orders = redis.call('hgetall', key)
    lenOrders = table.maxn(orders)
    for j=1,lenOrders,1
    do
        if(j%2 == 0 and orders[j] == "0")
        then
            table.insert(noPaidProductId, orders[j-1])
        end
    end
end
return noPaidProductId