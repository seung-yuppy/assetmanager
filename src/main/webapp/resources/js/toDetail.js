document.addEventListener('DOMContentLoaded', function() {
	const tableBody = document.querySelector('.data-table tbody');
	
	if (tableBody) {
        tableBody.addEventListener('click', function(event) { 
        	const row = event.target.closest('tr');
        	if(row){
        		const id = row.getAttribute('data-id');
        		window.location.href=`detail/${id}`;
        	}
        });
	}
});

//요청 취소
const cancelBtn = document.querySelector("#cancel-btn");
console.log("cancelBtn: " + cancelBtn);

cancelBtn.addEventListener("click", async () => { 
	const container = document.querySelector('.section-card');
	const id = container.getAttribute('data-id');
	const userId = container.getAttribute('data-author');
	console.log(container);
	console.log(userId);
	if(userId != loginUser.id) {// 작성자가 취소하는지 확인
		console.log("userId 있어???"+userId);
		return;
	}
	Swal.fire({
		title:"요청을 취소하시겠습니까?",
		imageUrl: "/assetmanager/resources/image/reject_admin.jpg",
		imageWidth: 90,
		imageHeight: 90, 
		imageAlt: "경고 아이콘",
		confirmButtonColor: "#14b3ae",
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
			console.log("data 나오니??"+ data)
			if (data.msg === "요청 취소가 완료되었습니다.") {
				Swal.fire({
					title: "성공",
					text: data.msg,
					icon: "success",
					confirmButtonColor: "#a5dc86",
					confirmButtonText: "확인",
				}).then(() =>{
					location.href = "/assetmanager/rent/list";
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