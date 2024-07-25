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
    <title>Ogani | Template</title>

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
    <link rel="stylesheet" href="Static_acess_shop/css/block-change-address.css" type="text/css">
    <!-- Custom styles for this template -->
    <script src="assets/jquery-1.11.3.min.js"></script>
    <style>
        .payment-method {
            display: inline-block;
            border: solid 1px;
            font-size: 14px;
            width: 150px;
            height: 33px;
            margin-bottom: 0px;
            text-align: center;
            line-height: 26px;
            cursor: pointer;
            align-content: center;
            margin-right: 10px;
        }

        .payment-method input[type="radio"] {
            display: none;
        }

        .payment-method.active {
            background-color: #02ff4b;;
        }
    </style>
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

                <form id="frmCreateOrder" method="post" action="vnpayajax" class="custom-border">
                    <div class="shoping__cart__table" style="margin-bottom: 10px">
                        <table style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1); border-radius: 15px;">
                            <thead>
                            <tr>
                                <th style="width: 3%; padding: 5px 0px 5px 0px;">ID</th>
                                <th style="padding: 5px 0px 5px 0px;" class="shoping__product">Products</th>
                                <th></th>
                                <th style="padding: 5px 0px 5px 0px;">Price</th>
                                <th style="padding: 5px 0px 5px 0px;">Quantity</th>
                                <th style="padding: 5px 0px 5px 0px;">Total</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listP}" var="c">
                                <tr>
                                    <td><input name="pid" value="${c.product.id}" type="hidden"/>${c.product.id}
                                    </td>
                                    <td><img height="80px" width="100px" src="${c.product.img}"
                                             alt="avatar product"></td>
                                    <td class="shoping__cart__item">
                                        <h5 style="align-content: center;">${c.product.name}</h5>
                                        <input name="pname" value="${c.product.name}" type="hidden"/>
                                    </td>
                                    <td class="shoping__cart__price">
                                        <fmt:formatNumber value="${c.product.price}" type="number"
                                                          minFractionDigits="0"
                                                          maxFractionDigits="2"/>
                                        <input name="price" value="${c.product.price}" type="hidden"/>
                                    </td>
                                    <td class="shoping__cart__quantity"
                                        style="font-size: 18px; color: #1c1c1c; font-weight: 700;">
                                            ${c.quantity}
                                        <input name="quantity" value="${c.quantity}" type="hidden"/>
                                    </td>
                                    <td class="shoping__cart__total">
                                        <fmt:formatNumber value="${c.quantity * c.product.price}" type="number"
                                                          minFractionDigits="0"
                                                          maxFractionDigits="2"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="1" style="text-align: right; padding-left: 10px">Note:</td>
                                <td colspan="2" style="text-align: left; padding-left: 10px;">
                                    <input style="border: ridge; padding-right: 40%" placeholder="Note to us..."
                                           type="text" name="note"></td>
                                <td colspan="2" style="text-align: right;">Total Order Amount:</td>
                                <td colspan="1">
                                    <input name="total" value="${totalOrderAmount}" hidden/>
                                    <fmt:formatNumber value="${totalOrderAmount}" type="number"
                                                      minFractionDigits="0"
                                                      maxFractionDigits="2"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="shoping__cart__table" style="margin-bottom: 10px">
                        <table style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1); border-radius: 15px; margin-bottom: 10px">
                            <thead>
                            <tr>
                                <th style="width: 3%; padding: 5px 0px 5px 0px; text-align: left; padding-left: 10px;">
                                    Delivery address
                                </th>
                                <th></th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td style="width: 25%; text-align: left; padding-left: 30px">${shippingInfor.getFullName()}<br/>
                                    <input name="idAddress" value="${shippingInfor.getId()}" hidden/>
                                    ${shippingInfor.getPhone()}
                                </td>
                                <td style="width: 55%; text-align: left"> ${shippingInfor.getAddress()}
                                </td>
                                <td>
                                    <div class="row">
                                        <c:if test="${shippingInfor.isDefault() == true}">
                                            <p style="border: solid 1px; font-size: 10px; width: 50px; height: 26px; color: red; border-color: red; margin-bottom: 0px;">
                                                Default</p>
                                        </c:if>
                                        <button style="margin-left: 16%; border: outset; background-color: white; color: #3ac202e6; padding: 0px 10px; }"
                                                onclick="changeAddress()">Change
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>

                        <%--Payment method--%>

                        <table style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1); border-radius: 15px;">
                            <thead>
                            <tr>
                                <th style="width: 3%; padding: 5px 0px 5px 0px; text-align: left; padding-left: 10px;">
                                    Payment method
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td style="width: 100%">
                                    <c:forEach items="${listPM}" var="l">
                                        <label class="payment-method" onclick="setActive(this)">
                                            <input type="radio" name="paymentMethod" value="${l.id}">
                                                ${l.method}
                                        </label>
                                    </c:forEach>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <input id="amount" name="amount" type="number" value="${totalOrderAmount}" hidden/>
                </form>


                <div class="shoping__cart__table" style="margin-bottom: 10px">

                    <%-- Change address block--%>
                    <div id="addressModal" class="modal"
                         <c:if test='${showAddress.equals("true")}'>style="display: block;</c:if>">
                        <div class="modal-content" style="margin: 10% auto;">
                            <form action="cartcontact">
                                <c:forEach items="${listP}" var="c">
                                    <input name="checkoutpid" value="${c.product.id}" hidden/>
                                </c:forEach>
                                <table>
                                    <thead>
                                    <tr>
                                        <th style="text-align: left;" colspan="2">My Address</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${shippingInfors}" var="s">
                                        <tr>
                                            <td><input style="padding: 5px 0px 5px 0px;" type="radio" name="address"
                                                       value="${s.id}" ${s.id == shippingInfor.id ? 'checked' : ''}>
                                            </td>
                                            <td style="width: 76%; text-align: left; padding: 5px 0px 5px 10px;"><label
                                                    style="margin-bottom: 0px"
                                                    for="address"> ${s.fullName} (${s.phone}) - ${s.address}
                                                <c:if test="${s.isDefault() == true}">
                                                    <p style="border: solid 1px; font-size: 10px; width: 50px; height: 26px; color: red; border-color: red; margin-bottom: 0px; padding-left: 7px">
                                                        Default
                                                    </p>
                                                </c:if>
                                            </label></td>
                                            <td style="padding: 5px 0 5px 0;">
                                                <button onclick="showUpdateAddressModal('Update Address', '${s.getFullName()}', '${s.getPhone()}', '${s.getAddress()}', ${s.isDefault()}, '${s.getId()}')"
                                                        style="color: blue; text-decoration: none; background-color: white">
                                                    Update
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td style="text-align: left;padding: 0 0 10px 0;" colspan="3">
                                            <button onclick="showUpdateAddressModal('Add New Address', '', '', '', false, '0')"
                                                    style="color: #f60; text-decoration: none; background-color: white; border-color: #f60">
                                                Add
                                                new address
                                            </button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="buttons">
                                    <button onclick="cancelBtn()">Cancel</button>
                                    <button type="submit">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <%--Update address block--%>

                    <div id="updateAddress" class="modal">
                        <div class="modal-content" style="margin: 10% auto;">
                            <form action="processaddress">
                                <c:forEach items="${listP}" var="c">
                                    <input name="checkoutpid" value="${c.product.id}" hidden/>
                                </c:forEach>
                                <input id="idAddress" name="idAddress" value="" hidden/>
                                <table>
                                    <thead>
                                    <tr>
                                        <th id="modalTitle" style="text-align: left;"></th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr style="text-align: left;">
                                        <td style="padding-top: 10px; padding-bottom: 10px; width: 55%;">
                                            <label for="name">Full Name</label>
                                            <input style="width: 90%; height: 35px;" type="text" id="name" name="name"
                                                   value="" required/>
                                        </td>
                                        <td style="padding-bottom: 10px; padding-top: 10px;">
                                            <label for="phone">Phone number</label>
                                            <input style="width: 95%; height: 35px;" type="text" id="phone" name="phone"
                                                   value="" required/>
                                        </td>
                                    </tr>
                                    <tr style="text-align: left">
                                        <td colspan="2" style="padding-bottom: 10px;padding-top: 10px; ">
                                            <label for="address">Address</label>
                                            <input style="width: 98%; height: 35px;}" type="text" id="address"
                                                   name="address" value="" required/>
                                        </td>
                                    </tr>
                                    <tr style="text-align: left">
                                        <td style="padding: 10px 0px 10px 0px;">
                                            <input type="checkbox" id="defaultCheckbox" name="default" value="true"/>
                                            Set default
                                            address
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="buttons">
                                    <button onclick="cancelUpdateAddress()">Back</button>
                                    <button type="submit">Confirm</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="shoping__cart__btns">
                        <a href="cartdetail" class="primary-btn cart-btn" style="text-decoration: none">Back</a>
                        <a onclick="proceedToCheckout()" class="primary-btn cart-btn cart-btn-right">Check Out</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Shoping Cart Section End -->

<jsp:include page="../Footer.jsp"/>

<!-- Js Plugins -->
<script type="text/javascript">
    $(document).ready(function() {
        $("#frmCreateOrder").submit(function (event) {
            event.preventDefault();

            var postData = $(this).serialize();
            var submitUrl = $(this).attr("action");
            $.ajax({
                type: "POST",
                url: submitUrl,
                data: postData,
                dataType: 'JSON',
                success: function (x) {
                    if (x.code === '00') {
                        if (window.vnpay) {
                            vnpay.open({width: 768, height: 600, url: x.data});
                        } else {
                            window.location.href = x.data;
                        }
                    } else {
                        alert(x.Message);
                    }
                }
            });
        });
    });

    function proceedToCheckout() {
        var paymentMethods = document.getElementsByName('paymentMethod');
        var isChecked = false;
        var selectedPaymentMethodId;

        for (var i = 0; i < paymentMethods.length; i++) {
            if (paymentMethods[i].checked) {
                isChecked = true;
                selectedPaymentMethodId = paymentMethods[i].value;
                break;
            }
        }

        if (!isChecked) {
            alert('Vui lòng chọn phương thức thanh toán trước khi checkout.');
            return false;
        }

        if (selectedPaymentMethodId == '2') {
            // Gửi biểu mẫu và kích hoạt sự kiện AJAX
            $("#frmCreateOrder").submit();
        } else {
            const form = document.getElementById('frmCreateOrder');
            const originalAction = form.action;
            const originalMethod = form.method;
            form.action = 'cartcompletion';
            form.method = 'GET';
            form.submit();
            form.action = originalAction;
            form.method = originalMethod;
        }
    }
</script>


<script>

    function changeAddress() {
        event.preventDefault();
        document.getElementById('addressModal').style.display = "block";
    }

    function showUpdateAddressModal(title, name, phone, address, isDefault, idAddress) {
        event.preventDefault();
        document.getElementById('updateAddress').style.display = "block";
        document.getElementById('addressModal').style.display = 'none';
        document.getElementById('modalTitle').innerText = title;
        document.getElementById('name').value = name;
        document.getElementById('phone').value = phone;
        document.getElementById('address').value = address;
        document.getElementById('idAddress').value = idAddress;
        document.getElementById('defaultCheckbox').checked = isDefault;
    }

    function setActive(element) {
        var labels = document.querySelectorAll('.payment-method');
        labels.forEach(function (label) {
            label.classList.remove('active');
        });
        element.classList.add('active');
    }

    function cancelUpdateAddress() {
        event.preventDefault();
        document.getElementById('updateAddress').style.display = "none";
        document.getElementById('addressModal').style.display = 'block';
    }

    function cancelBtn() {
        event.preventDefault();
        document.getElementById('addressModal').style.display = 'none';
    }

</script>
<script src="Static_acess_shop/js/jquery-3.3.1.min.js"></script>
<script src="Static_acess_shop/js/bootstrap.min.js"></script>
<script src="Static_acess_shop/js/jquery.nice-select.min.js"></script>
<script src="Static_acess_shop/js/jquery-ui.min.js"></script>
<script src="Static_acess_shop/js/jquery.slicknav.js"></script>
<script src="Static_acess_shop/js/mixitup.min.js"></script>
<script src="Static_acess_shop/js/owl.carousel.min.js"></script>
<script src="Static_acess_shop/js/main.js"></script>
<script src="Static_acess_shop/js/block-change-address.js"></script>


</body>

</html>