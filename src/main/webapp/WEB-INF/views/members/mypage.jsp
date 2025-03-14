<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<style>
		/* 전체 배경, 폰트 */
		body {
			margin: 0;
			padding: 0;
			background: #F9F4FF; /* 연한 보라 배경 */
			font-family: "Noto Sans KR", sans-serif;
		}
		/* 메인 컨테이너 */
		.mypage-container {
			width: 350px;
			margin: 0 auto;
			padding-top: 50px;
			text-align: center;
		}
		.mypage-title {
			font-size: 20px;
			font-weight: bold;
			color: #666;
			margin-bottom: 20px;
		}
		/* 테이블 스타일 */
		.info-table {
			width: 100%;
			border-collapse: collapse;
			background: transparent;
			margin-bottom: 20px;
		}
		.info-table th, .info-table td {
			border-bottom: 1px solid #ccc;
			padding: 10px;
			vertical-align: middle;
			text-align: left;
		}
		.info-table th {
			width: 80px;
			color: #666;
			font-weight: bold;
			background: none;
		}
		/* 버튼 공통 스타일 */
		.btn {
			margin: 5px;
			padding: 10px 20px;
			border: none;
			border-radius: 25px;
			font-size: 14px;
			font-weight: bold;
			cursor: pointer;
			transition: background 0.3s, transform 0.2s;
		}
		/* 보라색 버튼 */
		.btn-purple {
			background: #9B59B6;
			color: #fff;
		}
		.btn-purple:hover {
			background: #8e44ad;
			transform: translateY(-2px);
		}
		/* 회색 버튼 */
		.btn-gray {
			background: #bdc3c7;
			color: #fff;
		}
		.btn-gray:hover {
			background: #a7b1b4;
			transform: translateY(-2px);
		}
	</style>
</head>
<body>
<div class="mypage-container">
	<div class="mypage-title">마이페이지</div>
	<table class="info-table">
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
	<button class="btn btn-purple" id="editBtn">정보수정</button>
	<button class="btn btn-gray" id="logoutBtn">로그아웃</button>
	<br>
	<hr>
</div>
<script>
	$(function() {
		$.ajax({
			url: "/members/mypage"
		}).done(function(resp) {
			$("#id").text(resp.id);
			$("#name").text(resp.name);
			$("#contact").text(resp.contact);
		});
		$("#editBtn").on("click", function() {
			alert("정보수정 페이지로 이동합니다(예시).");
		});
		$("#logoutBtn").on("click", function() {
			alert("로그아웃 처리(예시).");
		});
	});
</script>
</body>
</html>
