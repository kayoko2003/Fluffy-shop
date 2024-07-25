<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Home</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="Static_acess_shop/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="Static_acess_shop/css/style.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    <style>
        #notification-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }

        .notification {
            background-color: red;
            color: white;
            padding: 20px 30px;
            margin-bottom: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .notification.show {
            opacity: 1;
        }
    </style>
</head>

<body>
<jsp:include page="Header.jsp"/>
<div id="notification-container"></div>
<!-- Check for notification message attribute -->
<c:if test="${not empty param.outStockQuantity}">
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            showNotification('${param.outStockQuantity}');
        });
    </script>
</c:if>

<style>
    .hero {
        position: relative;
        width: 100%;
    }

    .hero__item {
        background-size: cover;
        background-position: center;
        width: 100%;
        height: 500px;
    }

    .hero__text {
        position: absolute;
        bottom: 50px;
        left: 50px;
        color: #fff;
    }

    .owl-nav {
        position: absolute;
        top: 50%;
        width: 100%;
        display: flex;
        justify-content: space-between;
        transform: translateY(-50%);
        pointer-events: none;
    }

    .owl-prev, .owl-next {
        background: #fff;
        padding: 10px;
        border-radius: 50%;
        pointer-events: all;
    }

    .owl-prev {
        left: 10px;
    }

    .owl-next {
        right: 10px;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Owl Carousel JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<!-- Initialize Owl Carousel -->
<script>
    $(document).ready(function () {
        $('.owl-carousel').owlCarousel({
            loop: true,
            margin: 10,
            nav: true,
            items: 1,
            autoplay: true,
            autoplayTimeout: 3000,
            autoplayHoverPause: true,
            navText: ['<span class="owl-prev"><</span>', '<span class="owl-next">></span>']
        });
    });
</script>

<!-- Hero Section Begin -->
<section class="hero">
    <div class="container">
        <div class="col-lg-12">
            <div class="product__discount">
                <div class="row">
                    <div class="slider owl-carousel">
                        <c:forEach items="${slider}" var="s">
                            <c:if test="${s.status}">
                                <div class="col-lg-12">
                                    <div class="product__discount__item">
                                        <c:set var="image" value="${fn:replace(s.image, '\\\\', '/')}"/>
                                        <div class="product__discount__item__pic hero__item set-bg"
                                             data-setbg="${image}">
                                            <div class="hero__text" style="margin-left: -20px">
                                                <span>FLUFFY SHOP</span>
                                                <h2 style="font-size: 40px; color: red">${s.title}</h2>
                                                <p>${s.note}</p>
                                                <a href="${s.backlink}" class="primary-btn">SHOP NOW</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Hero Section End -->

<!-- Categories Section Begin -->
<section class="categories">
    <div class="container">
        <div class="row">
            <div class="categories__slider owl-carousel">
                <c:forEach items="${listC}" var="c">
                    <div class="col-lg-3">
                        <div class="categories__item set-bg"
                             data-setbg="Static_acess_shop/img/categories/${c.getId()}.jpg">
                            <h5><a href="shopping?category=${c.getId()}">${c.getName()}</a></h5>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</section>
<!-- Categories Section End -->

<!-- Featured Section Begin -->
<section class="featured spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <h2 style="margin-bottom: 0px">Featured Product</h2>
                </div>
                <div class="featured__controls">
                    <ul>
                        <li class="active" data-filter="*">All</li>
                        <c:forEach items="${listFeature}" var="l">
                            <c:choose>
                                <c:when test="${!displayedCategories.contains(l.getCategory().getName())}">
                                    <li data-filter=".category${l.getCategory().getId()}">${l.getCategory().getName()}</li>
                                    <c:set var="dummy" value="${displayedCategories.add(l.getCategory().getName())}"/>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <div class="row featured__filter">
            <c:forEach items="${listFeature}" var="l">
                <div class="col-lg-3 col-md-4 col-sm-6 mix category${l.getCategory().getId()}">
                    <div class="featured__item">
                        <c:set var="imgPath" value="${fn:replace(l.img, '\\\\', '/')}"/>
                        <div class="featured__item__pic set-bg" data-setbg="${imgPath}"
                             style='background-image: url("${imgPath}")'>
                            <c:if test="${acc == null || isCustomer == 'true'}">
                                <ul class="featured__item__pic__hover">
                                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                    <li><a href="addtocart?pid=${l.id}&home=true"><i
                                            class="fa fa-shopping-cart"></i></a></li>
                                </ul>
                            </c:if>
                        </div>
                        <div class="featured__item__text">
                            <h6><a href="productdetail?pid=${l.id}">${l.getName()}</a></h6>
                            <h5><fmt:formatNumber value="${l.price}" type="number"
                                                  minFractionDigits="0"
                                                  maxFractionDigits="2"/></h5>
                        </div>
                        <div class="featured__item__text"></div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<!-- Featured Section End -->

<!-- Banner Begin -->
<div class="banner">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="banner__pic">
                    <img src="Static_acess_shop/img/banner/banner-1.jpg" alt="">
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="banner__pic">
                    <img style="height: 281px; width: 100%;" src="Static_acess_shop/img/banner/banner-2.jpg" alt="">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Banner End -->

<!-- Latest Product Section Begin -->
<section class="latest-product spad" style="align-items: center">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-9">
                <div class="latest-product__text">
                    <h4 style="text-align: center">Latest Products</h4>
                    <div class="latest-product__slider owl-carousel" style="padding-left: 20%">
                        <div class="latest-prdouct__slider__item">
                            <c:forEach items="${latest}" var="l" begin="0" end="2">
                                <a href="productdetail?pid=${l.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${l.img}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${l.name}</h6>
                                        <span><fmt:formatNumber value="${l.price}" type="number"
                                                                minFractionDigits="0"
                                                                maxFractionDigits="2"/></span>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                        <div class="latest-prdouct__slider__item">
                            <c:forEach items="${latest}" var="l" begin="3">
                                <a href="productdetail?pid=${l.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${l.img}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${l.name}</h6>
                                        <span><fmt:formatNumber value="${l.price}" type="number"
                                                                minFractionDigits="0"
                                                                maxFractionDigits="2"/></span>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-9">
                <div class="latest-product__text">
                    <h4 style="text-align: center">Top Purchase</h4>
                    <div class="latest-product__slider owl-carousel" style="padding-left: 20%">
                        <div class="latest-prdouct__slider__item">
                            <c:forEach items="${listFeature}" var="p" begin="0" end="2">
                                <a href="productdetail?pid=${p.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${p.img}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${p.name}</h6>
                                        <span><fmt:formatNumber value="${p.price}" type="number"
                                                                minFractionDigits="0"
                                                                maxFractionDigits="2"/></span>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                        <div class="latest-prdouct__slider__item">
                            <c:forEach items="${listFeature}" var="p" begin="3" end="5">
                                <a href="productdetail?pid=${p.id}" class="latest-product__item">
                                    <div class="latest-product__item__pic">
                                        <img src="${p.img}" alt="">
                                    </div>
                                    <div class="latest-product__item__text">
                                        <h6>${p.name}</h6>
                                        <span><fmt:formatNumber value="${p.price}" type="number"
                                                                minFractionDigits="0"
                                                                maxFractionDigits="2"/></span>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Latest Product Section End -->

<!-- Blog Section Begin -->
<section class="from-blog spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title from-blog__title">
                    <h2>From The Blog</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <c:forEach items="${latestPost}" var="l">
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="blog__item">
                        <div class="blog__item__pic">
                            <img src="${l.thumbnail}" alt="">
                        </div>
                        <div class="blog__item__text">
                            <ul>
                                <li><i class="fa fa-calendar-o"></i>${l.createDate}</li>
                                    <%--                                <li><i class="fa fa-comment-o"></i> 5</li>--%>
                            </ul>
                            <h5><a href="blogdetail?bid=${l.postId}">${l.title}</a></h5>
                            <p>${l.shortDetail}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
<!-- Blog Section End -->

<!-- Footer Section Begin -->
<jsp:include page="Footer.jsp"/>
<!-- Footer Section End -->

<!-- Js Plugins -->
<script src="Static_acess_shop/js/jquery-3.3.1.min.js"></script>
<script src="Static_acess_shop/js/bootstrap.min.js"></script>
<script src="Static_acess_shop/js/jquery.nice-select.min.js"></script>
<script src="Static_acess_shop/js/jquery-ui.min.js"></script>
<script src="Static_acess_shop/js/jquery.slicknav.js"></script>
<script src="Static_acess_shop/js/mixitup.min.js"></script>
<script src="Static_acess_shop/js/owl.carousel.min.js"></script>
<script src="Static_acess_shop/js/main.js"></script>
<script>
    function showNotification(message) {
        const container = document.getElementById('notification-container');

        const notification = document.createElement('div');
        notification.classList.add('notification');
        notification.textContent = message;

        container.appendChild(notification);

        setTimeout(() => {
            notification.classList.add('show');
        }, 10);

        setTimeout(() => {
            notification.classList.remove('show');
            setTimeout(() => {
                container.removeChild(notification);
            }, 500);
        }, 3000);
    }
</script>

</body>

</html>