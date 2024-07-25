package model;

import java.sql.Timestamp;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int customerId;
    private String fullName;
    private String email;
    private String address;
    private String phone;
    private PaymentMethod paymentMethod;
    private String note;
    private StatusOrder status;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private Staff staff;
    private String saleNote;
    private List<OrderDetail> orderDetails;


    public Order() {
        this.orderDetails = new ArrayList<>();

    }

    public Order(int id, int customerId, String fullName, String email, String address, String phone, PaymentMethod paymentMethod, String note, StatusOrder status, Timestamp createdDate, Timestamp updatedDate, Staff staff, String sale_note, List<OrderDetail> orderDetails) {
        this.id = id;
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.paymentMethod = paymentMethod;
        this.note = note;
        this.status = status;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.staff = staff;
        this.saleNote = sale_note;
        this.orderDetails = orderDetails;
    }

    public Order(int id, int customerId, String fullName, String email, String address, String phone, PaymentMethod paymentMethod, String note, StatusOrder status, Timestamp createdDate, Timestamp updatedDate, Staff staff, List<OrderDetail> orderDetails) {
        this.id = id;
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.paymentMethod = paymentMethod;
        this.note = note;
        this.status = status;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.staff = staff;
        this.orderDetails = orderDetails;
    }

    public Order(int id) {
        this.id = id;
    }


    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Order(int id, String fullName, String email, String phone, String address, Timestamp createdDate, StatusOrder status) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.createdDate = createdDate;
        this.status = status;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public StatusOrder getStatus() {
        return status;
    }

    public void setStatus(StatusOrder status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public String getSaleNote() {
        return saleNote;
    }

    public void setSaleNote(String saleNote) {
        this.saleNote = saleNote;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", customerId=" + customerId +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", paymentMethod=" + paymentMethod +
                ", note='" + note + '\'' +
                ", status=" + status +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                ", staff=" + staff +
                ", saleNote='" + saleNote + '\'' +
                ", orderDetails=" + orderDetails +
                '}';
    }
}
