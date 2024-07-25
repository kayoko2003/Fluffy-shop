

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Method</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
            background-color: #ffffff;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            border-radius: 8px;
        }
        h1 {
            margin-bottom: 20px;
            color: #343a40;
            text-align: center;
        }
        .table thead th {
            background-color: #007bff;
            color: #ffffff;
        }
        .table tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
            border-color: #d39e00;
            color: #212529;
        }
        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Payment Method</h1>
    <a href="payment-method?action=add" class="btn btn-primary mb-3">Add New</a>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Method</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="paymentMethod" items="${paymentMethods}">
            <tr>
                <td>${paymentMethod.id}</td>
                <td>${paymentMethod.method}</td>
                <td>
                    <a href="payment-method?action=edit&id=${paymentMethod.id}" class="btn btn-warning">Edit</a>
                    <a onclick="return confirm('Are you sure to delete it?')" href="payment-method?action=delete&id=${paymentMethod.id}" class="btn btn-danger">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
