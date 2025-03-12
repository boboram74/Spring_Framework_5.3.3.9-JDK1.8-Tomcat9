<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<form action="/members/insert" method="post" enctype="multipart/form-data">
		<table border="1" align="center">
			<tr>
				<th>Profile Image</th>
				<td><input type="file" id="imageInput" name="profile_file" accept="image/*"></td>
			</tr>
			
			<tr>
				<td><img src="" id="image" style="max-width: 150px; max-height: 150px;"></td>
			</tr>
			
			<tr>
				<th>ID</th>
				<td><input type="text" name="id" id="id" placeholder="ID를 입력해주세요">
					<button type="button" id="idcheck">중복검사</button> <br>
					<span id="id_result"></span>
				</td>
			</tr>

			<tr>
				<th>PW</th>
				<td><input type="password" name="pw" id="pw"
					placeholder="PW를 입력해주세요"></td>
			</tr>

			<tr>
				<th>Name</th>
				<td><input type="text" name="name" id="name"
					placeholder="NAME을 입력해주세요"></td>
			</tr>

			<tr>
				<th>Contact</th>
				<td><input type="text" name="contact" id="contact"
					placeholder="Contact를 입력해주세요"></td>
			</tr>

			<tr>
				<td colspan="2" class="button-container">
					<button type="submit">가입완료</button>
					<button type="button">취소</button>
				</td>
			</tr>
		</table>
	</form>

	<script>
	    $("#idcheck").on("click", function () {
	        $.ajax({
	            url: "/members/idcheck",
	            data: { id: $("#id").val() }
	        }).done(function (resp) {
	            if (JSON.parse(resp)) {
	                $("#id_result").css({
	                    "color": "red",
	                    "font-size": "12px"
	                }).html("이미 사용중인 ID입니다.");
	            } else {
	                $("#id_result").css({
	                    "color": "dodgerblue",
	                    "font-size": "12px"
	                }).html("사용 가능한 ID입니다.");
	            }
	        });
	    });
		$("#imageInput").on("change",function () {
			const file = this.files[0];
			if(file) {
				if(file.type.startsWith("image/")) {
					$("#image").attr("src",URL.createObjectURL(file));
				}
			}
		});
	</script>
</body>
</html>
