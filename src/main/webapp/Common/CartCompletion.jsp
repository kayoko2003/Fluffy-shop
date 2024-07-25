<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Cart completion</title>

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

</head>

<body>
<jsp:include page="../Header.jsp"/>


<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="Static_acess_shop/img/breadcrumbblog.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Cart</h2>
                    <div class="breadcrumb__option">
                        <a href="./index.html">Home</a>
                        <a>Cart detail</a>
                        <a>Cart contact</a>
                        <span>Cart completion</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Blog Section Begin -->
<section class="blog spad">
    <div class="container" style="max-width: 1170px">
        <div class="row">
            <div class="col-lg-3" style="height: 947px">
                <jsp:include page="../SiderShop.jsp"/>
            </div>
            <div class="col-lg-9">
                <c:if test="${paymentFail != null}">
                    <div class="col-lg-12" style="text-align: center">
                        <h2>Payment not successfully, please try again</h2>
                        <a class="primary-btn cart-btn cart-btn-right" style="background: #ff0404; float: none; margin-top: 30px" href="home">Back to home</a>
                    </div>
                </c:if>
                <c:if test="${paymentFail == null}">
                    <div class="checkout__form">
                        <h4>Thank for shoping, here are your invoice</h4>
                        <div class="row">
                            <div class="col-lg-7">
                                <h5 style="text-align: center; color: #1c1c1c; font-weight: 700; border-bottom: 1px solid #e1e1e1; padding-bottom: 20px; margin-bottom: 25px;">
                                    Billing Details</h5>
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Full Name</p>
                                            <input type="text" style="border: dashed; color: black; border-radius: 30px"
                                                   value="${order.fullName}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="checkout__input">
                                            <p>Phone</p>
                                            <input style="border: dashed; color: black; border-radius: 30px" type="text"
                                                   value="${order.phone}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="checkout__input">
                                    <p>Address</p>
                                    <input type="text" style="border: dashed; color: black; border-radius: 30px"
                                           value="${order.address}" class="checkout__input__add" readonly>
                                </div>
                                <div class="checkout__input">
                                    <p>Order notes</p>
                                    <input style="border: dashed; color: black; border-radius: 30px" type="text"
                                           value="${order.note}"
                                           readonly>
                                </div>
                                <div class="checkout__input">
                                    <div>
                                        <p>Payment method</p>
                                        <input style="border: dashed; color: black; border-radius: 30px" type="text"
                                               value="${order.paymentMethod.method}"
                                               readonly>
                                    </div>
                                </div>
                                <c:if test="${order.paymentMethod.id == 3}">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="checkout__input">
                                                <div>
                                                    <p>Please transfer in 24h with content:</p>
                                                    <p>Your name + Payment orders</p>
                                                    <p>Bank: ${bankName} </p>
                                                    <p>Bank Number: ${bankAccountNumber} </p>
                                                    <p>Bank Account Name: ${bankAccountName} </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <img src="${qrPayment}">
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${order.paymentMethod.id == 1}">
                                    <div class="checkout__input">
                                        <div>
                                            <p>Thank you for purchasing our products, be sure to prepare enough cash
                                                before
                                                receiving the goods</p>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="col-lg-5">
                                <div class="checkout__order">
                                    <h4 style="border-bottom: 0px solid #e1e1e1; margin-bottom: -20px;">Your Order</h4>
                                    <div class="checkout__order__products">Products <span>Total</span></div>
                                    <div class="latest-product__slider owl-carousel">
                                        <c:set var="counter" value="0"/>
                                        <c:set var="startItem" value="0"/>
                                        <c:set var="endItem" value="2"/>
                                        <c:forEach var="i" begin="1" end="${endValue}">
                                            <c:if test="${counter + 1 == endValue}">
                                                <c:set var="endItem" value="${myOrder.size()}"/>
                                            </c:if>
                                            <c:set var="counter" value="${counter + 1}"/>
                                            <div class="latest-product__slider__item">
                                                <c:forEach items="${myOrder}" var="m" begin="${startItem}"
                                                           end="${endItem}">
                                                    <a href="#" class="latest-product__item">
                                                        <div class="latest-product__item__pic">
                                                            <img src="${m.getProduct().getImg()}"
                                                                 alt="">
                                                        </div>
                                                        <div class="latest-product__item__text">
                                                            <h6>${m.getProduct().getName()}</h6>
                                                            <h6>${m.getQuantity()} product(s)</h6>
                                                            <span><fmt:formatNumber
                                                                    value="${m.getPrice() * m.getQuantity()}"
                                                                    type="number"
                                                                    minFractionDigits="0"
                                                                    maxFractionDigits="2"/></span>
                                                        </div>
                                                    </a>
                                                </c:forEach>
                                                <c:set var="startItem" value="${endItem + 1}"/>
                                                <c:set var="endItem" value="${endItem + 3}"/>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="checkout__order__total" style="margin-bottom: 0px">Total
                                        <span><fmt:formatNumber value="${totalOrderAmount}" type="number"
                                                                minFractionDigits="0"
                                                                maxFractionDigits="2"/></span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</section>
<!-- Blog Section End -->

<jsp:include page="../Footer.jsp"/>

<!-- Js Plugins -->
<script src="Static_acess_shop/js/jquery-3.3.1.min.js"></script>
<script src="Static_acess_shop/js/bootstrap.min.js"></script>
<script src="Static_acess_shop/js/jquery.nice-select.min.js"></script>
<script src="Static_acess_shop/js/jquery-ui.min.js"></script>
<script src="Static_acess_shop/js/jquery.slicknav.js"></script>
<script src="Static_acess_shop/js/mixitup.min.js"></script>
<script src="Static_acess_shop/js/owl.carousel.min.js"></script>
<script src="Static_acess_shop/js/main.js"></script>

</body>

</html>