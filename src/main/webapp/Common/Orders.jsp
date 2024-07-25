<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>List Order</title>
    <!-- Google Font -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
        .tab {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #ccc;
            background-color: #f1f1f1;
        }

        .tab button {
            background-color: inherit;
            flex: 1;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 17px;
            text-align: center;
        }

        .tab button:hover {
            background-color: #ddd;
        }

        .tab button.active {
            background-color: #ccc;
        }

        .tabcontent {
            display: none;
            padding: 6px 12px;
            border-top: none;
        }

        .order-item {
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #fff;
            display: flex;
            justify-content: space-between;
        }

        .order-details {
            display: flex;
        }

        .order-actions {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .order-actions button {
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-received {
            background-color: #ff5a5f;
            color: white;
        }

        .btn-request-return, .btn-contact-seller {
            background-color: #fff;
            border: 1px solid #ccc;
        }

        .btn-request-return:hover, .btn-contact-seller:hover {
            background-color: #f1f1f1;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover, .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .rating {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .rating select {
            padding: 10px;
            font-size: 16px;
        }

        .order-item {
            border: 1px solid #ccc;
            margin-top: 20px;
            background-color: #fff;
            width: 100%;
        }

        .order-details {
            display: flex;
            flex-wrap: wrap;
            width: 100%;
        }

        .order-image img {
            max-width: 100%;
            height: auto;
        }

        .order-info {
            flex-grow: 1;
            padding-left: 15px;
        }

        .order-actions {
            display: flex;
            justify-content: space-between;
        }

        .btn-received, .btn-request-return, .btn-contact-seller {
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-received {
            background-color: #ff5a5f;
            color: white;
        }

        .btn-request-return, .btn-contact-seller {
            background-color: #fff;
            border: 1px solid #ccc;
        }

        .btn-request-return:hover, .btn-contact-seller:hover {
            background-color: #f1f1f1;
        }

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
<jsp:include page="../Header.jsp"/>
<c:if test="${not empty param.feedbacksuccess}">
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            showNotification('${param.feedbacksuccess}');
        });
    </script>
</c:if>
<section class="breadcrumb-section set-bg" data-setbg="Static_acess_shop/img/breadcrumbblog.png">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Orders</h2>
                    <div class="breadcrumb__option">
                        <a href="http://localhost:8080/FluffyShop_war/home">Home</a>
                        <a>Orders</a>
                        <span>Orders</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="shoping-cart spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3" style="height: 947px;">
                <jsp:include page="../SiderShop.jsp"/>
            </div>
            <div class="col-lg-9">
                <div class="tab">
                    <button class="tablinks" onclick="openTab(event, 'Pending')" id="defaultOpen">Pending</button>
                    <button class="tablinks" onclick="openTab(event, 'Shipping')">Shipping</button>
                    <button class="tablinks" onclick="openTab(event, 'Delivered')">Delivered</button>
                    <button class="tablinks" onclick="openTab(event, 'Completed')">Completed</button>
                    <button class="tablinks" onclick="openTab(event, 'Cancel')">Cancel</button>
                </div>

                <div id="Pending" class="tabcontent">
                    <c:forEach var="order" items="${pendingAndconfirm}">
                        <div class="order-item row" data-order-id="${order.id}"
                             style="margin-left: 2px ; box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; ">
                            <div class="col-lg-6">
                                <h4>id: #${order.id}</h4>
                            </div>
                            <div class="col-lg-3"><p>Trạng thái đơn hàng:</p></div>
                            <div class="col-lg-3">
                                <c:if test="${order.status.id == '8'}">
                                    <a href="cartcontact?checkoutagain=true&oid=${order.id}"><h5 style="color: #0a3b79">
                                        Thanh toán lại</h5>
                                    </a>
                                </c:if>
                                <c:if test="${order.status.id == '1' || order.status.id == '2'}">
                                    <h5 style="color: #0a3b79"> Chờ xử lý </h5>
                                </c:if>
                            </div>
                            <div class="order-item row "
                                 style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; margin:auto">
                                <div class="order-details" data-order-id="${order.id}">
                                    <c:set var="total" value="0"/>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <div class="col-lg-12 d-flex mb-3 order-info"
                                             data-product-id="${orderDetail.product.id}">
                                            <div class="order-image">
                                                <img src="${orderDetail.product.img}" alt="Product Image"
                                                     style="width: 100px; height: 100px">
                                            </div>
                                            <a href="order?orderId=${order.id}"
                                               style="text-decoration: none; color: inherit; display: block;">
                                                <div class="order-info ml-3 row">
                                                    <div class="col-lg-10">
                                                        <h4 style="margin-bottom: 0px">${orderDetail.product.name}</h4>
                                                        <p style="margin-bottom: 0px">id san pham:
                                                            x${orderDetail.product.id}</p>
                                                        <p style="margin-bottom: 0px">Số lượng:
                                                            x${orderDetail.quantity}</p>
                                                        <p style="margin-bottom: 0px">Trạng thái đơn
                                                            hàng: ${order.status.status}</p>
                                                    </div>
                                                    <div class="col-lg-2" style="align-content: center">
                                                        <p>${orderDetail.price}₫</p>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="order-actions" style="margin-bottom: 20px; margin-left: 450px">
                                            <div>
                                                <c:set var="total"
                                                       value="${total + (orderDetail.quantity * orderDetail.price)}"/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="col-lg-12"
                                         style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; text-align: end; align-content: center; background: #80808047">
                                        <p style="color: black; margin-bottom: 0px;">Thành tiền: ${total}₫</p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </div>

                <div id="Shipping" class="tabcontent">
                    <c:forEach var="order" items="${shipping}">
                        <div class="order-item row" data-order-id="${order.id}"
                             style="margin-left: 2px ; box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; ">
                            <a href="order?orderId=${order.id}"
                               style="text-decoration: none; color: inherit; display: block;">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <h4>id: #${order.id}</h4>
                                    </div>
                                    <div class="col-lg-3"><p>Trạng thái đơn hàng:</p></div>
                                    <div class="col-lg-3">
                                        <h5 style="color: #0a3b79"> Đang trên đường giao tới bạn
                                        </h5>
                                    </div>
                                </div>
                                <div class="order-item row "
                                     style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; margin:auto">
                                    <div class="order-details" data-order-id="${order.id}">
                                        <c:set var="total" value="0"/>
                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <div class="col-lg-12 d-flex mb-3 order-info"
                                                 data-product-id="${orderDetail.product.id}">
                                                <div class="order-image">
                                                    <img src="${orderDetail.product.img}" alt="Product Image"
                                                         style="width: 100px; height: 100px">
                                                </div>
                                                <div class="order-info ml-3 row">
                                                    <div class="col-lg-10">
                                                        <h4 style="margin-bottom: 0px">${orderDetail.product.name}</h4>
                                                        <p style="margin-bottom: 0px">id san pham:
                                                            x${orderDetail.product.id}</p>
                                                        <p style="margin-bottom: 0px">Số lượng:
                                                            x${orderDetail.quantity}</p>
                                                        <p style="margin-bottom: 0px">Trạng thái đơn
                                                            hàng: ${order.status.status}</p>
                                                    </div>
                                                    <div class="col-lg-2" style="align-content: center">
                                                        <p>${orderDetail.price}₫</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-actions" style="margin-bottom: 20px; margin-left: 450px">
                                                <div>
                                                    <c:set var="total"
                                                           value="${total + (orderDetail.quantity * orderDetail.price)}"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="col-lg-12"
                                             style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; text-align: end; align-content: center; background: #80808047">
                                            <p style="color: black; margin-bottom: 0px;">Thành tiền: ${total}₫</p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <div id="Delivered" class="tabcontent">
                    <c:forEach var="order" items="${delivered}">
                        <div class="order-item row" data-order-id="${order.id}"
                             style="margin-left: 2px ; box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; ">

                            <div class="row">
                                <div class="col-lg-6">
                                    <h4>id: #${order.id}</h4>
                                </div>
                                <div class="col-lg-3"><p>Trạng thái đơn hàng:</p></div>

                                <div class="col-lg-3">
                                    <h5 style="color: red; cursor: pointer;" onclick="confirmOrder(${order.id}, 6)">
                                        Xác
                                        nhận đơn hàng </h5>
                                </div>
                            </div>
                            <a href="order?orderId=${order.id}"
                               style="text-decoration: none; color: inherit; display: block;">
                                <div class="order-item row "
                                     style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; margin:auto">
                                    <div class="order-details" data-order-id="${order.id}">
                                        <c:set var="total" value="0"/>
                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <div class="col-lg-12 d-flex mb-3 order-info"
                                                 data-product-id="${orderDetail.product.id}">
                                                <div class="order-image">
                                                    <img src="${orderDetail.product.img}" alt="Product Image"
                                                         style="width: 100px; height: 100px">
                                                </div>
                                                <div class="order-info ml-3 row">
                                                    <div class="col-lg-10">
                                                        <h4 style="margin-bottom: 0px">${orderDetail.product.name}</h4>
                                                        <p style="margin-bottom: 0px">id san pham:
                                                            x${orderDetail.product.id}</p>
                                                        <p style="margin-bottom: 0px">Số lượng:
                                                            x${orderDetail.quantity}</p>
                                                        <p style="margin-bottom: 0px">Trạng thái đơn
                                                            hàng: ${order.status.status}</p>
                                                    </div>
                                                    <div class="col-lg-2" style="align-content: center">
                                                        <p>${orderDetail.price}₫</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-actions" style="margin-bottom: 20px; margin-left: 450px">
                                                <div>
                                                    <c:set var="total"
                                                           value="${total + (orderDetail.quantity * orderDetail.price)}"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="col-lg-12"
                                             style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; text-align: end; align-content: center; background: #80808047">
                                            <p style="color: black; margin-bottom: 0px;">Thành tiền: ${total}₫</p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <div id="Completed" class="tabcontent">
                    <c:forEach var="order" items="${completed}">
                        <div class="order-item row" data-order-id="${order.id}"
                             style="margin-left: 2px; box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px;">
                            <div class="col-lg-6">
                                <h4>id: #${order.id}</h4>
                            </div>
                            <div class="col-lg-3"><p>Trạng thái đơn hàng:</p></div>

                            <div class="col-lg-3">
                                <!-- Hiển thị nút nếu tất cả sản phẩm đã được đánh giá -->
                                <c:if test="${order.status.id == '6' && orderFeedbackStatusMap[order.id]}">
                                    <button class="btn-received"
                                            onclick="window.location.href='feedbackDetails?orderId=${order.id}'">
                                        Chi
                                        Tiết Đánh Giá
                                    </button>
                                </c:if>
                                <!-- Hiển thị nút nếu còn sản phẩm chưa đánh giá -->
                                <c:if test="${order.status.id == '6' && !orderFeedbackStatusMap[order.id]}">
                                    <button class="btn-received"
                                            onclick="collectProductIds('${order.id}', '${order.staff.staffID}', '${order.fullName}', '${order.email}', '${order.phone}')">
                                        Đánh giá
                                    </button>
                                </c:if>
                            </div>
                            <div class="order-item row"
                                 style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; margin:auto">
                                <div class="order-details" data-order-id="${order.id}">
                                    <c:set var="total" value="0"/>
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <div class="col-lg-12 d-flex mb-3 order-info"

                                             data-product-id="${orderDetail.product.id}"
                                             data-has-feedback="${feedbackMap[order.id][orderDetail.product.id] ? 'true' : 'false'}"
                                             data-fullname="${order.fullName}" data-email="${order.email}"
                                             data-mobile="${order.phone}">

                                            <div class="order-image">
                                                <img src="${orderDetail.product.img}" alt="Product Image"
                                                     style="width: 100px; height: 100px">
                                            </div>
                                            <div class="order-info ml-3 row">
                                                <a href="order?orderId=${order.id}"
                                                   style="text-decoration: none; color: inherit; display: block;">
                                                    <div class="col-lg-10">
                                                        <h4 style="margin-bottom: 0px">${orderDetail.product.name}</h4>
                                                        <p style="margin-bottom: 0px">id sản phẩm:
                                                            x${orderDetail.product.id}</p>
                                                        <p style="margin-bottom: 0px">Số lượng:
                                                            x${orderDetail.quantity}</p>
                                                        <p style="margin-bottom: 0px">Trạng thái đơn
                                                            hàng: ${order.status.status}</p>
                                                    </div>
                                                </a>
                                                <div class="col-lg-2" style="align-content: center">
                                                    <p>${orderDetail.price}₫</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="order-actions" style="margin-bottom: 20px; margin-left: 450px">
                                            <!-- Hiển thị nút đánh giá sản phẩm nếu chưa đánh giá -->
                                            <c:if test="${order.status.id == '6' && !feedbackMap[order.id][orderDetail.product.id]}">
                                                <button class="btn-received" data-has-feedback="false"
                                                        onclick="showRatingForm('${orderDetail.product.id}', '${order.id}', '${order.staff.staffID}', '${order.fullName}', '${order.email}', '${order.phone}')">
                                                    Đánh giá sản phẩm
                                                </button>
                                            </c:if>
                                            <!-- Hiển thị nút xem chi tiết đánh giá nếu sản phẩm đã được đánh giá -->
                                            <c:if test="${order.status.id == '6' && feedbackMap[order.id][orderDetail.product.id]}">
                                                <button class="btn-received" data-has-feedback="true"
                                                        onclick="window.location.href='feedbackDetails?orderId=${order.id}&productId=${orderDetail.product.id}'">
                                                    Xem Chi Tiết Đánh Giá Sản Phẩm
                                                </button>
                                            </c:if>
                                            <div>
                                                <c:set var="total"
                                                       value="${total + (orderDetail.quantity * orderDetail.price)}"/>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <div class="col-lg-12"
                                         style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; text-align: end; align-content: center; background: #80808047">
                                        <p style="color: black; margin-bottom: 0px;">Thành tiền: ${total}₫</p>
                                    </div>
                                </div>
                            </div>
                            </a>
                        </div>
                    </c:forEach>

                </div>

                <div id="Cancel" class="tabcontent">
                    <c:forEach var="order" items="${cancel}">
                        <div class="order-item row" data-order-id="${order.id}"
                             style="margin-left: 2px ; box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; ">
                            <a href="order?orderId=${order.id}"
                               style="text-decoration: none; color: inherit; display: block;">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <h4>id: #${order.id}</h4>
                                    </div>
                                    <div class="col-lg-3"><p>Trạng thái đơn hàng:</p></div>
                                    <div class="col-lg-3">

                                        <h5 style="color: red"> Đã Hủy
                                        </h5>


                                    </div>
                                </div>
                                <div class="order-item row "
                                     style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; margin:auto">
                                    <div class="order-details" data-order-id="${order.id}">
                                        <c:set var="total" value="0"/>
                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <div class="col-lg-12 d-flex mb-3 order-info"
                                                 data-product-id="${orderDetail.product.id}">
                                                <div class="order-image">
                                                    <img src="${orderDetail.product.img}" alt="Product Image"
                                                         style="width: 100px; height: 100px">
                                                </div>
                                                <div class="order-info ml-3 row">
                                                    <div class="col-lg-10">
                                                        <h4 style="margin-bottom: 0px">${orderDetail.product.name}</h4>
                                                        <p style="margin-bottom: 0px">id san pham:
                                                            x${orderDetail.product.id}</p>
                                                        <p style="margin-bottom: 0px">Số lượng:
                                                            x${orderDetail.quantity}</p>
                                                        <p style="margin-bottom: 0px">Trạng thái đơn
                                                            hàng: ${order.status.status}</p>
                                                    </div>
                                                    <div class="col-lg-2" style="align-content: center">
                                                        <p>${orderDetail.price}₫</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="order-actions" style="margin-bottom: 20px; margin-left: 450px">
                                                <div>
                                                    <c:set var="total"
                                                           value="${total + (orderDetail.quantity * orderDetail.price)}"/>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="col-lg-12"
                                             style="box-shadow: 0 0px 9px rgba(0, 0, 0, 0.1);border-radius: 15px; text-align: end; align-content: center; background: #80808047">
                                            <p style="color: black; margin-bottom: 0px;">Thành tiền: ${total}₫</p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div id="ratingModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeRatingForm()">&times;</span>
                    <h2>Đánh giá của bạn</h2>
                    <form id="ratingForm" method="post" action="comfirmorder" enctype="multipart/form-data">
                        <input type="hidden" id="staffId" name="staffId"/>
                        <input type="hidden" id="productIds" name="productIds"/>
                        <input type="hidden" id="orderId" name="orderId"/>
                        <!-- Các trường khác -->
                        <label for="fullName">Họ và tên:</label>
                        <input type="text" id="fullName" name="fullName" readonly/><br><br>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" readonly><br><br>
                        <label for="phone">Số di động:</label>
                        <input type="tel" id="phone" name="phone" readonly><br><br>
                        <label for="rating">Đánh giá sao:</label>
                        <input type="number" id="rating" name="rating" min="1" max="5" required><br><br>
                        <label for="image">Chọn hình ảnh để tải lên:</label>
                        <input type="file" id="image" name="image" accept="image/*"><br><br>
                        <label for="feedback">Phản hồi của bạn:</label>
                        <textarea id="feedback" name="feedback" rows="4" cols="50"></textarea><br><br>
                        <button type="submit">submit form</button>

                    </form>
                </div>
            </div>

        </div>
    </div>
</section>
<jsp:include page="../Footer.jsp"/>
<script>
    function confirmOrder(orderId, statusId) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "updateOrderStatus", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var response = xhr.responseText;
                if (response === "success") {
                    alert("Đơn hàng đã được xác nhận.");
                    location.reload(); // Tải lại trang để cập nhật trạng thái đơn hàng
                } else {
                    alert("Xác nhận đơn hàng thất bại.");
                }
            }
        };
        xhr.send("orderId=" + orderId + "&statusId=" + statusId);
    }

    function openTab(evt, tabName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace("active", "");
        }
        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += "active";
    }

    document.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("defaultOpen").click();
    });

    function collectProductIds(orderId, StaffId, fullName, email, mobile) {
        let productIds = [];
        let orderItems = document.querySelectorAll('[data-order-id="' + orderId + '"] .order-info');

        orderItems.forEach(function (item) {
            let productId = item.getAttribute('data-product-id');
            let hasFeedback = item.getAttribute('data-has-feedback') === 'true';

            if (productId && !hasFeedback) {
                productIds.push(productId);
            }
        });

        if (productIds.length > 0) {
            showRatingForm(productIds.join(','), orderId, StaffId, fullName, email, mobile);
        } else {
            alert("Không có sản phẩm nào để đánh giá.");
        }
    }

    function showRatingForm(productIds, orderId, staffId, fullName, email, phone) {
        document.getElementById('productIds').value = productIds;
        document.getElementById('orderId').value = orderId;
        document.getElementById('staffId').value = staffId;
        document.getElementById('fullName').value = fullName;
        document.getElementById('email').value = email;
        document.getElementById('phone').value = phone;
        document.getElementById('ratingModal').style.display = 'block';
    }

    function closeRatingForm() {
        document.getElementById('ratingModal').style.display = 'none';
    }

    window.onclick = function (event) {
        var modal = document.getElementById("ratingModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

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
