document.addEventListener("DOMContentLoaded", function() {
	const returnBtn = document.querySelectorAll(".return-button");
		returnBtn.forEach((btn) => {
			console.log("두번째는 들어가??"+ btn);
			btn.addEventListener("click", function() {	
				Swal.fire({
					title:"반납하시겠습니까?",
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
						const container = this.closest('.asset-box');
						const assetId = container.getAttribute('data-id');
				    	const data = { assetId : assetId}
				    	console.log("값 들어갔어?? " + assetId)
						const res = await fetch("/assetmanager/rent/return",{
							method: "POST",	
							headers: {
				                'Content-Type': 'application/json'
				            },
				            body : JSON.stringify(data)
						});
					}
				})	
			});
		})
});


