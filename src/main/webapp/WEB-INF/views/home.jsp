<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
    a {
        text-decoration: none;
        color: black;
    }
    #home {
    	width:20vw;
    	height:15vw;
    }
</style>
</head>
<body>
	<form action="/members/login" method="post">
	<table border="1" align="center" style="margin:auto" id="home">
		<tr>
			<th colspan="2">Home</th>
		</tr>
		<c:choose>
			<c:when test="${dto == null}">
		<tr>
			<td><input type="text" name="id" placeholder="ID입력"></td>
		</tr>
		<tr>
			<td><input type="text" name="pw" placeholder="PW입력"></td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: center;"> 
				<a href="/members/signupForm">
					<button type="button">회원가입</button>
				</a>
				<a href="/members/login">
					<button type="submit">로그인</button>
				</a>
			</td>
		</tr>
		</c:when>
		<c:otherwise>
		<tr>
			<td colspan="">
			  <c:if test="${dto.profile_image != null}">
			    <img src="/upload/${dto.profile_image}" style="width: 100%; height: auto;">
			  </c:if>
			  <c:if test="${dto.profile_image == null}">
			    <span>이미지 없음</span>
			  </c:if>
			</td>
		</tr>
		<tr>
			<td style="text-align: center;">${dto.name}님 환영합니다</td>
		</tr>
		<tr>
	    <td style="text-align: center;">
				<button type="button" onclick="location.href='/members/toMypage'">마이페이지</button>
				<button type="button" onclick="location.href='/boards/toBoard?cpage=1'">게시판</button>
				<button type="button" onclick="location.href='/members/logout'">로그아웃</button>
				<button type="button" id="delete_btn">회원탈퇴</button>
			</td>
		</tr>
			<script>
			$("#delete_btn").on("click", function() {
	   			if(confirm("정말 삭제하시겠습니까?") == true) {
	        		location.href = "/members/out?id=${loginID}";
	        		
	   			}
	    	});
			</script>
		</c:otherwise>
	</c:choose>
	</table>
	</form>
</body>
</html>