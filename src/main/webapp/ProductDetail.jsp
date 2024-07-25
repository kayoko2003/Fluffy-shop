<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Product Detail</title>

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

<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="Static_acess_shop/img/breadcrumbblog.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Product Detail</h2>
                    <div class="breadcrumb__option">
                        <a href="./index.html">Home</a>
                        <a>${product.getCategory().getName()}</a>
                        <span>${product.getName()}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Blog Section Begin -->
<section class="blog spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3" style="height: 947px;">
                <jsp:include page="SiderShop.jsp"/>
            </div>
            <div class="col-lg-9">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="product__details__pic">
                            <div class="product__details__pic__item">
                                <img class="product__details__pic__item--large"
                                     src="${product.img}" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <form action="addtocart" method="get">
                            <div class="product__details__text">
                                <h3>${product.name}</h3>
                                <div class="product__details__rating">
                                    <span>(18 feedback)</span>
                                </div>
                                <div class="product__details__price"><fmt:formatNumber value="${product.price}"
                                                                                       type="number"
                                                                                       minFractionDigits="0"
                                                                                       maxFractionDigits="2"/></div>
                                <p>${product.description}</p>
                                <c:if test="${product.getSockQuantity() - holdNumber > 0}">
                                    <div class="product__details__quantity">
                                        <div class="quantity">
                                            <div class="pro-qty">
                                                <c:if test="${num != null}">
                                                    <input type="text" name="quantity" value="${num}">
                                                </c:if>
                                                <c:if test="${num == null}">
                                                    <input type="text" name="quantity" value="1">
                                                </c:if>
                                                <% session.removeAttribute("num"); %>
                                            </div>
                                        </div>
                                    </div>
                                    <input name="pid" value="${product.id}" hidden/>
                                    <input hidden id="userRole" value="${isCustomer}" />
                                    <input hidden id="login" value="${acc == null ? 'true': ''}" />
                                    <button type="submit" class="primary-btn" id="submitButton" >ADD TO CARD</button>

                                    <script>
                                        document.getElementById('submitButton').addEventListener('click', function(event) {
                                            var userRole = document.getElementById('userRole').value;
                                            var login = document.getElementById('login').value;
                                            if (userRole !== 'true' && login !== 'true') {
                                                event.preventDefault();
                                                alert('You must be a customer to add to cart');
                                            }
                                        });
                                    </script>

                                </c:if>
                                <c:if test="${product.getSockQuantity() - holdNumber == 0}">
                                    <a class="primary-btn" style="color: white; background: red">OUT OF STOCK</a>
                                </c:if>
                                <a href="#" class="heart-icon"><span class="icon_heart_alt"></span></a>


                                <ul>
                                    <li><b>Availability</b> <span>${product.status}</span></li>
                                    <li><b>Brand</b> <a href="shopping?brand=${product.brand.id}"
                                                        style="color: black">${product.getBrand().getName()}</a></li>
                                    <li><b>Number Sold</b> <span>${product.numberSold}</span></li>
                                </ul>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-1" role="tab"
                                       aria-selected="true">Feedback</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                    <div class="product__details__tab__desc">
                                        <h6>Products Infomation</h6>
                                        <p>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui.
                                            Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus.
                                            Vivamus
                                            suscipit tortor eget felis porttitor volutpat. Vestibulum ac diam sit amet
                                            quam
                                            vehicula elementum sed sit amet dui. Donec rutrum congue leo eget malesuada.
                                            Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat,
                                            accumsan id imperdiet et, porttitor at sem. Praesent sapien massa, convallis
                                            a
                                            pellentesque nec, egestas non nisi. Vestibulum ac diam sit amet quam
                                            vehicula
                                            elementum sed sit amet dui. Vestibulum ante ipsum primis in faucibus orci
                                            luctus
                                            et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet
                                            aliquam
                                            vel, ullamcorper sit amet ligula. Proin eget tortor risus.</p>
                                        <p>Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                            ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                            elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                            porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                            nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                            Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Sed
                                            porttitor lectus nibh. Vestibulum ac diam sit amet quam vehicula elementum
                                            sed sit amet dui. Proin eget tortor risus.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Blog Section End -->

<!-- Related Product Section Begin -->
<section class="related-product">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title related__product__title">
                    <h2>Related Product</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="categories__slider owl-carousel">
                <c:forEach items="${relateProduct}" var="p">
                    <div class="col-lg-3">
                        <div class="product__item set-bg">
                            <c:set var="imgPath" value="${fn:replace(p.img, '\\\\', '/')}"/>
                            <div class="product__item__pic set-bg" data-setbg="${imgPath}">
                                <ul class="product__item__pic__hover">
                                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                    <li><a href="addtocart?pid=${p.id}"><i class="fa fa-shopping-cart"></i></a></li>
                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="productdetail?pid=${p.id}">${p.name}</a></h6>
                                <h5>$30.00</h5>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</section>
<!-- Related Product Section End -->

<jsp:include page="Footer.jsp"/>

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