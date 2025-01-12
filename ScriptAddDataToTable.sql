USE QuanLyDichVuQuanNet;
GO

-- Xóa dữ liệu cũ theo thứ tự khóa ngoại
DELETE FROM UuDai;
DELETE FROM KhachHang;
DELETE FROM NguoiQuanLy;
DELETE FROM TaiKhoan;
DELETE FROM ChiTietHoaDon;
DELETE FROM DichVu;
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


-- Xóa dữ liệu cũ trước khi thêm mới
GO
DELETE FROM ChiTietHoaDon;
DELETE FROM DichVu;

-- Tạm thời vô hiệu hóa trigger
DISABLE TRIGGER tr_CheckDichVu ON DichVu;
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

-- Bật lại trigger
ENABLE TRIGGER tr_CheckDichVu ON DichVu;
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

--Thêm giá trị vào bảng Ưu đãi
GO
-- Xóa dữ liệu cũ trước khi thêm mới
DELETE FROM UuDai;
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