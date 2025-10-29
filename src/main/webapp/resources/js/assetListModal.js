document.addEventListener("DOMContentLoaded", function() {
	const productModal = document.querySelector('#product-modal');  

	// 모달이 이 페이지에 없으면, JS가 더 이상 실행되지 않도록 막음
	if (!productModal) {
        return; 
    }
	
	const closeModalBtn = document.querySelector('.close-modal-btn');
	const searchInput = document.getElementById('product-search-input');
	const listBody = document.getElementById('asset-list-body');
	const formInputArea = document.getElementById('formInputArea');
		
	let activeProductNameInput = null;
	let currentFetchedAssets = [];
	
	const closeModal = () => {
    	productModal.classList.add('hidden');
    };
		
	const renderAssetList = (filter = '') => {
		listBody.innerHTML = '';
        const lowercasedFilter = filter.toLowerCase();
        
        const filteredData = currentFetchedAssets.filter(asset =>
        asset.assetName.toLowerCase().includes(lowercasedFilter) || 
        (asset.spec && asset.spec.toLowerCase().includes(lowercasedFilter)) ||
        asset.count
    );
 
        if (filteredData.length === 0) {
        	listBody.innerHTML = '<tr><td colspan="2" style="text-align: center; padding: 1rem;">검색 결과가 없습니다.</td></tr>';
            return;
        }

        filteredData.forEach(asset => {
            const tr = document.createElement('tr');
            tr.innerHTML = `<td>${asset.assetName}</td><td>${asset.spec || ''}</td><td>${asset.count || ''}</td>`;
            
            tr.addEventListener('click', () => {
            	const assetId = asset.id; 
                const assetName = asset.assetName;
            	
                if (activeProductNameInput) {
                    activeProductNameInput.value = assetName;
                    
                    // 숨겨진 assetId 값 찾기
                    const parentRow = activeProductNameInput.closest('.form-row');
                    if (parentRow) {
                        const hiddenInput = parentRow.querySelector('input[name="assetId"]');
                        if(hiddenInput) {                 
                            hiddenInput.value = assetId;
                        }
                    }
                }
                closeModal();
            });
            listBody.appendChild(tr);
        });
	};
		console.log(formInputArea);
        if (formInputArea) {
            formInputArea.addEventListener('click', (e) => {
                if (e.target.classList.contains('productSelect')) {
                    
                	console.log(e.target);
     
                    // 클릭한 입력창 저장
                    activeProductNameInput = e.target;

                    // 현재 카테고리 값에서 가까운 부모
                    const parentRow = e.target.closest('.form-row');
                    
                    // select 찾기
                    const categorySelect = parentRow.querySelector('select[name="category"]');
             
                    console.log(categorySelect);
                    
    				if (!categorySelect) {
    					return;
    				}
    				
    				// 현재 category 값 찾기
                    const selectedCategory = categorySelect.value;
                    
                    console.log(selectedCategory);
                    
                    // 카테고리 값
                    let categoryId = 0;
                    switch (selectedCategory) {
                        case "notebook":categoryId = 1; break;
                        case "monitor":categoryId = 2; break; 
                        case "tablet":categoryId = 3; break; 
                        case "smartphone":categoryId = 4; break; 
                        case "multiprinter":categoryId = 5; break; 
                        case "desktop":categoryId = 6; break; 
                        case "tv":categoryId = 7; break; 
                        case "projector":categoryId = 8; break;                   
                        case "other":categoryId = 9; break;                   
                        default: 
                            categoryId = 0;
                    }
                    
                    // 자산 데이터 요청
                    fetch(`/assetmanager/rent/assets?categoryId=${categoryId}`)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('서버 응답 오류');
                            }
                            return response.json(); 
                        })
                        .then(assets => {
                            // 받아온 데이터 저장
                            currentFetchedAssets = assets; 
                            
                         // 전체 불러오기
                            renderAssetList(); 
                            
                            // 모달 열기
                            productModal.classList.remove('hidden');
                            searchInput.value = '';
                            searchInput.focus();
                        })
                        .catch(error => {                      
                            listBody.innerHTML = '<tr><td colspan="2">자산을 불러오는 데 실패했습니다.</td></tr>';
                            productModal.classList.remove('hidden'); 
                        });
                }
            });
        }
		
        if(closeModalBtn) { 
        	closeModalBtn.addEventListener('click', closeModal);
        }
		
        if(searchInput) {
        	searchInput.addEventListener('input', (e) => renderAssetList(e.target.value));
        }
        
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && !productModal.classList.contains('hidden')) {
            	closeModal();
            }
        });
});