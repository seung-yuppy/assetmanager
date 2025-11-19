const deleteBtns = document.querySelectorAll('.btn-delete');
deleteBtns.forEach((deleteBtn) => {
	deleteBtn.addEventListener('click', async() => {
		const id = deleteBtn.getAttribute("data-id");
		const response = await fetch(`/assetmanager/admin/item/${id}`, {
			method:"GET"
		});
		const itemData = await response.json();
		const itemName = itemData.item.itemName;
		console.log(itemData);
		
	    Swal.fire({
	    	title: "제품 삭제",
			text: `${itemName} 삭제하시겠습니까?`,
			icon: "error",
		    confirmButtonColor: "#1c4587",
		    confirmButtonText: "확인",
		    showCancelButton: true,
	        cancelButtonText: '취소',
		    customClass: {
		    	input: 'custom-swal-input'
		    },
		    preConfirm: async () => { 
		    	const res = await fetch("/assetmanager/admin/item/delete", {
		    		method: "POST",
		    		headers: {
		    			"Content-Type": "application/json",
		    		},
		    		body: JSON.stringify({id: id}),
		    	})
		    	const data = await res.json();
		    	if (data.msg === '권장 제품을 삭제하였습니다.') {
		            Swal.fire({
		                title: "성공",
		                text: data.msg,
		                icon: "success",
		                confirmButtonColor: "#1c4587",
		                confirmButtonText: "확인",
		            }).then(() =>{
		            	location.href = "/assetmanager/admin/item/list";
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
