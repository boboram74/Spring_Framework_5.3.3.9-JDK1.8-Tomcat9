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
		/* 전체 화면 배경 및 폰트 (로그인 폼과 동일) */
		body {
			margin: 0;
			padding: 0;
			background: #F9F4FF; /* 연한 보라/분홍 배경 */
			font-family: "Noto Sans KR", sans-serif;
		}

		/* 작성 페이지 컨테이너 */
		.write-container {
			width: 600px;
			margin: 0 auto;
			padding-top: 50px;
		}

		.write-title {
			text-align: center;
			font-size: 20px;
			color: #666;
			font-weight: bold;
			margin-bottom: 20px;
		}

		/* 테이블 스타일 */
		.write-table {
			width: 100%;
			border-collapse: collapse;
			background: transparent;
		}
		.write-table th, .write-table td {
			border-bottom: 1px solid #ccc;
			padding: 10px;
			vertical-align: middle;
		}
		.write-table th {
			width: 100px;
			text-align: left;
			color: #666;
			font-weight: bold;
			background: none;
		}
		/* 제목 input: 밑줄 제거 */
		.write-table input[type="text"] {
			width: 100%;
			border: none;         /* 테두리 제거 */
			outline: none;
			font-size: 14px;
			background: transparent;
		}
		#contents {
			width: 100%;
			height: 200px;
			resize: none;
			border: none;
			outline: none;
			font-size: 14px;
			background: transparent;
		}
		::-webkit-input-placeholder { color: #ccc; }
		:-ms-input-placeholder { color: #ccc; }
		::placeholder { color: #ccc; }

		/* (1) 파일 선택 버튼 커스텀 */
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
			background: #bdc3c7;
			color: #fff;
			font-size: 14px;
			font-weight: bold;
			cursor: pointer;
			transition: background 0.3s;
		}
		.file-btn:hover {
			background: #a7b1b4;
		}
		/* 파일 라벨 텍스트 */
		.file-label {
			margin-left: 10px;
			font-size: 14px;
			color: #999;
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
<div class="write-container">
	<div class="write-title">글 작성하기</div>

	<form action="/boards/insert" method="post" enctype="multipart/form-data">
		<input type="hidden" name="writer" value="${dto.id}">
		<table class="write-table">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" id="title" placeholder="제목을 작성해주세요">
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<label for="files" class="file-btn">파일 선택</label>
					<input type="file" id="files" name="files" multiple>
					<span class="file-label">선택된 파일 없음</span>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="contents" id="contents" placeholder="내용을 입력해주세요"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: right;">
					<button type="submit" class="btn btn-purple">작성하기</button>
					<button type="button" class="btn btn-gray" id="cancelBtn">취소</button>
				</td>
			</tr>
		</table>
	</form>
</div>

<script>
	document.getElementById("files").addEventListener("change", function() {
		const fileList = this.files;
		const label = document.querySelector(".file-label");
		if(fileList.length > 0) {
			label.textContent = fileList.length + "개 파일 선택됨";
		} else {
			label.textContent = "선택된 파일 없음";
		}
	});
	document.getElementById("cancelBtn").addEventListener("click", function() {
		history.back();
	});
</script>
</body>
</html>
