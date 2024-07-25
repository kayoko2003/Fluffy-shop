package model;

public class ShippingInfor {
    private int id;
    private int customerID;
    private String fullName;
    private String phone;
    private String address;
    private boolean isDefault;

    public ShippingInfor() {
    }

    public ShippingInfor(int id, int customerID, String fullName, String phone, String address, boolean isDefault) {
        this.id = id;
        this.customerID = customerID;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.isDefault = isDefault;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean aDefault) {
        isDefault = aDefault;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "ShippingInfor{" +
                "id=" + id +
                ", customerID=" + customerID +
                ", fullName='" + fullName + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", isDefault=" + isDefault +
                '}';
    }
}
