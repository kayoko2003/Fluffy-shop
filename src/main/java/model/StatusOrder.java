package model;

public class StatusOrder {
    private int id;
    private String status;

    public StatusOrder() {
    }

    public StatusOrder(int id, String status) {
        this.id = id;
        this.status = status;
    }

    public StatusOrder(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "StatusOrder{" +
                "id=" + id +
                ", status='" + status + '\'' +
                '}';
    }
}
