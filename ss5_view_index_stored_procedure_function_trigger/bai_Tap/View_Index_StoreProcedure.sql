create table product(
	id int primary key,
    product_code varchar(25),
    product_name varchar(25),
    product_price int,
    product_amount int,
    product_description varchar(50),
    product_status bit(1)
);
insert into product values
(1,"A","ABC",1000,1,"vip",1),
(2,"B","BCA",2000,2,"vip",0),
(3,"C","CAB",3000,3,"vip",1),
(4,"D","DCB",4000,4,"vip",0);

create unique index i_productCode on product(product_code);
explain select * from product where product_code = "D";

create index i_product_name_price on product(product_name,product_price);
explain select * from product where product_name = "DCB" and product_price = 4000;

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view view_product as
select product_code, product_name, product_price, product_status from product;

-- Tiến hành sửa đổi view
update view_product set product_price = 5000 where product_name = "DCB";
select * from view_product;
select * from product;
-- Tiến hành xoá view
drop view view_product;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
 delimiter //
 create procedure sp_product ()
 begin
	select * from product;
 end //
 delimiter ;
 call sp_product();

-- Tạo store procedure thêm một sản phẩm mới 

 delimiter //
 create procedure sp_insert_product (
 in id int,
 in product_code varchar(25),
 in product_name varchar(25),
 in product_price int,
 in product_amount int,
 in product_description varchar(50),
 in product_status bit(1)
 )
 begin
	insert into product values (id,product_code,product_name,product_price,product_amount,product_description,product_status);
    select * from product;
 end //
 delimiter ;
 
 call sp_insert_product(5,"E","EEE",3020,1,"vip",1);
 
 -- Tạo store procedure sửa thông tin sản phẩm theo id
 
 delimiter //
 create procedure sp_alter_product (in sp_id int)
 begin
	update product set product_name = "Hoai Nam" where id = sp_id;
	select * from product;
 end //
 delimiter ;
 
 call sp_alter_product(1);
 
 -- Tạo store procedure xoá sản phẩm theo id
 delimiter //
 create procedure sp_delete_product (in sp_id int)
 begin
	delete from product where id = sp_id;
	select * from product;
 end //
 delimiter ;
 call sp_delete_product(1);