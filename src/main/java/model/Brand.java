package model;

public class Brand {
    private int id;
    private String name;
    private String detail;

    public Brand() {
    }

    public Brand(int id, String name, String detail) {
        this.id = id;
        this.name = name;
        this.detail = detail;
    }

    public Brand(int brand_id, String name_brand) {
        this.id = brand_id;
        this.name = name_brand;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    @Override
    public String toString() {
        return "Brand{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", detail='" + detail + '\'' +
                '}';
    }
}
