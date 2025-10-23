const editBtn = document.querySelector("#edit-modal");

const response = async(id) => {
	const res = await fetch(`/assetmanager/admin/asset/info/${id}`, {
		method:"GET"
	});
	const result = await res.json();
	return result.result;
};

const formHtml = (data) =>  `
	<div class="modal-container">
		<label>
			자산명
		</label>
		<input type="text" class="modal-input" value="${data.assetName}"> 
	</div>
	<div class="modal-container">
		<label>
			카테고리
		</label>
		<input type="text" class="modal-input" value="${data.category}"> 
	</div>
	<div class="modal-container">
		<label>
			일련번호
		</label>
		<input type="text" class="modal-input" value="${data.serialNumber}"> 
	</div>
	<div class="modal-container">
		<label>
			스펙
		</label>
		<input type="text" class="modal-input" value="${data.spec}"> 
	</div>
`;

editBtn.addEventListener("click", async () => {
	const assetId = editBtn.dataset.assetId;
	const assetDataFromServer = await response(assetId);
	const dynamicFormHtml = formHtml(assetDataFromServer);
	Swal.fire({
		title: '자산 정보 수정하기',
        icon: 'info',
        html: dynamicFormHtml,
        showCancelButton: true,
        confirmButtonText: '저장 및 반영',
        cancelButtonText: '취소',
	    confirmButtonColor: "#14b3ae",
	    confirmButtonText: "확인",
	    customClass: {
	    	title: 'custom-swal-title-approved'
	    }
    })
});