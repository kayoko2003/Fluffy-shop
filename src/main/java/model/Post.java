package model;

import java.util.Date;

public class Post {
    private int postId;
    private String thumbnail;
    private String title;
    private PostCategory pcategory;
    private Staff staff;
    private String shortDetail;
    private String blogDetail;
    private boolean isShow;
    private Date createDate;
    private Date updateDate;

    public Post() {

    }

    public Post(int postId, String thumbnail, String title, PostCategory pcategory, Staff staff, String shortDetail, String blogDetail, boolean isShow, Date createDate, Date updateDate) {
        this.postId = postId;
        this.thumbnail = thumbnail;
        this.title = title;
        this.pcategory = pcategory;
        this.staff = staff;
        this.shortDetail = shortDetail;
        this.blogDetail = blogDetail;
        this.isShow = isShow;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }



    public Post(int postId, String thumbnail, String title, Staff staff, String shortDetail, Date updateDate) {
        this.postId = postId;
        this.thumbnail = thumbnail;
        this.title = title;
        this.staff = staff;
        this.shortDetail = shortDetail;
        this.updateDate = updateDate;
    }

    public Post(int postId, String thumbnail, String title) {
        this.postId = postId;
        this.thumbnail = thumbnail;
        this.title = title;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public PostCategory getPcategory() {
        return pcategory;
    }

    public void setPcategory(PostCategory pcategory) {
        this.pcategory = pcategory;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public String getShortDetail() {
        return shortDetail;
    }

    public void setShortDetail(String shortDetail) {
        this.shortDetail = shortDetail;
    }

    public String getBlogDetail() {
        return blogDetail;
    }

    public void setBlogDetail(String blogDetail) {
        this.blogDetail = blogDetail;
    }

    public boolean isShow() {
        return isShow;
    }

    public void setShow(boolean show) {
        isShow = show;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Override
    public String toString() {
        return "Post{" +
                "postId=" + postId +
                ", thumbnail='" + thumbnail + '\'' +
                ", title='" + title + '\'' +
                ", pcategory=" + pcategory +
                ", staff=" + staff +
                ", shortDetail='" + shortDetail + '\'' +
                ", blogDetail='" + blogDetail + '\'' +
                ", isShow=" + isShow +
                ", createDate=" + createDate +
                ", updateDate=" + updateDate +
                '}' + "\n";
    }
}