package model;

public class Slider {
    private int id;
    private String title;
    private String image;
    private String backlink;
    private boolean status;
    private String note;

    public Slider() {
    }

    public Slider(int id, String title, String image, String backlink, boolean status, String note) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.backlink = backlink;
        this.status = status;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBacklink() {
        return backlink;
    }

    public void setBacklink(String backlink) {
        this.backlink = backlink;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Slider{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", image='" + image + '\'' +
                ", backlink='" + backlink + '\'' +
                ", status=" + status +
                ", note='" + note + '\'' +
                '}';
    }
}
