create database ss2_thiet_ke_csdl;
create table Class(
	classID int,
    courseCode varchar(255),
    dayOfWeek date,
    timeStart datetime,
    timeEnd datetime,
    teacherID int,
    primary key (classID),
    foreign key (teacherID) references Teacher (teacherID)
);
create table Teacher(
	teacherID int,
    `name` varchar(255),
    phone int default 10,
    primary key (teacherID)
);
insert into Teacher(teacherID,`name`) values (1,"Nam");