create database ss3_thao_tac_voi_csdl;
use ss3_thao_tac_voi_csdl;

create table Class(
	ClassID int auto_increment primary key,
    ClassName varchar(60) not null,
    StartDate datetime not null,
    `Status` bit
);

create table Student(
	StudentID int auto_increment primary key,
    StudentName varchar(30) not null,
    Address varchar(50),
    Phone varchar (20),
    `Status` bit,
    ClassID int not null,
    foreign key(ClassID) references Class(ClassID)
);

create table Subject(
	SubID int auto_increment primary key,
    SubName varchar(30) not null,
    Credit tinyint not null default 1 check (Credit>=1),
    Status bit default 1
);

create table Mark(
	MarkID int auto_increment primary key,
    SubID int not null unique,
    StudentID int not null unique,
    Mark float default 0 check (Mark between 0 and 100),
    ExamTimes tinyint default 1,
    foreign key(SubID) references Subject(SubID),
    foreign key(StudentID) references Student(StudentID)
);