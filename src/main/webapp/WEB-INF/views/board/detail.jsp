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
	  #contents {
	    width: 500px;
	    height: 300px;
	    resize: none;
	  }
	  #comment {
	    width: 515px;
	    height: 65px;
	    resize: none;
	  }
	  #filelist {
		display: inline-block;
		width: auto; 
	  }
	  ul {
	    list-style-type: none;
	    padding: 0;
	    margin: 0;
	}
</style>
</head>
<body>
	<form action="/boards/update" method="post">
	<input type="hidden" name="seq" value="${boardDto.seq}">
		<table border="1" align="center">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" id="title" value="${boardDto.title}" readonly>
				</td>
			</tr>
			
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="writer" id="writer" value="${boardDto.writer}" readonly>
				</td>
			</tr>	
			<tr>
				<th>작성날짜</th>
				<td class="relative-date" data-timestamp="${boardDto.write_date.time}">${boardDto.write_date}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<button id="file_btn" type="button">파일목록</button>
					<fieldset id="filelist" style="display:none;">
						<legend>파일 목록</legend>
					</fieldset>					
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="contents" id="contents"readonly>${boardDto.contents}</textarea>
				</td>
			</tr>
			<tr>
			<c:if test="${dto.id == boardDto.writer}">
				<td colspan="2" class="button-container" align="right">
					<button type="button" id="delete_btn">삭제하기</button>
					<button type="button" id="update_btn">수정하기</button>
				</td>
			</c:if>
			</tr>
		</table>
	</form>
	
		<table border="1" align="center">
			<tr>
				<th>작성자</th>
				<td>예시작성자</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="comment" id="comment">예시내용</textarea></td>
			</tr>
		</table>
		
		<table border="1" align="center">
			<tr>
				<th>작성자</th>
				<td><input type="text" id="writer" value="${dto.id}"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="comment" id="comment"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="button-container" align="right">
					<button type="button" id="reply_add">작성하기</button>
				</td>
			</tr>
		</table>
	<script>
		$("#file_btn").on("click",function() {
			$.ajax({
				url: "/files/list",
				data: {parent_seq:"${boardDto.seq}"}
			}).done(function(resp) {
				console.log(resp);		
				let ul = $("<ul>");
		        for(let i = 0; i < resp.length; i++) {
		        	let link = $("<a>").attr("href","/files/download?sysName="+resp[i].sysName+"&oriName="+resp[i].oriName).text(resp[i].oriName);
		        	let li = $("<li>").append(link);
		        	ul.append(li);
		        }
				$("#filelist").append(ul).show();
				$("#file_btn").hide();
			});
		})
		$("#delete_btn").on("click", function() {
   			if(confirm("정말 삭제하시겠습니까?") == true) {
        		location.href = "/boards/delete?id=${boardDto.seq}";
   			} else {
   				location.href = "/boards/detail?id=${boardDto.seq}";
   			}
    	});
		$("#update_btn").on("click",function() {
			$("#title").focus();
			$("#update_btn,#delete_btn").css("display","none");
			$("#title, #contents").removeAttr("readonly");
			
   			let updateOk = $("<button>");
   			updateOk.html("수정완료");
   			
   			let updateCancel = $("<button>").attr("type","button");
   			updateCancel.html("취소");
   			
   			updateCancel.on("click", function() {
   				location.reload();
   			});
   			$(".button-container").append(updateCancel,updateOk);
		});
		//댓글작성
		$("#reply_add").on("click",function() {
			$.ajax({
				url: "/reply/insert",
				type: "post",
				data: {
						parent_seq:"${boardDto.seq}",
						writer:$("#writer").val(),
						content:$("#comment").val()
					}
			}).done(function(resp) {
				console.log(resp);
			});
		})
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
	</script>
</body>
</html>