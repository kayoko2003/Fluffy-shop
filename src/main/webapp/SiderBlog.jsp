<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-3">
    <div class="blog__sidebar">
        <div class="blog__sidebar__search">
            <form action="bloglist" >
                <input type="text" name="search" placeholder="Search...">
                <button type="submit"><span class="icon_search"></span></button>
            </form>
        </div>
        <div class="blog__sidebar__item">
            <h4>Categories</h4>
            <ul>
                <li><a style="${categoryId == null? "font-weight: bold" : ""}" href="bloglist">All</a></li>
                <c:forEach items="${postCategory}" var="p">
                    <li><a style="${p.getPostCId() == categoryId ? "font-weight: bold" : ""}" href="bloglist?categoryId=${p.getPostCId()}">${p.getPostCName()}</a></li>
                </c:forEach>
            </ul>
        </div>
        <div class="blog__sidebar__item">
            <h4>Recent News</h4>
            <div class="blog__sidebar__recent">
                <c:forEach items="${recentPost}" var="r">
                    <a href="blogdetail?bid=${r.postId}" class="blog__sidebar__recent__item">
                        <div class="blog__sidebar__recent__item__pic">
                            <img src="${r.thumbnail}" style="width: 80px;" alt="">
                        </div>
                        <div class="blog__sidebar__recent__item__text">
                            <h6>${r.title}</h6>
                            <span>${r.createDate}</span>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>