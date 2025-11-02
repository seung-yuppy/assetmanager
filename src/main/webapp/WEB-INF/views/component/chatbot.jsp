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
			챗봇
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
	
	<script>
		const chatbotInput = document.querySelector('.chatbot-input input[type="text"]');
		const chatbotBtn = document.querySelector('.chatbot-button');
		chatbotBtn.addEventListener('click', ()=>{
			const chatbotContent = document.querySelector('.chatbot-content-wrapper');
			const isHidden = chatbotContent.style.display === 'none' || chatbotContent.style.display === '';
			chatbotContent.style.display = isHidden ? 'flex' : 'none';
			
			if (isHidden) {
				chatbotInput.focus();
			}
		});
		
		// --- 데모 메시지 (기존 코드) ---
		const chatItems = document.querySelector('.content-items');
		
		const botLi = document.createElement('li');
		botLi.classList.add('bot-item');
		botLi.textContent = '어떤걸 도와드릴까요? 1. 구매하는 방법  2. 반출하는 방법 ';
		chatItems.append(botLi);

		// 폼 제출 시
		const chatForm = document.querySelector('.chatbot-input');
		chatForm.addEventListener('submit', async (e) => {
			e.preventDefault();
			
			const userInput = chatbotInput.value.trim();
			if (userInput === '') return;

			const res = await fetch(`/assetmanager/chat`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
				},
				body: JSON.stringify({ id: userInput }),
			});
			
			const result = await res.json();
			const msg = result.msg;
			
			// 1. 사용자 메시지 추가
			const newUserLi = document.createElement('li');
			newUserLi.classList.add('user-item');
			newUserLi.textContent = userInput;
			chatItems.append(newUserLi);

			// 2. 입력창 비우기
			chatbotInput.value = '';

			// 3. 스크롤을 맨 아래로 이동
			chatItems.scrollTop = chatItems.scrollHeight;

			// 4. (예시) 봇 응답 시뮬레이션
			setTimeout(() => {
				const newBotLi1 = document.createElement('li');
				newBotLi1.classList.add('bot-item');
				newBotLi1.textContent = msg;
				chatItems.append(newBotLi1);
				const newBotLi2 = document.createElement('li');
				newBotLi2.classList.add('bot-item');
				newBotLi2.textContent = `어떤걸 도와드릴까요? 1. 구매하는 방법  2. 반출하는 방법 `;
				chatItems.append(newBotLi2);
				chatItems.scrollTop = chatItems.scrollHeight;
			}, 500);
		});
	</script>
</body>
</html>