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
	
<!-- 	<script>
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
	</script> -->
	
	<script>
		// --- 타이핑 효과 헬퍼 함수 ---
		/**
		 * @param {HTMLElement} chatItems - 채팅 아이템을 감싸는 부모 요소 (스크롤 계산용)
		 * @param {string} text - 타이핑할 전체 텍스트
		 * @param {number} speed - 타이핑 속도 (ms)
		 * @returns {Promise} 타이핑 완료 시 resolve되는 Promise
		 */
		function typeBotMessage(chatItems, text, speed = 40) {
			return new Promise(resolve => {
				const newBotLi = document.createElement('li');
				newBotLi.classList.add('bot-item');
				chatItems.append(newBotLi); // 1. 빈 <li> 요소를 먼저 추가

				let i = 0;
				function typing() {
					if (i < text.length) {
						newBotLi.textContent += text.charAt(i); // 2. 한 글자씩 추가
						i++;
						chatItems.scrollTop = chatItems.scrollHeight; // 스크롤
						setTimeout(typing, speed); // 3. 다음 글자 
					} else {
						resolve(); // 4. 타이핑 완료
					}
				}
				typing(); // 타이핑 시작
			});
		}


		// --- 기존 챗봇 로직 ---
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
		
		const chatItems = document.querySelector('.content-items');
		
		// --- 데모 메시지 (기존 코드) ---
		const botLi = document.createElement('li');
		botLi.classList.add('bot-item');
		botLi.textContent = '어떤걸 도와드릴까요? 1. 구매하는 방법  2. 반출하는 방법 ';
		chatItems.append(botLi);

		// 폼 제출 시
		const chatForm = document.querySelector('.chatbot-input');
		// 폼 이벤트 핸들러를 async로 변경
		chatForm.addEventListener('submit', async (e) => {
			e.preventDefault();
			
			const userInput = chatbotInput.value.trim();
			if (userInput === '') return;

			// 1. 사용자 메시지 추가
			const newUserLi = document.createElement('li');
			newUserLi.classList.add('user-item');
			newUserLi.textContent = userInput;
			chatItems.append(newUserLi);

			// 2. 입력창 비우기
			chatbotInput.value = '';

			// 3. 스크롤을 맨 아래로 이동
			chatItems.scrollTop = chatItems.scrollHeight;

			// 4. (수정) 봇 응답 처리
			try {
				const res = await fetch(`/assetmanager/chat`, {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json',
					},
					body: JSON.stringify({ id: userInput }),
				});
				
				const result = await res.json();
				const msg = result.msg;

				setTimeout(async () => {
					await typeBotMessage(chatItems, msg);
					const menuText = `어떤걸 도와드릴까요? 1. 구매하는 방법  2. 반출하는 방법 `;
					await typeBotMessage(chatItems, menuText);
				}, 500);

			} catch (error) {
				console.error("Chat error:", error);
				// (예외 처리) 에러 메시지 표시
				await typeBotMessage(chatItems, "오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			}
		});
	</script>
</body>
</html>