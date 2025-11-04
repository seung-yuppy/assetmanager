document.addEventListener("DOMContentLoaded", function() {
	const returnBtn = document.querySelector(".return-button");
	 
	if(returnBtn){
		returnBtn.addEventListener("click", function() {			
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
			    preConfirm: async () => {
					const res = await fetch("/assetmanager/admin/return/list",{
						method: "GET"					
					});
				}
		
			})	
		});
	}
});
