package repository.employee;

import repository.BaseRepository;
import model.*;
import model.HinhThucThanhToan;
import model.PhongTro;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PhongTroRepo implements IPhongTroRepo {
    private final String SELECT_ALL = "select * from phong_tro;";
        private final String SELECT_BY_ID = "select * from phong_tro where ma_phong_tro = ?;";
    private final String ADD = "insert into phong_tro(ten_nguoi_thue,so_dien_thoai,ngay_bat_dau,hinh_thuc_thanh_toan_id,ghi_chu) " +
            "values (?,?,?,?,?)";
    private final String DELETE = "delete from phong_tro where ma_phong_tro = ?";
    private final String SEARCH = "select * from phong_tro where ma_phong_tro like ? and ten_nguoi_thue like ? and so_dien_thoai like ?";
    @Override
    public List<PhongTro> findAll() {
        List<PhongTro> phongTroList = new ArrayList<>();

        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int maPhongTro = resultSet.getInt("ma_phong_tro");
                String tenNguoiThue = resultSet.getString("ten_nguoi_thue");
                String[] temp = resultSet.getString("ngay_bat_dau").split("-");
                String ngayBatDau = String.join("-", temp[2], temp[1], temp[0]);
                String soDienThoai = resultSet.getString("so_dien_thoai");
                HinhThucThanhToan hinhThucThanhToan = new HinhThucThanhToan(Integer.parseInt(resultSet.getString("hinh_thuc_thanh_toan_id")));
                String ghiChu = resultSet.getString("ghi_chu");
                phongTroList.add(new PhongTro(maPhongTro, tenNguoiThue, soDienThoai, ngayBatDau, hinhThucThanhToan, ghiChu));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return phongTroList;
    }

    @Override
    public PhongTro findById(int id) {
        PhongTro phongTro = null;
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_ID))
        {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            phongTro = new PhongTro();
            if (resultSet.next()) {
                phongTro.setMaPhongTro(resultSet.getInt("ma_phong_tro"));
                phongTro.setTenNguoiThue(resultSet.getString("ten_nguoi_thue"));
                String[] temp = resultSet.getString("ngay_bat_dau").split("-");
                String birthday = String.join("-", temp[2], temp[1], temp[0]);
                phongTro.setNgayBatDau(birthday);
                phongTro.setSoDienThoai(resultSet.getString("so_dien_thoai"));
                phongTro.setHinhThucThanhToan(new HinhThucThanhToan(resultSet.getInt("hinh_thuc_thanh_toan_id")));
                phongTro.setGhiChu(resultSet.getString("ghi_chu"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return phongTro;
    }


    @Override
    public boolean add(PhongTro phongTro) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(ADD);
            preparedStatement.setString(1, phongTro.getTenNguoiThue());
            preparedStatement.setString(2, phongTro.getSoDienThoai());
            preparedStatement.setString(3, phongTro.getNgayBatDau());
            preparedStatement.setInt(4, phongTro.getHinhThucThanhToan().getId());
            preparedStatement.setString(5, phongTro.getGhiChu());
            return preparedStatement.executeUpdate()>0;

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return false;
    }



    @Override
    public void delete(int id) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<PhongTro> search(String maPhongTro, String tenNguoiDung, String soDienThoai) {
        List<PhongTro> list = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        PhongTro phongTro = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SEARCH);
            preparedStatement.setString(1,"%"+maPhongTro+"%");
            preparedStatement.setString(2,"%"+tenNguoiDung+"%");
            preparedStatement.setString(3,"%"+soDienThoai+"%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                phongTro = new PhongTro();
                phongTro.setMaPhongTro(resultSet.getInt("ma_phong_tro"));
                phongTro.setTenNguoiThue(resultSet.getString("ten_nguoi_thue"));
                String[] temp = resultSet.getString("ngay_bat_dau").split("-");
                String birthday = String.join("-", temp[2], temp[1], temp[0]);
                phongTro.setNgayBatDau(birthday);
                phongTro.setSoDienThoai(resultSet.getString("so_dien_thoai"));
                phongTro.setHinhThucThanhToan(new HinhThucThanhToan(resultSet.getInt("hinh_thuc_thanh_toan_id")));
                phongTro.setGhiChu(resultSet.getString("ghi_chu"));
                list.add(phongTro);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
