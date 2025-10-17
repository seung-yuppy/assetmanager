function transitionPage(event, link) {
	event.preventDefault();
	const wrapper = document.querySelector('.split-wrapper');

	const loginContainer = document.querySelector('.login-container');
	loginContainer.style.animation = 'slideOutRight 0.5s forwards';
	
	setTimeout(() => {
		window.location.href = link.href;
	}, 500);
}

document.addEventListener("DOMContentLoaded", () => {
	const empNoInput = document.querySelector('input[name="empNo"]');
	const dupBtn = document.querySelector("#dupcheck-button");
	const joinForm = document.querySelector('.join-form');
    let isEmpNoChecked = false;
	
    empNoInput.addEventListener('input', () => {
        // 입력 필드의 값에 따라 버튼 활성화/비활성화 상태를 변경
        if (empNoInput.value.trim().length > 0) {
            dupBtn.disabled = false;
            dupBtn.classList.remove('disabled');
        } else {
            dupBtn.disabled = true;
            dupBtn.classList.add('disabled');
        }
    });
	
	dupBtn.addEventListener("click", async () => {
		const empNo = empNoInput.value.trim();
		const res = await fetch("/assetmanager/check/empno", {
			method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ empNo: empNo }),
		});
		const data = await res.json();

		if (data.isDup === '사용 가능한 사번입니다.') {
			isEmpNoChecked = true;
            Swal.fire({
                title: "승인됨",
                text: data.isDup,
                icon: "success",
                confirmButtonColor: "#a5dc86",
                confirmButtonText: "확인",
            });
		} else {
			isEmpNoChecked = false;
            Swal.fire({
                title: "중복됨",
                text: data.isDup,
                icon: "error",
                confirmButtonColor: "#d33",
                confirmButtonText: "확인",
            });
		}
	});

	// --- 비밀번호 일치 확인 추가 코드 ---
    const passwordInput = document.querySelector('input[name="password"]');
    const passwordCheckInput = document.querySelector('input[name="passwordCheck"]');

    // 피드백 메시지를 표시할 DOM 요소를 생성
    const passwordMatchMessage = document.createElement('div');
    passwordMatchMessage.classList.add('password-match-message');
    passwordCheckInput.after(passwordMatchMessage);

    const checkPasswordMatch = () => {
        const password = passwordInput.value;
        const passwordCheck = passwordCheckInput.value;

        // 두 필드 모두 값이 있을 때만 검사
        if (password.length > 0 && passwordCheck.length > 0) {
            if (password === passwordCheck) {
                passwordMatchMessage.textContent = '비밀번호가 일치합니다.';
                passwordMatchMessage.style.color = 'green';
            } else {
                passwordMatchMessage.textContent = '비밀번호가 일치하지 않습니다.';
                passwordMatchMessage.style.color = 'red';
            }
        } else {
            // 둘 중 하나라도 비어 있으면 메시지 초기화
            passwordMatchMessage.textContent = '';
        }
    };

    // 'input' 이벤트 발생 시 함수 실행
    passwordInput.addEventListener('input', checkPasswordMatch);
    passwordCheckInput.addEventListener('input', checkPasswordMatch);	
    
    joinForm.addEventListener('submit', (event) => {
        const password = passwordInput.value;
        const passwordCheck = passwordCheckInput.value;
        
        if (!isEmpNoChecked) {
            event.preventDefault();
            Swal.fire({
                title: "오류",
                text: "사번 중복 확인이 필요합니다.",
                icon: "warning",
                confirmButtonColor: "#3085d6",
                confirmButtonText: "확인",
            });
        }
        if (password !== passwordCheck) {
            event.preventDefault();
            Swal.fire({
                title: "오류",
                text: "비밀번호와 비밀번호 확인이 일치하지 않습니다.",
                icon: "warning",
                confirmButtonColor: "#3085d6",
                confirmButtonText: "확인",
            });
        }
    });    
});