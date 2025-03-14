<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 상세보기</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<style>
		/* 전체 화면 배경 및 폰트 */
		body {
			margin: 0;
			padding: 0;
			background: #F9F4FF; /* 연한 보라 배경 */
			font-family: "Noto Sans KR", sans-serif;
		}
		/* 상세보기 컨테이너 */
		.detail-container {
			width: 600px;
			margin: 0 auto;
			padding-top: 50px;
		}
		.detail-title {
			text-align: center;
			font-size: 20px;
			color: #666;
			font-weight: bold;
			margin-bottom: 20px;
		}
		/* 본문(상세보기) 테이블 */
		.view-table {
			width: 100%;
			border-collapse: collapse;
			background: transparent;
			margin-bottom: 30px;
		}
		.view-table th, .view-table td {
			border-bottom: 1px solid #ccc;
			padding: 10px;
			vertical-align: middle;
		}
		.view-table th {
			width: 100px;
			text-align: left;
			color: #666;
			font-weight: bold;
			background: none;
		}
		/* 댓글 영역 테이블 */
		.comment-table {
			width: 100%;
			border-collapse: collapse;
			background: #ECE3FA; /* 댓글 영역 배경색 (예: 연한 라벤더) */
			margin-bottom: 30px;
		}
		.comment-table th, .comment-table td {
			border-bottom: 1px solid #ccc;
			padding: 10px;
			vertical-align: middle;
		}
		.comment-table th {
			width: 100px;
			text-align: left;
			color: #666;
			font-weight: bold;
			background: none;
		}
		/* 읽기 전용 input/textarea */
		.readonly {
			border: none;
			outline: none;
			background: transparent;
			width: 100%;
			font-size: 14px;
			color: #666;
			resize: none;
		}
		/* 수정 모드 시 밑줄 */
		.editable {
			border-bottom: 1px solid #ccc;
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
		.btn-purple {
			background: #9B59B6;
			color: #fff;
		}
		.btn-purple:hover {
			background: #8e44ad;
			transform: translateY(-2px);
		}
		.btn-gray {
			background: #bdc3c7;
			color: #fff;
		}
		.btn-gray:hover {
			background: #a7b1b4;
			transform: translateY(-2px);
		}
		/* 파일 목록 버튼 */
		#file_btn {
			margin: 5px;
			padding: 8px 15px;
			border-radius: 25px;
			border: none;
			font-size: 14px;
			font-weight: bold;
			cursor: pointer;
			background: #bdc3c7;
			color: #fff;
			transition: background 0.3s;
		}
		#file_btn:hover {
			background: #a7b1b4;
		}
		#filelist {
			display: none;
			border: 1px solid #ccc;
			margin-top: 5px;
			padding: 10px;
		}
		#filelist ul {
			list-style-type: none;
			margin: 0;
			padding: 0;
		}
		/* 댓글 작성 textarea */
		#comment_input {
			width: 100%;
			height: 65px;
			resize: none;
			border: none;
			background: transparent;
			outline: none;
			font-size: 14px;
		}
		#comment_input.editable {
			border-bottom: 1px solid #ccc;
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
	</style>
</head>
<body>
<div class="detail-container">
	<div class="detail-title">글 상세보기</div>

	<form action="/boards/update" method="post">
		<input type="hidden" name="seq" value="${boardDto.seq}">
		<table class="view-table">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" id="title" class="readonly"
						   value="${boardDto.title}" readonly>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="writer" id="writer" class="readonly"
						   value="${boardDto.writer}" readonly>
				</td>
			</tr>
			<tr>
				<th>작성날짜</th>
				<td class="relative-date" data-timestamp="${boardDto.write_date.time}">
					${boardDto.write_date}
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<button id="file_btn" type="button">파일목록</button>
					<fieldset id="filelist">
						<legend>파일 목록</legend>
						<!-- AJAX로 파일 목록 삽입 -->
					</fieldset>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="contents" id="contents" class="readonly" readonly>${boardDto.contents}</textarea>
				</td>
			</tr>
			<c:if test="${dto.id == boardDto.writer}">
				<tr>
					<td colspan="2" style="text-align: right;">
						<button type="button" class="btn btn-gray" id="delete_btn">삭제하기</button>
						<button type="button" class="btn btn-gray" id="update_btn">수정하기</button>
					</td>
				</tr>
			</c:if>
		</table>
	</form>

	<!-- 예시 댓글(수정 불가) -->
	<table class="comment-table">
		<tr>
			<th>작성자</th>
			<td>예시작성자</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea class="readonly" readonly>예시내용</textarea>
			</td>
		</tr>
	</table>

	<!-- 실제 댓글 작성 폼 -->
	<table class="comment-table">
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" id="reply_writer" class="readonly"
					   value="${dto.id}" readonly>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<!-- **버튼을 같은 셀 안에서 오른쪽 정렬** -->
			<td>
				<div style="display: flex; justify-content: space-between; align-items: center;">
					<textarea name="comment" id="comment_input" class="readonly editable" placeholder="댓글 내용을 입력하세요"></textarea>
					<button type="button" class="btn btn-purple" id="reply_add" style="margin-left: 10px;">작성</button>
				</div>
			</td>
		</tr>
	</table>
</div>

<script>
	// 파일 목록
	$("#file_btn").on("click",function() {
		$.ajax({
			url: "/files/list",
			data: { parent_seq: "${boardDto.seq}" }
		}).done(function(resp) {
			let ul = $("<ul>");
			for(let i = 0; i < resp.length; i++) {
				let link = $("<a>")
						.attr("href", "/files/download?sysName="+resp[i].sysName+"&oriName="+resp[i].oriName)
						.text(resp[i].oriName);
				let li = $("<li>").append(link);
				ul.append(li);
			}
			$("#filelist").append(ul).show();
			$("#file_btn").hide();
		});
	});

	// 삭제하기
	$("#delete_btn").on("click", function() {
		if(confirm("정말 삭제하시겠습니까?")) {
			location.href = "/boards/delete?id=${boardDto.seq}";
		} else {
			location.href = "/boards/detail?id=${boardDto.seq}";
		}
	});

	// 수정하기
	$("#update_btn").on("click",function() {
		// 제목, 내용 readOnly 해제 + 스타일 변경
		$("#title, #contents").removeClass("readonly").addClass("editable").removeAttr("readonly");
		// 수정/삭제 버튼 숨김
		$("#update_btn, #delete_btn").hide();

		// 수정완료, 취소 버튼 생성
		let updateOk = $("<button>").text("수정완료")
				.addClass("btn btn-purple")
				.on("click", function() {
					$("form").submit();
				});
		let updateCancel = $("<button>").text("취소")
				.addClass("btn btn-gray")
				.on("click", function() {
					location.reload();
				});
		$(this).parent().append(updateOk, updateCancel);
	});

	// 댓글 작성
	$("#reply_add").on("click",function() {
		$.ajax({
			url: "/reply/insert",
			type: "post",
			data: {
				parent_seq: "${boardDto.seq}",
				writer: $("#reply_writer").val(),
				content: $("#comment_input").val()
			}
		}).done(function(resp) {
			alert("댓글이 등록되었습니다.");
			location.reload();
		});
	});

	// 상대적 날짜 표시
	let now = new Date();
	$(".relative-date").each(function(){
		let timestamp = parseInt($(this).data("timestamp"), 10);
		let postDate = new Date(timestamp);
		let diffMinutes = Math.floor((now - postDate) / (1000 * 60));

		if(diffMinutes < 1) {
			$(this).text("방금 전");
		} else if(diffMinutes < 60) {
			$(this).text(diffMinutes + "분 전");
		} else if(diffMinutes < 1440) {
			let diffHours = Math.floor(diffMinutes / 60);
			$(this).text(diffHours + "시간 전");
		} else {
			let year = postDate.getFullYear();
			let month = String(postDate.getMonth() + 1).padStart(2, '0');
			let day = String(postDate.getDate()).padStart(2, '0');
			$(this).text(year + "년 " + month + "월 " + day + "일 ");
		}
	});
</script>
</body>
</html>
