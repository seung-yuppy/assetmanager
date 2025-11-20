// 총액 계산
document.querySelectorAll(".form-row").forEach(row => calculateTotalPrice(row));

function calculateTotalPrice(row){
	const price = row.querySelector('input[name*="price"]').getAttribute("data-value");
	const quantity = row.querySelector('input[name*="count"]').value;
	const targetEl = row.querySelector('input[name*="totalPrice"]');
	
	targetEl.value = (price * quantity).toLocaleString();
}

// 반려 처리
const rejectBtn = document.querySelectorAll(".reject-btn").forEach(btn => {
    btn.addEventListener("click", async () => {
    const container = document.getElementById('approval-line-container');
	const id = container.getAttribute('data-approvalId');
	const status = container.getAttribute('data-status');
	
        Swal.fire({
            title: "반려하시겠습니까?",
            text:"반려 사유를 입력해주세요.",
            input: "text",
            imageUrl: "/assetmanager/resources/image/reject_admin.jpg",
            imageWidth: 90,
            imageHeight: 90, 
            imageAlt: "경고 아이콘",
            confirmButtonColor: "#1c4587",
            confirmButtonText: "확인",
            showCancelButton: true,
            cancelButtonText: '취소',
            customClass: {
                input: 'custom-swal-input'
            },
            preConfirm: async (reason) => { 
    			const rejectReason = reason;
				
				if (!rejectReason || rejectReason.trim() === "") {
					Swal.fire('오류', '반려 사유를 입력해야 합니다.', 'error');
					return;
				}
            	
                const resultObject = {
                        id: id,
                        rejectReason: reason,
                        status: status
                };
                
                const res = await fetch("/assetmanager/approval/reject", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(resultObject),
                });
                const data = await res.json();
                
                if (data.msg === "반려 처리가 완료되었습니다.") {
                    Swal.fire({
                        title: "성공",
                        text: data.msg,
                        icon: "success",
                        confirmButtonColor: "#1c4587",
                        confirmButtonText: "확인",
                    }).then(() =>{
                    	location.href = "../list";
                    });
                } else {
                    Swal.fire({
                        title: "실패",
                        text: data.msg,
                        icon: "error",
                        confirmButtonColor: "#1c4587",
                        confirmButtonText: "확인",
                    }).then(() =>{
                        window.location.reload();
                    });
                }
            }
        })
    });
});

// 승인 처리
const approveBtn = document.querySelectorAll(".approve-btn").forEach(btn => {
	btn.addEventListener("click", async () => {
		const container = document.getElementById('approval-line-container');
		const id = container.getAttribute('data-approvalId');
		const status = container.getAttribute('data-status');
		const managerId = container.getAttribute('data-manager-id');
		const approverId = container.getAttribute('data-approver-id');
		
		Swal.fire({
			title:"승인하시겠습니까?",
			text: "요청을 승인 처리합니다.",
			imageUrl: "/assetmanager/resources/image/approval_admin.jpg",
			imageWidth: 90,
			imageHeight: 90, 
			imageAlt: "경고 아이콘",
			confirmButtonColor: "#1c4587",
			confirmButtonText: "승인",
			showCancelButton: true,
			cancelButtonText: '취소',
			customClass: {
				input: 'custom-swal-input'
			},
			preConfirm: async () => { 
				const resultObject = {
						id: id,
						status: status,
						managerId: managerId,
						approverId: approverId
				};
				const res = await fetch("/assetmanager/approval/approve", {
					method: "POST",
					headers: {
						"Content-Type": "application/json",
					},
					body: JSON.stringify(resultObject),
				});
				const data = await res.json();
				
				if (data.msg === "승인 처리가 완료되었습니다.") {
					Swal.fire({
						title: "성공",
						text: data.msg,
						icon: "success",
						confirmButtonColor: "#1c4587",
						confirmButtonText: "확인",
					}).then(() =>{
						location.href = "../list";
					});
				} else {
					Swal.fire({
						title: "실패",
						text: data.msg,
						icon: "error",
						confirmButtonColor: "#1c4587",
						confirmButtonText: "확인",
					}).then(() =>{
						window.location.reload();
					});
				}
			}
		})
	});
});



