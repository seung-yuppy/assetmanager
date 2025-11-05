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
		    	
		    	.then(()=>{
		    		location.href = "/assetmanager/admin/return/list";
		    	});
			}
		})
	});
});