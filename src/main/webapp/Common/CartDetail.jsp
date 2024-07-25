<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Cart detail</title>

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
<!-- Header Section End -->
<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="Static_acess_shop/img/breadcrumbblog.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Shopping Cart</h2>
                    <div class="breadcrumb__option">
                        <a href="./index.html">Home</a>
                        <span>Shopping Cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Shoping Cart Section Begin -->
<section class="shoping-cart spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3" style="height: 947px;">
                <jsp:include page="../SiderShop.jsp"/>
            </div>

            <div class="col-lg-9">
                <!-- Display the message if it exists -->
                <c:if test="${not empty message}">
                    <div class="alert alert-warning">
                            ${message}
                    </div>
                </c:if>

                <c:if test="${carts.isEmpty()}">
                    <img style="width: 100%" src="Static_acess_shop\img\cart-empty.jpg" alt="Cart empty"/>
                </c:if>
                <c:if test="${!carts.isEmpty()}">
                    <form id="cartForm" action="process" method="get">
                        <div class="shoping__cart__table">
                            <table>
                                <thead>
                                <tr>
                                    <th style="width: 3%"><input type="checkbox" id="selectAll"
                                                                 onclick="toggleCheckboxes(this)"
                                                                 onchange="updateTotal()"></th>
                                    <th class="shoping__product">Products</th>
                                    <th></th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set var="o" value="${requestScope.listCart}"/>
                                <c:forEach items="${carts}" var="c">
                                    <tr>
                                        <td><input type="checkbox" name="checkoutpid"
                                                   value="${c.product.id}" onchange="updateTotal()"></td>
                                        <td><img height="80px" width="100px" src="${c.product.img}"
                                                 alt="avatar product"></td>
                                        <td class="shoping__cart__item">
                                            <h5 style="align-content: center;">${c.product.name}</h5>
                                        </td>
                                        <td class="shoping__cart__price">
                                            <fmt:formatNumber value="${c.product.price}" type="number"
                                                              minFractionDigits="0"
                                                              maxFractionDigits="2"/> VND
                                        </td>
                                        <td class="shoping__cart__quantity">
                                            <div class="quantity">
                                                <div class="pro-qty">
                                                    <input type="text" name="pid${c.product.id}" value="${c.quantity}"
                                                           data-initial-quantity="${c.quantity}">
                                                </div>
                                            </div>
                                        </td>
                                        <td class="shoping__cart__total">
                                            <fmt:formatNumber value="${c.quantity * c.product.price}" type="number"
                                                              minFractionDigits="0"
                                                              maxFractionDigits="2"/> VND
                                        </td>
                                        <td class="shoping__cart__item__close">
                                            <a href="process?delete=1&pid=${c.product.id}"
                                               style="font-size: x-large; color: red;" class="icon_close"></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="shoping__cart__btns">
                                    <a href="home" class="primary-btn cart-btn">CONTINUE SHOPPING</a>
                                    <button type="submit" class="primary-btn cart-btn cart-btn-right"><span
                                            class="icon_loading"></span>
                                        <input name="update" value="1" hidden=""/>
                                        Upadate Cart
                                    </button>
                                </div>
                            </div>
                            <div class="col-lg-6">
                            </div>
                            <div class="col-lg-6">
                                <div class="shoping__checkout">
                                    <h5>Cart Total</h5>
                                    <ul>
                                        <li>Total <span id="totalMoney">0</span></li>
                                    </ul>
                                    <span class="primary-btn" onclick="proceedToCheckout()">PROCEED TO CHECKOUT</span>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</section>
<!-- Shoping Cart Section End -->

<jsp:include page="../Footer.jsp"/>

<!-- Js Plugins -->
<script>
    function proceedToCheckout() {
        var checkboxes = document.getElementsByName('checkoutpid');
        var canProceed = true;
        var isChoose = false;
        checkboxes.forEach(function (checkbox) {
            var row = checkbox.closest('tr');
            var quantityInput = row.querySelector('.shoping__cart__quantity input');
            var quantity = parseFloat(quantityInput.value);
            var initialQuantity = parseFloat(quantityInput.getAttribute('data-initial-quantity'));
            if (quantity !== initialQuantity) {
                alert("Please update your cart before proceeding to checkout.");
                canProceed = false;
            }
            if (checkbox.checked) {
                isChoose = true;
            }
        });
        if (!canProceed) {
            return false; // stop the function execution
        } else if (!isChoose) {
            alert("Please choose product before checkout.");
            return false;
        }

        const form = document.getElementById('cartForm');
        const originalAction = form.action;
        form.action = 'cartcontact';
        form.submit();
        form.action = originalAction;
    }

    function toggleCheckboxes(source) {
        const checkboxes = document.querySelectorAll('input[name="checkoutpid"]');
        checkboxes.forEach(checkbox => {
            checkbox.checked = source.checked;
        });
    }

    function updateTotal() {
        var total = 0;
        var checkboxes = document.getElementsByName('checkoutpid');
        checkboxes.forEach(function (checkbox) {
            if (checkbox.checked) {
                var row = checkbox.closest('tr');
                var price = parseInt(row.querySelector('.shoping__cart__price').innerText.replace(',', ''));
                var quantity = parseInt(row.querySelector('.shoping__cart__quantity input').value);
                total += price * quantity;
            }
        });
        total = total * 1000;
        var formattedTotal = total.toLocaleString('de-DE') + ' VND'; // 'de-DE' locale adds dots as thousand separators
        document.getElementById('totalMoney').innerText = formattedTotal;
    }

    document.addEventListener('DOMContentLoaded', function () {
        var checkboxes = document.getElementsByName('checkoutpid');
        checkboxes.forEach(function (checkbox) {
            checkbox.addEventListener('change', function () {
                updateTotal();
            });
        });
    });
</script>
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