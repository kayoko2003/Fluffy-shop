<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Đánh Giá Đơn Hàng</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Chi Tiết Đánh Giá Đơn Hàng #${orderId}</h2>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Sản phẩm</th>
            <th>Hình ảnh đánh giá</th>
            <th>Điểm số</th>
            <th>Nhận xét</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="feedback" items="${feedbackList}">
            <tr>
                <td>${feedback.getProduct().getName()}</td>
                <td><img src="${feedback.getImagePath()}" alt="Product Image" style="width: 100px; height: 100px"></td>
                <td>${feedback.rating}</td>
                <td>${feedback.content}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <button class="btn btn-primary" onclick="window.history.back()">Quay lại</button>
</div>
</body>
</html>
