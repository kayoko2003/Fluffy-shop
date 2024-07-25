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
    <title>Shopping</title>

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
        .deleted-product {
            pointer-events: none; /* Ngăn chặn các sự kiện chuột */
        }

        .out-of-stock {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0.8);
            padding: 10px 20px;
            font-size: 27px;
            color: red;
            font-weight: bold;
            z-index: 1;
        }

        /* Add this CSS to your existing styles */

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
                    <h2>Organi Shop</h2>
                    <div class="breadcrumb__option">
                        <a href="home">Home</a>
                        <span>Shop</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Product Section Begin -->
<section class="product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <jsp:include page="SiderShop.jsp"/>
            </div>
            <div class="col-lg-9 col-md-7">
                <div class="product__discount">
                    <div class="section-title product__discount__title">
                        <h2>Sale Off</h2>
                    </div>
                    <div class="row">
                        <div class="product__discount__slider owl-carousel">
                            <c:forEach items="${saleProducts}" var="s">
                                <div class="col-lg-4">
                                    <div class="product__discount__item">
                                        <c:set var="imgPath" value="${fn:replace(s.img, '\\\\', '/')}"/>
                                        <div class="product__discount__item__pic set-bg"
                                             data-setbg="${imgPath}">
                                            <div class="product__discount__percent">-20%</div>
                                            <ul class="product__item__pic__hover">
                                                <c:if test="${acc == null || isCustomer == 'true'}">
                                                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                                    <li><a href="addtocart?pid=${s.id}&shop=true"><i
                                                            class="fa fa-shopping-cart"></i></a></li>
                                                </c:if>
                                            </ul>
                                        </div>
                                        <div class="product__discount__item__text">
                                            <span>${s.getCategory().getName()}</span>
                                            <h5><a href="productdetail?pid=${s.id}">${s.name}</a></h5>
                                            <div class="product__item__price"><fmt:formatNumber
                                                    value="${s.price - s.price*20/100}" type="number"
                                                    minFractionDigits="0"
                                                    maxFractionDigits="2"/> <span><fmt:formatNumber value="${s.price}"
                                                                                                    type="number"
                                                                                                    minFractionDigits="0"
                                                                                                    maxFractionDigits="2"/></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="filter__item">
                    <div class="row">

                        <div class="col-lg-5">
                            <div class="filter__sort row">
                                <span>Sort By</span>
                                <form method="get" action="shopping">
                                    <input name="txt" value="${search}" hidden/>
                                    <input name="brand" value="${brand}" hidden/>
                                    <input name="category" value="${category}" hidden/>
                                    <input name="search" value="${search}" hidden/>
                                    <select name="sortBy" onchange="this.form.submit()">
                                        <option value="p.price"
                                                <c:if test="${sortBy == 'p.price'}">selected</c:if> >Price
                                        </option>
                                        <option value="p.product_name"
                                                <c:if test="${sortBy == 'p.product_name'}">selected</c:if> >Name product
                                        </option>
                                        <option value="p.update_date"
                                                <c:if test="${sortBy == 'p.update_date'}">selected</c:if> >Newest
                                        </option>
                                    </select>
                                    <span style="margin-right: -10px;">Order By</span>
                                    <select name="sortOrder" onchange="this.form.submit()">
                                        <option value="ASC"
                                                <c:if test="${sortOrder == 'ASC'}">selected</c:if> >Ascending
                                        </option>
                                        <option value="DESC"
                                                <c:if test="${sortOrder == 'DESC'}">selected</c:if> >Descending
                                        </option>
                                    </select>
                                </form>
                            </div>
                        </div>

                        <div class="col-lg-7" style="text-align-last: left;">
                            <div class="filter__found">
                                <h6><span>${total}</span> Products found</h6>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${productList}" var="p">
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <c:set var="imgPath" value="${fn:replace(p.getKey().getImg(), '\\\\', '/')}"/>
                                <div class="product__item__pic set-bg ${p.getKey().getSockQuantity() - p.getValue() == 0 ? 'deleted-product' : ''}"
                                     data-setbg="${imgPath}">
                                    <c:if test="${p.getKey().getSockQuantity() - p.getValue() > 0}">
                                        <ul class="product__item__pic__hover">
                                            <c:if test="${acc == null || isCustomer == 'true'}">
                                                <li><a href="#" ${p.getKey().getSockQuantity() - p.getValue() == 0 ? 'onclick="return false;"' : ''}><i
                                                        class="fa fa-heart"></i></a></li>
                                                <li>
                                                    <a href="addtocart?pid=${p.getKey().getId()}&shop=true" ${p.getKey().getSockQuantity() - p.getValue() == 0 ? 'onclick="return false;"' : ''}><i
                                                            class="fa fa-shopping-cart"></i></a></li>
                                            </c:if>
                                        </ul>
                                    </c:if>
                                    <c:if test="${p.getKey().getSockQuantity() - p.getValue() == 0}">
                                        <div style="width: 100%; height: 100%; align-content: center; text-align: center;"
                                             class="out-of-stock">Out of Stock
                                        </div>
                                    </c:if>
                                </div>
                                <div class="product__item__text">
                                    <h6>
                                        <a href="productdetail?pid=${p.getKey().getId()}">${p.getKey().getName()}</a>
                                    </h6>
                                    <h5><fmt:formatNumber value="${p.getKey().getPrice()}"
                                                          type="number"
                                                          minFractionDigits="0"
                                                          maxFractionDigits="2"/></h5>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="product__pagination">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="shopping?currentPage=${i}&search=${search}&brand=${brand}&category=${category}&sortOrder=${sortOrder}&sortBy=${sortBy}"
                           style="<c:if test='${i == currentPage}'>background-color: #8bc34a; color: white; </c:if>">
                                ${i}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Product Section End -->

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