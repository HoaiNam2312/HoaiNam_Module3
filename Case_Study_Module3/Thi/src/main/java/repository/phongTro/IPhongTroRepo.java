package repository.employee;

import model.Employee;
import model.PhongTro;

import java.util.List;

public interface IPhongTroRepo {
    List<PhongTro> findAll();
    PhongTro findById(int id);
    boolean add(PhongTro employee);
    void delete(int id);
    List<PhongTro> search(String maPhongTro,String tenNguoiThue, String soDienThoai);
}
