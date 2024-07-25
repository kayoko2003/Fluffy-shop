package model;

import java.time.LocalDate;

public class Customer {
    private int customerID;
    private String email;
    private String password;
    private String fullname;
    private String address;
    private boolean gender;
    private String phoneNumber;
    private LocalDate dob;
    private LocalDate createDate;
    private LocalDate updateDate;
    private String token;
    private String status;
    private String img;
    private String log;

     public Customer() {

     }

    public Customer(int customerID, String email, String fullname) {
        this.customerID = customerID;
        this.email = email;
        this.fullname = fullname;
    }

    public Customer(int customerID, String email, String password, String fullname, String address, boolean gender, String phoneNumber, LocalDate dob, LocalDate createDate, LocalDate updateDate, String token, String status, String img) {
        this.customerID = customerID;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.address = address;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.token = token;
        this.status = status;
        this.img = img;
    }

    public Customer(int customerID, String email, String password, String fullname, String address, boolean gender, String phoneNumber, LocalDate dob, LocalDate createDate, LocalDate updateDate, String token, String status) {
        this.customerID = customerID;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.address = address;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.token = token;
        this.status = status;
    }

    public Customer(int customerID, String email, String password, String fullname, String address, boolean gender, String phoneNumber, LocalDate dob, LocalDate createDate, LocalDate updateDate, String token, String status, String img, String log) {
        this.customerID = customerID;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.address = address;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.token = token;
        this.status = status;
        this.img = img;
        this.log = log;
    }



    public boolean isGender() {
        return gender;
    }

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }



    public Customer(String fullname, boolean gender, String email, String phoneNumber, String address) {
        this.fullname = fullname;
        this.gender = gender;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
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

    public String getGender() {
        return gender ? "Male" : "Female";
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public LocalDate getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDate createDate) {
        this.createDate = createDate;
    }

    public LocalDate getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(LocalDate updateDate) {
        this.updateDate = updateDate;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "customerId=" + customerID +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", fullname='" + fullname + '\'' +
                ", address='" + address + '\'' +
                ", gender=" + gender +
                ", phoneNumber=" + phoneNumber +
                ", dob=" + dob +
                ", createDate=" + createDate +
                ", updateDate=" + updateDate +
                ", token='" + token + '\'' +
                ", status='" + status + '\'' +
                ", img='" + img + '\'' +
                ", log='" + log + '\'' +
                '}';
    }
}
