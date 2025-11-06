window.addEventListener('DOMContentLoaded', () => {
    getCategories(); // 페이지 시작 시 카테고리 목록 불러오기
});

//권장 제품 데이터
let productData;
let categoryOptionsHTML = ''; // 전역 변수 (나중에 동적 행 추가 시 재사용)

function getCategories() {
    fetch('/assetmanager/order/form/category')
        .then(res => res.json())
        .then(data => {
            categoryOptionsHTML = `
                <option value="" disabled selected>선택하세요</option>
                ${data.map(item => `<option value="${item.id}">${item.categoryName}</option>`).join('')}
            `;
        })
        .catch(err => console.error("카테고리 불러오기 실패:", err));
}

//이벤트 부착
const inputArea = document.getElementById('formInputArea');
inputArea.addEventListener('change',function(e){
	// 총액 계산용
	if (e.target && e.target.tagName === 'INPUT' && e.target.type === 'number'){
		calculateTotalPrice(e.target);
	// 권장 제품 로드
	}else if(e.target && e.target.tagName === 'SELECT' && e.target.name.includes('categoryId')){
		const categoryId =  parseInt(e.target.value);
		const parentRow = e.target.closest('.form-row');
		// 권장 제품 목록 로드
		fetch(`/assetmanager/order/form/standard?categoryId=${categoryId}`)
			.then(res=> res.json())
			.then(data => {
				productData = data.map(item => ({
			        id: item.itemName,     // value로 itemName 사용
			        text: item.itemName,   // 화면 표시
			        itemName: item.itemName,
			        spec: item.spec,
			        price: item.price
			    }));
				setRowIndex();
				init_select2(parentRow);
				calculateTotalPrice(e.target);
			});
	}
});

//이벤트 부착 : 제목 추가용 
const requestForm = document.getElementById('requestForm');
requestForm.addEventListener('submit', setTitle);

function calculateTotalPrice(el){
	const row = el.closest('.form-row');
	const price = row.querySelector('input[name*="price"]').value;
	const quantity = row.querySelector('input[name*="count"]').value;
	const targetEl = row.querySelector('input[name*="totalPrice"]');
	
	targetEl.value = price * quantity;
}

function setRowIndex() {
    const container = document.querySelector("#formInputArea");
    
    if (!container) {
        console.error("Error: #formInputArea container not found.");
        return; 
    }
    container.querySelectorAll('.form-row').forEach((row, idx) => {
        // 1. categoryId 검증 및 처리
        const categoryInput = row.querySelector('[name*="categoryId"]');
        if (categoryInput) {
            categoryInput.name = `products[${idx}].categoryId`;
        }

        // 2. itemName 검증 및 처리
        const itemNameInput = row.querySelector('[name*="itemName"]');
        if (itemNameInput) {
            itemNameInput.name = `products[${idx}].itemName`;
        }
        
        const specInput = row.querySelector('[name*="spec"]');
        if (specInput) {
        	specInput.name = `products[${idx}].spec`;
        }

        // 3. price 검증 및 처리
        const priceInput = row.querySelector('[name*="price"]');
        if (priceInput) {
            priceInput.name = `products[${idx}].price`;
        }

        // 4. count 검증 및 처리
        const countInput = row.querySelector('[name*="count"]');
        if (countInput) {
            countInput.name = `products[${idx}].count`;
        }

        // 5. totalPrice 검증 및 처리
        const totalPriceInput = row.querySelector('[name*="totalPrice"]');
        if (totalPriceInput) {
            totalPriceInput.name = `products[${idx}].totalPrice`;
        }
    });
}

//구매 요청할 제품 추가하는 함수 
function addProduct(){
	if (!checkProductCnt()){
		alert("요청 품목은 10개까지만 가능합니다.");
		return;
	}
	
    if (!categoryOptionsHTML) {
        console.warn("카테고리 데이터가 아직 로드되지 않았습니다.");
        return;
    }
	
	const targetEl = document.querySelector('#add-product-section');
	const newFormRowHTML = `
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<select name="categoryId" required>
										${categoryOptionsHTML}
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
							        <select name="itemName"></select>
								</div>
								<div style="display:none;">
									<input type="text" name="spec">
								</div>
								<div class="form-group fixed-width-med">
									<input type="number" name="price" value="0" min="0" required>
								</div>

								<div class="form-group fixed-width-sm">
									<input type="number" name="count" min="1" max="10" value="1" required>
								</div>
								<div class="form-group fixed-width-med">
									<div class="last-input-group">
										<input type="text" name="totalPrice" value="0" class="locked-input" readonly>
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)"></img>
									</div>
								</div>
							</div>
	`
	targetEl.insertAdjacentHTML('beforebegin', newFormRowHTML);
	setRowIndex();
};

function renderFormFromExcel(json, purchase_reason) {
	  const container = document.getElementById('data-display-area');
	  container.innerHTML = ""; // 기존 내용 초기화

	  if (json.length === 0) return;

	  // 모든 row를 처리하는 단일 루프
	  for (let i = 0; i < json.length; i++) {
	    const row = json[i];
	    // 첫 번째 row (i === 0)에만 실제로 표시될 label 텍스트
	    // 나머지 row에서는 CSS로 숨길 예정
	    const categoryLabel = (i === 0) ? '<label>카테고리</label>' : '';
	    const itemNameLabel = (i === 0) ? '<label>제품명</label>' : '';
	    const priceLabel = (i === 0) ? '<label>단가 (원)</label>' : '';
	    const countLabel = (i === 0) ? '<label>수량</label>' : '';

	    const rowHtml = `
	      <div class="form-row">
	        <div class="form-group category-group fixed-width-med">
	          ${categoryLabel}
	          <input type="text" value="${row.카테고리 || ''}" readonly>
	          <input type="text" name="products[${i}].categoryId" value="${categoryMap.get(row.카테고리 || '')}" style="display:none">
	        </div>
	        <div class="form-group product-select-group fixed-width-lg">
	          ${itemNameLabel}
	          <input type="text" name="products[${i}].itemName" value="${row.제품명 || ''}" readonly>
	        </div>
			<div style="display:none;">
				<input type="text" name="products[${i}].spec">
			</div>
	        <div class="form-group fixed-width-med">
	          ${priceLabel}
	          <input type="number" name="products[${i}].price" value="${row.단가 || 0}" min="0" readonly>
	        </div>
	        <div class="form-group fixed-width-sm">
	          ${countLabel}
	          <input type="number" name="products[${i}].count" value="${row.수량 || 1}" min="1" max="10" readonly>
	        </div>
	      </div>
	    `;
	    container.insertAdjacentHTML('beforeend', rowHtml);
	  }

	  // 구매 요청 사유는 변경 없이 유지
	  const reasonHtml = `
	    <div class="form-group">
	      <label for="reason">구매 요청 사유 <span class="required">*</span></label>
	      <textarea id="reason" name="requestMsg" rows="4" required maxlength="200" readonly>${purchase_reason || ''}</textarea>
	    </div>
	  `;
	  container.insertAdjacentHTML('beforeend', reasonHtml);
	}


	//엑셀 템플릿 다운로드 기능 구현
	function downloadExcelTemplate() {
		 // 1. 실제 템플릿 파일이 위치한 경로를 지정합니다.
		 const templatePath = '/assetmanager/resources/template/구매요청양식.xlsx'; 
		 // 2. 다운로드를 실행합니다. (가장 일반적인 방법: <a> 태그를 이용)
		 const link = document.createElement('a');
		 link.href = templatePath;
		 link.download = '구매요청양식.xlsx'; // 다운로드될 파일명
		 document.body.appendChild(link);
		 link.click(); // 클릭 이벤트 발생
		 document.body.removeChild(link); // 생성된 <a> 태그 제거
	}

function init_select2(parent){
	const $select = $(parent).find('[name*="itemName"]');
	if($select.hasClass("select2-hidden-accessible")){
		$select.empty();
		$select.select2('destroy');
	}
	
    const emptyOption = new Option("", "", true, true); // value가 "" (비어 있음)
    $select.append(emptyOption);
    // 3. Select2 데이터를 HTML <option> 태그로 변환하여 삽입
    productData.forEach(item => {
        const option = new Option(item.itemName, item.itemName, false, false);
        // description을 데이터 속성으로 저장하여 templateResult에서 사용 (Select2 내부 객체에 포함됨)
        $(option).data('description', item.spec); 
        $(option).data('price', item.price); 
        $(option).data('id', item.id); 
        $select.append(option);
    });
    
    // 4. Select2 초기화 및 Tags 옵션 활성화
    $select.select2({
        data: productData, // Select2가 내부적으로 사용할 데이터 목록
        placeholder: "제품명 선택",
        allowClear: true,
        tags: true, // 직접 입력 허용
        
        // 검색 결과 목록에 적용할 템플릿
        templateResult: formatProductResult,

        // 검색된 항목이 없는 경우, 사용자가 입력한 텍스트를 옵션으로 표시
        createTag: function (params) {
            // 새 항목임을 표시하는 data 속성을 추가하여 선택 변경 이벤트에서 활용
            const tag = {
                id: params.term,
                text: params.term, 
                itemName: params.term,
                price: undefined,
                isNew: true // 새 항목임을 표시
            };
            return tag;
        }
    });
    
    // 드롭다운 내 검색 입력창에 플레이스홀더 설정
    $select.on('select2:open', function() {
        // 드롭다운이 열릴 때 동적으로 생성되는 검색 입력 필드를 찾아 placeholder 속성을 설정합니다.
        $('.select2-search--dropdown .select2-search__field').attr(
            'placeholder', 
            '직접 입력'
        );
    });
    
    // 5. 선택 변경 이벤트 핸들러
    $select.on('select2:select', function(e) {
        const selectedData = e.params.data; // 선택된 Select2 내부 객체
        const $formRow = $(this).closest('.form-row');
        const $priceInput = $formRow.find('[name*="price"]');
        const $specInput = $formRow.find('[name*="spec"]');
        
        // 가격 반영
        if (selectedData.price !== undefined) {
            $priceInput.val(selectedData.price);
            calculateTotalPrice($priceInput[0]);
            $priceInput.attr('readonly', true);
        } else {
            $priceInput.val('');
            $priceInput.removeAttr('readonly');
        }
        
        // 스펙 저장
        if(selectedData.spec !== undefined){
        	$specInput.val(selectedData.spec);
        }

        // 화면에 선택 정보 표시
        let detail = `선택된 ID: <strong>${selectedData.id}</strong>, 상품명: <strong>${selectedData.itemName}</strong>`;

        if (selectedData.isNew) {
            detail = `<strong style="color: #b91c1c;">[직접 입력된 새 항목]</strong> 상품명: <strong>${selectedData.itemName}</strong>`;
        } else if (selectedData.spec) {
            detail += `<br>설명: <em>${selectedData.spec}</em>`;
        }

        $('#selected-value').html(detail);
    });
    
    $select.on('select2:unselect', function(e) {
        const $priceInput = $(this).closest('.form-row').find('[name*="price"]');
        $priceInput.val('');// 단가 초기화
        $priceInput.removeAttr('disabled');
        calculateTotalPrice($priceInput[0]);
    });
}

//Select2 결과 템플릿 함수 (설명을 표시)
function formatProductResult (product) {
    // 로딩 상태, 선택된 값 (selection), 또는 직접 입력된 텍스트는 건너뜁니다.
    if (!product.id) {
        return product.itemName; 
    }

    // 직접 입력된 새 항목인 경우
    if (product.element && product.element.dataset.new === 'true') {
         // tags:true로 입력된 항목은 description이 없으므로, 사용자에게 표시할 텍스트를 조정합니다.
        return $(
            '<span class="product-name">새 상품 입력: ' + product.text + '</span>'
        );
    }
    
    // 데이터 목록에서 가져온 항목인 경우
    return $(
        '<span class="product-result">' +
            '<span class="product-name">' + product.itemName + '</span>' +
            '<span class="product-desc">' + (product.spec || '설명 없음') + '</span>' +
        '</span>'
    );
}





