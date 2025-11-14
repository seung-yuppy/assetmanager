document.addEventListener("DOMContentLoaded", function() {
	const dataProvider = document.getElementById("approval-data-provider");

	if (!dataProvider) {
		return;
	}
	const approvalId = dataProvider.dataset.approvalId;
	const currentStatus = dataProvider.dataset.approvalStatus; 
	const approverId = dataProvider.dataset.approverId; 
	const managerId = dataProvider.dataset.managerId; 

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
						status: currentStatus,
						approverId: approverId,
						managerId: managerId
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
						if (result) {
							Swal.fire({
								title: "성공",
								text: "승인되었습니다.",
								icon: "success",
								confirmButtonColor: "#a5dc86",
								confirmButtonText: "확인",
							}).then(() =>{
								if(loginUser.role === 'admin'){
									location.href = "/assetmanager/admin/rent/list";
								}else if (loginUser.role === 'manager'){
									location.href = "/assetmanager/manager/rent/list";
								}
							});
						} else {
							Swal.fire({
								title: "실패",
								text: "승인 실패하였습니다.",
								icon: "error",
								confirmButtonColor: "#d33",
								confirmButtonText: "확인",
							}).then(()=>{
									location.reload();
								})
							}							
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
						if (result) {
							Swal.fire({
								title: "성공",
								text: "반려되었습니다.",
								icon: "success",
								confirmButtonColor: "#a5dc86",
								confirmButtonText: "확인",
							}).then(() =>{
								if(loginUser.role === 'admin'){
									location.href = "/assetmanager/admin/rent/list";
								}else if (loginUser.role === 'manager'){
									location.href = "/assetmanager/manager/rent/list";
								}
							});
						} else {
							Swal.fire({
								title: "실패",
								text: "반려 실패하였습니다.",
								icon: "error",
								confirmButtonColor: "#d33",
								confirmButtonText: "확인",
							}).then(()=>{
									location.reload();
								})
							}							
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