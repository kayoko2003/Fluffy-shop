package model;

public class Cart {
    private int quantity;
    private Product product;
    private Customer customer;

    public Cart() {

    }

    public Cart(int quantity, Product product, Customer customer) {
        this.quantity = quantity;
        this.product = product;
        this.customer = customer;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "quantity=" + quantity +
                ", product=" + product +
                ", customer=" + customer +
                '}';
    }
}
