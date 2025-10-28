const editBtn = document.querySelector("#edit-modal");
const deleteBtn = document.querySelector("#delete-modal"); 

const response = async(id) => {
	const res = await fetch(`/assetmanager/admin/asset/info/${id}`, {
		method:"GET"
	});
	const result = await res.json();
	return result.result;
};

const formHtml = (data) =>  `
	<div class="modal-wrapper">
	<div class="modal-container">
		<div class="modal-input-title">
			<span class="title-name">자산명</span>
		</div>
		<input type="text" class="modal-input" value="${data.assetName}" data-key="assetName"> 
	</div>
	<div class="modal-container">
		<div class="modal-input-title">
			<span class="title-name">카테고리</span>
		</div>
		<select class="modal-input" name="categoryId" data-key="categoryId">
			<option value="1" ${data.categoryId == 1 ? 'selected' : ''}>노트북</option>
		    <option value="2" ${data.categoryId == 2 ? 'selected' : ''}>모니터</option>
		    <option value="3" ${data.categoryId == 3 ? 'selected' : ''}>태블릿</option>
		    <option value="4" ${data.categoryId == 4 ? 'selected' : ''}>스마트폰</option>
		    <option value="5" ${data.categoryId == 5 ? 'selected' : ''}>복합기</option>
		    <option value="6" ${data.categoryId == 6 ? 'selected' : ''}>데스크탑</option>
		    <option value="7" ${data.categoryId == 7 ? 'selected' : ''}>TV</option>
		    <option value="8" ${data.categoryId == 8 ? 'selected' : ''}>프로젝터</option>
		    <option value="9" ${data.categoryId == 9 ? 'selected' : ''}>기타</option>
		</select>
	</div>
	<div class="modal-container">
		<div class="modal-input-title">
			<span class="title-name">일련번호</span>
		</div>
		<input type="text" class="modal-input" value="${data.serialNumber}" data-key="serialNumber"> 
	</div>
	<div class="modal-container">
		<div class="modal-input-title">
			<span class="title-name">스펙</span>
		</div>
		<input type="text" class="modal-input" value="${data.spec}" data-key="spec"> 
	</div>
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
	    },
	    preConfirm: async () => {
	    	const inputs = Swal.getHtmlContainer().querySelectorAll('.modal-input');
			const asset = { 
				id: assetId
			};
			
			inputs.forEach(input => {
				const key = input.dataset.key;
				asset[key] = input.value;
			});
	
	    	const res = await fetch("/assetmanager/admin/asset/change", {
	    		method: "POST",
	    		headers: {
	    			"Content-Type": "application/json",
	    		},
	    		body: JSON.stringify({ asset: asset }),
	    	});
	    	const data = await res.json();
	    	
	    	if (data.msg === "수정이 완료되었습니다.") {
	            Swal.fire({
	                title: "성공",
	                text: data.msg,
	                icon: "success",
	                confirmButtonColor: "#a5dc86",
	                confirmButtonText: "확인",
	            }).then(() =>{
	            	window.location.reload();
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