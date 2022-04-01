local function calMoneyOrder(orderid)
    local calMoneyOrder=0 --result
    local key="" --key to query
    local idProductAmount,idProductPrice,idProduct
    local len=0

    --get product id and amount
    key="orders:"..orderid..":products"
    idProductAmount=redis.call("hgetall", key)
    --get length
    len=table.maxn(idProductAmount)
    --get product id and price
    key="orders:"..orderid..":products.price"
    idProductPrice=redis.call("hgetall", key)
    --get all product id
    idProduct=redis.call("hkeys", key)
    --count the number of order that contain the X product id
    for i,proId in pairs(idProduct)
    do
        local amount,price=0,0 
        --get amount
        for j=1,len,1
        do
            if(proId == idProductAmount[j])
            then
                amount=tonumber(idProductAmount[j+1])
                break
            end
        end
        --get price
        for j=1,len,1
        do
            if(proId == idProductPrice[j])
            then
                price=tonumber(idProductPrice[j+1])
                break
            end
        end
        calMoneyOrder = calMoneyOrder + price*amount
    end
    return calMoneyOrder
end

local listTotalMoneyOrder={}
local listOrderId={}
local key
local users={"hung", "huyen"}
local maxTotalMoneyOrderIds={}
local max=0
--dang key:value lưu trữ của đơn hàng lưu vết đã thanh toán: (users:{cookieid}:orders.ispaid):({orderid-value})

--lay các đơn hàng của các user


--get all orderid
for i,user in ipairs(users)
do
    key="users:"..user..":orders"
    local orders = redis.call('lrange', key, 0, -1)
    for j,id in pairs(orders)
    do
        table.insert(listOrderId, id)
    end
end

--calculate
for i,id in pairs(listOrderId)
do
    listTotalMoneyOrder[id]=calMoneyOrder(id)
end

for id,total in pairs(listTotalMoneyOrder)
do
    if(total>=max)
    then
        max=total
    end
end

for id,total in pairs(listTotalMoneyOrder)
do
    if(total==max)
    then
        table.insert(listTotalMoneyOrder,id)
    end
end

return listTotalMoneyOrder


