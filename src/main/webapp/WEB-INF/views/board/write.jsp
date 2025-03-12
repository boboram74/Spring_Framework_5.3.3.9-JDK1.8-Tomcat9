<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성하기</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
	  #contents {
	    width: 500px;
	    height: 300px;
	    resize: none;
	  }
</style>
</head>
<body>
	<form action="/boards/insert" method="post" enctype="multipart/form-data">
	<input type="hidden" name="writer" value="${dto.id}">
		<table border="1" align="center">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" id="title" placeholder="제목을 작성해주세요">
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="files" multiple></td>
			</tr>

			<tr>
				<th>내용</th>
				<td>
					<textarea name="contents" id="contents" placeholder="내용을 입력해주세요"></textarea>
				</td>
			</tr>

			<tr>
				<td colspan="2" class="button-container" align="right">
					<button type="submit">작성하기</button>
					<button type="button">취소</button>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>