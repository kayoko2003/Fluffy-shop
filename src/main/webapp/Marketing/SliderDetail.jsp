<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${action == 'view' ? 'View' : 'Edit'} Slider</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script>
        function previewImage(event) {
            var input = event.target;
            var reader = new FileReader();
            reader.onload = function(){
                var imgElement = document.getElementById('previewImage');
                imgElement.src = reader.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    </script>
</head>
<body>
<div class="container mt-5">
    <h2>${action == 'view' ? 'View' : 'Edit'} Slider</h2>
    <form action="listslider" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${slider.id}">
        <div class="form-group">
            <label for="title">Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${slider.title}" ${action == 'view' ? 'readonly' : ''} required>
        </div>
        <div class="form-group">
            <label>Image</label>
            <div>
                <img id="previewImage" src="${slider.image}" alt="Current Image" style="max-width: 200px; max-height: 200px;">
            </div>
            <input type="file" class="form-control-file" id="sliderImage" name="sliderImage" onchange="previewImage(event)" ${action == 'view' ? 'disabled' : ''}>
        </div>
        <div class="form-group">
            <label for="backlink">Backlink</label>
            <input type="text" class="form-control" id="backlink" name="backlink" value="${slider.backlink}" ${action == 'view' ? 'readonly' : ''} required>
        </div>
        <div class="form-group">
            <label for="status">Status</label>
            <select class="form-control" id="status" name="status" ${action == 'view' ? 'disabled' : ''}>
                <option value="true" ${slider.status ? 'selected' : ''}>Active</option>
                <option value="false" ${!slider.status ? 'selected' : ''}>Inactive</option>
            </select>
        </div>
        <div class="form-group">
            <label for="note">Note</label>
            <textarea class="form-control" id="note" name="note" ${action == 'view' ? 'readonly' : ''} required>${slider.note}</textarea>
        </div>
        <c:choose>
            <c:when test="${action == 'edit'}">
                <button type="submit" class="btn btn-primary">Update Slider</button>
            </c:when>
            <c:otherwise>
                <a href="listslider" class="btn btn-secondary">Back to List</a>
            </c:otherwise>
        </c:choose>
    </form>
</div>
</body>
</html>
