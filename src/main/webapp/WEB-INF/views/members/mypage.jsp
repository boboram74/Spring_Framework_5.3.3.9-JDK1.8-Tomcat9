<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYPAGE</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<table border="1" align="center" margin="auto">
		<tr>
			<th>ID</th>
			<td id="id"></td>
		</tr>
		<tr>
			<th>이름</th>
			<td id="name"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td id="contact"></td>
		</tr>				
	</table>
	
	<script>
	$(function() {
	    $.ajax({
	        url: "/members/mypage"
	    }).done(function(resp) {
	        $("#id").text(resp.id);
	        $("#name").text(resp.name);
	        $("#contact").text(resp.contact);
	    });
	})
	</script>
</body>
</html>