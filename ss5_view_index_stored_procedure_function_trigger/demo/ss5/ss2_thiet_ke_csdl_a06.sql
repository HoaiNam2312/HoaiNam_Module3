create database if not exists a0622i1;
use a0622i1;
create table jame (
username varchar(50) primary key,
`password` varchar(50)
);
create table class(
id int auto_increment primary key,
`name` varchar(20)
);
create table room(
id int primary key auto_increment,
name varchar(20),
class_id int,
foreign key(class_id) references class(id)
);
create table student(
 id int auto_increment primary key,
 `name` varchar(50),
 gender boolean,
 birthday date,
 `email` varchar(50),
 `point` float,
 username varchar(50) unique,
 class_id int
);
alter table student add foreign key(username) references jame(username);
alter table student add foreign key(class_id) references class(id);

create table instructor (
id int auto_increment primary key,
 `name` varchar(50),
 birthday date,
 salary float
);

create table instructor_class(
 instructor_id int,
 class_id int,
 start_time date,
 end_time date,
 primary key(instructor_id,class_id),
 foreign key(instructor_id) references instructor(id),
 foreign key(class_id) references class(id)
);

insert into class (name) values ('c1121g1'), ('c1221g1'),('a0821i1'),('a0921i1');
insert into room(name,class_id) values ('Ken',1), ('Jame',1),('Ada',2),('Andy',2);

insert into jame(`username`,`password`)
 values('cunn','12345'),('chunglh','12345'),('hoanhh','12345'),('dungd','12345'),('huynhtd','12345'),
 ('hainm','12345'),('namtv','12345'),('hieuvm','12345'),('kynx','12345'),('vulm','12345');

insert into jame(`username`,`password`)
 values('chau','12345');
 
insert into instructor(`name`,birthday, salary)
 values('tran van chanh','1985-02-03',100),('tran minh chien','1985-02-03',200),('vu thanh tien','1985-02-03',300);
insert into instructor(`name`,birthday, salary)
 values('tran van nam','1989-12-12',100);


 
 insert into student(`name`,birthday, gender,`point`, class_id,`username`) 
 values ('nguyen ngoc cu','1981-12-12',1,8,1,'cunn'),('le hai chung','1981-12-12',1,5,1,'chunglh'),
 ('hoang huu hoan','1990-12-12',1,6,2,'hoanhh'),('dau dung','1987-12-12',1,8,1,'dungd'),
 ('ta dinh huynh','1981-12-12',1,7,2,'huynhtd'),('nguyen minh hai','1987-12-12',1,9,1,'hainm'),
 ('tran van nam','1989-12-12',1,4,2,'namtv'),('vo minh hieu','1981-12-12',1,3,1,'hieuvm'),
 ('le xuan ky','1981-12-12',1,7,2,'kynx'),('le minh vu','1981-12-12',1,7,1,'vulm');

  insert into student(`name`,birthday, gender,`point`, class_id) 
 values ('nguyen van a','1981-12-12',1,8,null),('tran van b','1981-12-12',1,5,null);
 
--   insert into student(`name`,birthday, gender,`point`, class_id,`username`) 
--  values ('nguyen minh hai chau','1981-12-12',1,8,null,'chau');
 
 insert into instructor_class(class_id,instructor_id) values (1,1),(1,2),(2,1),(2,2),(3,1),(3,2);


-- ss3 thao tác với csdl
select * from student;
-- 1. Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào.
 select s.*, c.name as class_name from 
 student s inner join 
 class c on s.class_id = c.id;
  
-- 2. Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào 
-- và cả các bạn đã đăng ký nhưng chưa có lớp học.
 select s.*, ifnull(c.name, 'chưa có lớp')  as class_name from 
 student s left join 
 class c on s.class_id = c.id;

-- 3. Lấy thông tin của các học viên tên 'nguyen minh hai'.
select * from student where name ='nguyen minh hai';

-- 4. Lấy ra học viên có họ là “nguyen”
select * from student where name like 'nguyen %';
-- 5. Lấy thông tin của các học viên tên 'hai' hoặc 'huynh’.
select * from student where name like '% hai' or name like '% huynh';
-- tìm hiểu regexp

-- 6. Lấy ra các học viên có điểm lớn hơn 5 .
select * from student where point >5;

-- 7. lấy ra thông tin các học viên có điểm 4,6,8
select * from student where point in (4,6,8);
select * from student where point between 5 and 7;

-- trả về cột có điểm duy nhất
select distinct point  from student order by point asc;
select point from student group by point;
-- 8. Thông kế số lượng học sinh theo từng loại điểm.
select point, count(id) as sl from student group by point;
-- 9 . Thông kế số lượng học sinh theo điểm và điểm phải lớn hơn 5
select point, count(id) as sl from student where point>5 group by point;
-- 10. Thông kế số lượng học sinh theo điểm lớn hơn 5 và chỉ hiện thị với số lượng>=2
select point, count(id) as sl from student where point>5 group by point having sl>2;
select * from student having point>5;
-- 11. Lấy ra danh sách học viên của lớp c1121g1 và sắp xếp  học viên theo point giảm dần,
-- nếu point bằng nhau thì sắp xếp theo tên tăng dần.
select * from 
student s join class c on s.class_id = c.id
where c.name ='c1121g1'
order by point desc, s.name asc;



-- bài 4: sử dụng các hàm thông dụng
select* from class;
select* from student;
-- 1.1	Hiện thị danh sách các lớp có học viên theo học và số lượng học viên của mỗi lớp

select c.name as class_name, count(s. class_id) as so_luong from student s 
join class c on s.class_id = c.id
group by s.class_id;
-- 1.2.	 Tính điểm lớn nhất của mỗi các lớp
select c.name as class_name, max(s. point) as max_point from student s 
join class c on s.class_id = c.id
group by s.class_id;
-- 1.3	 Tình điểm trung bình  của từng lớp
select c.name as class_name, avg(s. point) as avg_point from student s 
join class c on s.class_id = c.id
group by s.class_id;

 -- 2 Lấy ra toàn bộ tên và ngày sinh các instructor và student ở CodeGym.
select s.name, s.birthday from student s
union
select i.name, i.birthday from instructor i
union
select c.id, c.name from class c;
-- union để hỗ trợ full join
select * from student s 
left join class c on s.class_id = c.id
union
select * from student s 
right join class c on s.class_id = c.id;

  -- 4 Lấy ra top 3 học viên có điểm cao nhất của trung tâm.
  
  select * from student
  order by point desc
  limit 3;
  

 -- 5. Lấy ra các học viên có điểm số là cao nhất của trung tâm.
select * from student where point =(select max(point) from student);

-- 6 lấy ra tất cả các giảng viên chưa từng tham gia giảng dạy
-- subquery
select * from instructor i where i.id not in(
select distinct ic.instructor_id from instructor_class ic);

select * from instructor i where not exists(
select* from instructor_class ic where ic.instructor_id= i.id
);
-- không dùng subquery
select * from instructor i
left join instructor_class ic
on i.id=ic.instructor_id
where ic.instructor_id is null;


select * from room;
select* from class;
select* from jame;
select* from student;
select* from instructor;
select * from instructor_class;




-- ss5: index, view, sp, function, trigger
-- 1. index
select count(*) from customers where city like 'lyon';
explain select * from customers where city like 'lyon';
select * from customers;

-- cách 1
create index i_city on customers(city);
drop index i_city on customers;
-- cách 2
alter table customers add index i_city(city);
alter table customers drop index i_city;

 -- 2.view (tạo view lấy thông tin của học viên)
create view w_student as
select s.id, s.name as student_name, c.name as class_name
from student s join class c on s.class_id = c.id;
 -- sử dụng view
select * from w_student;
drop view w_student;

-- 3.1  tạo một sp không tham số  để lấy danh sách student
 delimiter //
 create procedure sp_get_all_student()
 begin
 select s.id, s.name as student_name, c.name as class_name
from student s join class c on s.class_id = c.id;
 end //
 delimiter ;
-- goi sp
call sp_get_all_student();
-- 3.2 sp có tham số in để lấy ra học viên có tham số id
 delimiter //
 create procedure sp_get_student_by_id(IN p_id int)
 begin
   select * from student where id = p_id;
 end //
 delimiter ;
-- gọi sp
call sp_get_student_by_id(1);
-- 3.3 sp đếm số lượng học viên của trung tâm sử dụng OUT param

-- 4 viêt 1 function kiểm tra pass hay fail theo point
  DELIMITER //
  create function f_check_pass_module(p_point int)
  returns varchar(50)
  deterministic
  begin
  declare result varchar(50);
  if p_point>=5 then
  set result = 'pass';
  else 
  set result ='fail';
  end if;
  return result;
  end //
  DELIMITER ;
-- sử dụng function
	select f_check_pass_module(6);
     select s.*,f_check_pass_module(s.point) as ket_qua  from student s;
   -- 5 tạo trigger tự động tạo tài khoản jame trước khi thêm mới một học viên
 select * from student;
 select * from jame;

-- tạo bảng để ghi log
create table `history`(
id int auto_increment primary key,
name varchar(50),
old_point int,
new_point int,
update_day date
);

-- tạo trigger
DELIMITER //
CREATE TRIGGER tr_history 
AFTER UPDATE ON student
FOR EACH ROW
BEGIN
insert into `history`(`name`, old_point, new_point, update_day) 
values ( old.`name`, old.`point`,new.`point`,now());
END //
DELIMITER ;

select * from history;
select * from student;

