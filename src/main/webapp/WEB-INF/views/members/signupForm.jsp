<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<!-- 폰트어썸 (필요하다면 아이콘 사용 가능) -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
		  integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
		  crossorigin="anonymous" referrerpolicy="no-referrer" />
	<style>
		/* 로그인 폼과 비슷한 배경 및 폰트 설정 */
		body {
			margin: 0;
			padding: 0;
			background: #F9F4FF; /* 연한 보라/분홍 배경 */
			font-family: "Noto Sans KR", sans-serif;
		}
		/* 회원가입 컨테이너 */
		.signup-container {
			width: 350px;
			margin: 0 auto;
			padding-top: 50px;
			text-align: center;
		}
		/* 테이블을 깔끔하게 */
		.signup-table {
			margin: 0 auto;
			border-collapse: collapse;
			width: 100%;
			background: transparent; /* 투명 혹은 배경색 없음 */
		}
		.signup-table th, .signup-table td {
			border-bottom: 1px solid #ccc;
			padding: 10px;
			vertical-align: middle;
		}
		/* 테이블 헤더 스타일 */
		.signup-table th {
			width: 120px;       /* 라벨 영역 너비 */
			text-align: left;   /* 왼쪽 정렬 */
			color: #666;
			font-weight: bold;
			background: none;
		}
		/* input[type="text"], [type="password"] 기본 스타일 */
		.signup-table input[type="text"],
		.signup-table input[type="password"] {
			width: 100%;
			border: none;
			border-bottom: 1px solid #ccc;
			outline: none;
			font-size: 14px;
			background: transparent;
		}
		::-webkit-input-placeholder { color: #ccc; }
		:-ms-input-placeholder { color: #ccc; }
		::placeholder { color: #ccc; }

		/* 이미지 미리보기 */
		#image {
			max-width: 150px;
			max-height: 150px;
		}

		/* (1) 파일 선택 버튼 커스텀 */
		/* 실제 input[type="file"]는 숨기고, label을 버튼처럼 사용 */
		input[type="file"] {
			position: absolute;
			width: 1px;
			height: 1px;
			padding: 0;
			margin: -1px;
			overflow: hidden;
			clip: rect(0,0,0,0);
			border: 0;
		}
		.file-btn {
			display: inline-block;
			padding: 8px 15px;
			border-radius: 25px;
			background: #bdc3c7; /* 기존 버튼 색상과 맞춤 */
			color: #fff;
			font-size: 14px;
			font-weight: bold;
			cursor: pointer;
			transition: background 0.3s;
		}
		.file-btn:hover {
			background: #a7b1b4;
		}

		/* 버튼 공통 스타일 (로그인 폼과 통일) */
		.btn {
			width: 40%;
			margin: 5px;
			padding: 12px 0;
			border: none;
			border-radius: 25px;
			font-size: 16px;
			font-weight: bold;
			cursor: pointer;
			transition: background 0.3s;
		}
		/* 보라색 버튼 */
		.btn-submit {
			background: #9B59B6;  /* 보라색 */
			color: #fff;
		}
		.btn-submit:hover {
			background: #8e44ad;
		}
		/* 회색 버튼 */
		.btn-cancel {
			background: #bdc3c7;  /* 연회색 */
			color: #fff;
		}
		.btn-cancel:hover {
			background: #a7b1b4;
		}

		/* (2) 아이디 중복검사 버튼을 ID입력창 오른쪽에 배치 */
		.id-row {
			display: flex;          /* 수평 배치 */
			align-items: center;    /* 수직 가운데 정렬 */
			gap: 5px;               /* 요소 간격 */
		}
		.id-row input[type="text"] {
			flex: 1;                /* 남은 공간을 모두 차지 */
			margin: 0;              /* 기본 여백 제거 */
		}
		#idcheck {
			background: #bdc3c7;
			color: #fff;
			border: none;
			padding: 5px 15px;
			border-radius: 25px;
			cursor: pointer;
			font-size: 14px;
			font-weight: bold;
			transition: background 0.3s;
		}
		#idcheck:hover {
			background: #a7b1b4;
		}
		/* ID 중복검사 결과 스타일 */
		#id_result {
			display: block;
			margin-top: 5px;
			font-size: 12px;
		}
	</style>
</head>
<body>
<div class="signup-container">
	<h2 style="color: #666; margin-bottom: 20px;">회원가입</h2>
	<form action="/members/insert" method="post" enctype="multipart/form-data">
		<table class="signup-table">
			<!-- (1) 파일 선택 버튼 커스텀 -->
			<tr>
				<th>Profile Image</th>
				<td>
					<label for="imageInput" class="file-btn">파일 선택</label>
					<input type="file" id="imageInput" name="profile_file" accept="image/*">
					<span style="font-size: 14px; margin-left: 10px;">파일 없음</span>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<img src="" id="image">
				</td>
			</tr>

			<!-- (2) ID 입력창 오른쪽에 중복검사 버튼 -->
			<tr>
				<th>ID</th>
				<td>
					<div class="id-row">
						<input type="text" name="id" id="id" placeholder="ID를 입력해주세요">
						<button type="button" id="idcheck">중복검사</button>
					</div>
					<span id="id_result"></span>
				</td>
			</tr>

			<tr>
				<th>PW</th>
				<td>
					<input type="password" name="pw" id="pw" placeholder="PW를 입력해주세요">
				</td>
			</tr>
			<tr>
				<th>Name</th>
				<td>
					<input type="text" name="name" id="name" placeholder="NAME을 입력해주세요">
				</td>
			</tr>
			<tr>
				<th>Contact</th>
				<td>
					<input type="text" name="contact" id="contact" placeholder="Contact를 입력해주세요">
				</td>
			</tr>

			<tr>
				<td colspan="2" style="text-align: center;">
					<button type="submit" class="btn btn-submit">가입완료</button>
					<button type="button" class="btn btn-cancel">취소</button>
				</td>
			</tr>
		</table>
	</form>
</div>

<script>
	$("#idcheck").on("click", function () {
		$.ajax({
			url: "/members/idcheck",
			data: { id: $("#id").val() }
		}).done(function (resp) {
			if (JSON.parse(resp)) {
				$("#id_result").css({
					"color": "red"
				}).html("이미 사용중인 ID입니다.");
			} else {
				$("#id_result").css({
					"color": "dodgerblue"
				}).html("사용 가능한 ID입니다.");
			}
		});
	});

	$("#imageInput").on("change", function () {
		const file = this.files[0];
		if (file && file.type.startsWith("image/")) {
			$("#image").attr("src", URL.createObjectURL(file));
		}
	});

	$(".btn-cancel").on("click", function() {
		history.back();
	});
</script>
</body>
</html>
