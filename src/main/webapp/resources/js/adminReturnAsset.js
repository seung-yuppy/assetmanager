document.addEventListener("DOMContentLoaded", function() {
	const adminReturnBtn = document.querySelector(".adminReturn-button");
	adminReturnBtn.addEventListener("click", function() {	
		Swal.fire({
			title:"반납을 승인하시겠습니까?",
			imageUrl: "/assetmanager/resources/image/approval_admin.jpg",
			imageWidth: 90,
			imageHeight: 90, 
			imageAlt: "경고 아이콘",
			confirmButtonColor: "#14b3ae",
			confirmButtonText: "예",
			showCancelButton: true,
			cancelButtonText: '아니오',
			customClass: {
		    	title: 'custom-swal-title-approved'
		    },
		    preConfirm: async() => {			
		    	const returnId = adminReturnBtn.getAttribute("data-id");
		    	const assetId = adminReturnBtn.getAttribute("data-asset");
		    	console.log("returnId 여기야???"+returnId)
		    	console.log("assetId 나오니??? "+assetId)
		    	const data = { id : returnId, assetId: assetId}
				const res = await fetch("/assetmanager/admin/return/confirm",{
					method: "POST",	
					headers: {
		                'Content-Type': 'application/json'
		            },
		            body : JSON.stringify(data)
				})
				.then(result => {					
					if (result) {
						Swal.fire({
							title: "성공",
							text: "반납되었습니다.",
							icon: "success",
							confirmButtonColor: "#a5dc86",
							confirmButtonText: "확인",
						}).then(() =>{
							location.href = "/assetmanager/admin/return/list";
						});
					} else {
						Swal.fire({
							title: "실패",
							text: "반납에 실패하였습니다.",
							icon: "error",
							confirmButtonColor: "#d33",
							confirmButtonText: "확인",
						}).then(()=>{
							location.reload();
							})
						}
				})
			}
		})
	});
});