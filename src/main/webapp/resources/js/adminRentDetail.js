document.addEventListener("DOMContentLoaded", function() {
	const dataProvider = document.getElementById("approval-data-provider");

	if (!dataProvider) {
		return;
	}
	const approvalId = dataProvider.dataset.approvalId;
	const currentStatus = dataProvider.dataset.approvalStatus; 

	if (!approvalId || !currentStatus) {
		return;
	}
	
	const approveBtn = document.querySelector(".approve-btn");
	if (approveBtn) {
		approveBtn.addEventListener("click", function() {
			Swal.fire({
				title: '승인하시겠습니까?',
				text: "요청을 승인 처리합니다.",
				imageUrl: "/assetmanager/resources/image/approval_admin.jpg",
			    imageWidth: 90, 
			    imageHeight: 90, 
			    imageAlt: "경고 아이콘",
				showCancelButton: true,
				confirmButtonText: '승인',
				cancelButtonText: '취소',
				confirmButtonColor: '#007bff',
				cancelButtonColor: '#6c757d'
			}).then((result) => {
				if (result.isConfirmed) {
					const data = {
						id: approvalId,
						status: currentStatus
					};
					fetch('/assetmanager/approval/approve', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json',
							'Accept': 'application/json'
						},
						body: JSON.stringify(data)
					})
					.then(response => response.json())
					.then(result => {
							sessionStorage.setItem('showToastMessage', '승인 처리가 완료되었습니다.');
							location.href = '/assetmanager/admin/rent/list';
						})
						.catch(error => {
						console.error('Error:', error);
						Swal.fire('오류', '승인 처리 중 오류가 발생했습니다.', 'error');
					});						
				}
			});
		});
	}

const rejectBtn = document.querySelector(".reject-btn");
	
	if (rejectBtn) {
		rejectBtn.addEventListener("click", function() {
			Swal.fire({
				title: "거절하시겠습니까?",
				text: "거절 사유를 입력해주세요.",
				input: "text",
				imageUrl: "/assetmanager/resources/image/reject_admin.jpg",
				imageWidth: 90,
				imageHeight: 90,
				imageAlt: "경고 아이콘",
				showCancelButton: true,
				confirmButtonColor: "#14b3ae",
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				customClass: {
					input: 'custom-swal-input'
				}
			}).then((result) => {
				if (result.isConfirmed) {
					const rejectReason = result.value;
									
					if (!rejectReason || rejectReason.trim() === "") {
						Swal.fire('오류', '반려 사유를 입력해야 합니다.', 'error');
						return;
					}

					const data = {
						id: approvalId,
						status: currentStatus,
						rejectReason: rejectReason
					};

					fetch('/assetmanager/approval/reject', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json',
							'Accept': 'application/json'
						},
						body: JSON.stringify(data)
					})
					.then(response => response.json())
					.then(result => {					
						sessionStorage.setItem('showToastMessage', '거절 처리가 완료되었습니다.');
						location.href = '/assetmanager/manager/rent/list';
					})
					.catch(error => {
						console.error('Error:', error);
						Swal.fire('오류', '반려 처리 중 오류가 발생했습니다.', 'error');
					});
				}
			});
		});
	}
});