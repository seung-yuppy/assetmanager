document.addEventListener('DOMContentLoaded', function() {
	//요청 취소
	const cancelBtn = document.querySelector("#cancel-btn");
	console.log("cancelBtn: " + cancelBtn);
	
	cancelBtn.addEventListener("click", async () => { 
		const container = document.querySelector('.section-card');
		const id = container.getAttribute('data-id');
		const userId = container.getAttribute('data-author');
		if(userId != loginUser.id)
			return;
		
		Swal.fire({
			title:"회수하시겠습니까?",
			icon: "warning",
			confirmButtonColor: "#1c4587",
			confirmButtonText: "예",
			showCancelButton: true,
			cancelButtonText: '아니오',
			customClass: {
				input: 'custom-swal-input'
			},
			preConfirm: async () => {  
				const res = await fetch(`/assetmanager/rent/cancel?id=${id}`, { 
					method: "GET",
					headers: {
						"Content-Type": "application/json",
					}
				});
				const data = await res.json();
				if (data.msg === "회수가 완료되었습니다.") {
					Swal.fire({
						title: "성공",
						text: data.msg,
						icon: "success",
						confirmButtonColor: "#1c4587",
						confirmButtonText: "확인",
					}).then(() =>{
						location.reload();
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