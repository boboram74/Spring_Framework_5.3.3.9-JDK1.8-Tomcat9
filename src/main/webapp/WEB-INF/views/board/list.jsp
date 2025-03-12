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
	.paging {
		border:1px solid black;
		cursor:pointer;
		display:inline-block;
		width:20px;
		height:20px;
		margin: auto;
		padding: auto;
	}
    a {
        text-decoration: none;
        color: black;
    }
</style>
</head>
<body>
	<table border="1" align="center" margin="auto">
		<tr>
			<th colspan="6">자유게시판</th>
		</tr>
		
		<tr id="board_list">
			<th width="5%">ID</th>
			<th width="30%">제목</th>
			<th width="5%">작성자</th>
			<th width="10%">날짜</th>
			<th width="5%">조회수</th>
		</tr>
		
		<tr id="buttons">
			<td colspan="6" align="right">
				<button id="btn1" type="button" onclick="location.href='/'">홈으로</button>
				<button id="btn2" type="button" onclick="location.href='/boards/writeForm'">작성하기</button>
			</td>
		</tr>
		
	</table>
	<script>
	$(function() {
		let cpage = sessionStorage.getItem("page") || 1;
	    $.ajax({
	        url: "/boards/boardList",
	        data: { cpage:cpage }
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
	       
	        let tr = $('<tr>');
	        let td = $('<td colspan="5" style="text-align: center;">');
	        //이전 버튼이 필요한 경우
	        if(resp.needPrev) {
		    	let prevSpan = $('<span>').addClass('paging').attr("page",resp.startNavi-1).html("<");
		        td.append(prevSpan);
	        }
	        //페이지 번호 생성
	        for(let i = resp.startNavi; i <= resp.endNavi; i++) {
	        	let pageSpan = $('<span>').addClass('paging').attr("page",i).html(i);
	        	td.append(pageSpan);
	        }
	        //다음 버튼이 필요한 경우
	        if(resp.needNext) {
	        	let nextSpan = $('<span>').addClass('paging').attr("page", resp.endNavi+1).html(">");
			    td.append(nextSpan);
	        }
	        // 페이징 생성
	        tr.append(td);
	        $('#buttons').before(tr);
	        
	       	$(".paging").on("click",function() {
	       		let pageNum = $(this).attr("page");
	       		sessionStorage.setItem("page",pageNum);
	       		location.href="/boards/toBoard?cpage="+pageNum;
	       	});	
	    	var now = new Date();
			$('.relative-date').each(function(){
				var timestamp = parseInt($(this).data('timestamp'), 10);
				var postDate = new Date(timestamp);
				var diffMinutes = Math.floor((now - postDate) / (1000 * 60));
				    
				if(diffMinutes < 1) {
					$(this).text("방금 전");
				} else if(diffMinutes < 60) {
					$(this).text(diffMinutes + "분 전");
				} else if(diffMinutes < 1440) {
				   var diffHours = Math.floor(diffMinutes / 60);
				   $(this).text(diffHours + "시간 전");
				} else {
					let year = postDate.getFullYear();
					let month = String(postDate.getMonth() + 1).padStart(2, '0');
					let day = String(postDate.getDate()).padStart(2, '0');
					$(this).text(year + "년 " + month + "월 " + day + "일 ");	
				}
			 });	       	
	    });
	})

	</script>
</body>
</html>