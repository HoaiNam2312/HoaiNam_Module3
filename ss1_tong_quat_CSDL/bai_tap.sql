create database ss1_tong_quat_csdl;
create table Class(
	id int primary key,
    `name` varchar(50)
);
select * from Class;
create table Teacher(
	id int primary key,
    name varchar(50),
    age int,
    country varchar(50)
);
select * from Teacher;
insert into Class values(1,"Le Vu Hoai Nam"), (2,"Nguyen Thi Yen Vy");
insert into Class values(5,"Le Vu Hoai Nam2"), (4,"Nguyen Thi Yen Vy2");
insert into Teacher values(5,"Huynh Quoc Trung1",22,"Da Nang"),(6,"Dang Huynh Nam Anh1",11,"Ha Noi");
alter table Class
modify `name` varchar(50) not null;
alter table Class
add unique (`name`);
alter table Class
drop index `name`;
alter table Class
drop primary key;
alter table Teacher
add check (age>=18);