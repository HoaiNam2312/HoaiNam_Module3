package model;

public class HinhThucThanhToan {
    private int id;
    private String kieuThue;

    public HinhThucThanhToan() {
    }

    public HinhThucThanhToan(int id, String kieuThue) {
        this.id = id;
        this.kieuThue = kieuThue;
    }

    public HinhThucThanhToan(String kieuThue) {
        this.kieuThue = kieuThue;
    }

    public HinhThucThanhToan(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getKieuThue() {
        return kieuThue;
    }

    public void setKieuThue(String kieuThue) {
        this.kieuThue = kieuThue;
    }
}
