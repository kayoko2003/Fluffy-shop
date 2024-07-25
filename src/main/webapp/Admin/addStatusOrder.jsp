<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${statusOrder != null ? 'Edit' : 'Add'} Status Order</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
            max-width: 600px;
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

        .form-group label {
            font-weight: bold;
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }

        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }

        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${statusOrder != null ? "Edit Status Order" : "Add New Status Order"}</h1>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">
                ${errorMessage}
        </div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success" role="alert">
                ${successMessage}
        </div>
    </c:if>
    <form action="status-order" method="post">
        <c:if test="${statusOrder != null}">
            <input type="hidden" name="id" value="${statusOrder.id}"/>
        </c:if>
        <div class="form-group">
            <label>Status</label>
            <input type="text" name="status" class="form-control"
                   value="${statusOrder != null ? statusOrder.status : ''}" required>
        </div>
        <input name="action" type="hidden" value="${statusOrder != null ? 'edit' : 'add'}"/>
        <button type="submit" class="btn btn-success">Save</button>
        <a href="status-order" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
