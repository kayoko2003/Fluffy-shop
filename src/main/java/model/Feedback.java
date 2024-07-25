package model;

import java.util.Date;


public class Feedback {
    private int feedbackId;
    private Customer customer;
    private Product product;
    private String content;
    private Date createdDate;
    private Date DeletedDate;
    private Staff deletedBy;
    private boolean isDeleted;
    private int rating;
    private Staff sale;
    private String imagePath;
    private Order orderId;

    public Feedback() {

    }

    @Override
    public String toString() {
        return "Feedback{" +
                "feedbackId=" + feedbackId +
                ", customer=" + customer +
                ", product=" + product +
                ", content='" + content + '\'' +
                ", createdDate=" + createdDate +
                ", DeletedDate=" + DeletedDate +
                ", deletedBy=" + deletedBy +
                ", isDeleted=" + isDeleted +
                ", rating=" + rating +
                ", sale=" + sale +
                ", imagePath='" + imagePath + '\'' +
                ", orderId=" + orderId +
                '}';
    }
    public Feedback(int feedbackId, Customer customer, Product product, String content, Date createdDate, Date deletedDate, Staff deletedBy, boolean isDeleted, int rating, Staff sale, Order orderId, String imagePath) {
        this.feedbackId = feedbackId;
        this.customer = customer;
        this.product = product;
        this.content = content;
        this.createdDate = createdDate;
        DeletedDate = deletedDate;
        this.deletedBy = deletedBy;
        this.isDeleted = isDeleted;
        this.rating = rating;
        this.sale = sale;
        this.orderId = orderId;
        this.imagePath = imagePath;
    }
    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Order getOrderId() {
        return orderId;
    }

    public void setOrderId(Order orderId) {
        this.orderId = orderId;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getDeletedDate() {
        return DeletedDate;
    }

    public void setDeletedDate(Date deletedDate) {
        DeletedDate = deletedDate;
    }

    public Staff getDeletedBy() {
        return deletedBy;
    }

    public void setDeletedBy(Staff deletedBy) {
        this.deletedBy = deletedBy;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public Staff getSale() {
        return sale;
    }

    public void setSale(Staff sale) {
        this.sale = sale;
    }

    public Feedback(int feedbackId) {
        this.feedbackId = feedbackId;
    }


    public Feedback(int feedbackId, Customer customer, Product product, String content, Date createdDate, Date deletedDate, Staff deletedBy, boolean isDeleted, int rating, Staff sale, String imagePath, Order orderId) {
        this.feedbackId = feedbackId;
        this.customer = customer;
        this.product = product;
        this.content = content;
        this.createdDate = createdDate;
        DeletedDate = deletedDate;
        this.deletedBy = deletedBy;
        this.isDeleted = isDeleted;
        this.rating = rating;
        this.sale = sale;
        this.imagePath = imagePath;
        this.orderId = orderId;
    }
}
