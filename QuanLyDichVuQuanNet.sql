Create Database QuanLyDichVuQuanNet;
Go
Use QuanLyDichVuQuanNet;
Go
-- Bảng TaiKhoan (lớp cha)
CREATE TABLE TaiKhoan (
    maTaiKhoan INT PRIMARY KEY,
    taiKhoan VARCHAR(50) NOT NULL UNIQUE,
    matKhau VARCHAR(50) NOT NULL
);

-- Bảng NguoiQuanLy
CREATE TABLE NguoiQuanLy (
    maNguoiQuanLy INT PRIMARY KEY,
    maTaiKhoan INT,
    FOREIGN KEY (maTaiKhoan) REFERENCES TaiKhoan(maTaiKhoan)
);

-- Bảng KhachHang
CREATE TABLE KhachHang (
    maKhachHang INT PRIMARY KEY,
    maTaiKhoan INT,
    thoiGianConLai TIME NOT NULL,
    loaiKhachHang NVARCHAR(50) CHECK (loaiKhachHang = N'Thường' OR loaiKhachHang = N'Vip'),
    diemTichLuy INT,
    maNguoiQuanLy INT,  -- Người quản lý tạo khách hàng
    FOREIGN KEY (maTaiKhoan) REFERENCES TaiKhoan(maTaiKhoan),
    FOREIGN KEY (maNguoiQuanLy) REFERENCES NguoiQuanLy(maNguoiQuanLy)
);

-- Bảng MayTinh
CREATE TABLE MayTinh (
    maMayTinh INT PRIMARY KEY,
    tinhTrang NVARCHAR(50),
    maNguoiQuanLy INT,  -- Người quản lý bảo trì máy tính
    CONSTRAINT tinhTrangHienTaiCuaMayTinh CHECK (tinhTrang = 'Trong' OR tinhTrang = 'DangSuDung' OR tinhTrang = 'DangBaoTri'),
    FOREIGN KEY (maNguoiQuanLy) REFERENCES NguoiQuanLy(maNguoiQuanLy)
);

-- Bảng PhienDangNhap
CREATE TABLE PhienDangNhap (
	maPhienDangNhap INT PRIMARY KEY,
    maKhachHang INT,
    maMayTinh INT,
    thoiGianBatDau TIME,
    thoiGianSuDung TIME,
    thoiGianConLai TIME,
    FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang),
    FOREIGN KEY (maMayTinh) REFERENCES MayTinh(maMayTinh)
);

-- Bảng UuDai
CREATE TABLE UuDai (
    maUuDai INT PRIMARY KEY,
    tenUuDai NVARCHAR(100),
    giaTri DECIMAL(10, 2),
    thoiGianBatDau DATETIME,
    thoiGianKetThuc DATETIME,
    dieuKien NVARCHAR(255),
    soLuong INT,
    tinhTrang NVARCHAR(50) CHECK (tinhTrang = N'Còn hiệu lực' OR tinhTrang = 'Hết hiệu lực'),
    maNguoiQuanLy INT,  -- Người quản lý tạo ưu đãi
    FOREIGN KEY (maNguoiQuanLy) REFERENCES NguoiQuanLy(maNguoiQuanLy),
	CONSTRAINT chk_ThoiGian CHECK (thoiGianBatDau < thoiGianKetThuc)
);

-- Bảng DichVu
CREATE TABLE DichVu (
    maDichVu INT PRIMARY KEY,
    tenDichVu NVARCHAR(100),
    loaiDichVu NVARCHAR(50),
    donGia DECIMAL(10, 2),
    soLuong INT,
    maNguoiQuanLy INT,  -- Người quản lý phụ trách dịch vụ
    FOREIGN KEY (maNguoiQuanLy) REFERENCES NguoiQuanLy(maNguoiQuanLy)
);

-- Bảng HoaDon
CREATE TABLE HoaDon (
    maHoaDon INT PRIMARY KEY,
    thoiGianTao DATETIME,
    maKhachHang INT,
    maMayTinh INT,
    trangThai NVARCHAR(50),
    triGia DECIMAL(10, 2),
    maUuDai INT,
    maNguoiQuanLy INT,  -- Người quản lý xuất hóa đơn
    FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang),
    FOREIGN KEY (maMayTinh) REFERENCES MayTinh(maMayTinh),
    FOREIGN KEY (maUuDai) REFERENCES UuDai(maUuDai) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (maNguoiQuanLy) REFERENCES NguoiQuanLy(maNguoiQuanLy),
    CONSTRAINT trangThaiHienTaiCuaHoaDon CHECK (trangThai = 'ChuaThanhToan' OR trangThai = 'DaThanhToan')
);

-- Bảng ChiTietHoaDon
CREATE TABLE ChiTietHoaDon (
    maHoaDon INT,
    maDichVu INT,
    soLuong INT,
    tongGiaTien DECIMAL(10, 2),
	PRIMARY KEY (maHoaDon, maDichVu),
    FOREIGN KEY (maHoaDon) REFERENCES HoaDon(maHoaDon),
    FOREIGN KEY (maDichVu) REFERENCES DichVu(maDichVu) ON DELETE CASCADE
);

-- Bảng NapTien
CREATE TABLE NapTien (
    maKhachHang INT,
    thoiGianNapTien DATETIME,
    giaTriNap DECIMAL(10, 2),
    thoiGianQuyDoi TIME,
    maNguoiQuanLy INT,  -- Người quản lý xác nhận nạp tiền
	PRIMARY KEY (maKhachHang, maNguoiQuanLy, thoiGianNapTien),
    FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang),
    FOREIGN KEY (maNguoiQuanLy) REFERENCES NguoiQuanLy(maNguoiQuanLy)
);





Go
-- Trigger này sẽ kích hoạt sau khi có một bản ghi mới được thêm vào bảng PhienDangNhap
-- Khi khách hàng bắt đầu phiên đăng nhập, trạng thái máy tính sẽ được cập nhật thành "ĐangSuDung".
CREATE TRIGGER trg_UpdateTinhTrangMayTinh_AfterInsertPhienDangNhap
ON PhienDangNhap
AFTER INSERT
AS
BEGIN
    -- Khai báo biến để lưu mã máy tính
    DECLARE @maMayTinh INT;


    -- Lấy thông tin mã máy tính từ bản ghi vừa được thêm vào
    SELECT @maMayTinh = inserted.maMayTinh
    FROM inserted;


    -- Cập nhật trạng thái máy tính thành "ĐangSuDung"
    UPDATE MayTinh
    SET tinhTrang = 'DangSuDung'
    WHERE maMayTinh = @maMayTinh;
END;


Go
-- Trigger này sẽ kích hoạt sau khi một bản ghi bị xóa khỏi bảng PhienDangNhap
-- Khi khách hàng kết thúc phiên đăng nhập, trạng thái máy tính sẽ được đặt lại thành "Trống".
CREATE TRIGGER trg_UpdateTinhTrangMayTinh_AfterDeletePhienDangNhap
ON PhienDangNhap
AFTER DELETE
AS
BEGIN
    -- Khai báo biến để lưu mã máy tính
    DECLARE @maMayTinh INT;


    -- Lấy thông tin mã máy tính từ bản ghi vừa bị xóa
    SELECT @maMayTinh = deleted.maMayTinh
    FROM deleted;


    -- Cập nhật trạng thái máy tính thành "Trong"
    UPDATE MayTinh
    SET tinhTrang = 'Trong'
    WHERE maMayTinh = @maMayTinh;
END;



GO
Use QuanLyDichVuQuanNet
Go

-- View Danh sách khách hàng (sau khi nhấn vào nút "Quản lý thành viên" từ "Màn hình chính" của Quản lý)
CREATE VIEW QuanLyKhachHangView AS
SELECT 
    maKhachHang,
    maTaiKhoan,
    thoiGianConLai,
    loaiKhachHang,
    diemTichLuy
FROM KhachHang;



GO
-- View Danh sách máy tính (sau khi nhấn vào "quản lý máy" từ "Màn hình chính" của Quản lý)
CREATE VIEW QuanLyMayTinhView AS
SELECT mt.maMayTinh, 
       pdn.maKhachHang,
       mt.tinhTrang, 
       COALESCE(pdn.thoiGianBatDau, '00:00:00') AS thoiGianBatDau,
       COALESCE(pdn.thoiGianSuDung, '00:00:00') AS thoiGianSuDung,
       COALESCE(kh.thoiGianConLai, '00:00:00') AS thoiGianConLai -- Lấy thoiGianConLai từ KhachHang
FROM MayTinh mt
LEFT JOIN PhienDangNhap pdn ON mt.maMayTinh = pdn.maMayTinh
LEFT JOIN KhachHang kh ON pdn.maKhachHang = kh.maKhachHang; -- Thêm JOIN với bảng KhachHang



Go
-- View Danh sách dịch vụ chưa thanh toán (sau khi nhấn vào "quản lý gọi dịch vụ" từ "Màn hình chính" của Quản lý)
CREATE VIEW DichVuChuaThanhToanView AS
SELECT hd.maHoaDon, 
       hd.thoiGianTao, 
       hd.trangThai, 
       tk.taiKhoan AS tenTaiKhoan, 
	   hd.maUuDai,
       hd.triGia
FROM HoaDon hd
JOIN KhachHang kh ON hd.maKhachHang = kh.maKhachHang
JOIN TaiKhoan tk ON kh.maTaiKhoan = tk.maTaiKhoan
WHERE hd.trangThai = 'ChuaThanhToan';


Go
-- View Danh sách dịch vụ chưa thanh toán (sau khi nhấn vào "quản lý gọi dịch vụ" từ "Màn hình chính" của Quản lý)
CREATE VIEW DichVuDaThanhToanView AS
SELECT hd.maHoaDon, 
       hd.thoiGianTao, 
       hd.trangThai, 
       tk.taiKhoan AS tenTaiKhoan, 
	   hd.maUuDai,
       hd.triGia
FROM HoaDon hd
JOIN KhachHang kh ON hd.maKhachHang = kh.maKhachHang
JOIN TaiKhoan tk ON kh.maTaiKhoan = tk.maTaiKhoan
WHERE hd.trangThai = 'DaThanhToan';

Go
CREATE PROCEDURE sp_GetChiTietHoaDon
    @maHoaDon INT
AS
BEGIN
    SELECT * 
    FROM ChiTietHoaDonView 
    WHERE maHoaDon = @maHoaDon;
END;

Go
-- Khi quản lý hoặc người dùng ấn xem chi tiết hóa đơn
CREATE PROCEDURE XemChiTietHoaDonProcedure
    @maHoaDon INT
AS
BEGIN
    SELECT hd.maHoaDon, 
		hd.maUuDai,
		hd.thoiGianTao, 
		kh.maKhachHang,
		mt.maMayTinh, 
		dv.maDichVu, 
		cthd.soLuong, 
		cthd.tongGiaTien, 
		hd.triGia, 
		hd.trangThai
    FROM HoaDon hd
    JOIN KhachHang kh ON hd.maKhachHang = kh.maKhachHang
    JOIN TaiKhoan tk ON kh.maTaiKhoan = tk.maTaiKhoan
    JOIN MayTinh mt ON hd.maMayTinh = mt.maMayTinh
    JOIN ChiTietHoaDon cthd ON hd.maHoaDon = cthd.maHoaDon
    JOIN DichVu dv ON cthd.maDichVu = dv.maDichVu
    WHERE hd.maHoaDon = @maHoaDon;
END;
-- Thực thi bằng lệnh: EXEC XemChiTietHoaDonProcedure @maHoaDon = 1;

Go
CREATE PROCEDURE sp_CapNhatTinhTrangHoaDon
    @maHoaDon INT
AS
BEGIN
    DECLARE @maUuDai INT;

    -- Kiểm tra nếu hóa đơn tồn tại và có trạng thái 'ChuaThanhToan'
    IF EXISTS (SELECT 1 FROM HoaDon WHERE maHoaDon = @maHoaDon AND trangThai = 'ChuaThanhToan')
    BEGIN
        -- Lấy mã ưu đãi từ hóa đơn
        SELECT @maUuDai = maUuDai
        FROM HoaDon
        WHERE maHoaDon = @maHoaDon;

        -- Cập nhật trạng thái hóa đơn thành 'DaThanhToan'
        UPDATE HoaDon
        SET trangThai = 'DaThanhToan'
        WHERE maHoaDon = @maHoaDon;

        -- Nếu hóa đơn có mã ưu đãi, trừ số lượng ưu đãi đi một đơn vị
        IF @maUuDai IS NOT NULL
        BEGIN
            UPDATE UuDai
            SET soLuong = soLuong - 1
            WHERE maUuDai = @maUuDai AND soLuong > 0;
        END;

        -- Thông báo thành công
        PRINT 'Hóa đơn đã được Thanh Toán';
    END
    ELSE
    BEGIN
        -- Thông báo nếu hóa đơn không tồn tại hoặc không ở trạng thái 'ChuaThanhToan'
        PRINT 'Hóa đơn không tìm thấy.';
		END
END;
GO

Go
CREATE PROCEDURE sp_XemHoaDon_KhachHang
    @maKhachHang INT
AS
BEGIN
    -- Khai báo biến để lưu thông tin hóa đơn
    DECLARE @maHoaDon INT;

    -- Lấy mã hóa đơn lớn nhất của khách hàng
    SELECT TOP 1 @maHoaDon = maHoaDon
    FROM HoaDon
    WHERE maKhachHang = @maKhachHang AND trangThai = 'ChuaThanhToan'
    ORDER BY maHoaDon DESC;

    -- Trả về thông tin hóa đơn nếu tồn tại
    IF @maHoaDon IS NOT NULL
    BEGIN
        SELECT hd.maHoaDon, 
			hd.maUuDai,
			hd.thoiGianTao, 
			kh.maKhachHang,
			mt.maMayTinh, 
			dv.maDichVu, 
			cthd.soLuong, 
			cthd.tongGiaTien, 
			hd.triGia, 
			hd.trangThai
		FROM HoaDon hd
		JOIN KhachHang kh ON hd.maKhachHang = kh.maKhachHang
		JOIN TaiKhoan tk ON kh.maTaiKhoan = tk.maTaiKhoan
		JOIN MayTinh mt ON hd.maMayTinh = mt.maMayTinh
		JOIN ChiTietHoaDon cthd ON hd.maHoaDon = cthd.maHoaDon
		JOIN DichVu dv ON cthd.maDichVu = dv.maDichVu
		WHERE hd.maHoaDon = @maHoaDon;
    END
    ELSE
    BEGIN
        PRINT 'Không tìm thấy hóa đơn cho khách hàng';
    END
END;

go
-- View lọc theo loại dịch vụ "Đồ ăn"
CREATE VIEW DichVuDoAnView AS
SELECT maDichVu, tenDichVu, donGia, loaiDichVu, soLuong
FROM DichVu
WHERE loaiDichVu = N'Đồ ăn';
GO

-- View lọc theo loại dịch vụ "Thức uống"
CREATE VIEW DichVuThucUongView AS
SELECT maDichVu, tenDichVu, donGia, loaiDichVu, soLuong
FROM DichVu
WHERE loaiDichVu = N'Thức uống';
GO

-- View lọc theo loại dịch vụ "Thẻ cào"
CREATE VIEW DichVuTheCaoView AS
SELECT maDichVu, tenDichVu, donGia, loaiDichVu, soLuong
FROM DichVu
WHERE loaiDichVu = N'Thẻ cào';
GO

-- View lọc tất cả dịch vụ
CREATE VIEW DichVuView AS
SELECT maDichVu, tenDichVu, loaiDichVu, donGia, soLuong
FROM DichVu;
GO


CREATE VIEW ViewNapTien AS
SELECT 
    maKhachHang,
    thoiGianNapTien,
    giaTriNap,
    thoiGianQuyDoi
FROM NapTien;


Go
CREATE VIEW ViewPhienDangNhap AS
SELECT *
FROM PhienDangNhap;
go
-- VIEW cho khách hàng Thường
CREATE VIEW ViewUuDaiThuong AS
SELECT 
    maUuDai,
    tenUuDai,
    giaTri,
    thoiGianBatDau,
    thoiGianKetThuc,
    dieuKien,
    soLuong,
    tinhTrang
FROM UuDai
WHERE dieuKien = N'Tất cả khách hàng';
go
-- VIEW cho khách hàng VIP
CREATE VIEW ViewUuDaiVIP AS
SELECT 
    maUuDai,
    tenUuDai,
    giaTri,
    thoiGianBatDau,
    thoiGianKetThuc,
    dieuKien,
    soLuong,
    tinhTrang
FROM UuDai;
go
CREATE FUNCTION LayLoaiKhachHang (@maKhachHang INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @loaiKhachHang NVARCHAR(50);

    -- Truy vấn loại khách hàng dựa vào mã khách hàng
    SELECT @loaiKhachHang = loaiKhachHang
    FROM KhachHang
    WHERE maKhachHang = @maKhachHang;

    RETURN @loaiKhachHang;
END;
go

ALTER TABLE NapTien
ADD CONSTRAINT chk_giaTriNap CHECK (giaTriNap % 1000 = 0);




GO
CREATE FUNCTION KiemTraKhachHangDangNhap (
    @taiKhoan VARCHAR(50),
    @matKhau VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @maTaiKhoan INT;

    -- Kiểm tra tài khoản và mật khẩu, join với KhachHang 
    SELECT @maTaiKhoan = tk.maTaiKhoan
    FROM TaiKhoan tk
    JOIN KhachHang kh ON tk.maTaiKhoan = kh.maTaiKhoan
    WHERE tk.taiKhoan = @taiKhoan AND tk.matKhau = @matKhau;

    -- Trả về mã tài khoản nếu hợp lệ, ngược lại trả về NULL
    RETURN @maTaiKhoan;
END;
GO
CREATE FUNCTION KiemTraNguoiQuanLyDangNhap (
    @taiKhoan VARCHAR(50),
    @matKhau VARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @maNguoiQuanLy INT;

    -- Kiểm tra tài khoản và mật khẩu, join với NguoiQuanLy
    SELECT @maNguoiQuanLy = ql.maNguoiQuanLy
    FROM TaiKhoan tk
    JOIN NguoiQuanLy ql ON tk.maTaiKhoan = ql.maTaiKhoan
    WHERE tk.taiKhoan = @taiKhoan AND tk.matKhau = @matKhau;

    -- Trả về mã tài khoản nếu hợp lệ, ngược lại trả về NULL
    RETURN @maNguoiQuanLy;
END;

GO
CREATE FUNCTION GetTenTaiKhoan (
    @maTaiKhoan INT
)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @tenTaiKhoan NVARCHAR(255);
    
    -- Truy vấn tên tài khoản dựa trên mã tài khoản
    SELECT @tenTaiKhoan = taiKhoan 
    FROM TaiKhoan 
    WHERE maTaiKhoan = @maTaiKhoan;
    
    -- Trả về tên tài khoản
    RETURN @tenTaiKhoan;

END;

GO
CREATE PROC DoiMatKhau(
	@taiKhoan NVARCHAR(50),
	@matKhau NVARCHAR(50),
	@matKhauMoi NVARCHAR(50)
)
AS
BEGIN
	-- Kiểm tra mật khẩu nhập đã đúng chưa
    IF NOT EXISTS (SELECT 1 FROM TaiKhoan WHERE taiKhoan = @taiKhoan AND matKhau = @matKhau)
    BEGIN
        -- Nếu sai mật khẩu, sử dụng RAISERROR để trả về lỗi cho C#
        RAISERROR('Sai mật khẩu', 16, 1);
        RETURN;
    END
	-- Thực hiện cập nhật
	UPDATE TaiKhoan
	SET matKhau = @matKhauMoi
	WHERE taiKhoan = @taiKhoan;
END;


Go

CREATE PROCEDURE ThemPhienDangNhap
    @maKhachHang INT,
    @maMayTinh INT
AS
BEGIN
	-- Tìm giá trị maPhienDangNhap lớn nhất hiện có và tăng thêm 1
    DECLARE @maPhienDangNhap INT;
    SELECT @maPhienDangNhap = ISNULL(MAX(maPhienDangNhap), 0) + 1 FROM PhienDangNhap;

	-- Cài đặt thời gian bắt đầu sử dụng
	DECLARE @thoiGianBatDau TIME;
    SET @thoiGianBatDau= CONVERT(TIME, GETDATE());

	-- Tính toán thời gian đã sử dụng
    DECLARE @thoiGianSuDung TIME;
    SET @thoiGianSuDung = '00:00:00';


    -- Lấy thoiGianConLai của khách hàng
    DECLARE @thoiGianConLai TIME;
    SELECT @thoiGianConLai = thoiGianConLai FROM KhachHang WHERE maKhachHang = @maKhachHang;

    -- Thêm phiên đăng nhập
    INSERT INTO PhienDangNhap (maPhienDangNhap, maKhachHang, maMayTinh, thoiGianBatDau, thoiGianSuDung, thoiGianConLai)
    VALUES (@maPhienDangNhap, @maKhachHang, @maMayTinh, @thoiGianBatDau, @thoiGianSuDung, @thoiGianConLai);

END;

go
CREATE PROCEDURE NapTienProcedure
    @maKhachHang INT,
    @thoiGianNapTien DateTime,
    @giaTriNap decimal(10, 2),
    @thoiGianQuyDoi time(7),
	@maNguoiQuanLy INT
As
BEGIN
    -- Thêm bản ghi nạp tiền vào bảng NapTien
    INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy)
    VALUES (@maKhachHang, @thoiGianNapTien, @giaTriNap, @thoiGianQuyDoi, @maNguoiQuanLy);
END;
Go
CREATE TRIGGER trg_UpdateThoiGianConLaiVaDiemTichLuy_AfterNapTien
ON NapTien
AFTER INSERT
AS
BEGIN
    -- Khai báo các biến để lưu mã khách hàng, thời gian quy đổi và giá trị nạp
    DECLARE @maKhachHang INT, @thoiGianQuyDoi TIME, @giaTriNap DECIMAL(10,2);


    -- Lấy thông tin mã khách hàng, thời gian quy đổi và giá trị nạp từ bản ghi vừa được thêm vào
    SELECT @maKhachHang = inserted.maKhachHang, @thoiGianQuyDoi = inserted.thoiGianQuyDoi, @giaTriNap = inserted.giaTriNap
    FROM inserted;


    -- Cập nhật thời gian còn lại của khách hàng bằng cách cộng thêm thời gian quy đổi
    UPDATE KhachHang
    SET thoiGianConLai = DATEADD(MINUTE, DATEDIFF(MINUTE, '00:00:00', @thoiGianQuyDoi), thoiGianConLai)
    WHERE maKhachHang = @maKhachHang;


    -- Cộng thêm điểm tích lũy cho khách hàng dựa trên giá trị nạp (mỗi 1 tiếng được 1 điểm)
    UPDATE KhachHang
    SET diemTichLuy = diemTichLuy + FLOOR(@giaTriNap / 5000)
    WHERE maKhachHang = @maKhachHang;
END;

Go
CREATE PROCEDURE ThemDichVuProcedure
    @tenDichVu NVARCHAR(100),
    @loaiDichVu NVARCHAR(50),
    @donGia DECIMAL(10, 2),
    @soLuong INT,
	@maNguoiQuanLy INT
AS
BEGIN
    -- Tìm giá trị maDichVu lớn nhất hiện có và tăng thêm 1
    DECLARE @maDichVu INT;
    SELECT @maDichVu = ISNULL(MAX(maDichVu), 0) + 1 FROM DichVu;

    -- Thêm dịch vụ mới với maDichVu được tính toán
    INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy)
    VALUES (@maDichVu, @tenDichVu, @loaiDichVu, @donGia, @soLuong, @maNguoiQuanLy);

	PRINT 'Dịch vụ đã được thêm thành công';
END;
GO
CREATE PROCEDURE SuaDichVuProcedure
    @maDichVu INT,
    @tenDichVu NVARCHAR(100),
    @loaiDichVu NVARCHAR(50),
    @donGia DECIMAL(10, 2),
    @soLuong INT
AS
BEGIN
    -- Kiểm tra nếu dịch vụ tồn tại
    IF NOT EXISTS (SELECT * FROM DichVu WHERE maDichVu = @maDichVu)
    BEGIN
        PRINT 'Dịch vụ không tồn tại';
        RETURN;
    END
    -- Cập nhật thông tin dịch vụ
    UPDATE DichVu
    SET
        tenDichVu = @tenDichVu,
        loaiDichVu = @loaiDichVu,
        donGia = @donGia,
        soLuong = @soLuong
    WHERE maDichVu = @maDichVu;
END;

GO
CREATE TRIGGER tr_CheckDichVu
ON DichVu
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 
               FROM DichVu dv 
               JOIN inserted i ON dv.tenDichVu = i.tenDichVu AND dv.loaiDichVu = i.loaiDichVu)
    BEGIN
        -- Nếu dịch vụ đã tồn tại, hủy bỏ giao dịch
        RAISERROR ('Dịch vụ đã tồn tại', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Thêm dịch vụ nếu không tồn tại
        INSERT INTO DichVu(maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy)
        SELECT maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy FROM inserted;
    END
END;



GO
CREATE PROCEDURE XoaDichVuProcedure
    @maDichVu INT
AS
BEGIN
    -- Kiểm tra nếu dịch vụ tồn tại
    IF NOT EXISTS (SELECT * FROM DichVu WHERE maDichVu = @maDichVu)
    BEGIN
        PRINT 'Dịch vụ không tồn tại';
        RETURN;
    END

    -- Thực hiện xóa dịch vụ
    DELETE FROM DichVu WHERE maDichVu = @maDichVu;
END;
GO
CREATE PROCEDURE sp_AddKhachHang
    @taiKhoan VARCHAR(50),
    @matKhau VARCHAR(50),
	@maNguoiQuanLy INT
AS
BEGIN
    -- Kiểm tra xem tài khoản đã tồn tại hay chưa
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE taiKhoan = @taiKhoan)
    BEGIN
        -- Nếu tài khoản đã tồn tại, sử dụng RAISERROR để trả về lỗi cho C#
        RAISERROR('Tài khoản đã tồn tại', 16, 1);
        RETURN;
    END

    -- Nếu tài khoản chưa tồn tại, tiến hành thêm mới
    BEGIN
        -- Bước 1: Tìm giá trị maTaiKhoan lớn nhất hiện tại và cộng thêm 1
        DECLARE @maTaiKhoan INT;
        SELECT @maTaiKhoan = ISNULL(MAX(maTaiKhoan), 0) + 1 FROM TaiKhoan;

        -- Bước 2: Thêm vào bảng TaiKhoan
        INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau)
        VALUES (@maTaiKhoan, @taiKhoan, @matKhau);

        -- Bước 3: Tìm giá trị maKhachHang lớn nhất hiện tại và cộng thêm 1
        DECLARE @maKhachHang INT;
        SELECT @maKhachHang = ISNULL(MAX(maKhachHang), 0) + 1 FROM KhachHang;

        -- Bước 4: Thêm khách hàng mới vào bảng KhachHang
        INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy)
        VALUES (@maKhachHang, @maTaiKhoan, '00:00:00', N'Thường', 0, @maNguoiQuanLy);

        -- Thông báo thành công
        PRINT 'Thêm khách hàng thành công';
    END
END;
GO
CREATE TRIGGER CreateSQLAccountKhachHang
ON KhachHang
AFTER INSERT
AS
BEGIN
    DECLARE 
        @maTaiKhoan INT,
        @taiKhoan VARCHAR(50),
        @matKhau VARCHAR(50),
        @sqlString NVARCHAR(2000);

    -- Lấy giá trị từ bảng inserted (giả định chỉ có một hàng được chèn mỗi lần)
    SELECT @maTaiKhoan = i.maTaiKhoan, 
           @taiKhoan = tk.taiKhoan, 
           @matKhau = tk.matKhau
    FROM inserted i JOIN TaiKhoan tk ON
	 i.maTaiKhoan = tk.maTaiKhoan;

    -- Tạo tài khoản đăng nhập (LOGIN)
    SET @sqlString = 'CREATE LOGIN [' + @taiKhoan + '] WITH PASSWORD = ''' + @matKhau + ''', DEFAULT_DATABASE=[QuanLyDichVuQuanNet], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF';
    EXEC (@sqlString);

    -- Tạo người dùng (USER) liên kết với tài khoản đăng nhập
    SET @sqlString = 'CREATE USER [' + @taiKhoan + '] FOR LOGIN [' + @taiKhoan + ']';
    EXEC (@sqlString);

    SET @sqlString = ' ALTER  ROLE KhachHang ADD MEMBER '+ @taiKhoan;
	EXEC (@sqlString);
    
END;​

Go
GO
CREATE TRIGGER CreateSQLAccountQuanLy
ON NguoiQuanLy
AFTER INSERT
AS
BEGIN
    DECLARE 
        @maTaiKhoan INT,
        @taiKhoan VARCHAR(50),
        @matKhau VARCHAR(50),
        @sqlString NVARCHAR(2000);

    -- Lấy giá trị từ bảng inserted (giả định chỉ có một hàng được chèn mỗi lần)
    SELECT @maTaiKhoan = i.maTaiKhoan, 
           @taiKhoan = tk.taiKhoan, 
           @matKhau = tk.matKhau
    FROM inserted i JOIN TaiKhoan tk ON
	 i.maTaiKhoan = tk.maTaiKhoan;

    -- Tạo tài khoản đăng nhập (LOGIN)
    SET @sqlString = 'CREATE LOGIN [' + @taiKhoan + '] WITH PASSWORD = ''' + @matKhau + ''', DEFAULT_DATABASE=[QuanLyDichVuQuanNet], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF';
    EXEC (@sqlString);

    -- Tạo người dùng (USER) liên kết với tài khoản đăng nhập
    SET @sqlString = 'CREATE USER [' + @taiKhoan + '] FOR LOGIN [' + @taiKhoan + ']';
    EXEC (@sqlString);

    SET @sqlString = 'ALTER server ROLE sysadmin ADD MEMBER '+ @taiKhoan;
		EXEC (@sqlString);
    
END;​


GO
CREATE PROCEDURE TimKiemDichVuProcedure
    @tenDichVu NVARCHAR(100),
    @loaiDichVu NVARCHAR(50)
AS
BEGIN
    -- Tìm các dịch vụ có tên chứa chuỗi @tenDichVu
    SELECT * 
	FROM DichVu
	WHERE tenDichVu LIKE N'%' + @tenDichVu + N'%' 
		AND loaiDichVu = @loaiDichVu;
END;
GO
CREATE TRIGGER tr_CheckUuDai
ON UuDai
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 
               FROM UuDai dv 
               JOIN inserted i ON dv.tenUuDai = i.tenUuDai)
    BEGIN
        -- Nếu ưu đãi đã tồn tại, hủy bỏ giao dịch
        RAISERROR ('Ưu đãi đã tồn tại', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Thêm ưu đãi nếu không tồn tại
        INSERT INTO UuDai (maUuDai,tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy)
		SELECT maUuDai,tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy FROM inserted;

    END
END;

Go
CREATE PROCEDURE ThemUuDaiProcedure
    @tenUuDai NVARCHAR(100),
    @giaTri DECIMAL(10, 2),
    @thoiGianBatDau DATETIME,
    @thoiGianKetThuc DATETIME,
    @dieuKien NVARCHAR(255),
    @soLuong INT,
    @tinhTrang NVARCHAR(50),
	@maNguoiQuanLy INT
AS
BEGIN
	-- Tìm giá trị maUuDai lớn nhất hiện có và tăng thêm 1
    DECLARE @maUuDai INT;
    SELECT @maUuDai = ISNULL(MAX(maUuDai), 0) + 1 FROM UuDai;

	-- Thêm ưu đãi mới với maUuDai được tính toán
    INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy)
    VALUES (@maUuDai, @tenUuDai, @giaTri, @thoiGianBatDau, @thoiGianKetThuc, @dieuKien, @soLuong, @tinhTrang, @maNguoiQuanLy);
END;




Go
CREATE PROCEDURE SuaUuDaiProcedure
    @maUuDai INT,
    @tenUuDai NVARCHAR(100),
    @giaTri DECIMAL(10, 2),
    @thoiGianBatDau DATETIME,
    @thoiGianKetThuc DATETIME,
    @dieuKien NVARCHAR(255),
    @soLuong INT,
    @tinhTrang NVARCHAR(50)
AS
BEGIN
	-- Kiểm tra nếu ưu đãi tồn tại
    IF NOT EXISTS (SELECT * FROM UuDai WHERE maUuDai = @maUuDai)
    BEGIN
        PRINT 'Ưu đãi không tồn tại';
        RETURN;
    END
	-- Cập nhật thông tin ưu đãi
    UPDATE UuDai
    SET 
        tenUuDai = @tenUuDai,
        giaTri = @giaTri,
        thoiGianBatDau = @thoiGianBatDau,
        thoiGianKetThuc = @thoiGianKetThuc,
        dieuKien = @dieuKien,
        soLuong = @soLuong,
        tinhTrang = @tinhTrang
    WHERE maUuDai = @maUuDai;
END;


Go
CREATE PROCEDURE TimKiemUuDaiThuongProcedure
    @tenUuDai NVARCHAR(100)
AS
BEGIN
    SELECT * 
    FROM UuDai
    WHERE tenUuDai LIKE N'%' + @tenUuDai + '%' AND dieuKien = N'Tất cả khách hàng';
END;

Go
CREATE PROCEDURE TimKiemUuDaiVipProcedure
    @tenUuDai NVARCHAR(100)
AS
BEGIN
    SELECT * 
    FROM UuDai
    WHERE tenUuDai LIKE N'%' + @tenUuDai + '%';
END;

Go
CREATE PROCEDURE XoaUuDaiProcedure
    @maUuDai INT
AS
BEGIN
	-- Kiểm tra nếu ưu đãi tồn tại
    IF NOT EXISTS (SELECT * FROM UuDai WHERE maUuDai = @maUuDai)
    BEGIN
        PRINT 'Ưu đãi không tồn tại';
        RETURN;
    END

    DELETE FROM UuDai WHERE maUuDai = @maUuDai;
END;
GO
CREATE PROCEDURE sp_SearchKhachHangByTaiKhoan
    @taiKhoan VARCHAR(50)
AS
BEGIN
    SELECT kh.maKhachHang, kh.maTaiKhoan, tk.taiKhoan, kh.thoiGianConLai, kh.loaiKhachHang, kh.diemTichLuy
    FROM KhachHang kh
    JOIN TaiKhoan tk ON kh.maTaiKhoan = tk.maTaiKhoan
    WHERE tk.taiKhoan LIKE '%' + @taiKhoan + '%';
END;

Go
CREATE PROCEDURE dbo.XoaPhienDangNhap
    @maKhachHang INT,
	@thoiGianConLai Time
AS
BEGIN
    -- Cập nhật thời gian còn lại cho khách hàng
    UPDATE KhachHang
    SET thoiGianConLai = @thoiGianConLai
    WHERE maKhachHang = @maKhachHang;

    -- Xoá phiên đăng nhập
    DELETE FROM PhienDangNhap
    WHERE maKhachHang = @maKhachHang;
  
END;




Go
CREATE FUNCTION dbo.LayPhienDangNhap (@maKhachHang INT)
RETURNS TABLE
AS
RETURN
(
    SELECT maKhachHang, maMayTinh, thoiGianBatDau, thoiGianSuDung, thoiGianConLai
    FROM ViewPhienDangNhap
    WHERE maKhachHang = @maKhachHang
);
Go
CREATE PROCEDURE sp_ChuyenDoiMaKhachHangSangMaTaiKhoan
    @maKhachHang INT,
    @maTaiKhoan INT OUTPUT -- Sử dụng tham số OUTPUT để trả về mã tài khoản
AS
BEGIN
    -- Truy vấn để lấy mã tài khoản từ mã khách hàng
    SELECT @maTaiKhoan = kh.maTaiKhoan
    FROM KhachHang kh
    WHERE kh.maKhachHang = @maKhachHang;
END;


CREATE PROCEDURE sp_CalculateTongGiaTien
    @maDichVu INT,
    @maHoaDon INT
AS
BEGIN
    -- Khai báo biến để lưu đơn giá
    DECLARE @donGia DECIMAL(10,2), @soLuong INT;

    -- Lấy đơn giá của dịch vụ từ bảng DichVu
    SELECT @donGia = donGia
    FROM DichVu
    WHERE maDichVu = @maDichVu;

	SELECT @soLuong = soLuong
    FROM ChiTietHoaDon
    WHERE maDichVu = @maDichVu AND maHoaDon = @maHoaDon;

    -- Cập nhật tổng giá tiền cho chi tiết hóa đơn
    UPDATE ChiTietHoaDon
    SET tongGiaTien = @soLuong * @donGia
    WHERE maDichVu = @maDichVu AND maHoaDon = @maHoaDon;
END;
GO


GO
CREATE PROCEDURE sp_RecalculateTriGiaHoaDon
    @maHoaDon INT
AS
BEGIN
    -- Khai báo các biến cần thiết
    DECLARE @maUuDai INT;
    DECLARE @tongGiaTien DECIMAL(10, 2);
    DECLARE @giaTriUuDai DECIMAL(10, 2);

    -- Lấy mã ưu đãi từ hóa đơn
    SELECT @maUuDai = maUuDai
    FROM HoaDon
    WHERE maHoaDon = @maHoaDon;

    -- Tính tổng giá tiền của các dịch vụ trong ChiTietHoaDon cho hóa đơn hiện tại
    SELECT @tongGiaTien = SUM(tongGiaTien)
    FROM ChiTietHoaDon
    WHERE maHoaDon = @maHoaDon;

    -- Kiểm tra nếu maUuDai có trong hóa đơn, lấy giaTri của ưu đãi
    IF @maUuDai IS NOT NULL
    BEGIN
        SELECT @giaTriUuDai = giaTri
        FROM UuDai
        WHERE maUuDai = @maUuDai;

        -- Tính lại trị giá hóa đơn với ưu đãi (giảm giá theo phần trăm)
        UPDATE HoaDon
        SET triGia = @tongGiaTien * (1 - @giaTriUuDai / 100)
        WHERE maHoaDon = @maHoaDon;
    END
    ELSE
    BEGIN
        -- Nếu không có ưu đãi, trị giá hóa đơn chỉ là tổng giá tiền
        UPDATE HoaDon
        SET triGia = @tongGiaTien
        WHERE maHoaDon = @maHoaDon;
    END
END;
GO
Go
CREATE PROCEDURE sp_ThemDichVuVaoChiTietHoaDon
    @maKhachHang INT,
    @maMayTinh INT,
    @maDichVu INT,
    @soLuong INT
AS
BEGIN
    -- Bắt đầu transaction
    BEGIN TRANSACTION;
    
    DECLARE @maHoaDon INT;
    DECLARE @donGia DECIMAL(10, 2);
    DECLARE @tongGiaTien DECIMAL(10, 2);
    
    -- Kiểm tra hóa đơn chưa thanh toán của khách hàng
    SELECT @maHoaDon = maHoaDon 
    FROM HoaDon 
    WHERE maKhachHang = @maKhachHang 
      AND maMayTinh = @maMayTinh
      AND trangThai = 'ChuaThanhToan';

    -- Nếu hóa đơn chưa tồn tại, tạo hóa đơn mới
    IF @maHoaDon IS NULL
    BEGIN
		SET @maHoaDon = (SELECT ISNULL(MAX(maHoaDon), 0) + 1 FROM HoaDon);
        -- Tạo hóa đơn mới
        INSERT INTO HoaDon(maHoaDon, thoiGianTao, maKhachHang, maMayTinh, trangThai, triGia)
        VALUES (@maHoaDon, GETDATE(), @maKhachHang, @maMayTinh, 'ChuaThanhToan', 0);
        
    END

	-- Kiểm tra số lượng dịch vụ còn đủ không
    DECLARE @soLuongCon INT;
    SELECT @soLuongCon = soLuong FROM DichVu WHERE maDichVu = @maDichVu;

    IF @soLuong > @soLuongCon
    BEGIN
        RAISERROR('Số lượng dịch vụ không đủ', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Kiểm tra dịch vụ có tồn tại trong chi tiết hóa đơn chưa
    IF EXISTS (SELECT 1 FROM ChiTietHoaDon WHERE maHoaDon = @maHoaDon AND maDichVu = @maDichVu)
    BEGIN
        -- Lấy đơn giá của dịch vụ
        SELECT @donGia = donGia FROM DichVu WHERE maDichVu = @maDichVu;

        -- Cập nhật số lượng và tổng giá tiền
        UPDATE ChiTietHoaDon
        SET soLuong = soLuong + @soLuong
        WHERE maHoaDon = @maHoaDon AND maDichVu = @maDichVu;

		-- Gọi procedure để tính lại tổng giá tiền
        EXEC sp_CalculateTongGiaTien @maDichVu, @maHoaDon;
    END
    ELSE
    BEGIN

        -- Lấy đơn giá của dịch vụ
        SELECT @donGia = donGia FROM DichVu WHERE maDichVu = @maDichVu;

        -- Thêm vào ChiTietHoaDon
        INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong)
        VALUES (@maHoaDon, @maDichVu, @soLuong);

        -- Gọi procedure để tính tổng giá tiền
        EXEC sp_CalculateTongGiaTien @maDichVu, @maHoaDon;
    END

    -- Cập nhật số lượng dịch vụ trong bảng DichVu
    UPDATE DichVu
    SET soLuong = soLuong - @soLuong
    WHERE maDichVu = @maDichVu;

    EXEC sp_RecalculateTriGiaHoaDon @maHoaDon;

    -- Commit transaction
    COMMIT TRANSACTION;
END;


Go
CREATE FUNCTION fn_LayMaKhachHang(@maTaiKhoan INT)
RETURNS INT
AS
BEGIN
    DECLARE @maKhachHang INT;

    SELECT @maKhachHang = maKhachHang
    FROM KhachHang
    WHERE maTaiKhoan = @maTaiKhoan;

    RETURN @maKhachHang;
END;


Go
CREATE VIEW ChiTietHoaDonView AS
SELECT 
    cthd.maHoaDon,
    cthd.maDichVu,
    dv.tenDichVu,
    cthd.soLuong,
    cthd.tongGiaTien
FROM 
    ChiTietHoaDon cthd
JOIN 
    DichVu dv ON cthd.maDichVu = dv.maDichVu;

Go
CREATE PROCEDURE sp_UpdateTinhTrangMayTinh
    @maMayTinh INT,
    @tinhTrang NVARCHAR(50),
	@maNguoiQuanLy INT
AS
BEGIN
    UPDATE MayTinh
    SET tinhTrang = @tinhTrang,
		maNguoiQuanLy = @maNguoiQuanLy
    WHERE maMayTinh = @maMayTinh;
END;

Go
CREATE TRIGGER Update_LoaiKhachHang
ON [dbo].[KhachHang]
AFTER UPDATE
AS
BEGIN
    -- Khai báo các biến để lưu mã khách hàng, điểm tích lũy và loại khách hàng
    DECLARE @maKhachHang INT, @diemTichLuy INT, @loaiKhachHang NVARCHAR(50);

    -- Lấy thông tin mã khách hàng và điểm tích lũy từ bản ghi vừa được cập nhật
    SELECT @maKhachHang = inserted.maKhachHang, @diemTichLuy = inserted.diemTichLuy
    FROM inserted;

    -- Xác định loại khách hàng dựa trên điểm tích lũy
    IF @diemTichLuy >= 100 
    BEGIN
        SET @loaiKhachHang = 'Vip';
    END
    ELSE
    BEGIN
        SET @loaiKhachHang = N'Thường';
    END

    -- Cập nhật loại khách hàng trong bảng KhachHang
    UPDATE KhachHang
    SET loaiKhachHang = @loaiKhachHang
    WHERE maKhachHang = @maKhachHang;
END;

GO
-- sau procedure này sẽ tính toán lại trị giá hóa đơn (function)
CREATE PROCEDURE ThemMaUuDaiVaoHoaDon
    @maHoaDon INT,
    @maUuDai INT
AS
BEGIN
    DECLARE @soLuong INT, @thoiGianBatDau DATE, @thoiGianKetThuc DATE, @thoiGianHienTai DATE;
    SET @thoiGianHienTai = GETDATE();

    -- Kiểm tra xem mã hóa đơn có tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM HoaDon WHERE maHoaDon = @maHoaDon)
    BEGIN
        RAISERROR(N'Mã hóa đơn không tồn tại.', 16, 1);
        RETURN;
    END;

    -- Lấy thông tin ưu đãi: số lượng, ngày bắt đầu và ngày kết thúc
    SELECT @soLuong = soLuong, @thoiGianBatDau = thoiGianBatDau, @thoiGianKetThuc = thoiGianKetThuc
    FROM UuDai
    WHERE maUuDai = @maUuDai;

    -- Kiểm tra xem mã ưu đãi có tồn tại và số lượng còn lại có lớn hơn 0 hay không
    IF @soLuong IS NULL
    BEGIN
        RAISERROR(N'Mã ưu đãi không tồn tại.', 16, 1);
        RETURN;
    END;
    ELSE IF @soLuong <= 0
    BEGIN
        RAISERROR(N'Ưu đãi đã hết số lượng.', 16, 1);
        RETURN;
    END;

    -- Kiểm tra ngày hiện tại có nằm trong khoảng ngày bắt đầu và ngày kết thúc của ưu đãi hay không
    IF @thoiGianHienTai < @thoiGianBatDau OR @thoiGianHienTai > @thoiGianKetThuc
    BEGIN
        RAISERROR(N'Ưu đãi không hợp lệ cho ngày hiện tại.', 16, 1);
        RETURN;
    END;

    -- Cập nhật mã ưu đãi vào hóa đơn nếu tất cả điều kiện trên đều thỏa
    UPDATE HoaDon
    SET maUuDai = @maUuDai
    WHERE maHoaDon = @maHoaDon;

	EXEC sp_RecalculateTriGiaHoaDon @maHoaDon;

    PRINT 'Cập nhật mã ưu đãi thành công.';
END;
GO


Go
CREATE PROCEDURE sp_KiemTraThoiGianConLai
    @maKhachHang INT,
    @result BIT OUTPUT  -- Tham số OUTPUT kiểu BIT để trả về kết quả
AS
BEGIN
    DECLARE @thoiGianConLai TIME;

    -- Lấy thời gian còn lại từ bảng KhachHang
    SELECT @thoiGianConLai = thoiGianConLai
    FROM KhachHang
    WHERE maKhachHang = @maKhachHang;

    -- Kiểm tra nếu thoiGianConLai > '00:00:00' thì trả về 1 (true), ngược lại trả về 0 (false)
    IF @thoiGianConLai > '00:00:00'
        SET @result = 1;
    ELSE
        SET @result = 0;
END;
GO

CREATE ROLE NguoiQuanLy
CREATE ROLE KhachHang

--Gán các quyền truy cập view cho role KhachHang
GRANT SELECT ON ChiTietHoaDonView TO KhachHang;
GRANT SELECT ON DichVuChuaThanhToanView TO KhachHang;
GRANT SELECT ON DichVuDoAnView TO KhachHang;
GRANT SELECT ON DichVuTheCaoView TO KhachHang;
GRANT SELECT ON DichVuThucUongView TO KhachHang;
GRANT SELECT ON ViewUuDaiThuong TO KhachHang;
GRANT SELECT ON ViewUuDaiVIP TO KhachHang;
GRANT EXECUTE ON sp_XemHoaDon_KhachHang TO KhachHang;

--Gán các quyền thủ tục và hàm cho role KhachHang
GRANT EXECUTE ON DoiMatKhau TO KhachHang;
GRANT EXECUTE ON TimKiemDichVuProcedure TO KhachHang;
GRANT EXECUTE ON TimKiemUuDaiThuongProcedure TO KhachHang;
GRANT EXECUTE ON TimKiemUuDaiVipProcedure TO KhachHang;
GRANT EXECUTE ON sp_ThemDichVuVaoChiTietHoaDon TO KhachHang;
GRANT EXECUTE ON ThemMaUuDaiVaoHoaDon TO KhachHang;
GRANT EXECUTE ON sp_CapNhatTinhTrangHoaDon TO KhachHang;
GRANT EXECUTE ON sp_GetChiTietHoaDon TO KhachHang;
GRANT EXECUTE ON KiemTraKhachHangDangNhap TO KhachHang;
GRANT EXECUTE ON fn_LayMaKhachHang TO KhachHang;
GRANT EXECUTE ON layLoaiKhachHang TO KhachHang;



Go
-- Sau khi xóa dịch vụ, xóa những hóa đơn rỗng không chứa dịch vụ nào
CREATE TRIGGER trg_AfterDelete_DichVu
ON DichVu
AFTER DELETE
AS
BEGIN
    -- Xóa những hóa đơn không còn tồn tại trong bảng ChiTietHoaDon
    DELETE FROM HoaDon
    WHERE maHoaDon NOT IN (
        SELECT DISTINCT maHoaDon
        FROM ChiTietHoaDon
    );
END;



go

CREATE FUNCTION fn_TinhDoanhThuDichVuTheoNgay (@ngayTrongTuan INT, @loaiDichVu NVARCHAR(50))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @tongDoanhThu DECIMAL(18, 2);

    -- Tính tổng doanh thu từ loại dịch vụ được truyền vào theo ngày trong tuần
    SELECT @tongDoanhThu = SUM(cthd.tongGiaTien)
    FROM ChiTietHoaDon cthd
    JOIN DichVu dv ON cthd.maDichVu = dv.maDichVu
    JOIN HoaDon hd ON cthd.maHoaDon = hd.maHoaDon
    WHERE dv.loaiDichVu = @loaiDichVu
      AND hd.trangThai = 'DaThanhToan'
      AND DATEPART(WEEKDAY, hd.thoiGianTao) = @ngayTrongTuan;

    RETURN ISNULL(@tongDoanhThu, 0);
END;


go 
CREATE FUNCTION fn_TinhDoanhThuNapTienTheoNgay (@ngayTrongTuan INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @tongDoanhThu DECIMAL(18, 2);

    -- Tính tổng doanh thu từ nạp tiền theo ngày trong tuần
    SELECT @tongDoanhThu = SUM(giaTriNap)
    FROM NapTien
    WHERE DATEPART(WEEKDAY, thoiGianNapTien) = @ngayTrongTuan;

    RETURN ISNULL(@tongDoanhThu, 0);
END;

go
CREATE PROCEDURE sp_ThongKeDoanhThuTheoNgayTrongTuan
AS
BEGIN
    -- Bắt đầu giao dịch
    BEGIN TRANSACTION;

    BEGIN TRY
        DECLARE @ngayTrongTuan INT = 1;
        DECLARE @doanhThuDoAn DECIMAL(18, 2);
        DECLARE @doanhThuThucUong DECIMAL(18, 2);
        DECLARE @doanhThuTheCao DECIMAL(18, 2);
        DECLARE @doanhThuNapTien DECIMAL(18, 2);

        -- Tạo bảng tạm để lưu kết quả
        CREATE TABLE #ThongKeDoanhThu (
            NgayTrongTuan NVARCHAR(50),
            DoAn DECIMAL(18, 2),
            ThucUong DECIMAL(18, 2),
            TheCao DECIMAL(18, 2),
            NapTien DECIMAL(18, 2)
        );

        -- Vòng lặp từ Thứ Hai (1) đến Chủ Nhật (7)
        WHILE @ngayTrongTuan <= 7
        BEGIN
            -- Gọi hàm tính doanh thu cho từng loại dịch vụ
            SET @doanhThuDoAn = dbo.fn_TinhDoanhThuDichVuTheoNgay(@ngayTrongTuan, N'Đồ ăn');
            SET @doanhThuThucUong = dbo.fn_TinhDoanhThuDichVuTheoNgay(@ngayTrongTuan, N'Thức uống');
            SET @doanhThuTheCao = dbo.fn_TinhDoanhThuDichVuTheoNgay(@ngayTrongTuan, N'Thẻ cào');

            -- Gọi hàm tính doanh thu từ nạp tiền
            SET @doanhThuNapTien = dbo.fn_TinhDoanhThuNapTienTheoNgay(@ngayTrongTuan);

            -- Chèn kết quả vào bảng tạm
            INSERT INTO #ThongKeDoanhThu (NgayTrongTuan, DoAn, ThucUong, TheCao, NapTien)
            VALUES (
                CASE @ngayTrongTuan
                    WHEN 1 THEN N'Thứ Hai'
                    WHEN 2 THEN N'Thứ Ba'
                    WHEN 3 THEN N'Thứ Tư'
                    WHEN 4 THEN N'Thứ Năm'
                    WHEN 5 THEN N'Thứ Sáu'
                    WHEN 6 THEN N'Thứ Bảy'
                    WHEN 7 THEN N'Chủ Nhật'
                END,
                ISNULL(@doanhThuDoAn, 0),
                ISNULL(@doanhThuThucUong, 0),
                ISNULL(@doanhThuTheCao, 0),
                ISNULL(@doanhThuNapTien, 0)
            );

            -- Tăng biến đếm ngày
            SET @ngayTrongTuan = @ngayTrongTuan + 1;
        END

        -- Commit giao dịch nếu không có lỗi
        COMMIT TRANSACTION;

        -- Trả về kết quả
        SELECT * FROM #ThongKeDoanhThu;

        -- Xóa bảng tạm
        DROP TABLE #ThongKeDoanhThu;
    END TRY
    BEGIN CATCH
        -- Rollback giao dịch nếu có lỗi
        ROLLBACK TRANSACTION;

        -- In ra thông báo lỗi
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
Go
CREATE PROCEDURE sp_AddQuanLy
    @taiKhoan VARCHAR(50),
    @matKhau VARCHAR(50)
AS
BEGIN
    -- Kiểm tra xem tài khoản đã tồn tại hay chưa
    IF EXISTS (SELECT 1 FROM TaiKhoan WHERE taiKhoan = @taiKhoan)
    BEGIN
        -- Nếu tài khoản đã tồn tại, sử dụng RAISERROR để trả về lỗi cho C#
        RAISERROR('Tài khoản đã tồn tại', 16, 1);
        RETURN;
    END

    -- Nếu tài khoản chưa tồn tại, tiến hành thêm mới
    BEGIN
        -- Bước 1: Tìm giá trị maTaiKhoan lớn nhất hiện tại và cộng thêm 1
        DECLARE @maTaiKhoan INT;
        SELECT @maTaiKhoan = ISNULL(MAX(maTaiKhoan), 0) + 1 FROM TaiKhoan;

        -- Bước 2: Thêm vào bảng TaiKhoan
        INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau)
        VALUES (@maTaiKhoan, @taiKhoan, @matKhau);

        -- Bước 3: Tìm giá trị maNguoiQuanLy lớn nhất hiện tại và cộng thêm 1
        DECLARE @maNguoiQuanLy INT;
        SELECT @maNguoiQuanLy = ISNULL(MAX(maNguoiQuanLy), 0) + 1 FROM NguoiQuanLy;

        -- Bước 4: Thêm khách hàng mới vào bảng NguoiQuanLy
        INSERT INTO NguoiQuanLy (maNguoiQuanLy, maTaiKhoan)
        VALUES (@maNguoiQuanLy, @maTaiKhoan);

        -- Thông báo thành công
        PRINT 'Thêm quản lý thành công';
    END
END;



Go
Create TRIGGER UpdateThoiGianConLai_PhienDangNhap
ON KhachHang
AFTER UPDATE
AS
BEGIN
    -- Kiểm tra nếu cột thoiGianConLai được cập nhật
    IF UPDATE(thoiGianConLai)
    BEGIN
        -- Cập nhật thoiGianConLai trong bảng KhachHang dựa trên thay đổi ở bảng PhienDangNhap
        UPDATE PhienDangNhap
        SET PhienDangNhap.thoiGianConLai = inserted.thoiGianConLai
        FROM PhienDangNhap
        JOIN inserted ON PhienDangNhap.maKhachHang = inserted.maKhachHang
    END
END;

GO

-- Thêm 5 tài khoản cho người quản lý
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (0, 'm1', 'm1');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (1, 'm2', 'm2');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (2, 'm3', 'm3');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (3, 'm4', 'm4');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (4, 'm5', 'm5');
GO

-- Thêm dữ liệu vào bảng NguoiQuanLy
INSERT INTO NguoiQuanLy (maNguoiQuanLy, maTaiKhoan) VALUES (0, 0);
INSERT INTO NguoiQuanLy (maNguoiQuanLy, maTaiKhoan) VALUES (1, 1);
INSERT INTO NguoiQuanLy (maNguoiQuanLy, maTaiKhoan) VALUES (2, 2);
INSERT INTO NguoiQuanLy (maNguoiQuanLy, maTaiKhoan) VALUES (3, 3);
INSERT INTO NguoiQuanLy (maNguoiQuanLy, maTaiKhoan) VALUES (4, 4);
GO

-- Thêm 45 tài khoản cho khách hàng
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (5, 'u1', 'u1');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (6, 'u2', 'u2');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (7, 'u3', 'u3');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (8, 'u4', 'u4');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (9, 'u5', 'u5');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (10, 'u6', 'u6');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (11, 'u7', 'u7');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (12, 'u8', 'u8');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (13, 'u9', 'u9');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (14, 'u10', 'u10');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (15, 'u11', 'u11');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (16, 'u12', 'u12');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (17, 'u13', 'u13');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (18, 'u14', 'u14');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (19, 'u15', 'u15');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (20, 'u16', 'u16');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (21, 'u17', 'u17');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (22, 'u18', 'u18');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (23, 'u19', 'u19');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (24, 'u20', 'u20');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (25, 'u21', 'u21');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (26, 'u22', 'u22');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (27, 'u23', 'u23');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (28, 'u24', 'u24');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (29, 'u25', 'u25');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (30, 'u26', 'u26');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (31, 'u27', 'u27');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (32, 'u28', 'u28');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (33, 'u29', 'u29');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (34, 'u30', 'u30');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (35, 'u31', 'u31');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (36, 'u32', 'u32');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (37, 'u33', 'u33');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (38, 'u34', 'u34');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (39, 'u35', 'u35');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (40, 'u36', 'u36');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (41, 'u37', 'u37');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (42, 'u38', 'u38');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (43, 'u39', 'u39');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (44, 'u40', 'u40');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (45, 'u41', 'u41');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (46, 'u42', 'u42');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (47, 'u43', 'u43');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (48, 'u44', 'u44');
INSERT INTO TaiKhoan (maTaiKhoan, taiKhoan, matKhau) VALUES (49, 'u45', 'u45');

-- Thêm dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (0, 5, '01:00:00', N'Thường', 50, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (1, 6, '02:00:00', N'Thường', 80, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (2, 7, '03:00:00', N'VIP', 150, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (3, 8, '01:00:00', N'Thường', 90, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (4, 9, '02:00:00', N'VIP', 120, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (5, 10, '03:00:00', N'VIP', 200, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (6, 11, '01:00:00', N'Thường', 40, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (7, 12, '02:00:00', N'Thường', 70, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (8, 13, '03:00:00', N'VIP', 110, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (9, 14, '01:00:00', N'Thường', 30, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (10, 15, '02:00:00', N'Thường', 60, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (11, 16, '03:00:00', N'VIP', 130, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (12, 17, '01:00:00', N'Thường', 20, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (13, 18, '02:00:00', N'VIP', 140, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (14, 19, '03:00:00', N'VIP', 160, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (15, 20, '01:00:00', N'Thường', 50, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (16, 21, '02:00:00', N'Thường', 80, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (17, 22, '03:00:00', N'VIP', 170, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (18, 23, '01:00:00', N'Thường', 40, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (19, 24, '02:00:00', N'Thường', 60, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (20, 25, '03:00:00', N'VIP', 120, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (21, 26, '01:00:00', N'Thường', 70, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (22, 27, '02:00:00', N'VIP', 150, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (23, 28, '03:00:00', N'VIP', 200, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (24, 29, '01:00:00', N'Thường', 50, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (25, 30, '02:00:00', N'Thường', 90, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (26, 31, '03:00:00', N'VIP', 110, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (27, 32, '01:00:00', N'Thường', 30, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (28, 33, '02:00:00', N'Thường', 60, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (29, 34, '03:00:00', N'VIP', 140, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (30, 35, '01:00:00', N'Thường', 40, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (31, 36, '02:00:00', N'VIP', 130, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (32, 37, '03:00:00', N'VIP', 160, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (33, 38, '01:00:00', N'Thường', 50, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (34, 39, '02:00:00', N'Thường', 80, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (35, 40, '03:00:00', N'VIP', 170, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (36, 41, '01:00:00', N'Thường', 20, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (37, 42, '02:00:00', N'VIP', 180, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (38, 43, '03:00:00', N'VIP', 150, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (39, 44, '01:00:00', N'Thường', 60, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (40, 45, '02:00:00', N'Thường', 70, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (41, 46, '03:00:00', N'VIP', 190, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (42, 47, '01:00:00', N'Thường', 55, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (43, 48, '02:00:00', N'VIP', 175, 0);
INSERT INTO KhachHang (maKhachHang, maTaiKhoan, thoiGianConLai, loaiKhachHang, diemTichLuy, maNguoiQuanLy) VALUES (44, 49, '03:00:00', N'VIP', 180, 0);
GO

-- Thêm từng dịch vụ thuộc loại "Đồ ăn"
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (0, N'Bánh pizza', N'Đồ ăn', 80000.00, 50, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (1, N'Bánh xèo', N'Đồ ăn', 25000.00, 60, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (2, N'Bún cá', N'Đồ ăn', 30000.00, 70, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (3, N'Cơm chiên hải sản', N'Đồ ăn', 45000.00, 40, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (4, N'Mì Ý', N'Đồ ăn', 55000.00, 30, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (5, N'Phở bò tái', N'Đồ ăn', 40000.00, 80, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (6, N'Bánh chưng', N'Đồ ăn', 20000.00, 90, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (7, N'Bánh bột lọc Huế', N'Đồ ăn', 15000.00, 100, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (8, N'Bún thịt nướng', N'Đồ ăn', 35000.00, 55, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (9, N'Cháo vịt', N'Đồ ăn', 30000.00, 75, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (10, N'Gỏi gà', N'Đồ ăn', 40000.00, 45, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (11, N'Mì cay', N'Đồ ăn', 25000.00, 85, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (12, N'Xôi xéo', N'Đồ ăn', 20000.00, 65, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (13, N'Bánh bèo', N'Đồ ăn', 15000.00, 95, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (14, N'Bánh tét', N'Đồ ăn', 25000.00, 70, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (15, N'Nem nướng', N'Đồ ăn', 30000.00, 60, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (16, N'Bún chả', N'Đồ ăn', 35000.00, 80, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (17, N'Bánh khọt', N'Đồ ăn', 20000.00, 90, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (18, N'Bánh căn', N'Đồ ăn', 30000.00, 40, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (19, N'Chè thập cẩm', N'Đồ ăn', 15000.00, 100, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (20, N'Bún riêu cua', N'Đồ ăn', 35000.00, 55, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (21, N'Bánh mì que', N'Đồ ăn', 10000.00, 120, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (22, N'Bánh đúc', N'Đồ ăn', 15000.00, 85, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (23, N'Mì gói xào', N'Đồ ăn', 20000.00, 75, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (24, N'Bánh su kem', N'Đồ ăn', 25000.00, 65, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (25, N'Phở gà ta', N'Đồ ăn', 45000.00, 50, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (26, N'Cháo lòng', N'Đồ ăn', 30000.00, 70, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (27, N'Cơm cháy', N'Đồ ăn', 20000.00, 80, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (28, N'Bánh bao chiên', N'Đồ ăn', 15000.00, 95, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (29, N'Bánh xíu mại', N'Đồ ăn', 20000.00, 60, 0);
GO

-- Thêm từng dịch vụ thuộc loại "Thức uống"
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (30, N'Cafe đen đá', N'Thức uống', 15000.00, 80, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (31, N'Trá đào cam sả', N'Thức uống', 25000.00, 90, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (32, N'Soda chanh tươi', N'Thức uống', 18000.00, 100, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (33, N'Nước ép táo', N'Thức uống', 22000.00, 75, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (34, N'Matcha đá xay', N'Thức uống', 35000.00, 60, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (35, N'Sinh tố dâu tây', N'Thức uống', 30000.00, 50, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (36, N'Nước cam ép', N'Thức uống', 20000.00, 85, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (37, N'Sinh tố chuối', N'Thức uống', 25000.00, 70, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (38, N'Trá sữa trân châu', N'Thức uống', 30000.00, 65, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (39, N'Sữa đậu nành', N'Thức uống', 15000.00, 95, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (40, N'Trá gừng mật ong', N'Thức uống', 18000.00, 55, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (41, N'Soda bạc hà', N'Thức uống', 25000.00, 90, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (42, N'Sinh tố xoài', N'Thức uống', 30000.00, 80, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (43, N'Nước ép dưa hấu', N'Thức uống', 20000.00, 70, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (44, N'Soda chanh dây', N'Thức uống', 25000.00, 75, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (45, N'Sữa tươi trân châu', N'Thức uống', 35000.00, 65, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (46, N'Nước ép bưởi', N'Thức uống', 25000.00, 85, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (47, N'Sinh tố bơ', N'Thức uống', 30000.00, 60, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (48, N'Nước mía', N'Thức uống', 15000.00, 90, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (49, N'Sinh tố dưa leo', N'Thức uống', 18000.00, 100, 0);
GO

-- Thêm từng dịch vụ thuộc loại "Thẻ cào"
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (60, N'Thẻ Viettel 10k', N'Thẻ cào', 10000.00, 150, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (61, N'Thẻ Viettel 20k', N'Thẻ cào', 20000.00, 140, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (62, N'Thẻ Viettel 50k', N'Thẻ cào', 50000.00, 120, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (63, N'Thẻ Viettel 100k', N'Thẻ cào', 100000.00, 100, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (64, N'Thẻ Mobifone 10k', N'Thẻ cào', 10000.00, 180, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (65, N'Thẻ Mobifone 20k', N'Thẻ cào', 20000.00, 160, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (66, N'Thẻ Vinaphone 10k', N'Thẻ cào', 10000.00, 130, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (67, N'Thẻ Vinaphone 20k', N'Thẻ cào', 20000.00, 120, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (68, N'Thẻ Vietnamobile 10k', N'Thẻ cào', 10000.00, 150, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (69, N'Thẻ Gmobile 10k', N'Thẻ cào', 10000.00, 140, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (70, N'Thẻ Mobifone 200k', N'Thẻ cào', 200000.00, 100, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (71, N'Thẻ Vietnamobile 200k', N'Thẻ cào', 200000.00, 90, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (72, N'Thẻ Gmobile 200k', N'Thẻ cào', 200000.00, 80, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (73, N'Thẻ Viettel 300k', N'Thẻ cào', 300000.00, 70, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (74, N'Thẻ Vinaphone 300k', N'Thẻ cào', 300000.00, 60, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (75, N'Thẻ Mobifone 300k', N'Thẻ cào', 300000.00, 55, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (76, N'Thẻ Vietnamobile 300k', N'Thẻ cào', 300000.00, 50, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (77, N'Thẻ Gmobile 300k', N'Thẻ cào', 300000.00, 45, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (78, N'Thẻ Viettel 500k', N'Thẻ cào', 500000.00, 40, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (79, N'Thẻ Vinaphone 500k', N'Thẻ cào', 500000.00, 35, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (80, N'Thẻ Mobifone 500k', N'Thẻ cào', 500000.00, 30, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (81, N'Thẻ Vietnamobile 500k', N'Thẻ cào', 500000.00, 25, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (82, N'Thẻ Gmobile 500k', N'Thẻ cào', 500000.00, 20, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (83, N'Thẻ Viettel 1 triệu', N'Thẻ cào', 1000000.00, 15, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (84, N'Thẻ Vinaphone 1 triệu', N'Thẻ cào', 1000000.00, 10, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (85, N'Thẻ Mobifone 1 triệu', N'Thẻ cào', 1000000.00, 10, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (86, N'Thẻ Vietnamobile 1 triệu', N'Thẻ cào', 1000000.00, 8, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (87, N'Thẻ Gmobile 1 triệu', N'Thẻ cào', 1000000.00, 6, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (88, N'Thẻ Viettel 2 triệu', N'Thẻ cào', 2000000.00, 5, 0);
INSERT INTO DichVu (maDichVu, tenDichVu, loaiDichVu, donGia, soLuong, maNguoiQuanLy) VALUES (89, N'Thẻ Vinaphone 2 triệu', N'Thẻ cào', 2000000.00, 4, 0);
GO


-- Thêm từng máy tính vào bảng MayTinh
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (0, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (1, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (2, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (3, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (4, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (5, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (6, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (7, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (8, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (9, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (10, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (11, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (12, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (13, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (14, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (15, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (16, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (17, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (18, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (19, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (20, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (21, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (22, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (23, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (24, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (25, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (26, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (27, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (28, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (29, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (30, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (31, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (32, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (33, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (34, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (35, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (36, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (37, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (38, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (39, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (40, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (41, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (42, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (43, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (44, N'DangBaoTri', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (45, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (46, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (47, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (48, N'Trong', NULL);
INSERT INTO MayTinh (maMayTinh, tinhTrang, maNguoiQuanLy) VALUES (49, N'Trong', NULL);
GO


-- Thêm từng ưu đãi vào bảng UuDai
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (0, N'Giảm giá 5% toàn bộ hóa đơn', 5.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 150, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (1, N'Giảm giá 10% toàn bộ hóa đơn', 10.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 100, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (2, N'Ưu đãi giảm 15% hóa đơn', 15.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 120, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (3, N'Giảm ngay 20% khi thanh toán', 20.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 80, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (4, N'Khuyến mãi giảm giá 25%', 25.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 70, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (5, N'Giảm giá 30% toàn hóa đơn', 30.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 110, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (6, N'Tặng 35% giảm giá', 35.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 130, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (7, N'Ưu đãi giảm 40% hóa đơn', 40.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 100, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (8, N'Giảm ngay 45% toàn bộ', 45.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 60, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (9, N'Giảm giá đặc biệt 50%', 50.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 90, N'Còn hiệu lực', 0);

-- Tiếp tục với các ưu đãi còn lại
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (10, N'Ưu đãi giảm giá 5%', 5.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 200, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (11, N'Giảm giá 10% cho hóa đơn', 10.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 150, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (12, N'Ưu đãi hóa đơn giảm 15%', 15.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 140, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (13, N'Giảm giá 20% cho toàn bộ', 20.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 100, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (14, N'Giảm giá hóa đơn 25%', 25.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 80, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (15, N'Ưu đãi giảm 30% cho khách hàng', 30.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 70, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (16, N'Giảm giá hóa đơn 35%', 35.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 60, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (17, N'Giảm ngay 40% cho hóa đơn', 40.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 90, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (18, N'Khuyến mãi giảm 45%', 45.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 50, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (19, N'Giảm giá toàn bộ 50%', 50.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 150, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (20, N'Giảm giá 55%', 55.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 120, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (21, N'Ưu đãi giảm 60%', 60.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 100, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (22, N'Giảm giá 65%', 65.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 130, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (23, N'Giảm giá đặc biệt 70%', 70.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 90, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (24, N'Khuyến mãi 75% cho khách hàng VIP', 75.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 80, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (25, N'Giảm ngay 80% khi mua hàng', 80.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 70, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (26, N'Ưu đãi giảm 85% hóa đơn', 85.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 60, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (27, N'Giảm giá 90% toàn bộ dịch vụ', 90.00, GETDATE(), '2024-12-31', N'Tất cả khách hàng', 50, N'Còn hiệu lực', 0);
INSERT INTO UuDai (maUuDai, tenUuDai, giaTri, thoiGianBatDau, thoiGianKetThuc, dieuKien, soLuong, tinhTrang, maNguoiQuanLy) VALUES (28, N'Khuyến mãi đặc biệt giảm 95%', 95.00, GETDATE(), '2024-12-31', N'Khách hàng VIP', 40, N'Còn hiệu lực', 0);
GO

-- Thêm dữ liệu vào bảng NapTien
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (0, DATEADD(SECOND, 0, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (1, DATEADD(SECOND, 3, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (2, DATEADD(SECOND, 6, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (3, DATEADD(SECOND, 9, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (4, DATEADD(SECOND, 12, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (5, DATEADD(SECOND, 15, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (6, DATEADD(SECOND, 18, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (7, DATEADD(SECOND, 21, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (8, DATEADD(SECOND, 24, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (9, DATEADD(SECOND, 27, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (10, DATEADD(SECOND, 30, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (11, DATEADD(SECOND, 33, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (12, DATEADD(SECOND, 36, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (13, DATEADD(SECOND, 39, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (14, DATEADD(SECOND, 42, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (15, DATEADD(SECOND, 45, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (16, DATEADD(SECOND, 48, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (17, DATEADD(SECOND, 51, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (18, DATEADD(SECOND, 54, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (19, DATEADD(SECOND, 57, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (20, DATEADD(SECOND, 60, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (21, DATEADD(SECOND, 63, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (22, DATEADD(SECOND, 66, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (23, DATEADD(SECOND, 69, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (24, DATEADD(SECOND, 72, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (25, DATEADD(SECOND, 75, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (26, DATEADD(SECOND, 78, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (27, DATEADD(SECOND, 81, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (28, DATEADD(SECOND, 84, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (29, DATEADD(SECOND, 87, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (30, DATEADD(SECOND, 90, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (31, DATEADD(SECOND, 93, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (32, DATEADD(SECOND, 96, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (33, DATEADD(SECOND, 99, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (34, DATEADD(SECOND, 102, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (35, DATEADD(SECOND, 105, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (36, DATEADD(SECOND, 108, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (37, DATEADD(SECOND, 111, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (38, DATEADD(SECOND, 114, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (39, DATEADD(SECOND, 117, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (40, DATEADD(SECOND, 120, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (41, DATEADD(SECOND, 123, GETDATE()), 15000, '03:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (42, DATEADD(SECOND, 126, GETDATE()), 5000, '01:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (43, DATEADD(SECOND, 129, GETDATE()), 10000, '02:00:00', 0);
INSERT INTO NapTien (maKhachHang, thoiGianNapTien, giaTriNap, thoiGianQuyDoi, maNguoiQuanLy) VALUES (44, DATEADD(SECOND, 132, GETDATE()), 15000, '03:00:00', 0);
GO

-- Thêm hóa đơn vào bảng HoaDon và ChiTietHoaDon
INSERT INTO HoaDon (maHoaDon, thoiGianTao, maKhachHang, maMayTinh, trangThai, triGia, maUuDai, maNguoiQuanLy) VALUES (0, DATEADD(SECOND, 0, GETDATE()), 0, 0, 'ChuaThanhToan', 65000, 0, 0);
INSERT INTO HoaDon (maHoaDon, thoiGianTao, maKhachHang, maMayTinh, trangThai, triGia, maUuDai, maNguoiQuanLy) VALUES (1, DATEADD(SECOND, 3, GETDATE()), 1, 1, 'ChuaThanhToan', 115000, 1, 0);
INSERT INTO HoaDon (maHoaDon, thoiGianTao, maKhachHang, maMayTinh, trangThai, triGia, maUuDai, maNguoiQuanLy) VALUES (2, DATEADD(SECOND, 6, GETDATE()), 2, 2, 'DaThanhToan', 80750, 2, 0);
INSERT INTO HoaDon (maHoaDon, thoiGianTao, maKhachHang, maMayTinh, trangThai, triGia, maUuDai, maNguoiQuanLy) VALUES (3, DATEADD(SECOND, 9, GETDATE()), 3, 3, 'DaThanhToan', 48000, 3, 0);
INSERT INTO HoaDon (maHoaDon, thoiGianTao, maKhachHang, maMayTinh, trangThai, triGia, maUuDai, maNguoiQuanLy) VALUES (4, DATEADD(SECOND, 12, GETDATE()), 4, 4, 'DaThanhToan', 67500, 4, 0);

-- Hóa đơn 0
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (0, 0, 2, 40000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (0, 7, 1, 15000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (0, 15, 1, 10000);

-- Hóa đơn 1
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (1, 1, 3, 75000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (1, 8, 2, 20000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (1, 16, 1, 20000);

-- Hóa đơn 2
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (2, 2, 1, 30000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (2, 9, 1, 15000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (2, 17, 1, 50000);

-- Hóa đơn 3
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (3, 3, 1, 35000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (3, 10, 1, 5000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (3, 15, 2, 20000);

-- Hóa đơn 4
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (4, 4, 2, 30000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (4, 11, 1, 20000);
INSERT INTO ChiTietHoaDon (maHoaDon, maDichVu, soLuong, tongGiaTien) VALUES (4, 16, 2, 40000);




USE QuanLyDichVuQuanNet
GO

CREATE OR ALTER FUNCTION dbo.GetDanhHieuKhachHang(@maKhachHang INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @danhHieu NVARCHAR(100); -- Biến lưu trữ danh hiệu

    -- Lấy danh hiệu từ bảng KhachHang
    SELECT @danhHieu = danhHieu 
    FROM KhachHang 
    WHERE maKhachHang = @maKhachHang;

    -- Trả về danh hiệu
    RETURN @danhHieu;
END;
GO
CREATE or ALTER TRIGGER trg_DanhHieuThoiHan
ON PhienDangNhap
After INSERT
AS
BEGIN
	DECLARE @danhHieu BIT,
			@tenDanhHieu NVARCHAR(100);

	SET @danhHieu = 0;
	--Xét danh hiệu 'Tân binh' 
    DECLARE @danhHieuTanBinh BIT;
    DECLARE @maKhachHang INT;
    DECLARE @thoiGianBatDau TIME;

	SELECT @maKhachHang = maKhachHang
    FROM inserted;
	SET @danhHieuTanBinh = dbo.func_XetDanhHieuTanBinh(@maKhachHang)

	IF @danhHieuTanBinh = 1 
	BEGIN
		SET @danhHieu = 1;
		DECLARE @danhHieuTanBinhXuatSac BIT;
		-- Tân binh xuất sắc: Tân binh  có tổng giá trị nạp >= 100k || Thời gian chơi >= 10 tiếng
		SET @danhHieuTanBinhXuatSac = dbo.func_XetDanhHieuTanBinhXuatSac(@maKhachHang);
		IF @danhHieuTanBinhXuatSac = 1
		BEGIN 
		SET @tenDanhHieu =  N'Tân binh xuất sắc';
		END
		ELSE SET @tenDanhHieu = N'Tân binh';
	END

	--Xét danh hiệu 'Đại gia mới nổi'
	DECLARE @danhHieuDaiGiaMoiNoi BIT;
	SET @danhHieuDaiGiaMoiNoi = dbo.func_XetDanhHieuDaiGiaMoiNoi(@maKhachHang);
	IF @danhHieuDaiGiaMoiNoi = 1 
	BEGIN
		SET @danhHieu = 1;
		SET @tenDanhHieu = N'Đại gia mới nổi';
	END
	
	-- Kiểm tra khách hàng liệu có danh hiệu thời hạn
	IF @danhHieuDaiGiaMoiNoi = 1  or @danhHieuTanBinh = 1 
		BEGIN
			PRINT 'Cài đặt danh hiệu tạm thời'
		END
	ELSE
		BEGIN
			-- xét danh hiệu vĩnh viễn


			-- Người bạn đồng hành
			DECLARE @NguoiBanDongHanh BIT;
			SET @NguoiBanDongHanh = dbo.func_XetDanhHieuNguoiBanDongHanh(@maKhachHang);
			IF @NguoiBanDongHanh = 1 
			BEGIN 
				SET @danhHieu = 1;
				-- Người tiên phong
				DECLARE @NguoiTienPhong BIT;
				SET @NguoiTienPhong = dbo.func_XetDanhHieuNguoiTienPhong(@maKhachHang);
				IF @NguoiTienPhong = 1 
				SET @tenDanhHieu = N'Người tiên phong'
				ELSE
				SET @tenDanhHieu = N'Người bạn đồng hành'
			END
			


			-- Khắc kim đại lão
			DECLARE @khacKimDaiLao BIT;
			SET @khacKimDaiLao = dbo.func_XetDanhHieuKhacKimDaiLao(@maKhachHang);
			IF @khacKimDaiLao = 1 
			BEGIN
			SET @danhHieu = 1;
			SET @tenDanhHieu = N'Khắc kim đại lão'
			END

			--TopServer
			DECLARE @TopServer BIT;
			SET @TopServer = dbo.func_XetDanhHieuTopServer(@maKhachHang);
			IF @TopServer = 1 
			BEGIN
			SET @tenDanhHieu = N'TopServer'
			SET @danhHieu = 1;
			END

			IF @khacKimDaiLao = 1 AND @TopServer = 1 SET @tenDanhHieu = N'Huyền thoại đế vương'
						
			--Bậc thầy săn sale
			DECLARE @BacThaySanSale BIT;
			SET @BacThaySanSale = dbo.func_XetDanhHieuBacThaySanSale(@maKhachHang);
			IF @BacThaySanSale = 1 
			BEGIN
			SET @danhHieu = 1;
			SET @tenDanhHieu = N'Bậc thầy săn sale'
			END
			
		END
		-- Nếu khách hàng có danh hiệu thì sẽ là VIP, ngược lại sẽ là thường
	IF @danhHieu = 1 
		BEGIN
			UPDATE KhachHang
			SET loaiKhachHang = N'Vip', danhHieu = @tenDanhHieu
			WHERE maKhachHang = @maKhachHang;
		END
	ELSE
		BEGIN
			UPDATE KhachHang
			SET loaiKhachHang = N'Thường', danhHieu = N'Không có danh hiệu'
			WHERE maKhachHang = @maKhachHang;
		END
END;
GO

CREATE or ALTER function dbo.func_LayTongThoiGianChoi(@maKhachHang INT)
RETURNS TIME
BEGIN 
	DECLARE @tongThoiGianChoi TIME, 
			@tongThoiGianDaNap INT,
			@thoiGianConLai INT;
	
	SET @tongThoiGianDaNap = dbo.func_LayTongThoiGianDaNap(@maKhachHang);
	SET @thoiGianConLai  = dbo.func_LayThoiGianConLai(@maKhachHang);
	SET @tongThoiGianChoi = dbo.SEC_TO_TIME(@tongThoiGianDaNap - @ThoiGianConLai)
	RETURN @tongThoiGianChoi;
END;
GO
--Lấy thời gian còn lại trong tài khoản khách hàng
CREATE or ALTER function dbo.func_LayThoiGianConLai (@maKhachHang INT)
RETURNS INT
BEGIN
	DECLARE @thoiGianConLaiInSeconds INT;
	SELECT @thoiGianConLaiInSeconds = COALESCE(SUM(dbo.TIME_TO_SEC(thoiGianConLai)), 0)
	FROM KhachHang 
	WHERE maKhachHang = @maKhachHang;
	RETURN @thoiGianConLaiINSeconds;
END;
GO
--Lấy tổng thời gian đã nạp của khách hàng
CREATE or ALTER function func_LayTongThoiGianDaNap (@maKhachHang INT)
RETURNS INT
AS
BEGIN
	DECLARE @TongThoiGianInSeconds INT;

	SELECT @TongThoiGianInSeconds = COALESCE(SUM(dbo.TIME_TO_SEC(ThoiGianQuyDoi)), 0)
    FROM NapTien
    WHERE maKhachHang = @maKhachHang;

	RETURN @TongThoiGianInSeconds;
END;
GO
--Chuyển đổi giây thành thời gian
CREATE or ALTER function dbo.SEC_TO_TIME (@Seconds INT)
RETURNS TIME
AS
BEGIN
    RETURN CAST(DATEADD(SECOND, @Seconds, '00:00:00') AS TIME);
END;
GO
--Chuyển đổi thời gian thành giây
CREATE or ALTER function dbo.TIME_TO_SEC (@ThoiGian TIME)
RETURNS INT
AS
BEGIN
    DECLARE @TotalSeconds INT;
    
    -- Chuyển giờ, phút, giây thành tổng số giây
    SET @TotalSeconds = DATEPART(HOUR, @ThoiGian) * 3600  -- Giờ * 3600 giây
                        + DATEPART(MINUTE, @ThoiGian) * 60   -- Phút * 60 giây
                        + DATEPART(SECOND, @ThoiGian);        -- Giây
    
    RETURN @TotalSeconds;
END;
GO

CREATE or ALTER FUNCTION dbo.func_TongGiaTriHoaDonThangHienTai 
(
    @maKhachHang INT        -- Mã khách hàng
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @tongGiaTriHoaDon DECIMAL(18, 2);

    -- Tính tổng giá trị hóa đơn trong tháng và năm hiện tại của khách hàng
    SELECT @tongGiaTriHoaDon = COALESCE(SUM(triGia), 0)
    FROM HoaDon
    WHERE maKhachHang = @maKhachHang
      AND MONTH(thoiGianTao) = MONTH(GETDATE())  -- Lọc theo tháng hiện tại
      AND YEAR(thoiGianTao) = YEAR(GETDATE());  -- Lọc theo năm hiện tại

    RETURN @tongGiaTriHoaDon;
END;
GO
CREATE or ALTER FUNCTION dbo.func_TongGiaTriHoaDon 
(
    @maKhachHang INT        -- Mã khách hàng
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @tongGiaTriHoaDon DECIMAL(18, 2);

    -- Tính tổng giá trị hóa đơn trong tháng và năm hiện tại của khách hàng
    SELECT @tongGiaTriHoaDon = COALESCE(SUM(triGia), 0)
    FROM HoaDon
    WHERE maKhachHang = @maKhachHang

    RETURN @tongGiaTriHoaDon;
END;
GO
CREATE or ALTER FUNCTION dbo.func_TongGiaTriNapThangHienTai(@maKhachHang INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @tongGiaTriNap DECIMAL(18, 2);

    -- Tính tổng giá trị hóa đơn trong tháng và năm hiện tại của khách hàng
    SELECT @tongGiaTriNap = COALESCE(SUM(giaTriNap), 0)
    FROM NapTien
    WHERE maKhachHang = @maKhachHang
      AND MONTH(thoiGianNapTien) = MONTH(GETDATE())  -- Lọc theo tháng hiện tại
      AND YEAR(thoiGianNapTien) = YEAR(GETDATE());  -- Lọc theo năm hiện tại

    RETURN @tongGiaTriNap;
END;
GO
CREATE or ALTER FUNCTION dbo.func_TongGiaTriNap(@maKhachHang INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @tongGiaTriNap DECIMAL(18, 2);

    -- Tính tổng giá trị hóa đơn trong tháng và năm hiện tại của khách hàng
    SELECT @tongGiaTriNap = COALESCE(SUM(giaTriNap), 0)
    FROM NapTien
    WHERE maKhachHang = @maKhachHang

    RETURN @tongGiaTriNap;
END;
GO

--Hàm xét danh hiệu
CREATE or ALTER FUNCTION dbo.func_XetDanhHieuTanBinh (@maKhachHang INT)
RETURNS INT
BEGIN
    DECLARE @ngayTaoTaiKhoan DATETIME,  -- Thay đổi kiểu dữ liệu từ TIME sang DATETIME để so sánh với ngày giờ đầy đủ
            @ngayDangNhapHienTai DATETIME, 
            @thoiGianTaoTaiKhoan INT;

    -- Gán giá trị ngày tạo tài khoản từ bảng NapTien
    SELECT TOP 1 @ngayTaoTaiKhoan = thoiGianNapTien
    FROM NapTien
    WHERE maKhachHang = @maKhachHang
    ORDER BY thoiGianNapTien ASC;


    -- Tính thời gian giữa ngày tạo tài khoản và ngày đăng nhập hiện tại
    SET @thoiGianTaoTaiKhoan = DATEDIFF(DAY, @ngayTaoTaiKhoan, GETDATE());
    -- Kiểm tra xem thời gian tạo tài khoản có nhỏ hơn hoặc bằng 7 ngày không
    IF @thoiGianTaoTaiKhoan <= 7
    BEGIN
        RETURN 1;  -- Trả về 1 nếu thời gian nhỏ hơn hoặc bằng 7 ngày
    END
        RETURN 0;  -- Trả về 0 nếu thời gian lớn hơn 7 ngày
END;
GO
CREATE or ALTER FUNCTION dbo.func_XetDanhHieuTanBinhXuatSac (@maKhachHang INT)
RETURNS BIT
BEGIN
		-- Tân binh xuất sắc: Tân binh  có tổng giá trị nạp >= 100k || Thời gian chơi >= 10 tiếng
	DECLARE @tongGiaTriNap DECIMAL,
			@thoiGianChoi INT;

	SET @tongGiaTriNap = dbo.func_TongGiaTriNap(@maKhachHang);
	SET	@thoiGianChoi = dbo.TIME_TO_SEC(dbo.func_LayTongThoiGianChoi(@maKhachHang));
	
	DECLARE @thoiGianChoiToiThieu INT;
	SET @thoiGianChoiToiThieu = 10 * 3600; 

	IF @tongGiaTriNap >= 100000 AND @thoiGianChoi >= @thoiGianChoiToiThieu
	BEGIN
	RETURN 1;
	END		
RETURN 0;
END;
GO
CREATE or ALTER FUNCTION dbo.func_XetDanhHieuDaiGiaMoiNoi(@maKhachHang INT)
RETURNS BIT
BEGIN
--Tổng giá trị hóa đơn >= 2 triệu đồng và tổng giá trị nạp >= 150k trong 1 tháng
	DECLARE @tongGiaTriHoaDon DECIMAL,
			@tongGiaTriNap DECIMAL;
	SET @tongGiaTriHoaDon = dbo.func_TongGiaTriHoaDonThangHienTai(@maKhachHang);
	SET @tongGiaTriNap = dbo.func_TongGiaTriNapThangHienTai(@maKhachHang);

	IF @tongGiaTriHoaDon >= 2000000 AND @tongGiaTriNap >= 150000
	BEGIN
		RETURN 1;
	END
		RETURN 0;
END;
GO
CREATE or ALTER FUNCTION dbo.func_XetDanhHieuNguoiBanDongHanh (@maKhachHang INT)
RETURNS BIT
BEGIN
		-- Thời gian chơi >= 100 tiếng
	DECLARE @thoiGianChoi INT;

	SET	@thoiGianChoi = dbo.TIME_TO_SEC(dbo.func_LayTongThoiGianChoi(@maKhachHang));
	
	DECLARE @thoiGianChoiToiThieu INT;
	SET @thoiGianChoiToiThieu = 100 * 3600; 

	IF @thoiGianChoi >= @thoiGianChoiToiThieu
	BEGIN
	RETURN 1;
	END		
RETURN 0;
END;
GO
CREATE or ALTER FUNCTION dbo.func_XetDanhHieuKhacKimDaiLao (@maKhachHang INT)
RETURNS BIT
BEGIN
	-- Tổng giá trị nạp >= 1tr5 và tổng giá trị hóa đơn trong >= 10 triệu đồng
	DECLARE @tongGiaTriHoaDon DECIMAL,
			@tongGiaTriNap DECIMAL;
	SET @tongGiaTriHoaDon = dbo.func_TongGiaTriHoaDon(@maKhachHang);
	SET @tongGiaTriNap = dbo.func_TongGiaTriNap(@maKhachHang);

	IF @tongGiaTriHoaDon >= 10000000 AND @tongGiaTriNap >= 1500000
	BEGIN
		RETURN 1;
	END
		RETURN 0;
END;
GO
CREATE or ALTER FUNCTION dbo.func_XetDanhHieuTopServer (@maKhachHang INT)
RETURNS BIT
BEGIN
	-- Tổng giá trị nạp top 10
	DECLARE @tongGiaTriNap DECIMAL;
	SET @tongGiaTriNap = dbo.func_TongGiaTriNap(@maKhachHang);

	IF EXISTS (
        SELECT 1
        FROM (
            SELECT TOP 10 maKhachHang
            FROM NapTien
            GROUP BY maKhachHang
            ORDER BY SUM(giaTriNap) DESC
        ) AS Top10Customers
        WHERE Top10Customers.maKhachHang = @maKhachHang
    )
	BEGIN
		RETURN 1;
	END
		RETURN 0;
END;
GO
CREATE OR ALTER FUNCTION dbo.func_XetDanhHieuBacThaySanSale (@maKhachHang INT)
RETURNS BIT
BEGIN
    DECLARE @tongGiaTri DECIMAL,
            @suDungUuDai BIT;

	-- Lọc 10 hóa đơn gần đây nhất của khách hàng
		SELECT @tongGiaTri = SUM(triGia)
		FROM (
			SELECT TOP 10 triGia, maUuDai
			FROM HoaDon
			WHERE maKhachHang = @maKhachHang
			ORDER BY thoiGianTao DESC  -- Sắp xếp theo ngày mua gần nhất
		) AS Top10HoaDon;

    -- Kiểm tra xem 10 hóa đơn gần nhất của khách hàng liệu có dùng ưu đãi hay không
    IF EXISTS (
        SELECT 1
        FROM (
            SELECT TOP 10 maUuDai
            FROM HoaDon
            WHERE maKhachHang = @maKhachHang
            ORDER BY thoiGianTao DESC  -- Sắp xếp theo ngày gần đây nhất
        ) AS Top10HoaDon
        WHERE Top10HoaDon.maUuDai IS NULL  -- kiểm tra từng hóa đơn xem hóa đơn nào không sử dụng ưu đãi
    )
    BEGIN
        SET @suDungUuDai = 0;
    END SET @suDungUuDai = 1;-- Toàn bộ đều sử dụng ưu đãi

    IF @tongGiaTri >= 1000000 AND @suDungUuDai = 1
    BEGIN
        RETURN 1; 
    END
    RETURN 0;  
END;
GO
CREATE or ALTER FUNCTION dbo.func_XetDanhHieuNguoiTienPhong (@maKhachHang INT)
RETURNS BIT
BEGIN
		-- 10 người đầu tiên nạp tiền
	IF EXISTS (
        SELECT 1
        FROM (
            SELECT TOP 10 maKhachHang
            FROM NapTien
            ORDER BY thoiGianNapTien ASC  
        ) AS Top10KhachHang
        WHERE maKhachHang = @maKhachHang 
    )
	BEGIN
	RETURN 1;
	END		
RETURN 0;
END;
GO
GRANT EXECUTE ON [dbo].[GetDanhHieuKhachHang] TO [KhachHang];



Use QuanLyDichVuQuanNet
GO

CREATE FUNCTION PhanTichDoanhThuThang (
    @Thang NVARCHAR(7),  -- Tháng cần phân tích (YYYY-MM)
    @ThangTruoc NVARCHAR(7)  -- Tháng trước của tháng cần phân tích (YYYY-MM)
)
RETURNS @KetQua TABLE (
    PhanKhuc NVARCHAR(50),  -- Loại khách hàng (VIP, Thường, Mới)
    DoanhThuThangNay FLOAT,  -- Tổng doanh thu của tháng hiện tại
    DoanhThuThangTruoc FLOAT,  -- Tổng doanh thu của tháng trước
    TyLeTangTruong FLOAT,  -- Tỷ lệ tăng trưởng so với tháng trước (%)
    PhanLoaiDoanhThu NVARCHAR(50),  -- Phân loại tăng trưởng (Cao, Ổn định, Thấp)
    DeXuat NVARCHAR(255)  -- Đề xuất hành động dựa trên phân tích
)
AS
BEGIN
    INSERT INTO @KetQua
    SELECT 
        K.loaiKhachHang AS PhanKhuc,  -- Loại khách hàng

        -- Doanh thu tháng hiện tại
        SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @Thang THEN H.triGia ELSE 0 END) AS DoanhThuThangNay,

        -- Doanh thu tháng trước
        SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END) AS DoanhThuThangTruoc,

        -- Tỷ lệ tăng trưởng
        ISNULL(
            ((SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @Thang THEN H.triGia ELSE 0 END) - 
              SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END)) * 100.0 / 
              NULLIF(SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END), 0)
            ), 0
        ) AS TyLeTangTruong,

        -- Phân loại doanh thu dựa trên tỷ lệ tăng trưởng
        CASE 
            WHEN ISNULL(
                ((SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @Thang THEN H.triGia ELSE 0 END) - 
                  SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END)) * 100.0 / 
                  NULLIF(SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END), 0)
                ), 0) > 20 THEN N'Tăng trưởng cao (> 20%)'
            WHEN ISNULL(
                ((SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @Thang THEN H.triGia ELSE 0 END) - 
                  SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END)) * 100.0 / 
                  NULLIF(SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END), 0)
                ), 0) BETWEEN 5 AND 20 THEN N'Tăng trưởng ổn định (5% - 20%)'
            ELSE N'Tăng trưởng thấp (< 5%) hoặc giảm'
        END AS PhanLoaiDoanhThu,

        -- Đề xuất hành động dựa trên phân loại tăng trưởng và loại khách hàng
        CASE 
            -- Trường hợp tăng trưởng cao
            WHEN ISNULL(((SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @Thang THEN H.triGia ELSE 0 END) - 
                  SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END)) * 100.0 / 
                  NULLIF(SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END), 0)
                ), 0) > 20 THEN 
                CASE 
                    WHEN K.loaiKhachHang = N'VIP' THEN N'Tiếp tục đầu tư vào dịch vụ VIP, tổ chức sự kiện đặc biệt'
                    WHEN K.loaiKhachHang = N'Thường' THEN N'Tăng cường ưu đãi cho khách hàng thường xuyên'
                    WHEN K.loaiKhachHang = N'Mới' THEN N'Triển khai quảng cáo thu hút khách hàng mới'
                END
            
            -- Trường hợp tăng trưởng ổn định
            WHEN ISNULL(
                ((SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @Thang THEN H.triGia ELSE 0 END) - 
                  SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END)) * 100.0 / 
                  NULLIF(SUM(CASE WHEN CONVERT(VARCHAR(7), H.thoiGianTao, 120) = @ThangTruoc THEN H.triGia ELSE 0 END), 0)
                ), 0) BETWEEN 5 AND 20 THEN 
                CASE 
                    WHEN K.loaiKhachHang = N'VIP' THEN N'Duy trì chất lượng dịch vụ VIP, khảo sát ý kiến khách hàng'
                    WHEN K.loaiKhachHang = N'Thường' THEN N'Duy trì ưu đãi hiện tại và tăng trải nghiệm'
                    WHEN K.loaiKhachHang = N'Mới' THEN N'Cải thiện chương trình giữ chân khách hàng'
                END

            -- Trường hợp tăng trưởng thấp
            ELSE 
                CASE 
                    WHEN K.loaiKhachHang = N'VIP' THEN N'Tìm hiểu lý do giảm chi tiêu, tổ chức gặp mặt trực tiếp'
                    WHEN K.loaiKhachHang = N'Thường' THEN N'Tăng cường cải thiện dịch vụ, tạo ưu đãi quay lại'
                    WHEN K.loaiKhachHang = N'Mới' THEN N'Tập trung vào dịch vụ và chăm sóc khách hàng'
                END
        END AS DeXuat

    FROM HoaDon H
    JOIN KhachHang K ON H.maKhachHang = K.maKhachHang
    GROUP BY K.loaiKhachHang;

    RETURN;
END;
GO


CREATE PROCEDURE DuDoanDoanhThuTuPhanTichPhucTap
AS
BEGIN
    -- Tạo bảng tạm để lưu kết quả phân tích doanh thu
    CREATE TABLE #KetQuaPhanTich (
        PhanKhuc NVARCHAR(50),
        DoanhThuThangNay FLOAT,
        DoanhThuThangTruoc FLOAT,
        TyLeTangTruong FLOAT,
        PhanLoaiDoanhThu NVARCHAR(50),
        DeXuat NVARCHAR(255)
    );

    -- Tạo bảng tạm để lưu dự đoán
    CREATE TABLE #DuDoan (
        PhanKhuc NVARCHAR(50),
        DuDoanDoanhThu FLOAT,
        SoHoaDonDuDoan INT,
        KhachHangMoiDuDoan INT,
        KhachHangQuayLaiDuDoan INT,
        GhiChu NVARCHAR(255)
    );-- Phân tích từng tháng
    DECLARE @ThangHienTai NVARCHAR(7) = CONVERT(VARCHAR(7), GETDATE(), 120);
    DECLARE @ThangTruoc NVARCHAR(7) = CONVERT(VARCHAR(7), DATEADD(MONTH, -1, GETDATE()), 120);

    -- Chèn kết quả phân tích vào bảng tạm
    INSERT INTO #KetQuaPhanTich
    SELECT * FROM dbo.PhanTichDoanhThuThang(@ThangHienTai, @ThangTruoc);

    -- Phân tích chi tiết theo từng trường hợp
    SELECT 
        PhanKhuc,
        DoanhThuThangNay,
        DoanhThuThangTruoc,
        TyLeTangTruong,
        PhanLoaiDoanhThu,
        CASE 
            -- Tăng trưởng cao (>20%)
            WHEN TyLeTangTruong > 20 THEN 
                CASE 
                    WHEN PhanKhuc = N'VIP' AND TyLeTangTruong > 30 THEN N'Đẩy mạnh quảng cáo và dịch vụ cao cấp cho VIP'
                    WHEN PhanKhuc = N'VIP' THEN N'Duy trì chất lượng dịch vụ VIP và gói ưu đãi'
                    WHEN PhanKhuc = N'Thường' AND TyLeTangTruong > 20 THEN N'Chuyển đổi khách hàng thường thành VIP'
                    ELSE N'Tăng ưu đãi cho khách hàng thường'
                END

            -- Tăng trưởng ổn định (5%-20%)
            WHEN TyLeTangTruong BETWEEN 5 AND 20 THEN 
                CASE 
                    WHEN PhanKhuc = N'VIP' AND TyLeTangTruong < 10 THEN N'Tăng cường trải nghiệm khách hàng VIP'
                    WHEN PhanKhuc = N'VIP' THEN N'Duy trì các chương trình tri ân khách hàng'
                    WHEN PhanKhuc = N'Thường' THEN N'Triển khai các gói dịch vụ tiện lợi cho khách thường'
                END

            -- Tăng trưởng thấp hoặc âm (<5%)
            ELSE 
                CASE 
                    WHEN PhanKhuc = N'VIP' AND TyLeTangTruong < -20 THEN N'Khảo sát lý do giảm doanh thu VIP'
                    WHEN PhanKhuc = N'VIP' THEN N'Tăng cường chiến lược quảng cáo cho VIP'
                    WHEN PhanKhuc = N'Thường' THEN N'Tăng cường gói dịch vụ khuyến mãi'
                END
        END AS DeXuat
    FROM #KetQuaPhanTich;

    -- Dự đoán dựa trên kết quả phân tích
    INSERT INTO #DuDoan
    SELECT 
        PhanKhuc,
        -- Dự đoán doanh thu
        DoanhThuThangNay * (1 + (TyLeTangTruong / 100)) AS DuDoanDoanhThu,
        -- Dự đoán số hóa đơn
        CASE 
            WHEN TyLeTangTruong > 20 THEN COUNT(*) * 1.2
            WHEN TyLeTangTruong BETWEEN 5 AND 20 THEN COUNT(*) * 1.1
            ELSE COUNT(*) * 0.9
        END AS SoHoaDonDuDoan,
        -- Dự đoán số khách hàng mới
        CASE 
            WHEN TyLeTangTruong > 20 THEN COUNT(*) * 0.3
            WHEN TyLeTangTruong BETWEEN 5 AND 20 THEN COUNT(*) * 0.2
            ELSE COUNT(*) * 0.1
        END AS KhachHangMoiDuDoan,
        -- Dự đoán số khách hàng quay lại
        CASE 
            WHEN TyLeTangTruong > 20 THEN COUNT(*) * 0.7WHEN TyLeTangTruong BETWEEN 5 AND 20 THEN COUNT(*) * 0.6
            ELSE COUNT(*) * 0.5
        END AS KhachHangQuayLaiDuDoan,
        -- Ghi chú
        CASE 
            WHEN TyLeTangTruong > 20 THEN N'Kỳ vọng tăng trưởng mạnh, cần tập trung vào gói ưu đãi'
            WHEN TyLeTangTruong BETWEEN 5 AND 20 THEN N'Tăng trưởng ổn định, có thể mở rộng thêm dịch vụ'
            ELSE N'Tăng trưởng thấp, cần thay đổi chiến lược'
        END AS GhiChu
    FROM #KetQuaPhanTich
    GROUP BY PhanKhuc, DoanhThuThangNay, TyLeTangTruong;

    -- Kết quả Phân Tích
    SELECT 
        'Phân Tích Doanh Thu' AS LoaiKetQua,
        * 
    FROM #KetQuaPhanTich;

    -- Kết quả Dự Đoán
    SELECT 
        'Dự Đoán Doanh Thu' AS LoaiKetQua,
        * 
    FROM #DuDoan;

    -- Xóa bảng tạm
    DROP TABLE #KetQuaPhanTich;
    DROP TABLE #DuDoan;
END;
GO


USE QuanLyDichVuQuanNet;
GO

IF OBJECT_ID('dbo.TinhTongBonus', 'FN') IS NOT NULL
    DROP FUNCTION dbo.TinhTongBonus;
GO

CREATE FUNCTION dbo.TinhTongBonus (
    @MaKhachHang INT,
    @GiaTriNap DECIMAL(10, 2),
    @ThoiGianNapTien DATETIME
)
RETURNS FLOAT
AS
BEGIN
    -- Khai báo các biến
    DECLARE @TongBonus FLOAT = 0; -- Tổng % bonus
    DECLARE @SoLanNap INT;
    DECLARE @TongTienDaNap DECIMAL(10, 2);
    DECLARE @GioChoi FLOAT;
    DECLARE @SoLanNapTrongTuan INT;
    DECLARE @LoaiKhachHang NVARCHAR(50);

    -- Quy đổi tiền nạp ra giờ chơi
    SET @GioChoi = @GiaTriNap / 5000;

    -- 1. Lấy tổng số lần nạp
    SELECT @SoLanNap = COUNT(*) 
    FROM NapTien 
    WHERE maKhachHang = @MaKhachHang;

    -- 2. Tổng số tiền đã nạp
    SELECT @TongTienDaNap = SUM(giaTriNap) 
    FROM NapTien 
    WHERE maKhachHang = @MaKhachHang;

    -- 3. Số lần nạp hợp lệ trong tuần
    SELECT @SoLanNapTrongTuan = COUNT(*) 
    FROM NapTien 
    WHERE maKhachHang = @MaKhachHang 
      AND giaTriNap >= 50000 
      AND DATEDIFF(WEEK, thoiGianNapTien, @ThoiGianNapTien) = 0;

    -- 4. Loại khách hàng
    SELECT @LoaiKhachHang = LoaiKhachHang 
    FROM KhachHang 
    WHERE maKhachHang = @MaKhachHang;

    -- Bắt đầu tính toán tổng bonus %
    -- 1. Bonus lần nạp đầu tiên
    IF @SoLanNap = 0
        SET @TongBonus = @TongBonus + 30; -- Bonus 30% lần nạp đầu tiên

    -- 2. Bonus theo số lần nạp đặc biệt (lần thứ 5, 10, 15)
    IF @SoLanNap + 1 = 5
        SET @TongBonus = @TongBonus + 5; -- Bonus 5% lần thứ 5
    ELSE IF @SoLanNap + 1 = 10
        SET @TongBonus = @TongBonus + 10; -- Bonus 10% lần thứ 10
    ELSE IF @SoLanNap + 1 = 15
        SET @TongBonus = @TongBonus + 15; -- Bonus 15% lần thứ 15

    -- 3. Bonus dựa trên giờ chơi quy đổi
    IF @GioChoi > 5 AND @GioChoi <= 10
        SET @TongBonus = @TongBonus + 10; -- Bonus 10% nếu > 5h
    ELSE IF @GioChoi > 10
        SET @TongBonus = @TongBonus + 20; -- Bonus 20% nếu > 10h

    -- 4. Bonus theo tổng tiền nạp
    IF @TongTienDaNap > 500000 AND @TongTienDaNap <= 1000000
        SET @TongBonus = @TongBonus + 5; -- Bonus 5% nếu tổng tiền > 500k
    ELSE IF @TongTienDaNap > 1000000 AND @TongTienDaNap <= 2000000
        SET @TongBonus = @TongBonus + 10; -- Bonus 10% nếu tổng tiền > 1tr
    ELSE IF @TongTienDaNap > 2000000
        SET @TongBonus = @TongBonus + 20; -- Bonus 20% nếu tổng tiền > 2tr

    -- 5. Bonus theo số lần nạp trong tuần
    IF @SoLanNapTrongTuan = 2 
        SET @TongBonus = @TongBonus + 5; -- Bonus 5% lần thứ 3 trong tuần
    ELSE IF @SoLanNapTrongTuan >= 4 
        SET @TongBonus = @TongBonus + 10; -- Bonus 10% từ lần thứ 5 trở đi

    -- 6. Bonus giờ cao điểm (sau 20h)
    IF DATEPART(HOUR, @ThoiGianNapTien) >= 20
        SET @TongBonus = @TongBonus + 20; -- Bonus 20% giá trị nạp
		-- 7. Bonus theo danh hiệu hoặc loại khách hàng
    IF @LoaiKhachHang = 'VIP'
        SET @TongBonus = @TongBonus + 5; -- Bonus 5% cho khách hàng VIP

    -- 8. Bonus vào các ngày lễ hoặc dịp đặc biệt
    IF FORMAT(@ThoiGianNapTien, 'dd/MM') IN (
        '01/01', '02/02', '03/03', '04/04', '05/05', '06/06', 
        '07/07', '08/08', '09/09', '10/10', '11/11', '12/12'
    )
        SET @TongBonus = @TongBonus + 20; -- Bonus 20% cho ngày đặc biệt

    -- Kết quả cuối cùng: Tổng % bonus
    RETURN @TongBonus;
END;
GO