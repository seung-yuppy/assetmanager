function getColor(name) {
    return getComputedStyle(document.documentElement).getPropertyValue(name).trim();
}

async function getData() {
	const res = await fetch("/assetmanager/asset/value", {
		method: "GET",
	}); 
	const data = await res.json();
	return data.result;
}

async function getDeptData() {
	const res = await fetch("/assetmanager/asset/dept", {
		method: "GET",
	});
	const data = await res.json();
	return data.result;
}

async function getCategoryData() {
	const res = await fetch("/assetmanager/asset/category", {
		method: "GET"
	});
	const data = await res.json();
	return data.result;
}

async function getApprovalData() {
	const res = await fetch("/assetmanager/asset/approval", {
		method: "GET"
	});
	const data = await res.json();
	return data.result;
}


// Chart.js 렌더링 함수
async function renderCharts() {
	// 1. 카테고리별 자산 현황
	const categoryCtx = document.querySelector('#categoryChart');
	const categoryAssets = await getCategoryData();
	const categoryNames = [];
	const categoryCounts = [];
	
	categoryAssets.map((categoryAsset) => {
		categoryNames.push(categoryAsset.categoryName);
		categoryCounts.push(categoryAsset.categoryCount);
	});
	
    const categoryData = {
            labels: categoryNames,
            datasets: [{
                label: '보유 자산',
                data: categoryCounts,
                backgroundColor: [
                	'#9FA8DA',
                	'#A5D6A7',
                	'#FFE0B2',
                	'#B39DDB',
                	'#FFAB91',
                	'#778DA9',
                	'#80CBC4',
                	'#FFF59D'                
                ],
                borderColor: '#3b82f6',
                borderRadius: 5,
            }]
        };

        new Chart(categoryCtx, {
            type: 'bar', // 가로 막대 차트는 'bar' 타입을 유지
            data: categoryData,
            options: {
                indexAxis: 'y', // 이 옵션이 가로 막대 차트를 만듭니다.
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            // 툴팁에서 x축(개수)이 표시되도록 수정
                            label: (context) => `${context.dataset.label || ''}: ${context.parsed.x.toLocaleString()}개`
                        }
                    }
                },
                scales: {
                    x: { // x축이 이제 개수 축이 됨
                        beginAtZero: true,
                        ticks: {
                            callback: (value) => `${value.toLocaleString()}개`,
                            stepSize: 10
                        },
                        grid: {
                            color: getColor('--white-color')
                        }
                    },
                    y: { // y축이 이제 카테고리 축이 됨
                        grid: { display: false }
                    }
                }
            }
        });
	
	
    // 2. 부서별 자산 현황 (막대 차트)
    const departmentCtx = document.getElementById('departmentChart');
    departmentCtx.style.height = '280px';
    
    const deptAssets = await getDeptData();
    const deptNames = [];
    const deptCount = [];
    
    deptAssets.map((deptAsset) => {
    	deptNames.push(deptAsset.deptName);
    	deptCount.push(deptAsset.deptCount);
    });

    const departmentData = {
        labels: deptNames,
        datasets: [{
            label: '보유 자산',
            data: deptCount,
            backgroundColor: '#485691',
            borderColor: getColor('--primary-color'),
            borderRadius: 5,
            barThickness: 50
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
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '개';
                        },
                        stepSize: 1 // <-- 이 속성을 추가합니다.
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

    // 3. 창고 자산 유무 (도넛 차트)
    const inventoryCtx = document.getElementById('inventoryChart');
    
    const assetDatas = await getData();
    const assetNames = [];
    const assetCounts = [];
    
    assetDatas.map((asset) => {
    	assetNames.push(asset.inventoryName);
    	assetCounts.push(asset.inventoryCount);
    });

    const totalAssets = assetDatas.reduce((sum, asset) => sum + asset.inventoryCount, 0);
    const assetPercentages = assetDatas.map(d => (d.inventoryCount / totalAssets) * 100);

    
    const assetDatass = {
    		labels: assetNames,
            datasets: [{
                data: assetPercentages,
                backgroundColor: [
                	'#A5D6A7',
                	'#3fa1d6',
                	'#FFAB91'
                ],
                hoverOffset: 3,
            }]
        };

    new Chart(inventoryCtx, {
        type: 'pie', // <--- 타입 변경
        data: assetDatass,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            radius: '75%',
            plugins: {
                legend: {
                    position: 'right', // 범례를 오른쪽에 표시
                    labels: {
                        boxWidth: 20, 
                        padding: 15, 
                        color: getColor('--dark-color'), 
                        font: {
                            size: 14
                        },
                        generateLabels: (chart) => {
                            const data = chart.data;
                            if (data.labels.length && data.datasets.length) {
                                const dataset = data.datasets[0];
                                return data.labels.map((label, i) => {
                                    const value = dataset.data[i];
                                    const backgroundColor = dataset.backgroundColor[i];
                                    const borderColor = dataset.borderColor;
                                    const borderWidth = dataset.borderWidth;

                                    return {
                                        text: `${label}: ${value.toFixed(1)}%`,
                                        fillStyle: backgroundColor,
                                        lineWidth: borderWidth,
                                        hidden: !chart.isDatasetVisible(0), 
                                        index: i
                                    };
                                });
                            }
                            return [];
                        }
                    }
                },
                tooltip: {
                    callbacks: {
                        label: (context) => {
                            const label = context.label || '';
                            const value = context.parsed;
                            return `${label}: ${value.toFixed(1)}%`; // 비율 표시
                        }
                    }
                }
            }
        },
    });
    
    // 4. 가로형 막대 그래프 (관리자 승인 대기 현황)
    const ctxApprovalBar = document.getElementById('approvalHorizontalBarChart');
    ctxApprovalBar.style.height = '230px';
    
    const approvalDatas = await getApprovalData();
    const approvalNames = [];
    const approvalCounts = [];
    
    approvalDatas.map((approval) => {
    	approvalNames.push(approval.approvalName);
    	approvalCounts.push(approval.approvalCount);
    });
    
    const approvalAssetData = {
            labels: approvalNames,
            datasets: [{
                label: '건수',
                data: approvalCounts,
                backgroundColor: '#485691',
                borderColor: getColor('--primary-color'),
                borderRadius: 5,
                barThickness: 50
            }]
        };
    
    new Chart(ctxApprovalBar, {
        type: 'bar',
        data: approvalAssetData,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '개';
                        },
                        stepSize: 1
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
}

// 페이지 로드 시 차트 렌더링
window.onload = renderCharts;