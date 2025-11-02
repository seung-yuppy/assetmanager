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
	const rejectForm = "<input type='text' id='reject-reason' class='modal-input' name='rejectReason'>";
	
        Swal.fire({
            title: "반려 사유를 입력해주세요.",
            html: rejectForm,
            imageUrl: "/assetmanager/resources/image/reject_admin.jpg",
            imageWidth: 90,
            imageHeight: 90, 
            imageAlt: "경고 아이콘",
            confirmButtonColor: "#14b3ae",
            confirmButtonText: "확인",
            showCancelButton: true,
            cancelButtonText: '취소',
            customClass: {
                input: 'custom-swal-input'
            },
            preConfirm: async () => { 
                const reason = Swal.getHtmlContainer().querySelector('#reject-reason').value;
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
                        confirmButtonColor: "#a5dc86",
                        confirmButtonText: "확인",
                    }).then(() =>{
                    	location.reload();
                    });
                } else {
                    Swal.fire({
                        title: "실패",
                        text: data.msg,
                        icon: "error",
                        confirmButtonColor: "#d33",
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
		
		
		Swal.fire({
			text: "요청을 승인하시겠습니까?",
			imageUrl: "/assetmanager/resources/image/approval_admin.jpg",
			imageWidth: 90,
			imageHeight: 90, 
			imageAlt: "경고 아이콘",
			confirmButtonColor: "#14b3ae",
			confirmButtonText: "승인",
			showCancelButton: true,
			cancelButtonText: '취소',
			customClass: {
				input: 'custom-swal-input'
			},
			preConfirm: async () => { 
				const resultObject = {
						id: id,
						status: status
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
						confirmButtonColor: "#a5dc86",
						confirmButtonText: "확인",
					}).then(() =>{
						location.reload();
					});
				} else {
					Swal.fire({
						title: "실패",
						text: data.msg,
						icon: "error",
						confirmButtonColor: "#d33",
						confirmButtonText: "확인",
					}).then(() =>{
						window.location.reload();
					});
				}
			}
		})
	});
});



