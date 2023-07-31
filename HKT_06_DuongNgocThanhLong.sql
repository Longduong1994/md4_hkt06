create database truonghoc;
use truonghoc;

create table dmkhoa(
makhoa varchar(20) primary key,
tenkhoa varchar(255) 
);

create table dmnganh(
manganh int primary key,
tennganh varchar(255),
makhoa varchar(20),
foreign key (makhoa) references dmkhoa(makhoa)
);

create table dmlop(
malop  varchar(20) primary key,
tenlop varchar(255),
manganh int,
khoahoc int,
hedt varchar(255),
namnhaphoc int,
foreign key(manganh) references dmnganh(manganh)
);

create table dmhocphan(
mahp int primary key,
tenhp varchar(255),
sodvht int ,
manganh int, 
hocky int,
foreign key(manganh) references dmnganh(manganh)
);
create table sinhvien(
masv int primary key,
hoten varchar(255),
malop varchar(20),
gioitinh tinyint(1),
ngaysinh date,
diachi varchar(255),
foreign key (malop) references dmlop(malop)
);

create table diemhp(
masv int,
mahp int,
diemhp float,
foreign key (masv) references sinhvien(masv),
foreign key (mahp) references dmhocphan(mahp)
);

insert into dmkhoa(makhoa,tenkhoa) values
("CNTT","Công Nghệ Thông Tin"),
("KT","Kế Toán"),
("SP","Sư Phạm");

insert into dmnganh(manganh,tennganh,makhoa) values
(140902,"Sư Phạm Toán Tin","SP"),
(480202,"Tin Học Ứng Dụng","CNTT");

insert into dmlop() values
("CT11","Cao Đẳng Tin Học",480202,11,"TC",2013),
("CT12","Cao Đẳng Tin Học",480202,12,"CĐ",2013),
("CT13","Cao Đẳng Tin Học",480202,13,"TC",2014);

insert into dmhocphan() values
(1,"Toán Cao cấp A1",4,480202,1),
(2,"Tiếng Anh 1",3,480202,1),
(3,"Vật Lý Đại Cương",4,480202,1),
(4,"Tiếng Anh 2",7,480202,1),
(5,"Tiếng Anh 1",3,480202,1),
(6,"Xác Suất Thống Kê",3,480202,1);

insert into sinhvien() values
(1,"Phan Thanh","CT12",0,"1990-09-12","Tuy Phước"),
(2,"Nguyến Thị Cẩm","CT12",1,"1994-01-12","Quy Nhơn"),
(3,"Võ Thị Hà","CT12",1,"1995-07-02","An Nhơn"),
(4,"Trần Hoài Nam","CT12",0,"1994-04-05","Tây Sơn"),
(5,"Trần Văn Hoàng","CT13",0,"1995-08-04","Vĩnh Thạnh"),
(6,"Đặng Thị Thảo","CT13",1,"1995-06-12","Quy Nhơn"),
(7,"Lê Thị Sen","CT13",1,"1994-08-12","Phủ Mỹ"),
(8,"Nguyễn Văn Huy","CT11",0,"1995-06-04","Tuy Phước"),
(9,"Trần Thị Hoa","CT11",1,"1994-08-09","Hoài Nhơn");
insert into diemhp() values 
(2,2,5.9),(2,3,4.5),(3,1,4.3),(3,2,6.7),(3,3,7.3),
(4,1,4),(4,2,5.2),(4,3,3.5),(5,1,9.8),(5,2,7.9),
(5,3,7.5),(6,1,6.1),(6,2,5.6),(6,3,4),(7,1,6.2);

select sv.masv "Mã SV", sv.hoten "Họ Tên", sv.malop "Mã Lớp", d.diemhp "Điểm HP", d.mahp "Mã HP" from sinhvien sv
 join diemhp d on sv.masv = d.masv where d.diemhp >=5;
 
 select sv.masv "Mã SV", sv.hoten "Họ Tên", sv.malop "Mã Lớp", d.diemhp "Điểm HP", d.mahp "Mã HP" from sinhvien sv
 join diemhp d on sv.masv = d.masv order by sv.malop asc, sv.hoten asc;
 
 select sv.masv "Mã SV" ,sv.hoten "Họ Tên", sv.malop "Mã Lớp", d.diemhp "Điểm HP", hocky "Học Kỳ"  from sinhvien sv 
 join diemhp d on sv.masv = d.masv join dmhocphan hp on d.mahp = hp.mahp where (d.diemhp between 5 and 7) and hocky = 1;
 
 select sv.masv "Mã SV", sv.hoten "Họ Tên", sv.malop "Mã Lớp", k.makhoa "Mã Khoa" from sinhvien sv 
 join dmlop l on sv.malop = l.malop join dmnganh n on l.manganh = n.manganh join dmkhoa k on n.makhoa = k.makhoa
 where k.makhoa = "CNTT";
 
 select l.malop "Mã Lớp", l.tenlop "Tên Lớp" , count(sv.masv) "Sĩ Số" from dmlop l 
 join sinhvien sv on l.malop = sv.malop group by sv.malop;
 
 select hp.hocky "Học Kỳ", sv.masv "Mã SV", (sum(d.diemhp * hp.sodvht)/sum(hp.sodvht)) "Điểm TBC" from sinhvien sv
 join diemhp d on sv.masv = d.masv join dmhocphan hp on d.mahp = hp.mahp group by sv.masv, hp.hocky;
 
 select l.malop "Mã Lớp", l.tenlop "Tên Lớp", 
 case when sv.gioitinh = 1 then "Nam" when sv.gioitinh = 0 then "Nữ" end as "Giới Tính", count(sv.gioitinh) "Số Lượng" from sinhvien sv 
 join dmlop l on sv.malop = l.malop group by sv.gioitinh , sv.malop;
 
 select sv.masv "Mã SV", (sum(d.diemhp * hp.sodvht)/ sum(hp.sodvht)) "Điêmt TBC" from sinhvien sv 
 join diemhp d on sv.masv = d.masv join dmhocphan hp on d.mahp = hp.mahp where hp.hocky = 1 group by sv.masv;
 
 select sv.masv "Mã SV", sv.hoten "Họ Tên", count(hp.sodvht) "Tổng DVHT" from sinhvien sv 
 join diemhp d on d.masv = sv.masv join dmhocphan hp on d.mahp = d.mahp
 where d.diemhp <5 group by  sv.masv;
 
 select d.mahp "Mã HP", count(d.mahp) "SL_SV_Thiếu"  from sinhvien sv
 join diemhp d on sv.masv = d.masv where d.diemhp <5
 group by d.mahp
 order by d.mahp;
 
 select sv.masv "Mã SV", sv.hoten "Họ Tên" , sum(hp.sodvht) from sinhvien sv 
 join diemhp d on sv.masv = d.masv join dmhocphan hp on d.mahp = hp.mahp
 where d.diemhp < 5
 group by sv.masv;
 
 select l.malop "Mã Lớp", l.tenlop "Tên Lớp", count(sv.masv) "Sĩ Số" from  dmlop l join sinhvien sv on l.malop = sv.malop 
 group by l.malop
 having count(sv.masv) >2;
 
 select sv.masv "Mã SV", sv.hoten "Họ Tên", count(d.mahp)  from sinhvien sv 
 join diemhp d on sv.masv = d.masv
 where d.diemhp >5
 group by sv.masv
 having count(d.mahp)