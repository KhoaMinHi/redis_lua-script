local calMoneyOrder=0 --result
local orderid=KEYS[1] --get key from command
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