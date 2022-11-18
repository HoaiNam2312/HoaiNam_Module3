use ss2_thiet_ke_csdl;

create table PhieuXuat(
	SoPX int auto_increment primary key,
    NgayXuat date not null
);

create table VatTu(
	MaVTU int auto_increment primary key,
    TenVTU varchar(50) not null
);

create table ChiTietPhieuXuat(
	DGXuat varchar(25) not null,
    SLXuat int not null,
    SoPX int not null ,
    MaVTU int not null,
    primary key (SoPX,MaVTU),
    foreign key(SoPX) references PhieuXuat(SoPX),
    foreign key(MaVTU) references vattu(MaVTU)
);

create table PhieuNhap(
	SoPN int auto_increment primary key,
    NgayNhap date not null
);

create table ChiTietPhieuNhap(
	DGNhap varchar(25) not null,
    SLNhap int not null,
    MaVTU int not null,
    SoPN int not null,
    foreign key(MaVTU) references vattu(MaVTU),
    foreign key(SoPN) references phieunhap(SoPN)
);
alter table chitietphieunhap
add primary key(mavtu,sopn);

create table DonDH(
	SoDH int auto_increment primary key,
    NgayDH date not null
);

create table ChiTietDonDatHang(
	MaVTU int not null,
    SoDH int not null,
    primary key (MaVTU,SoDH),
    foreign key (MaVTU) references vattu(MaVTU),
    foreign key (SoDH) references DonDH(SoDH)
);

create table NhaCC(
	MaNCC int auto_increment primary key,
    TenNCC varchar(25),
    DiaChi varchar(25),
    SDT varchar(11)
);

alter table DonDH
add MaNCC int not null;

alter table dondh
add foreign key(MaNCC) references NhaCC(MaNCC);

create table Sdt(
	id int primary key,
    MaNCC int auto_increment not null,
    foreign key(MaNCC) references NhaCC(MaNCC)
);