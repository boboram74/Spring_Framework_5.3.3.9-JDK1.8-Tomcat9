<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
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
		.board-container {
			width: 700px; /* 원하는 너비로 조절 */
			margin: 0 auto;
			padding-top: 50px;
			text-align: center;
		}
		/* 상단 제목 */
		.board-title {
			font-size: 24px;
			font-weight: bold;
			color: #666;
			margin-bottom: 20px;
		}
		/* 테이블 스타일 */
		.board-table {
			width: 100%;
			border-collapse: collapse;
			background: #fff0; /* 투명 배경 (또는 원하는 색상) */
		}
		.board-table th, .board-table td {
			border-bottom: 1px solid #ccc;
			padding: 10px;
			vertical-align: middle;
		}
		.board-table th {
			background: none;
			color: #666;
			font-weight: bold;
		}
		/* 버튼 공통 스타일 (로그인 폼과 유사) */
		.btn {
			margin: 5px;
			padding: 8px 15px;
			border: none;
			border-radius: 25px;
			font-size: 14px;
			font-weight: bold;
			cursor: pointer;
			transition: background 0.3s, transform 0.2s;
		}
		/* 보라색 버튼 */
		.btn-purple {
			background: #9B59B6; /* 보라색 */
			color: #fff;
		}
		.btn-purple:hover {
			background: #8e44ad;
			transform: translateY(-2px);
		}
		/* 회색 버튼 */
		.btn-gray {
			background: #bdc3c7; /* 연회색 */
			color: #fff;
		}
		.btn-gray:hover {
			background: #a7b1b4;
			transform: translateY(-2px);
		}
		/* 페이지 번호 (paging) 버튼 스타일 */
		.paging {
			display: inline-block;
			margin: 5px 3px;
			width: 30px;
			height: 30px;
			line-height: 30px;
			border-radius: 50%;
			background: #bdc3c7;
			color: #fff;
			text-align: center;
			vertical-align: middle;
			cursor: pointer;
			transition: background 0.3s, transform 0.2s;
		}
		.paging:hover {
			background: #a7b1b4;
			transform: translateY(-2px);
		}
		.contents {
			text-align: left;
		}
		.board-table a {
			color: #666;
			text-decoration: none;
		}
		.board-table a:hover {
			color: #8e44ad;
			text-decoration: underline;
		}
	</style>
</head>
<body>
<div class="board-container">
	<div class="board-title">자유게시판</div>
	<table class="board-table">
		<thead>
		<tr>
			<th width="5%">ID</th>
			<th width="30%">제목</th>
			<th width="5%">작성자</th>
			<th width="10%">날짜</th>
			<th width="5%">조회수</th>
		</tr>
		</thead>
		<tbody id="board-body">
		<!-- 게시글 목록이 동적으로 추가됨 -->
		</tbody>
		<tfoot id="buttons">
		<tr>
			<td colspan="5" style="text-align: right;">
				<button id="btn-home" class="btn btn-purple" type="button" onclick="location.href='/'" >홈으로</button>
				<button id="btn-write" class="btn btn-gray" type="button" onclick="location.href='/boards/writeForm'">작성하기</button>
			</td>
		</tr>
		</tfoot>
	</table>
</div>

<script>
	$(function() {
		let cpage = sessionStorage.getItem("page") || 1;
		$.ajax({
			url: "/boards/boardList",
			data: { cpage: cpage }
		}).done(function(resp) {
			let list = resp.list;
			for(let i = 0; i < list.length; i++) {
				let tr = $('<tr>');
				tr.append($('<td>').html(list[i].seq));

				let a = $('<a>').attr('href','/boards/detail?id='+ list[i].seq).text(list[i].title);
				tr.append($('<td>').append(a).addClass('contents').attr('id', list.seq));

				tr.append($('<td>').html(list[i].writer));

				let timestamp = new Date(list[i].write_date).getTime();
				tr.append($('<td>').addClass('relative-date').attr('data-timestamp',timestamp).html(list[i].write_date));

				tr.append($('<td>').html(list[i].view_count));
				$('#buttons').before(tr);
			}

			let pagingTr = $('<tr>');
			let pagingTd = $('<td colspan="5" style="text-align: center;">');
			if(resp.needPrev) {
				let prevSpan = $('<span>').addClass('paging').attr("page", resp.startNavi - 1).html("<");
				pagingTd.append(prevSpan);
			}
			// 페이지 번호
			for(let i = resp.startNavi; i <= resp.endNavi; i++) {
				let pageSpan = $('<span>').addClass('paging').attr("page", i).html(i);
				pagingTd.append(pageSpan);
			}
			// 다음 버튼
			if(resp.needNext) {
				let nextSpan = $('<span>').addClass('paging').attr("page", resp.endNavi + 1).html(">");
				pagingTd.append(nextSpan);
			}

			pagingTr.append(pagingTd);
			$('#buttons').before(pagingTr);

			// 페이지 번호 클릭 시
			$(".paging").on("click", function() {
				let pageNum = $(this).attr("page");
				sessionStorage.setItem("page", pageNum);
				location.href = "/boards/toBoard?cpage=" + pageNum;
			});

			// 상대적 날짜 표시
			let now = new Date();
			$('.relative-date').each(function(){
				let timestamp = parseInt($(this).data('timestamp'), 10);
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
		});
	});
</script>
</body>
</html>
