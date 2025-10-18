const rejectBtn = document.querySelector(".cancel-action");
const approvalBtn = document.querySelector(".primary-action");

rejectBtn.addEventListener("click", (e) => {
    Swal.fire({
		title: "거절 사유를 입력해주세요.",
	    input: "text",
	    imageUrl: "/assetmanager/resources/image/reject_admin.jpg",
	    imageWidth: 90, // 이미지 너비 (픽셀)
	    imageHeight: 90, // 이미지 높이 (픽셀)
	    imageAlt: "경고 아이콘",
	    confirmButtonColor: "#14b3ae",
	    confirmButtonText: "확인",
	    customClass: {
	    	input: 'custom-swal-input'
	    }
    }).then((result) => {
        // '확인' 버튼을 눌렀고, 입력값이 있다면
        if (result.isConfirmed) {
            const reason = result.value;
            // TODO: 1. (가장 중요) 'reason' 값을 서버로 전송하는 로직
            // 예: fetch('/api/reject', { method: 'POST', body: reason })
            // 이 작업이 성공한 후에 메시지를 저장하고 이동하는 것이 좋습니다.

            // 2. 토스트 메시지를 sessionStorage에 저장
            sessionStorage.setItem('showToastMessage', '거절 처리가 완료되었습니다.');
            
            // 3. 새 페이지로 이동
            location.href = '/assetmanager/admin/rent/list';
        }
    });
});

approvalBtn.addEventListener("click", (e) => {
	Swal.fire({
		title: "승인되었습니다.",
	    imageUrl: "/assetmanager/resources/image/approval_admin.jpg",
	    imageWidth: 90, // 이미지 너비 (픽셀)
	    imageHeight: 90, // 이미지 높이 (픽셀)
	    imageAlt: "경고 아이콘",
	    confirmButtonColor: "#14b3ae",
	    confirmButtonText: "확인",
	    customClass: {
	    	title: 'custom-swal-title-approved'
	    }
    }).then((result) => {
        // '확인' 버튼을 눌렀고, 입력값이 있다면
        if (result.isConfirmed) {
            const reason = result.value;
            // TODO: 1. (가장 중요) 'reason' 값을 서버로 전송하는 로직
            // 예: fetch('/api/reject', { method: 'POST', body: reason })
            // 이 작업이 성공한 후에 메시지를 저장하고 이동하는 것이 좋습니다.

            // 2. 토스트 메시지를 sessionStorage에 저장
            sessionStorage.setItem('showToastMessage', '승인 처리가 완료되었습니다.');
            
            // 3. 새 페이지로 이동
            location.href = '/assetmanager/admin/rent/list';
        }
    });
});