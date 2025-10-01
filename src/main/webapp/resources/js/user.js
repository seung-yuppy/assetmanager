function transitionPage(event, link) {
	event.preventDefault();
	const wrapper = document.querySelector('.split-wrapper');
	
	// 왼쪽 패널을 먼저 숨기는 애니메이션 적용
	//const splashPanel = document.querySelector('.splash-panel');
	//splashPanel.style.animation = 'slideOutLeft 0.5s forwards';
	
	// 오른쪽 패널을 숨기는 애니메이션 적용
	const loginContainer = document.querySelector('.login-container');
	loginContainer.style.animation = 'slideOutRight 0.5s forwards';
	
	// 애니메이션 종료 후 페이지 이동
	setTimeout(() => {
		window.location.href = link.href;
	}, 500);
}