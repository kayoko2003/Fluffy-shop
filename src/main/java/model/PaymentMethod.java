package model;

public class PaymentMethod {
    private int id;
    private String method;

    public PaymentMethod() {
    }

    public PaymentMethod(int id, String method) {
        this.id = id;
        this.method = method;
    }

    public PaymentMethod(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    @Override
    public String toString() {
        return "PaymentMethod{" +
                "id=" + id +
                ", method='" + method + '\'' +
                '}';
    }
}
