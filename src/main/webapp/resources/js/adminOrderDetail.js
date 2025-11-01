document.querySelectorAll(".form-row").forEach(row => calculateTotalPrice(row));

function calculateTotalPrice(row){
	const price = row.querySelector('input[name*="price"]').getAttribute("data-value");
	const quantity = row.querySelector('input[name*="count"]').value;
	const targetEl = row.querySelector('input[name*="totalPrice"]');
	
	targetEl.value = (price * quantity).toLocaleString();
}


deleteBtn.addEventListener("click", async () => {
	const assetId = deleteBtn.dataset.assetId;
	const deleteForm = `
		<input type='text' class='modal-input' name='disposalReason'>
		<input type='hidden' class='modal-input' name='assetId' value='${assetId}'>
	`;
	
    Swal.fire({
		title: "불용 사유를 입력해주세요.",
	    html: deleteForm,
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
	    	const input = Swal.getHtmlContainer().querySelector('.modal-input');
	    	const resultObject = {
	    		    assetId: assetId,
	    		    disposalReason: input.value
	    	};
	    	console.log(resultObject);
	    	const res = await fetch("/assetmanager/admin/asset/delete", {
	    		method: "POST",
	    		headers: {
	    			"Content-Type": "application/json",
	    		},
	    		body: JSON.stringify(resultObject),
	    	});
	    	const data = await res.json();
	    	
	    	if (data.msg === "불용처리가 완료되었습니다.") {
	            Swal.fire({
	                title: "성공",
	                text: data.msg,
	                icon: "success",
	                confirmButtonColor: "#a5dc86",
	                confirmButtonText: "확인",
	            }).then(() =>{
	            	location.href = "/assetmanager/admin/asset/list";
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