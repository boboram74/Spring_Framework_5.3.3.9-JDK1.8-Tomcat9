<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
		  integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
		  crossorigin="anonymous" referrerpolicy="no-referrer" />
	<style>
		body {
			margin: 0;
			padding: 0;
			background: #F9F4FF;
			font-family: "Noto Sans KR", sans-serif;
		}
		.login-container, .welcome-container {
			width: 350px;
			margin: 0 auto;
			padding-top: 50px;
			text-align: center;
		}
		.login-icon {
			width: 100px;
			height: 100px;
			margin: 40px auto 20px auto;
		}
		.profile-image {
			width: 100px;
			height: 100px;
			object-fit: cover;
			border-radius: 50%;
			margin: 40px auto 20px auto;
		}
		.label {
			text-align: left;
			margin: 15px 0 5px 0;
			font-weight: bold;
			font-size: 14px;
			color: #666;
		}
		.input-field {
			width: 100%;
			padding: 8px 0;
			border: none;
			border-bottom: 1px solid #ccc;
			outline: none;
			font-size: 14px;
			background: transparent;
		}
		::-webkit-input-placeholder { color: #ccc; }
		:-ms-input-placeholder { color: #ccc; }
		::placeholder { color: #ccc; }

		.btn {
			width: 100%;
			margin: 10px 0;
			padding: 12px 0;
			border: none;
			border-radius: 25px;
			font-size: 16px;
			cursor: pointer;
			transition: background 0.3s;
			font-weight: bold;
		}
		.btn-login {
			background: #9B59B6;
			color: #fff;
		}
		.btn-login:hover {
			background: #8e44ad;
		}
		.btn-signup {
			background: #bdc3c7;
			color: #fff;
		}
		.btn-signup:hover {
			background: #a7b1b4;
		}

		.btn-option {
			background: linear-gradient(135deg, #bdc3c7, #a7b1b4);
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
			color: #fff;
		}
		.btn-option:hover {
			background: linear-gradient(135deg, #a7b1b4, #bdc3c7);
			transform: translateY(-2px);
		}

		.welcome-text {
			font-size: 18px;
			color: #666;
			margin-bottom: 20px;
			font-weight: bold;
		}
	</style>
</head>
<body>
<c:choose>
	<c:when test="${dto == null}">
		<div class="login-container">
			<div class="login-icon">
				<i class="fa-solid fa-house fa-2xl"></i>
			</div>

			<div class="label">아이디</div>
			<input type="text" name="id" class="input-field" placeholder="아이디를 입력하세요" form="loginForm" />

			<div class="label">비밀번호</div>
			<input type="password" name="pw" class="input-field" placeholder="비밀번호를 입력하세요" form="loginForm" />

			<form action="/members/login" method="post" id="loginForm"></form>

			<button type="submit" form="loginForm" class="btn btn-login" onclick="location.href='/members/login'">로그인</button>
			<button type="button" class="btn btn-signup" onclick="location.href='/members/signupForm'">회원가입</button>
		</div>
	</c:when>

	<c:otherwise>
		<div class="welcome-container">
			<c:choose>
				<c:when test="${dto.profile_image != null}">
					<img src="/upload/${dto.profile_image}" alt="프로필 이미지" class="profile-image" />
				</c:when>
				<c:otherwise>
					<div class="login-icon">
						<i class="fa-solid fa-user fa-2xl"></i>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="welcome-text">${dto.name}님 환영합니다</div>
			<button type="button" class="btn btn-login" onclick="location.href='/members/toMypage'">마이페이지</button>
			<button type="button" class="btn btn-option" onclick="location.href='/chat/toChat'">채팅</button>
			<button type="button" class="btn btn-login" onclick="location.href='/boards/toBoard?cpage=1'">게시판</button>
			<button type="button" class="btn btn-option" onclick="location.href='/members/logout'">로그아웃</button>
			<button type="button" class="btn btn-login" id="delete_btn">회원탈퇴</button>
		</div>

		<script>
			$("#delete_btn").on("click", function() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href = "/members/out?id=${loginID}";
				}
			});
		</script>
	</c:otherwise>
</c:choose>
</body>
</html>
