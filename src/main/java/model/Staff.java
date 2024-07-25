package model;

import java.time.LocalDate;

public class Staff {
    private int staffID;
    private String email;
    private String password;
    private String fullname;
    private String address;
    private String phone_number;
    private String roleName;
    private LocalDate create_date;
    private LocalDate update_date;
    private String avatar;
    private boolean status;
    private boolean gender;

    public Staff() {
    }

    public Staff(int staffID, String fullname) {
        this.staffID = staffID;
        this.fullname = fullname;
    }

    public Staff(int staffID, String email, String password, String fullname, String address, String phone_number, String roleName, LocalDate create_date, LocalDate update_date, String avatar, boolean status, boolean gender) {
        this.staffID = staffID;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.address = address;
        this.phone_number = phone_number;
        this.roleName = roleName;
        this.create_date = create_date;
        this.update_date = update_date;
        this.avatar = avatar;
        this.status = status;
        this.gender = gender;
    }

    public Staff(int idCreater) {
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public LocalDate getCreate_date() {
        return create_date;
    }

    public void setCreate_date(LocalDate create_date) {
        this.create_date = create_date;
    }

    public LocalDate getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(LocalDate update_date) {
        this.update_date = update_date;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public boolean isStatus() {
        return status;
    }

    public String getStatus() {
        if(status == true) {
            return "Activate";
        }

        return "Deactivate";
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isGender() {
        return gender;
    }

    public String getGender() {
        if(gender == true) {
            return "Male";
        }

        return "Female";
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "Staff{" + "staffID=" + staffID + ", email=" + email + ", password=" + password + ", fullname=" + fullname + ", address=" + address + ", phone_number=" + phone_number + ", roleName=" + roleName + ", create_date=" + create_date + ", update_date=" + update_date + ", avatar=" + avatar + ", status=" + status + ", gender=" + gender + '}';
    }
    

}
