document.addEventListener("DOMContentLoaded", function() {
	const returnBtn = document.querySelectorAll(".return-button");
		returnBtn.forEach((btn) => {
			console.log("두번째는 들어가??"+ btn);
			btn.addEventListener("click", function() {	
				Swal.fire({
					title:"반납하시겠습니까?",
					icon: "warning",
					confirmButtonColor: "#1c4587",
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
						const res = await fetch("/assetmanager/rent/return",{
							method: "POST",	
							headers: {
				                'Content-Type': 'application/json'
				            },
				            body : JSON.stringify(data)
						});
				    	if (res)
				    		location.reload();
					}
				})	
			});
		})
});


