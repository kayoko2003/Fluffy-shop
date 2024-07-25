package model;

public class PostCategory {
    private int PostCId;
    private String PostCName;

    public PostCategory() {

    }

    public PostCategory(int PostCId, String PostCName) {
        this.PostCId = PostCId;
        this.PostCName = PostCName;
    }

    public int getPostCId() {
        return PostCId;
    }

    public void setPostCId(int postCId) {
        this.PostCId = postCId;
    }

    public String getPostCName() {
        return PostCName;
    }

    public void setPostCName(String postCName) {
        this.PostCName = postCName;
    }

    @Override
    public String toString() {
        return "PostCategory{" +
                "PostCId=" + PostCId +
                ", PostCName='" + PostCName + '\'' +
                '}';
    }
}
