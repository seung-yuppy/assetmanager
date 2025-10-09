// 1. 카테고리 선택 시 제품 목록 업데이트
function updateProductOptions() {
    const categorySelect = document.getElementById('category');
    const productNameGroup = document.getElementById('productGroup');
    const productNameSelect = document.getElementById('productName');
    const selectedCategory = categorySelect.value;
    
    // 이전 입력 필드 및 가격 초기화
    document.getElementById('price').value = 0;

}

//제품명 선택 시 호출되는 새로운 함수 (제품명 SELECT의 onchange에 연결)
function handleProductChange(selectedValue) {
    const productInputGroup = document.getElementById('productInputGroup');
    const priceInput = document.getElementById('price');

    // '직접 입력' 옵션 처리
    if (selectedValue === 'other') {
        // 직접 입력 필드를 보이게 설정
        productInputGroup.style.display = 'flex'; 
        
        // 가격 수정 가능하게 변경
        priceInput.readOnly = false;
        priceInput.classList.remove('price-lock');
        priceInput.value = '';
        
        // 사유는 직접 입력이므로 초기화 (선택 사항)
        document.getElementById('reason').value = ''; 
        
    } else {
        // 일반 제품 선택 시 숨기기
        productInputGroup.style.display = 'none';

        // 가격 수정 불가하게 변경 및 자동 입력 로직 호출
        priceInput.readOnly = true;
        priceInput.classList.add('price-lock');
        
        // ... (이전에 정의했던 가격 및 사유 자동 채우는 로직을 여기에 구현) ...
        // 예: updatePriceAndControls(selectedValue);
    }
}

/**
 * 단가와 수량을 계산하여 총액 필드에 값을 업데이트하는 함수.
 */
function calculateTotalPrice() {
    // 1. 필요한 HTML 요소 가져오기
    const priceInput = document.getElementById('price');
    const quantityInput = document.getElementById('quantity');
    const totalInput = document.getElementById('totalPrice');

    // 2. 입력 값 추출 및 유효성 검사
    // Number()를 사용하여 문자열 값을 숫자로 변환합니다.
    const price = Number(priceInput.value.replace(/,/g, '')); // 쉼표 제거 후 숫자로 변환
    const quantity = Number(quantityInput.value);

    // 값이 유효한 숫자인지, 수량이 0보다 큰지 확인
    if (isNaN(price) || isNaN(quantity) || quantity < 1 || price < 0) {
        totalInput.value = 0;
        return;
    }

    // 3. 총액 계산 (단가 * 수량)
    const totalPrice = price * quantity;

    // 4. 총액 필드에 계산 결과 적용
    // 천 단위 구분 기호를 추가하여 가독성을 높입니다.
    totalInput.value = totalPrice.toLocaleString('ko-KR'); // 총액 필드가 text 타입이 아닐 경우 (Number)
    totalInput.value = totalPrice; // 총액 필드가 number 타입이므로 단순 값만 할당
}

//DOMContentLoaded 이벤트는 HTML 문서 로드가 완료된 후 스크립트가 실행되도록 보장합니다.
document.addEventListener('DOMContentLoaded', function() {
    const priceInput = document.getElementById('price');
    const quantityInput = document.getElementById('quantity');

    // 'input' 이벤트: 사용자가 값을 입력할 때마다 즉시 실행
    priceInput.addEventListener('input', calculateTotalPrice);
    quantityInput.addEventListener('input', calculateTotalPrice);
    
    // 페이지 로드 시 초기 계산 한 번 실행
    calculateTotalPrice();
});


/**
 구매 사유 영역의 글자수를 세고 표시를 업데이트하는 함수
 */
function updateCharCount(textarea, maxLength) {
    const currentLength = textarea.value.length;
    const displayElement = document.getElementById('currentLength');
    
    if (displayElement) {
        // 현재 글자수를 업데이트
        displayElement.textContent = currentLength;
        
        // (선택 사항) 최대 길이에 도달했을 때 색상 변경
        if (currentLength >= maxLength) {
            displayElement.style.color = '#dc3545'; // 경고색 (빨간색)
        } else {
            displayElement.style.color = '#6c757d'; // 기본색 (회색)
        }
    }
}