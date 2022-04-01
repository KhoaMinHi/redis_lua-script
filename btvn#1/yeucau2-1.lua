local hmset = "hmset"

--tao danh sach don hang có thuộc tính đã thanh toán chưa
--users: hung, huyen
local mykey="users:hung:orders.ispaid"
redis.call(hmset, mykey, "hung1", 1, "hung2", 1, "hung3", 0)
mykey="users:huyen:orders.ispaid"
redis.call(hmset, mykey, "huyen1", 0, "huyen2", 1)

--orderid
redis.call("rpush", "users:hung:orders", "hung1", "hung2", "hung3")
redis.call("rpush", "users:huyen:orders", "huyen1", "huyen2")

--danh sách sản phẩm của 1 đơn hàng
redis.call("hmset", "orders:hung1:products", "sach1", 2, "sach2", 1)
redis.call("hmset", "orders:hung2:products", "vo1", 2, "vo2", 1)
redis.call("hmset", "orders:hung3:products", "but1", 2, "but2", 1)

redis.call("hmset", "orders:huyen2:products", "giay1", 2, "giay2", 1)
redis.call("hmset", "orders:huyen1:products", "ao", 2, "quan", 1)

--luu giá
redis.call("hmset", "orders:hung1:products.price", "sach1", 20000, "sach2", 15000)
redis.call("hmset", "orders:hung2:products.price", "vo1", 14000, "vo2", 10000)
redis.call("hmset", "orders:hung3:products.price", "but1", 4000, "but2", 10000)

redis.call("hmset", "orders:huyen2:products.price", "giay1", 500000, "giay2", 1000000)
redis.call("hmset", "orders:huyen1:products.price", "ao", 200000, "quan", 300000)

--thêm dữ liệu
---thêm orderid
redis.call("rpush", "users:huyen:orders", "huyen3")
---thêm thuộc tính thanh toán
redis.call(hmset, "users:huyen:orders.ispaid", "huyen3", 1)
---lưu số lượng
redis.call("hmset", "orders:huyen3:products", "but1", 8)
---lưu giá
redis.call("hmset", "orders:huyen3:products.price", "but1", 4000)