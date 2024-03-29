
use [master]
If Exists (select name From sys.databases Where name='dbSoftQuanLyNhaHang') -- Kiem tra dbSoftQuanLyNhaHang da ton tai hay chua
Drop Database dbSoftQuanLyNhaHang
go

create database dbSoftQuanLyNhaHang
go
use dbSoftQuanLyNhaHang

Go
/*---------------- Bang NhanVien ---------------*/
create table NhanVien
(
		IdNhanVien			varchar(10)primary key,
		HoLot				nvarchar(100),
		Ten					nvarchar(100),
		Ngaysinh			datetime,
		GioiTinh			nvarchar (10),
		DienThoai			varchar(15),
		Email				varchar(100),
		DiaChi				nvarchar(100)
)
     
Go


						/*-- BANG NHAN VIEN  -- */
						
/*------------- Hien thi thong tin NhanVien -------------------*/
create procedure spgetNhanVien
as
Begin
	select *from NhanVien
	
End
Go
--drop procedure spgetNhanVien
/*----------- Hien thi thong tin NhanVien bang IdNhanVien --------------*/
create procedure spgetNhanVienByIdNhanVien
(
	@IdNhanVien varchar(10)
)
as
Begin
	select * from NhanVien where IdNhanVien =@IdNhanVien
End

Go

/*-------------- Insert NhanVien -----------------------------*/
create procedure spInsertNhanVien
( 
		@IdNhanVien			varchar(10),
		@HoLot				nvarchar(100),
		@Ten				nvarchar(100),
		@Ngaysinh			datetime,
		@GioiTinh			nvarchar(10),
		@DienThoai			varchar(15),
		@Email				varchar(100),
		@DiaChi				nvarchar(100)  
)
as
Begin
	insert into NhanVien(IdNhanVien, HoLot, Ten, Ngaysinh, GioiTinh, DienThoai,Email,DiaChi)
	values(@IdNhanVien, @HoLot, @Ten, @Ngaysinh, @GioiTinh, @DienThoai,@Email,@DiaChi)
End
Go
/*------------------- Update NhanVien -----------------------*/
create procedure spUpdateNhanVien
(
		@IdNhanVien			varchar(10),
		@HoLot				nvarchar(100),
		@Ten				nvarchar(100),
		@Ngaysinh			datetime,
		@GioiTinh			nvarchar(10),
		@DienThoai			varchar(15),
		@Email				varchar(100),
		@DiaChi				nvarchar(100)  	 
)
as
Begin
	update NhanVien set 
						HoLot = @HoLot,
						Ten =@Ten,
						Ngaysinh =@Ngaysinh,
						GioiTinh =@GioiTinh,
						DienThoai =@DienThoai,
						Email	=@Email,
						DiaChi	=@DiaChi
											 
		where IdNhanVien =@IdNhanVien
End
Go
/*--------------- Delete NhanVien ---------------------*/
create procedure spDeleteNhanVien
(
	@idNhanVien varchar (10)
)
as
Begin
	delete from NhanVien where IdNhanVien=@idNhanVien
End
go

/*--------------TIM KIEM NHAN VIEN THEO IDNHANVIEN -----------*/
create procedure spSearchNVByIdNV
(
	@IdNhanVien varchar (10)
)
as
Begin
	select *from NhanVien where IdNhanVien like  '%'+@IdNhanVien+'%'
End 
Go

--drop  procedure spSearchNVByIdNV

/*--------------TIM KIEM NHAN VIEN THEO TEN -----------*/
create procedure spSearchNVByTenNV
(
	@Ten			nvarchar(100)
)
as
Begin
	select *from NhanVien where Ten like  N'%'+@Ten+'%'
End 

--drop  procedure spSearchNVByTenNV
GO

		Create function fcgetIdNhanVien()
		returns varchar(10)
		
		
		As
		Begin
			Declare @IdNhanVien varchar(10)
			Declare @MaxIdNhanVien varchar(10)
			Declare @Max float
			
			
			Select @MaxIdNhanVien = MAX(IdNhanVien) from NhanVien
			
			if exists (select IdNhanVien from NhanVien)
						set @Max = CONVERT(float, SUBSTRING(@MaxIdNhanVien,3,3)) + 1
			else
						set @Max=1	
			if (@Max < 10)
						set @IdNhanVien='NV' + '0' + Convert(varchar(1),@Max)
			else
			if (@Max < 100)
						set @IdNhanVien='NV'  + Convert(varchar(2),@Max)
			
			Return @IdNhanVien
	End
	
	-- select IdNhanVien=dbo.fcgetIdNhanVien()
		

GO
/*--------------- Bang KhuVuc ----------------------*/
create table KhuVuc
(
		IdKhuVuc			varchar (5) primary key,
		TenKhuVuc			nvarchar(100)unique,
		DienGiai			nvarchar(100),
		TrangThai			nvarchar(30),
		constraint Unique_KhuVuc unique(TenKhuVuc)
)
--   drop table KhuVuc

		
							/*--- BANG KHU VUC ---*/
go
							
/*--------- Hien thi thong tin KhuVuc ----------------*/
create procedure spgetKhuVuc
as
Begin
	select * from KhuVuc
End
Go
/*----------- Hien thi thong tin KhuVuc bang IdKhuVuc --------------*/
create proc spgetKhuVucByIdKhuVuc
(
	@IdKhuVuc		varchar (5)
)
as
begin
	select * from KhuVuc where IdKhuVuc = @IdKhuVuc
end
go
-- drop proc spgetKhuVucByIdKhuVuc

create procedure spgetTenKhuVuc
as
begin
	select TenKhuVuc from KhuVuc
end
go


/*---------------- Insert KhuVuc -------------------*/
create procedure spInsertKhuVuc
( 
		@IdKhuVuc			varchar (5),
		@TenKhuVuc			nvarchar(100),
		@DienGiai			nvarchar(100),
		@TrangThai			nvarchar(30)
)
as
Begin
	insert into KhuVuc(IdKhuVuc, TenKhuVuc, DienGiai, TrangThai)
	values(@IdKhuVuc, @TenKhuVuc, @DienGiai, @TrangThai)
End
Go

-- DROP PROCEDURE spInsertKhuVuc
/*---------------- Update KhuVuc -----------------*/
create procedure spUpdateKhuVuc
(
		@IdKhuVuc			varchar (5) ,
		@TenKhuVuc			nvarchar(100),
		@DienGiai			nvarchar(100),
		@TrangThai			nvarchar(30)
)
as
Begin
	update KhuVuc set 
						TenKhuVuc=@TenKhuVuc,
						DienGiai=@DienGiai,
						TrangThai=@TrangThai						 
		where IdKhuVuc =@IdKhuVuc
End
Go
-- drop procedure spUpdateKhuVuc
/*-------------------- Delete KhuVuc -------------------*/
create procedure spDeleteKhuVuc
(
	@IdKhuVuc		varchar(5)
)
as
begin
	delete KhuVuc where IdKhuVuc = @IdKhuVuc
end
-- drop procedure spDeleteKhuVuc

GO


Create function fcgetIdkhuVuc()
		returns varchar(5)
		
		
		As
		Begin
			Declare @IdKhuVuc varchar(5)
			Declare @MaxIdKhuVuc varchar(5)
			Declare @Max float
			
			
			Select @MaxIdKhuVuc = MAX(IdKhuVuc) from KhuVuc
			
			if exists (select IdKhuVuc from KhuVuc)
						set @Max = CONVERT(float, SUBSTRING(@MaxIdKhuVuc,3,3)) + 1
			else
						set @Max=1	
			if (@Max < 10)
						set @IdKhuVuc='KV' + '00' + Convert(varchar(1),@Max)
			else
			if (@Max < 100)
						set @IdKhuVuc='KV' + '0' + Convert(varchar(2),@Max)
			else
						set @IdKhuVuc ='KV' +  Convert(varchar(3),@Max)
			Return @IdKhuVuc
	End
	
	-- select IdKhachHang=dbo.fcgetIdKhuVuc()
		
		
		
		
GO
/*------------------- Bang Ban -----------------------*/
create table Ban
(
		IdBan			varchar (5) primary key,
		TenKhuVuc		nvarchar(100) foreign key references KhuVuc(TenKhuVuc),
		TenBan			nvarchar(100)unique,
		DienGiai		nvarchar(100),
		TrangThai		nvarchar(30),
		constraint Unique_Ban unique(TenBan)
)
-- drop table Ban



go

						/*----------- BANG BAN --------------*/
						
/*--------- Hien thi thong tin Ban ----------------*/
create procedure spgetBan
as
Begin
	select IdBan,TenBan,TenKhuVuc,DienGiai,TrangThai from Ban
End
Go
--drop  procedure spgetBan
/*----------- Hien thi thong tin Ban bang IdBan --------------*/
create procedure spgetBanByIdBan
(
	@IdBan	varchar (5)
)
as
begin
	select * from Ban where IdBan = @IdBan
end
go
-- drop proc spgetBanByIdBan
/*---------------- Insert Ban -------------------*/
create procedure spInsertBan
( 
		@IdBan			varchar (5) ,
		@TenKhuVuc		nvarchar(100) ,
		@TenBan			nvarchar(100),
		@DienGiai		nvarchar(100),
		@TrangThai		nvarchar(30)
)
as
Begin
	insert into Ban(IdBan,TenKhuVuc, TenBan, DienGiai, TrangThai)
	values(@IdBan,@TenKhuVuc,@TenBan,@DienGiai,@TrangThai)
End
Go

-- DROP PROCEDURE spInsertBan
/*---------------- Update Ban -----------------*/
create procedure spUpdateBan
(
		@IdBan			varchar (5) ,
		@TenKhuVuc		nvarchar(100) ,
		@TenBan			nvarchar(100),
		@DienGiai		nvarchar(100),
		@TrangThai		nvarchar(30)
)
as
Begin
	update Ban set		
						
						TenKhuVuc = @TenKhuVuc,
						TenBan=@TenBan,
						DienGiai=@DienGiai,
						TrangThai=@TrangThai						 
		where IdBan=@IdBan
End
Go
-- drop procedure spUpdateBan
/*-------------------- Delete Ban -------------------*/
create procedure spDeleteBan
(
	@IdBan		varchar(5)
)
as
begin
	delete Ban where IdBan = @IdBan
END

GO

Create function fcgetIdBan()
		returns varchar(5)
		
		
		As
		Begin
			Declare @IdBan varchar(5)
			Declare @MaxIdBan varchar(5)
			Declare @Max float
			
			
			Select @MaxIdBan = MAX(IdBan) from Ban
			
			if exists (select IdBan from Ban)
						set @Max = CONVERT(float, SUBSTRING(@MaxIdBan,4,2)) + 1
			else
						set @Max=1	
			if (@Max < 10)
						set @IdBan='BAN' + '0' + Convert(varchar(1),@Max)
			else
						set @IdBan ='BAN' +  Convert(varchar(3),@Max)
			Return @IdBan
	End
	
	-- select IdBan=dbo.fcgetIdBan()


GO
/*-------------------- Bang LoaiThucDon ------------*/
create table LoaiThucDon
(
		IdLoaiThucDon			varchar (5) primary key,
		TenLoaiThucDon			nvarchar(100)unique,
		DienGiai				nvarchar(100),
		TrangThai				nvarchar(30),
)
-- drop table LoaiThucDon

/*-------------------- Bang ThucDon ------------*/


go

						/*----------- BANG LOAITHUCDON --------------*/
						
/*--------- Hien thi thong tin LoaiThucDon ----------------*/
create procedure spgetLoaiThucDon
as
Begin
	select * from LoaiThucDon
End
Go
/*----------- Hien thi thong tin LoaiThucDon bang IdLoaiThucDon --------------*/
create procedure spgetLoaiThucDonByIdLoaiThucDon
(
	@IdLoaiThucDon			varchar (5)
)
as
begin
	select * from LoaiThucDon where IdLoaiThucDon = @IdLoaiThucDon
end
go
-- drop proc spgetLoaiThucDonByIdLoaiThucDon
/*---------------- Insert LoaiThucDon -------------------*/
create procedure spInsertLoaiThucDon
( 
		@IdLoaiThucDon			varchar (5),
		@TenLoaiThucDon			nvarchar(100),
		@DienGiai				nvarchar(100),
		@TrangThai				nvarchar(30)
)
as
Begin
	insert into LoaiThucDon(IdLoaiThucDon,TenLoaiThucDon,DienGiai,TrangThai)
	values(@IdLoaiThucDon,@TenLoaiThucDon,@DienGiai,@TrangThai)
End
Go

-- DROP PROCEDURE spInsertLoaiThucDon
/*---------------- Update LoaiThucDon -----------------*/
create procedure spUpdateLoaiThucDon
(
		@IdLoaiThucDon			varchar (5),
		@TenLoaiThucDon			nvarchar(100),
		@DienGiai				nvarchar(100),
		@TrangThai				nvarchar(30)
)
as
Begin
	update LoaiThucDon set 
						TenLoaiThucDon=@TenLoaiThucDon,
						DienGiai=@DienGiai,
						TrangThai=@TrangThai						 
		where IdLoaiThucDon =@IdLoaiThucDon
End
Go
-- drop procedure spUpdateLoaiThucDon
/*-------------------- Delete LoaiThucDon -------------------*/
create procedure spDeleteLoaiThucDon
(
	@IdLoaiThucDon			varchar (5)
)
as
begin
	delete LoaiThucDon where IdLoaiThucDon = @IdLoaiThucDon
end
go
/* ----------------------- Get TenLoaiThucDon ----------------*/
create procedure spgetTenLoaiThucDon
as
begin
	select TenLoaiThucDon from LoaiThucDon
end

go
Create function fcgetIdLoaiThucDon()
		returns varchar(5)
		
		
		As
		Begin
			Declare @IdLoaiThucDon		varchar(5)
			Declare @MaxIdLoaiThucDon	varchar(5)
			Declare @Max float
			
			
			Select @MaxIdLoaiThucDon = MAX(IdLoaiThucDon) from LoaiThucDon
			
			if exists (select IdLoaiThucDon from LoaiThucDon)
						set @Max = CONVERT(float, SUBSTRING(@MaxIdLoaiThucDon,4,2)) + 1
			else
						set @Max=1	
			if (@Max < 10)
						set @IdLoaiThucDon='LTD' + '0' + Convert(varchar(1),@Max)
			else
						set @IdLoaiThucDon ='LTD' +  Convert(varchar(3),@Max)
			Return @IdLoaiThucDon
	End
	
	-- select IdLoaiThucDon=dbo.fcgetIdLoaiThucDon()



GO
create table ThucDon
(
		IdThucDon			varchar(5) primary key,
		TenLoaiThucDon		nvarchar(100)foreign key references LoaiThucDon(TenLoaiThucDon),
		TenThucDon			nvarchar(100)unique,
		DonViTinh			nvarchar(10),
		SoLuongTon			float,
		DonGiaTon			float,
		TonToiThieu			float,
		TrangThai			nvarchar(30)
)
--  drop table ThucDon


GO
							/*-- BANG THUC DON -- */
							
/*--------- Hien thi thong tin ThucDon ----------------*/
create procedure spgetThucDon
as
Begin
	select IdThucDon,TenLoaiThucDon,TenThucDon,DonViTinh,SoLuongTon,DonGiaTon,TonToiThieu,TrangThai	
	from ThucDon
End
Go
-- drop proc spgetThucDon

/*--------- Hien thi thong tin ThucDon NOT TonToiThieu ----------------*/
create procedure spgetThucDonNotTTT
as
Begin
	select IdThucDon,TenLoaiThucDon,TenThucDon,DonViTinh,SoLuongTon,DonGiaTon,TrangThai	
	from ThucDon
End
Go
-- drop proc spgetThucDonNotTTT
/*----------- Hien thi thong tin ThucDon bang IdThucDon --------------*/
create procedure spgetThucDonByIdThucDon
(
	@IdThucDon		varchar (5)
)
as
begin
	select * from ThucDon where IdThucDon = @IdThucDon
end
go
/*---------------- Insert ThucDon -------------------*/
create procedure spInsertThucDon
( 
		@IdThucDon			varchar(5) ,
		@TenLoaiThucDon		nvarchar(100),
		@TenThucDon			nvarchar(100),
		@DonViTinh			nvarchar(10),
		@SoLuongTon			float,
		@DonGiaTon			float,
		@TonToiThieu		float,
		@TrangThai			nvarchar(30)
)
as
Begin
	insert into ThucDon(IdThucDon,TenLoaiThucDon,TenThucDon,DonViTinh,SoLuongTon,DonGiaTon,TonToiThieu,TrangThai)
	values(@IdThucDon,@TenLoaiThucDon,@TenThucDon,@DonViTinh,@SoLuongTon,@DonGiaTon,@TonToiThieu,@TrangThai)
End
Go

-- DROP PROCEDURE spgetThucDon
/*---------------- Update ThucDon -----------------*/
create procedure spUpdateThucDon
(
		@IdThucDon			varchar(5) ,
		@TenLoaiThucDon		nvarchar(100),
		@TenThucDon			nvarchar(100),
		@DonViTinh			nvarchar(10),
		@SoLuongTon			float,
		@DonGiaTon			float,
		@TonToiThieu		float,
		@TrangThai			nvarchar(30)
)
as
Begin
	update ThucDon set 
						TenLoaiThucDon=@TenLoaiThucDon,
						TenThucDon=@TenThucDon,
						DonViTinh=@DonViTinh,
						SoLuongTon=@SoLuongTon,
						DonGiaTon=@DonGiaTon,
						TonToiThieu=@TonToiThieu,
						TrangThai=@TrangThai
											 
		where IdThucDon =@IdThucDon
End
Go
----   drop proc spUpdateThucDon
/*-------------------- Delete ThucDon -------------------*/
create procedure spDeleteThucDon
(
	@IdThucDon		varchar (5)
)
as
begin
	delete ThucDon where IdThucDon = @IdThucDon
end
go
/*-------------------- get DonGiaTon tu TenThucDon -------------------*/
create procedure spgetDonGiaByTenThucDon
(
	@TenThucDon			nvarchar(100)
)
as
begin
	select DonGiaTon as 'Đơn giá' from ThucDon where TenThucDon=@TenThucDon
end
go
Create function fcgetIdThucDon()
		returns varchar(5)
		
		
		As
		Begin
			Declare @IdThucDon		varchar(5)
			Declare @MaxIdThucDon	varchar(5)
			Declare @Max float
			
			
			Select @MaxIdThucDon = MAX(IdThucDon) from ThucDon
			
			if exists (select IdThucDon from ThucDon)
						set @Max = CONVERT(float, SUBSTRING(@MaxIdThucDon,3,3)) + 1
			else
						set @Max=1	
			if (@Max < 10)
						set @IdThucDon='TD' + '00' + Convert(varchar(1),@Max)
			else
			if (@Max < 100)
						set @IdThucDon='TD' + '0' + Convert(varchar(2),@Max)
			else
						set @IdThucDon ='TD' +  Convert(varchar(3),@Max)
			Return @IdThucDon
	End
	
	-- select IdThucDon=dbo.fcgetIdThucDon()



GO 
/*---------------- Bang NguyenLieuThucDon --------------------*/	
create table NguyenLieuThucDon
(
		IdNguyenLieuThucDon			varchar(5),
		IdThucDon					varchar(5) foreign key references ThucDon(IdThucDon),
		SoLuong						float,
		DienGiai					nvarchar(100),
		TrangThai					nvarchar(30)
)
-- drop table NguyenLieuThucDon
	

/*---------------- Bang GoiMon --------------------*/	
GO
create table GoiMon
(
	IdBan				varchar (5) foreign key references Ban(IdBan),
	IdThucDon			varchar(5) foreign key references ThucDon (IdThucDon),
	TenThucDon			nvarchar(100),
	DonGiaTon			decimal ,
	SoLuong				int,
	ThoiGian			datetime,
	ThanhTien			decimal
	--constraint KhoaChinh_GoiMon	primary key (IdBan)
)

 -- drop table GoiMon
 GO
 
 						/*----- BANG GOIMON-----*/

/*--------- Hien thi thong tin GoiMon ----------------*/
create procedure spgetGoiMon
as
Begin
	select IdBan,TenThucDon,DonGiaTon,SoLuong,ThoiGian,(SoLuong*DonGiaTon)as ThanhTien
	from GoiMon
	ORDER BY IdBan
End
Go
-- drop procedure spgetGoiMon
/*----------- Hien thi thong tin GoiMon bang IdBan --------------*/
create procedure spgetGoiMonByIdBan
(
	@IdBan	varchar (5)
)
as
begin
	select  IdBan as 'Id Bàn', TenThucDon as 'Tên Thực Đơn',DonGiaTon as 'Đơn Giá',SoLuong as 'Số Lượng ',ThoiGian as 'Thời Gian',(SoLuong*DonGiaTon)as 'Thành Tiền'
	from GoiMon where IdBan = @IdBan
end
go
-- drop proc spgetGoiMonByIdBan
/*---------------- Insert GoiMon -------------------*/
create procedure spInsertGoiMon
( 
		@IdBan				varchar (5),
		@TenThucDon			nvarchar(100),
		@DonGiaTon			decimal ,
		@SoLuong			int,
		@ThoiGian			datetime,
		@ThanhTien			decimal
)
as
Begin
	insert into GoiMon(IdBan,TenThucDon, DonGiaTon, SoLuong, ThoiGian,ThanhTien)
	values(@IdBan,@TenThucDon, @DonGiaTon, @SoLuong, @ThoiGian,@ThanhTien )
End
Go

-- DROP PROCEDURE spInsertGoiMon
/*---------------- Update GoiMon -----------------*/
create procedure spUpdateGoiMon
(		
		@IdBan				varchar (5),
		@TenThucDon			nvarchar(100),
		@DonGiaTon			decimal ,
		@SoLuong			int,
		@ThoiGian			datetime,
		@ThanhTien			decimal
)
as
Begin
	update GoiMon set	
						TenThucDon = @TenThucDon,
						DonGiaTon=@DonGiaTon,
						SoLuong=@SoLuong,
						ThoiGian=@ThoiGian,
						ThanhTien=@ThanhTien
	where IdBan = @IdBan			 
End
Go
-- drop procedure spUpdateGoiMon
/*-------------------- Delete GoiMon -------------------*/
create procedure spDeleteGoiMon
(
	@IdBan				varchar (5)
)
as
begin
	Delete GoiMon where IdBan = @IdBan
end

GO
/*-------------------- get TenThucDon -------------------*/
create procedure spgetTenThucDon
as
begin
	select TenThucDon from ThucDon
end
go
/*-------------------- get DanhSachBan_GoiMon -------------------*/
create procedure spgetDanhSachBan_GoiMon
as
begin
	select  DISTINCT b.IdBan as 'Id Bàn' , TenBan as 'Tên Bàn',  TenKhuVuc as 'Tên Khu Vực',DienGiai as 'Diễn Giải'
	from Ban b,GoiMon gm
	where b.IdBan = gm.IdBan
	ORDER BY b.IdBan
end
go
-- drop proc spgetDanhSachBan_GoiMon

/*-------------------- get DanhSachBan_ChuaGoiMon -------------------*/
create procedure spgetDanhSachBan_ChuaGoiMon
as
begin
	select  distinct IdBan as 'Id Bàn',TenBan as 'Tên Bàn',TenKhuVuc as 'Tên Khu Vực',DienGiai as 'Diễn Giải'
	from Ban where IdBan not in (select IdBan from GoiMon)
	ORDER BY IdBan,TenBan,TenKhuVuc,DienGiai
end
-- drop proc spgetDanhSachBan_ChuaGoiMon

GO
/*---------- TRIGER RANG BUOC SO LUONG THUC DON ---------- */

create trigger trigger_Valid_insertUpdateGoiMon
on GoiMon FOR INSERT
as
begin
	if update (SoLuong)
	begin
		declare @SoLuongBan int 
		declare @SoLuongCon int
		declare @TenThucDon nvarchar(100)
		select @SoLuongBan = SoLuong,@TenThucDon = TenThucDon  from INSERTED
		select @SoLuongCon= SoLuongTon from ThucDon 
			where TenThucDon = @TenThucDon 
			if((@SoLuongCon-@SoLuongBan)<0)
			begin
				PRINT ('So Luong Thuc Don Khong Du!')
				rollback transaction
			end
			else 
				update ThucDon set SoLuongTon = @SoLuongCon -  @SoLuongBan 
					where TenThucDon = @TenThucDon 
	end			
end
go
-- drop trigger  trigger_Valid_insertUpdateGoiMon
Create Procedure dbo.DeleteAllProcedures
As
 declare @procName varchar(500)
 declare cur cursor
 for select [name] from sys.objects where type = 'p'
 open cur
 
 fetch next from cur into @procName
 while @@fetch_status = 0
 begin
 if @procName <> 'DeleteAllProcedures'
 exec('drop procedure ' + @procName)
 fetch next from cur into @procName
 end
 close cur
 deallocate cur
Go
 Grant Execute On dbo.DeleteAllProcedures To Public
Go
--drop proc  dbo.DeleteAllProcedures