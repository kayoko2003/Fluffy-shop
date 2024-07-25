<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- Header Section Begin -->
<header class="header">
    <style>
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background-color: #f5f5f5;
            color: #333;
            font-size: 16px;
            border: none;
            cursor: pointer;

        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 6px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown:hover .dropbtn {
            background-color: #f1f1f1;
        }
    </style>
    <div class="header__top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="header__top__left">
                        <ul>
                            <li><i class="fa fa-envelope"></i>fluffyshop@fpt.edu.vn</li>
                            <li>Free Shipping for all Order of $99</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="header__top__right">
                        <div class="header__top__right__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-linkedin"></i></a>
                            <a href="#"><i class="fa fa-pinterest-p"></i></a>
                        </div>
                        <div class="header__top__right__language">
                            <img src="img/language.png" alt="">
                            <div>English</div>
                            <span class="arrow_carrot-down"></span>
                            <ul>
                                <li><a href="#">Spanis</a></li>
                                <li><a href="#">English</a></li>
                            </ul>
                        </div>
                        <div class="header__top__right__auth">
                            <c:choose>
                                <c:when test="${acc == null}">
                                    <a href="login"><i class="fa fa-user"></i> Login</a>
                                </c:when>
                                <c:otherwise>
                                    <div class="dropdown">
                                        <button class="dropbtn"><i class="fa fa-user"></i>Hello: ${acc.fullname}
                                        </button>
                                        <div class="dropdown-content">
                                            <a href="profile">account</a>
                                            <a href="orders">orders</a>
                                            <a href="logout">logout</a>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        String currentURL = request.getRequestURL().toString();
        java.net.URL url = new java.net.URL(currentURL);
        String path = url.getPath();
        String[] pathComponents = path.split("/");
        String lastPathComponent = "/" + pathComponents[pathComponents.length - 1];

        String homeClass = "";
        if (lastPathComponent.equalsIgnoreCase("/Home.jsp")) {
            homeClass = "class=\"active\"";
        }

        String shopClass = "";
        if (lastPathComponent.equalsIgnoreCase("/Shopping.jsp") || lastPathComponent.equalsIgnoreCase("/ProductDetail.jsp")) {
            shopClass = "class=\"active\"";
        }

        String blogClass = "";
        if (lastPathComponent.equalsIgnoreCase("/BlogList.jsp") || lastPathComponent.equalsIgnoreCase("/BlogDetail.jsp")) {
            blogClass = "class=\"active\"";
        }

        String managerClass = "";
        if (lastPathComponent.equalsIgnoreCase("/manager.jsp")) {
            managerClass = "class=\"active\"";
        }
    %>
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="header__logo">
                    <a href="./index.html"><img src="img/logo.png" alt=""></a>
                </div>
            </div>
            <div class="col-lg-6">
                <nav class="header__menu">
                    <ul>
                        <li <%= homeClass %>><a href="home">Home</a></li>
                        <li <%= shopClass %>><a href="shopping">Shop</a></li>
                        <li><a href="#">Manager</a>
                        </li>
                        <li <%= blogClass %>><a href="bloglist">Blog</a></li>
                        <li><a href="./contact.html">Contact</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-3">
                <c:if test="${acc == null || isCustomer == 'true'}">
                    <div class="header__cart">
                        <ul>
                            <li><a href="cartdetail"><i class="fa fa-shopping-bag"></i>
                                <span>${acc == null ? '0' : size}</span></a></li>
                        </ul>
                        <div class="header__cart__price">item: <span>

                        <fmt:formatNumber value="${acc == null ? 0 : totalMoney}" type="number"
                                          minFractionDigits="0"
                                          maxFractionDigits="2"/></span></div>
                    </div>
                </c:if>
            </div>
        </div>
        <div class="humberger__open">
            <i class="fa fa-bars"></i>
        </div>
    </div>
</header>
<!-- Header Section End -->

<!-- Hero Section Begin -->
<section class="hero hero-normal">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="hero__categories">
                    <div class="hero__categories__all">
                        <i class="fa fa-bars"></i>
                        <span>All Category</span>
                    </div>
                    <ul>
                        <c:forEach items="${listC}" var="c">
                            <li><a href="shopping?category=${c.id}">${c.getName()}</a></li>
                        </c:forEach>
                        <c:forEach items="${listB}" var="b">
                            <li><a style="color: #70994e;" href="shopping?brand=${b.id}">${b.getName()}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="col-lg-9">
                <div class="hero__search">
                    <div class="hero__search__form">
                        <form action="shopping">
                            <input name="search" type="text" placeholder="What do you need?">
                            <button type="submit" class="site-btn">SEARCH</button>
                        </form>
                    </div>
                    <div class="hero__search__phone">
                        <div class="hero__search__phone__icon">
                            <i class="fa fa-phone"></i>
                        </div>
                        <div class="hero__search__phone__text">
                            <h5>+84 12345678</h5>
                            <span>support 24/7 time</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</section>
<!-- Hero Section End -->