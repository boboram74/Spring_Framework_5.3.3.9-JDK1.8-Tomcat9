<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <title>웹페이지 제목</title>
    <style>
        *{box-sizing: border-box;}
        .chat-box{
            width: 400px;
            height: 600px;
            margin: auto;
        }
        .chat-area{
            height: 80%;
            overflow-y: auto;
            background-color: #95b6d6;
            position: relative;
        }
        .chat-header {
            background-color: #ccc;
            height: 50px;
            line-height: 50px;
            text-align: center;
            font-weight: bold;
            color: #333;
        }
        .input {
            height: 20%;
            overflow-y: auto;
            display: flex;
        }

        .input>.input-area {
            height: 100%;
            width: 80%;
        }
        .input button {
            height: 100%;
            width: 20%;
        }
        .input-area{
            height: 20%;
            overflow-y: auto;
            border: 1px solid black;
            display: flex;
        }
        .input button {
            height: 100%;
            width: 20%;
        }
        .messageContainer {
            display: flex;
            align-items: center;
            border: none;
        }
        .message {
            width: fit-content;
            word-wrap: break-word;
            max-width: 80%;
            padding: 5px;
            margin: 5px;
            background: #fde500;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            font-size: 14px;
        }
        .date {
            display: flex;
            width: fit-content;
            font-size: 10px;
            color: white;
        }
    </style>
</head>
<body>
<div class="chat-box">
    <div class="chat-header">회원 소통 창구</div>
    <div class="chat-area"></div>
    <div class="input">
        <div class="input-area" contenteditable="true"></div>
        <button id="button" class="before">전송</button>
    </div>
</div>
<script>
    let ws = new WebSocket("ws://10.10.55.9/chat"); //WebSocket EndPoint Send
    function sendMessage() {
        let msg = $(".input-area").html().trim();
        if (!msg) {
            return;
        }
        ws.send(msg);
        $(".input-area").html("");
    }
    // 엔터키로 전송
    $(".input-area").on("keydown", function(e) {
        if(e.key === "Enter") {
            e.preventDefault();
            sendMessage();
            return false;
        }
    });
    // 버튼 클릭으로 전송
    $("#button").on("click", function(e) {
        e.preventDefault();
        sendMessage();
    });

    ws.onmessage = function (e) { // WebSocket Receive
        let msg = JSON.parse(e.data);
        if (msg.list) {
            msg.list.forEach(item => {
                let formatted = (item.write_date);
                let dateDiv = $("<div>").addClass("date").text(formatted);
                let line = $("<div>").addClass("message").html(item.writer + " : " + item.contents);
                let container = $("<div>").addClass("messageContainer");
                container.append(line, dateDiv);
                $(".chat-area").append(container);
            });
        } else {
            let date = $("<div>").addClass("date").text(msg.write_date);
            let line = $("<div>").addClass("message").html(msg.sender + " : " + msg.message);
            let container = $("<div>").addClass("messageContainer");
            container.append(line, date);
            $(".chat-area").append(container);
        }
        $(".chat-area").scrollTop($(".chat-area")[0].scrollHeight);
    };
    function formatDate(date) {
        let dateObj = new Date(date);
        let year   = dateObj.getFullYear();
        let month  = String(dateObj.getMonth() + 1).padStart(2, "0");
        let day    = String(dateObj.getDate()).padStart(2, "0");
        let hour   = String(dateObj.getHours()).padStart(2, "0");
        let minute = String(dateObj.getMinutes()).padStart(2, "0");
        let second = String(dateObj.getSeconds()).padStart(2, "0");
        return `${year}-${month}-${day} ${hour}:${minute}:${second}`;
    }
</script>
</body>
</html>