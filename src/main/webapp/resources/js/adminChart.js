function getColor(name) {
    return getComputedStyle(document.documentElement).getPropertyValue(name).trim();
}

async function getData() {
	const res = await fetch("/assetmanager/asset/value", {
		method: "GET",
	}); 
	const data = await res.json();
	return data;
}

// Chart.js 렌더링 함수
async function renderCharts() {
    // 1. 부서별 자산 현황 (막대 차트)
    const departmentCtx = document.getElementById('departmentChart');

    const departmentData = {
        labels: ['공공사업1팀', '공공사업2팀', '공공사업3팀', '공공사업4팀', '전략사업1팀', '전략사업2팀', '경영지원팀', '영업팀'],
        datasets: [{
            label: '보유 자산 (수량)',
            data: [30, 40, 67, 21, 14, 19, 24, 19],
            backgroundColor: [
            	getColor('--primary-color'),
            	getColor('--primary-color'),
            	getColor('--primary-color'),
            	getColor('--primary-color'),
            	getColor('--primary-color'),
            	getColor('--primary-color'),
            	getColor('--primary-color'),
            	getColor('--primary-color')
            ],
            borderColor: getColor('--primary-color'),
            borderRadius: 5,
        }]
    };

    new Chart(departmentCtx, {
        type: 'bar',
        data: departmentData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false // 범례 숨김
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += context.parsed.y.toLocaleString() + '개';
                            }
                            return label;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '개수',
                        color: getColor('--dark-color'),
                    },
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '개';
                        }
                    },
                    grid: {
                        color: getColor('--white-color')
                    }
                },
                x: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });

    // 2. 창고 자산 유무 (도넛 차트)
    const inventoryCtx = document.getElementById('inventoryChart');
    
    const assetData = await getData();
    const totalAsset = assetData.totalAsset;
    const usingAsset = assetData.usingAsset;
    const pendingAsset = assetData.pendingAsset;
    const invalidAsset = assetData.invalidAsset;
    
    const pendingPercentage = Math.round(((pendingAsset / totalAsset) * 100) * 100) / 100;
    const usingPercentage = Math.round(((usingAsset / totalAsset) * 100) * 100) / 100;
    const invalidPercentage = Math.round(((invalidAsset / totalAsset) * 100) * 100) / 100;
    
    const inventoryData = {
        labels: ['사용 가능 재고', '사용 중인 재고', '불용 처리 재고'],
        datasets: [{
            data: [pendingPercentage, usingPercentage, invalidPercentage], // 백분율 데이터
            backgroundColor: [
                getColor('--green-color'),
                getColor('--blue-color'),  
                getColor('--red-color')   
            ],
            hoverOffset: 4,
        }]
    };

    new Chart(inventoryCtx, {
        type: 'doughnut',
        data: inventoryData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '70%', // 도넛 두께
            plugins: {
                legend: {
                    display: false // 수동으로 범례를 구현했으므로 숨김
                },
            }
        },
    });
}

// 페이지 로드 시 차트 렌더링
window.onload = renderCharts;