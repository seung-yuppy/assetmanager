// [수정된 typeBotMessage 함수]
// 이 코드로 기존 함수를 완전히 덮어쓰세요.
function typeBotMessage(chatItems, text, speed = 40) {
    return new Promise(resolve => {
        const newBotLi = document.createElement('li');
        newBotLi.classList.add('bot-item');
        chatItems.append(newBotLi); // 1. 빈 <li> 요소를 먼저 추가

        let i = 0;
        function typing() {
            if (i < text.length) {
                const char = text.charAt(i);

                if (char === '\n') {
                    // 2. 만약 문자가 '\n' (줄바꿈)이면, <br> 요소를 추가합니다.
                    newBotLi.append(document.createElement('br'));
                } else {
                    // 3. 일반 문자라면, TextNode로 만들어서 안전하게 추가합니다.
                    // (XSS 방지. innerHTML += char 보다 훨씬 안전합니다.)
                    newBotLi.append(document.createTextNode(char));
                }

                i++;
                chatItems.scrollTop = chatItems.scrollHeight; // 스크롤
                setTimeout(typing, speed); // 4. 다음 글자
            } else {
                resolve(); // 5. 타이핑 완료
            }
        }
        typing(); // 타이핑 시작
    });
}
	
	    // --- ✨ [추가] HTML을 포함한 봇 메시지를 추가하는 함수 ---
	    // (링크/버튼을 표시하기 위해 필요)
	    function appendBotHtmlMessage(chatItems, html) {
	        const newBotLi = document.createElement('li');
	        newBotLi.classList.add('bot-item');
	        newBotLi.classList.add('bot-action-item'); // 버튼/링크용 별도 클래스
	        newBotLi.innerHTML = html; // 텍스트가 아닌 HTML로 내용 삽입
	        chatItems.append(newBotLi);
	        chatItems.scrollTop = chatItems.scrollHeight; // 스크롤
	    }
	
	    // --- (기존 코드: 챗봇창 토글) ---
	    const chatbotInput = document.querySelector('.chatbot-input input[type="text"]');
	    const chatbotBtn = document.querySelector('.chatbot-button');
	    chatbotBtn.addEventListener('click', () => {
	        const chatbotContent = document.querySelector('.chatbot-content-wrapper');
	        const isHidden = chatbotContent.style.display === 'none' || chatbotContent.style.display === '';
	        chatbotContent.style.display = isHidden ? 'flex' : 'none';
	        
	        if (isHidden) {
	            chatbotInput.focus();
	        }
	    });
	
	    // --- (기존 코드: 초기 메시지) ---
	    const chatItems = document.querySelector('.content-items');
	    const botLi = document.createElement('li');
	    botLi.classList.add('bot-item');
	    botLi.textContent = '어떤걸 도와드릴까요?';

	    const botLi2 = document.createElement('li');
	    botLi2.classList.add('bot-item');
	    botLi2.textContent = '1. 구매 2. 반출 3. 반납 4.연장';

	    chatItems.append(botLi, botLi2);
	
	    // --- ✨ [수정] menuText를 상단으로 이동 ---
	    const menuText1 = `어떤걸 도와드릴까요?`;
	    const menuText2 = `1. 구매 2. 반출 3. 반납 4.연장`;
	    const chatForm = document.querySelector('.chatbot-input');
	
	    // --- (기존 코드: 폼 전송 이벤트 리스너) ---
	    chatForm.addEventListener('submit', async (e) => {
	        e.preventDefault();
	        
	        const userInput = chatbotInput.value.trim();
	        if (userInput === '') return;
	
	        const newUserLi = document.createElement('li');
	        newUserLi.classList.add('user-item');
	        newUserLi.textContent = userInput;
	        chatItems.append(newUserLi);
	        chatbotInput.value = '';
	        chatItems.scrollTop = chatItems.scrollHeight;
	
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
	
	            // --- ✨ [수정] 봇 답변 후 처리 로직 ---
	            setTimeout(async () => {
	            	// 1. 서버에서 받은 msg
	                // (이전 답변의 정규식은 \n (줄바꿈)을 처리 못할 수 있으니 \s (모든 공백)로 변경)
	            	const msgHtml = msg.replace(/ (\d+(-\d+)?\.)/g, '<br> $1');

	                // 2. [수정!] <br> 태그를 HTML로 해석하는 'appendBotHtmlMessage' 함수로 변경
	                await typeBotMessage(chatItems, msgHtml);
	            	
                    let addressLink = "#";
                    if (userInput === "1")
                        addressLink = "/assetmanager/order/form";
                    else if (userInput === "2")
                        addressLink = "/assetmanager/rent/form";
                    else if (userInput === "3" || userInput === "4")
                    	addressLink = "/assetmanager/myasset/list"

	                const actionHtml = `
	                    <div class="chatbot-actions">
	                        <a href="${addressLink}" class="chatbot-link-icon">
	                           	 🔗 관련 페이지로 이동
	                        </a>
	                        <button type="button" class="chatbot-restart-btn">
	                              	💬 추가 질문하기
	                        </button>
	                    </div>
	                `;
	                appendBotHtmlMessage(chatItems, actionHtml);
	            }, 300);
	
	        } catch (error) {
	            console.error("Chat error:", error);
	            await typeBotMessage(chatItems, "오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	        }
	    });
	
	    // --- ✨ [추가] '추가 질문하기' 버튼 클릭 이벤트 처리 ---
	    // (이벤트 위임 사용)
	    chatItems.addEventListener('click', async (e) => {
	        // 클릭된 요소가 .chatbot-restart-btn 클래스를 가졌는지 확인
	        if (e.target.classList.contains('chatbot-restart-btn')) {
	            
	            // 1. 버튼 비활성화 (중복 클릭 방지)
	            e.target.disabled = true;
	            e.target.textContent = '...';
	
	            // 2. 메뉴 텍스트를 타이핑 효과로 출력
	            await typeBotMessage(chatItems, menuText1);
	            await typeBotMessage(chatItems, menuText2);
	        }
	    });