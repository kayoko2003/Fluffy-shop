package model;

import java.util.Date;
import java.util.Set;

public class Product {
    private int id;
    private String name;
    private Category category;
    private Brand brand;
    private String description;
    private double price;
    private String img;
    private String status;
    private int sockQuantity;
    private int numberSold;
    private Date createdDate;
    private Date updatedDate;
    private String createdBy;
    private String updatedBy;
    private Date deletedDate;
    private String deletedBy;
    private boolean isDeleted;
    private int importPrice;


    public Product() {
    }

    public Product(int id, String name, Category category, Brand brand, String description, double price, String img, String status, int sockQuantity, int numberSold, Date createdDate, Date updatedDate, String createdBy, String updatedBy, Date deletedDate, String deletedBy, boolean isDeleted, int importPrice) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.img = img;
        this.status = status;
        this.sockQuantity = sockQuantity;
        this.numberSold = numberSold;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.createdBy = createdBy;
        this.updatedBy = updatedBy;
        this.deletedDate = deletedDate;
        this.deletedBy = deletedBy;
        this.isDeleted = isDeleted;
        this.importPrice = importPrice;
    }

    public int getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(int importPrice) {
        this.importPrice = importPrice;
    }

    public Product(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Product(int id, double price, String name, String img) {
        this.id = id;
        this.price = price;
        this.name = name;
        this.img = img;
    }

    public Product(String img, String name, Category categories, double price) {
        this.img = img;
        this.name = name;
        this.category = categories;
        this.price = price;
    }

    public Product(int id) {
        this.id = id;
    }

    public Product(int productId, String productName, String productDescription,
                   double productPrice, String image, String productStatus) {
    }

    public Product(int id, String name, Category category, Brand brand, String description, double price, String img, String status) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.img = img;
        this.status = status;
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

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getSockQuantity() {
        return sockQuantity;
    }

    public void setSockQuantity(int sockQuantity) {
        this.sockQuantity = sockQuantity;
    }

    public int getNumberSold() {
        return numberSold;
    }

    public void setNumberSold(int numberSold) {
        this.numberSold = numberSold;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getDeletedDate() {
        return deletedDate;
    }

    public void setDeletedDate(Date deletedDate) {
        this.deletedDate = deletedDate;
    }

    public String getDeletedBy() {
        return deletedBy;
    }

    public void setDeletedBy(String deletedBy) {
        this.deletedBy = deletedBy;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", category=" + category +
                ", brand=" + brand +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", img='" + img + '\'' +
                ", status='" + status + '\'' +
                ", sockQuantity=" + sockQuantity +
                ", numberSold=" + numberSold +
                ", createdDate=" + createdDate +
                ", updatedDate=" + updatedDate +
                ", createdBy='" + createdBy + '\'' +
                ", updatedBy='" + updatedBy + '\'' +
                ", deletedDate=" + deletedDate +
                ", deletedBy='" + deletedBy + '\'' +
                ", isDeleted=" + isDeleted +
                '}';
    }
}
