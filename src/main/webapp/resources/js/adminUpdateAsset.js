const editBtn = document.querySelector("#edit-modal");

const assetData = {
        assetName: 'Latitude 7420 노트북',
        category: '노트북',
        serialNumber: 'L7420-SN-AB12345',
        registDate: '2023-01-05',
        isPersonal: '개인 할당'
};

const formHtml = `
	<div class="modal-container">
		<label>
			자산명
		</label>
		<input type="text" class="modal-input" value="${assetData.assetName}"> 
	</div>
	<div class="modal-container">
		<label>
			카테고리
		</label>
		<input type="text" class="modal-input" value="${assetData.category}"> 
	</div>
	<div class="modal-container">
		<label>
			시리얼 번호
		</label>
		<input type="text" class="modal-input" value="${assetData.serialNumber}"> 
	</div>
	<div class="modal-container">
		<label>
			등록일
		</label>
		<input type="text" class="modal-input" value="${assetData.registDate}"> 
	</div>
	<div class="modal-container">
		<label>
			분류
		</label>
		<input type="text" class="modal-input" value="${assetData.isPersonal}"> 
	</div>
`;

editBtn.addEventListener("click", () => {
	Swal.fire({
		title: '자산 정보 수정하기',
        icon: 'info',
        html: formHtml,
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