// 더미 데이터
const assetData = [
        { name: 'LG Gram 16"', spec: 'i7, 16GB RAM, 1TB SSD' },
        { name: 'Samsung Galaxy Book Pro', spec: 'i5, 16GB RAM, 512GB SSD' },
        { name: 'Dell Ultrasharp U2721DE', spec: '27-inch, QHD, IPS' },
        { name: 'Logitech MX Keys', spec: 'Wireless, Backlit' },
        { name: 'Sony A7M4', spec: '33MP, 4K 60p' },
        { name: 'Canon EOS R6', spec: '20.1MP, 4K 60p' },
        { name: 'Adobe Photoshop', spec: 'Creative Cloud - 1 Year' },
        { name: 'Microsoft Office 365', spec: 'Business Standard - 1 Year' },
        { name: 'Herman Miller Aeron', spec: 'Size B, Graphite' },
        { name: 'Dell PowerEdge R740', spec: 'Intel Xeon, 128GB RAM' }
    ];

const productBtn = document.querySelectorAll('.productSelect');
productBtn.forEach( input => {
	input.addEventListener('click', (e)=> {
		console.log(e.target);
		ProductList();
	})
});


function ProductList(){
	const productModal = document.querySelector('#product-modal');  
	if(productModal){
		const closeModalBtn = document.querySelector('.close-modal-btn');
		const searchInput = document.getElementById('product-search-input');
		const listBody = document.getElementById('asset-list-body');
		const formInputArea = document.getElementById('formInputArea');
		
		
		const renderAssetList = (filter = '') => {
			listBody.innerHTML = '';
            const lowercasedFilter = filter.toLowerCase();
            
            const filteredData = assetData.filter(asset =>
                asset.name.toLowerCase().includes(lowercasedFilter) ||
                asset.spec.toLowerCase().includes(lowercasedFilter)
            );

            if (filteredData.length === 0) {
            	listBody.innerHTML = '<tr><td colspan="2" style="text-align: center; padding: 1rem;">검색 결과가 없습니다.</td></tr>';
                return;
            }

            filteredData.forEach(asset => {
                const tr = document.createElement('tr');
                tr.innerHTML = `<td>${asset.name}</td><td>${asset.spec}</td>`;
                tr.addEventListener('click', () => {
                    if (activeProductNameInput) {
                        activeProductNameInput.value = asset.name;
                    }
                    closeModal();
                });
                listBody.appendChild(tr);
            });
        };

        const openModal = (targetInput) => {
            activeProductNameInput = targetInput;
            productModal.classList.remove('hidden');
            searchInput.value = '';
            searchInput.focus();
            renderAssetList();
        };

        const closeModal = () => {
        	productModal.classList.add('hidden');
        };
		
        if(formInputArea) {
            formInputArea.addEventListener('click', (e) => {
                if (e.target.classList.contains('productSelect')) {
                    openModal(e.target);
                }
            });
        }
		
        if(closeModalBtn) closeModalBtn.addEventListener('click', closeModal);
		
        if(searchInput) searchInput.addEventListener('input', (e) => renderAssetList(e.target.value));
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && !modal.classList.contains('hidden')) closeModal();
        });
	}
}