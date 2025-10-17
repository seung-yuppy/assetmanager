// 총액 자동 계산을 위한 이벤트 부착
const inputArea = document.getElementById('formInputArea');
inputArea.addEventListener('change',function(e){
	if (e.target && e.target.tagName === 'INPUT' && e.target.type === 'number'){
		calculateTotalPrice(e.target);
	}
})

function calculateTotalPrice(el){
	const row = el.closest('.form-row');
	const price = row.querySelector('input[name^="price"]').value;
	const quantity = row.querySelector('input[name^="quantity"]').value;
	const targetEl = row.querySelector('input[name^="totalPrice"]');
	
	targetEl.value = price * quantity;
}

let productRowIndex  = 0;

//구매 요청할 제품 추가하는 함수 
function addProduct(){
	if (!checkProductCnt()){
		alert("요청 품목은 10개까지만 가능합니다.");
		return;
	}
	const currentIndex = ++productRowIndex;
	const targetEl = document.querySelector('#add-product-section');
	const newFormRowHTML = `
							<div class="form-row">
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse-${currentIndex}">부서 자산</label>
									<div>
										<input type="checkbox" id="isDepartmentUse-${currentIndex}" name="isDepartmentUse-${currentIndex}"> 
									</div>
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select id="category" name="category-${currentIndex}" required onchange="updateProductOptions()">
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="software">소프트웨어</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명<span class="required">*</span></label>
									<input list="productOptions" name="productNameSelect-${currentIndex}" id="productNameSelect" placeholder="선택  또는 직접 입력">
									<datalist id="productOptions">
									    <option value="LG그램">
									    <option value="macbook 10">
									    <option value="직접 입력">
									</datalist>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">단가 (원) <span class="required">*</span></label>
									<input type="number" id="price" name="price-${currentIndex}" value="0" min="0" required>
								</div>

								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<input type="number" id="quantity" name="quantity-${currentIndex}" min="1" max="10" value="1" required>
								</div>
								<div class="form-group fixed-width-med">
									<label for="totalPrice">총액 (원)</label>
									<div class="last-input-group">
										<input type="text" id="totalPrice" name="totalPrice-${currentIndex}" value="0" class="locked-input" readonly>
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)"></img>
									</div>
								</div>
							</div>
	`
		targetEl.insertAdjacentHTML('beforebegin', newFormRowHTML);
};

// 1. 상품 데이터 목록 (ID, 이름, 설명 포함)
const productData = [
    { id: 'P101', text: '프리미엄 커피 머신', description: '자동 타이머 및 보온 기능이 있는 고급 드립 커피 머신.' },
    { id: 'P102', text: '인체공학적 사무용 의자', description: '요추 지지대와 3D 팔걸이가 있는 인체공학적 의자.' },
    { id: 'P103', text: '4K Ultra HD 모니터', description: '전문 작업 및 게이밍을 위한 고해상도 광시야각 모니터.' },
    { id: 'P104', text: '무선 기계식 키보드', description: '반응 속도가 빠르고 타건감이 좋은 무선 기계식 키보드.' },
    { id: 'P105', text: '노이즈 캔슬링 헤드폰', description: '뛰어난 소음 제거 기능과 긴 배터리 수명을 가진 헤드폰.' }
];

// 2. Select2 결과 템플릿 함수 (설명을 표시)
function formatProductResult (product) {
    // 로딩 상태, 선택된 값 (selection), 또는 직접 입력된 텍스트는 건너뜁니다.
    if (!product.id) {
        return product.text; 
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
            '<span class="product-name">' + product.text + '</span>' +
            '<span class="product-desc">' + (product.description || '설명 없음') + '</span>' +
        '</span>'
    );
}

$(document).ready(function() {
    const $select = $('#product-select');
    const emptyOption = new Option("", "", true, true); // value가 "" (비어 있음)
    $select.append(emptyOption);
    // 3. Select2 데이터를 HTML <option> 태그로 변환하여 삽입
    productData.forEach(item => {
        const option = new Option(item.text, item.id, false, false);
        // description을 데이터 속성으로 저장하여 templateResult에서 사용 (Select2 내부 객체에 포함됨)
        $(option).data('description', item.description); 
        $select.append(option);
    });
    
    // 4. Select2 초기화 및 Tags 옵션 활성화
    $select.select2({
        data: productData, // Select2가 내부적으로 사용할 데이터 목록
        placeholder: "제품명 선택",
        allowClear: true,
        tags: true, // 직접 입력 허용 (datalist와 유사한 기능)
        
        // 검색 결과 목록에 적용할 템플릿
        templateResult: formatProductResult,

        // 검색된 항목이 없는 경우, 사용자가 입력한 텍스트를 옵션으로 표시
        createTag: function (params) {
            // 새 항목임을 표시하는 data 속성을 추가하여 선택 변경 이벤트에서 활용
            const tag = {
                id: params.term, // 입력된 텍스트 자체를 값으로 사용
                text: params.term,
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
    $select.on('change', function() {
        const $selectedOption = $(this).find('option:selected');
        const selectedText = $selectedOption.text();
        const selectedValue = $(this).val();
        
        let detail = `선택된 ID: <strong>${selectedValue}</strong>, 상품명: <strong>${selectedText}</strong>`;
        
        // 값이 선택되었는지 확인
        if (selectedValue && selectedValue !== '') {
             const isNewItem = $selectedOption.data('isNew');
             
             if (isNewItem) {
                 // 직접 입력된 새 항목
                 detail = `<strong style="color: #b91c1c;">[직접 입력된 새 항목]</strong> 상품명: <strong>${selectedText}</strong>`;
             } else {
                // 기존 상품인 경우 상세 설명을 가져옵니다.
                const description = $selectedOption.data('description');
                if (description) {
                    detail += `<br>설명: <em>${description}</em>`;
                }
             }
            $('#selected-value').html(detail);
        } else {
            $('#selected-value').html('선택된 상품: 없음');
        }
    });
});