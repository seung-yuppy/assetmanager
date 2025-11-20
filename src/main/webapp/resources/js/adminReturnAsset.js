document.addEventListener("DOMContentLoaded", function() {
	const adminReturnBtn = document.querySelector(".adminReturn-button");
	adminReturnBtn.addEventListener("click", function() {	
		Swal.fire({
			title:"승인하시겠습니까?",
			text: "요청을 승인 처리합니다.",
			icon: "success",
			confirmButtonColor: "#1c4587",
			confirmButtonText: "예",
			showCancelButton: true,
			cancelButtonText: '아니오',
			customClass: {
		    	title: 'custom-swal-title-approved'
		    },
		    preConfirm: async() => {			
		    	const returnId = adminReturnBtn.getAttribute("data-id");
		    	const assetId = adminReturnBtn.getAttribute("data-asset");
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
							confirmButtonColor: "#1c4587",
							confirmButtonText: "확인",
						}).then(() =>{
							location.href = "/assetmanager/admin/return/list";
						});
					} else {
						Swal.fire({
							title: "실패",
							text: "반납에 실패하였습니다.",
							icon: "error",
							confirmButtonColor: "#1c4587",
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