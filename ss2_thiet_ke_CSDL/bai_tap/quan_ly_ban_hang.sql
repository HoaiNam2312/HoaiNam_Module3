create table customer(
	cID int primary key,
    cName varchar(25) not null,
    cAge int not null
);

create table `order`(
	oID int primary key,
    cID int not null,
    oDate date,
    oTotalPrice int,
    foreign key(cID) references customer(cID)
);

create table product(
	pID int primary key,
    pName varchar(25) not null,
    pPrice int
);

create table order_detail(
	oID int,
    pID int,
    odQTY varchar(50),
    primary key(oID,pID),
    foreign key(oID) references `order`(oID),
    foreign key(pID) references product(pID)
);