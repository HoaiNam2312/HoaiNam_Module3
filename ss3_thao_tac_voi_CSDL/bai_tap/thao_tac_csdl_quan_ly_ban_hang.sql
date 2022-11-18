insert into customer 
values (1,'Minh Quan',10),
		(2,'Ngoc Oanh',20),
		(3,'Hong Ha',50);


insert into `order`values
(1,1,'2006-03-21',null),
(2,2,'2006-03-23',null),
(3,1,'2006-03-16',null);


insert into product values
(1,'May Giat',3),
(2,'Tu Lanh',5),
(3,'Dieu Hoa',7),
(4,'Quat',1),
(5,'Bep Dien',2);

insert into order_detail values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order:

select oID, oDate, oTotalPrice from `order`;


-- danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách:

select cus.cName, p.pName from 
customer cus join `order` o on cus.cID = o.cID join
order_detail od on o.oID = od.oID join
product p on od.pID=p.pID;


-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào:

select cus.cName from customer cus
where cus.cid not in (select cid from `order`);


-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn):

select o.oID, o.oDate, sum(p.pPrice*od.odQTY) as 'oTotalPrice' from `order` o
join order_detail od on o.oID = od.oID join
product p on od.pID=p.pID
group by o.oID;
