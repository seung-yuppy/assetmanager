<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/chatbot.css" rel="stylesheet">
</head>
<body>
	<!-- 챗봇 버튼 시작  -->
	<div class="chatbot-wrapper">
		<button type="button" class="chatbot-button">
			<img src="/assetmanager/resources/image/icon_chat.svg" class="chat-icon">
		</button>
	</div>
	<!-- 챗봇 버튼 끝 -->
	
	<!-- 챗봇 내용 시작 -->
	<div class="chatbot-content-wrapper">
		<h2>AMS Helper</h2>
		<ul class="content-items">

		</ul>
		<form class="chatbot-input">
			<input type="text" name="id">
			<button type="submit">전송</button>
		</form>	
	</div>
	<!-- 챗봇 내용 끝 -->
	
	<script src="/assetmanager/resources/js/chat.js"></script>
</body>
</html>