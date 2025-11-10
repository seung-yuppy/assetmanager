/**
 * CSS 변수에서 색상 값을 가져옵니다.
 * @param {string} name - CSS 변수 이름 (예: '--primary-color')
 * @returns {string} - 색상 값 (예: '#FFFFFF')
 */
function getColor(name) {
    return getComputedStyle(document.documentElement).getPropertyValue(name).trim();
}

/**
 * 전역 Chart 인스턴스를 저장하는 객체.
 * 년도 변경 시 기존 차트를 파괴하고 새로 그리기 위해 사용됩니다.
 */
const chartInstances = {};

/**
 * 서버에서 데이터를 비동기적으로 가져옵니다.
 * @param {string} year - 선택된 년도
 * (현재는 더미 데이터를 사용하지만 함수는 유지)
 */
async function getData(year) {
	try {
		console.log(`Fetching data for year: ${year}`);
		// 실제 API 호출 시: const res = await fetch(`/assetmanager/asset/value?year=${year}`, { ... });
		const res = await fetch("/assetmanager/asset/테스트", {
			method: "GET",
		});
		if (!res.ok) {
			throw new Error(`HTTP error! status: ${res.status}`);
		}
		const data = await res.json();
		console.log("서버 데이터 수신:", data);
		return data;
	} catch (error) {
		console.error("데이터를 가져오는 중 오류 발생:", error);
		// 년도별 더미 데이터를 반환하여 차트가 작동하도록 합니다.
		return generateDummyData(year); 
	}
}

/**
 * 년도에 따른 더미 데이터 생성 (시뮬레이션용)
 * @param {string} year 
 * @returns {object} - 차트에 사용될 더미 데이터 구조
 */
function generateDummyData(year) {
    // 년도에 따라 약간씩 다른 데이터를 생성하여 시각적 변화를 줍니다.
    const seed = parseInt(year) % 3; // 2023, 2024, 2025에 대해 0, 1, 2 시드 사용
    const baseProgress = [30, 80, 10, 90, 50]; // 기본 진행도
    const baseQuantity = [150, 100, 50, 100]; // 기본 수량
    const baseFluctuation = { inflow: [20, 15, 30, 10, 25, 18], disposal: [5, 8, 2, 12, 5, 7] }; // 기본 입고/폐기

    // Line Chart Data (매출/비용)
    const lineData = {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월'],
        datasets: [
            {
                label: '데이터셋 1 (매출)',
                data: [60 + seed * 5, 50 + seed * 2, 70 + seed * 7, 85 - seed * 3, 55 + seed * 5, 60 + seed * 2, 45 + seed * 4].map(v => Math.floor(v)),
                fill: false,
                borderColor: 'rgb(75, 192, 192)',
                tension: 0.1
            },
            {
                label: '데이터셋 2 (비용)',
                data: [30 + seed * 3, 40 + seed * 1, 35 + seed * 2, 25 + seed * 4, 90 - seed * 5, 30 + seed * 1, 80 + seed * 3].map(v => Math.floor(v)),
                fill: false,
                borderColor: 'rgb(255, 99, 132)',
                tension: 0.1
            }
        ]
    };

    // Doughnut Chart Data (유형별 현황)
    const doughnutData = {
        labels: ['노트북', '모니터', '데스크탑', '기타'],
        data: baseQuantity.map(v => Math.floor(v + seed * 10))
    };
    
    // Bar Chart Data (입고/폐기)
    const barData = {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월'],
        inflow: baseFluctuation.inflow.map(v => Math.floor(v + seed * 3)),
        disposal: baseFluctuation.disposal.map(v => Math.floor(v + seed * 1))
    };

    // ------------------ 테이블 더미 데이터 ------------------

    // 1. 분기별 구매 추이 테이블 데이터 (purchaseTable)
    const purchaseTableData = [
        { asset: "Macbook Pro 16\"", category: "노트북", returnDate: `2026-10-${10 - seed}`, progress: `${baseProgress[0] + seed * 5}%` },
        { asset: "Dell XPS 15", category: "노트북", returnDate: `2025-12-${20 - seed}`, progress: `${baseProgress[1] - seed * 5}%` },
        { asset: "LG Gram 17", category: "노트북", returnDate: `2027-01-${15 + seed}`, progress: `${baseProgress[2] + seed * 10}%` },
        { asset: "Samsung Odyssey G9", category: "모니터", returnDate: `2025-11-${30 - seed * 2}`, progress: `${baseProgress[3] - seed * 10}%` },
        { asset: "iPhone 15 Pro", category: "모바일", returnDate: `2025-10-${25 + seed * 2}`, progress: `${baseProgress[4] + seed * 5}%` }
    ];

    // 2. 자산 유형별 현황 테이블 데이터 (assetTypeTable)
    const assetTypeTableData = doughnutData.labels.map((label, index) => {
        const quantity = doughnutData.data[index];
        const total = doughnutData.data.reduce((sum, val) => sum + val, 0);
        const ratio = (quantity / total * 100).toFixed(1) + '%';
        return { type: label, quantity: quantity, ratio: ratio };
    });

    // 3. 월별 자산 변동 테이블 데이터 (monthlyFluctuationTable)
    const monthlyFluctuationTableData = barData.labels.map((month, index) => {
        const inflow = barData.inflow[index];
        const disposal = barData.disposal[index];
        const netChange = inflow - disposal;
        return { month: month, inflow: inflow, disposal: disposal, netChange: (netChange > 0 ? '+' : '') + netChange };
    });

    return { 
        lineData, 
        doughnutData, 
        barData, 
        purchaseTableData, // 첫 번째 차트 관련 테이블 데이터
        assetTypeTableData, // 두 번째 차트 관련 테이블 데이터
        monthlyFluctuationTableData // 세 번째 차트 관련 테이블 데이터
    };
}

/**
 * 기존 차트 인스턴스를 파괴하는 헬퍼 함수
 * @param {string} chartId - 차트의 DOM ID
 */
function destroyChart(chartId) {
	if (chartInstances[chartId] instanceof Chart) {
		chartInstances[chartId].destroy();
		delete chartInstances[chartId];
	}
}

/**
 * 보고서 생성 상태 메시지를 UI에 표시합니다. (alert 대체)
 * @param {string} message - 표시할 메시지
 */
function showStatusMessage(message) {
    const statusElement = document.getElementById('reportStatusMessage');
    if (statusElement) {
        statusElement.textContent = message;
        statusElement.style.opacity = 1;
        
        // 3초 후 메시지를 숨깁니다.
        setTimeout(() => {
            statusElement.style.opacity = 0;
        }, 3000);
    }
}


/**
 * 분기별 구매 추이 (꺾은선 그래프) 렌더링
 * @param {object} chartData - 차트 데이터
 * @param {string} year - 선택된 년도
 */
function renderLineChart(chartData, year) {
	const chartId = 'totalPurchaseLineChart';
	const ctx = document.getElementById(chartId);
	if (!ctx) return; 

	destroyChart(chartId);

	const data = chartData.lineData;
	
	chartInstances[chartId] = new Chart(ctx, {
        type: 'line',
        data: data,
        options: {
            responsive: true,
            maintainAspectRatio: false, 
            aspectRatio: 1.8, // 넓은 카드에 적합한 비율
            plugins: {
                legend: { position: 'top' },
                title: {
                    display: true,
                    text: `${year}년 상반기 데이터`, // 년도 반영
                    font: { size: 18 }
                }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
}

/**
 * 자산 유형별 현황 (도넛 차트) 렌더링
 * @param {object} chartData - 차트 데이터
 * @param {string} year - 선택된 년도
 */
function renderDoughnutChart(chartData, year) {
	const chartId = 'assetTypeDoughnutChart';
	const ctx = document.getElementById(chartId);
	if (!ctx) return;

	destroyChart(chartId);

	const data = {
		labels: chartData.doughnutData.labels,
		datasets: [{
			label: '자산 수량',
			data: chartData.doughnutData.data,
			backgroundColor: [
				'rgb(255, 99, 132)',
				'rgb(54, 162, 235)',
				'rgb(255, 205, 86)',
				'rgb(153, 102, 255)'
			],
			hoverOffset: 4
		}]
	};

	chartInstances[chartId] = new Chart(ctx, {
		type: 'doughnut',
		data: data,
		options: {
			responsive: true,
			maintainAspectRatio: false, 
            aspectRatio: 1.2, // 좁은 카드에 적합한 비율
			plugins: {
				legend: {
					position: 'bottom',
				},
				title: {
					display: true,
					text: `${year}년 자산 유형별 비율`, // 년도 반영
					font: { size: 16 }
				}
			}
		}
	});
}

/**
 * 월별 자산 변동 (막대 차트) 렌더링
 * @param {object} chartData - 차트 데이터
 * @param {string} year - 선택된 년도
 */
function renderBarChart(chartData, year) {
	const chartId = 'monthlyFluctuationBarChart';
	const ctx = document.getElementById(chartId);
	if (!ctx) return;

	destroyChart(chartId);

	const data = {
		labels: chartData.barData.labels,
		datasets: [
			{
				label: '입고',
				data: chartData.barData.inflow,
				backgroundColor: 'rgba(75, 192, 192, 0.6)',
				borderColor: 'rgb(75, 192, 192)',
				borderWidth: 1
			},
			{
				label: '폐기',
				data: chartData.barData.disposal,
				backgroundColor: 'rgba(255, 99, 132, 0.6)',
				borderColor: 'rgb(255, 99, 132)',
				borderWidth: 1
			}
		]
	};

	chartInstances[chartId] = new Chart(ctx, {
		type: 'bar',
		data: data,
		options: {
			responsive: true,
			maintainAspectRatio: false, 
            aspectRatio: 1.2, // 좁은 카드에 적합한 비율
			plugins: {
				legend: {
					position: 'top',
				},
				title: {
					display: true,
					text: `${year}년 월별 입고 및 폐기 현황`, // 년도 반영
					font: { size: 16 }
				}
			},
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
}

/**
 * 테이블 데이터를 업데이트하는 함수
 * @param {string} tableId - 테이블의 ID
 * @param {object[]} data - 테이블에 채울 데이터 배열
 */
function updateTable(tableId, data) {
    const tableBody = document.querySelector(`#${tableId} tbody`);
    if (!tableBody) return;

    // 기존 내용 삭제
    tableBody.innerHTML = ''; 

    // 새로운 내용 삽입
    data.forEach(item => {
        const row = tableBody.insertRow();
        
        // 데이터 객체의 모든 값을 순서대로 셀에 삽입합니다.
        // 이 방식은 데이터 객체의 키 순서가 테이블 컬럼 순서와 일치한다고 가정합니다.
        Object.values(item).forEach(value => {
            row.insertCell().textContent = value || '';
        });
    });
}


/**
 * 모든 차트와 테이블을 렌더링하는 메인 함수
 * @param {string} year - 선택된 년도
 */
async function renderCharts(year) {
	// 1. 년도별 데이터 가져오기 (실제로는 서버에서 가져옴)
	const chartData = await getData(year);
	
	if (!chartData) {
		console.error("차트/테이블 데이터를 렌더링할 데이터를 찾을 수 없습니다.");
		return;
	}

	// 2. 차트 렌더링
	renderLineChart(chartData, year);
	renderDoughnutChart(chartData, year);
	renderBarChart(chartData, year);
	
	// 3. 테이블 데이터 업데이트
    // 모든 테이블을 동적으로 업데이트하도록 수정했습니다.
    updateTable('purchaseTable', chartData.purchaseTableData);
    updateTable('assetTypeTable', chartData.assetTypeTableData);
    updateTable('monthlyFluctuationTable', chartData.monthlyFluctuationTableData);
}

/**
 * 페이지 로드 시 차트 렌더링 및 이벤트 리스너 설정
 */
function setupDashboard() {
	const yearSelect = document.getElementById('yearSelect');
	const reportButton = document.getElementById('reportGenerateBtn');

	// 1. 초기 차트 렌더링 (기본 선택된 년도로)
	const initialYear = yearSelect ? yearSelect.value : new Date().getFullYear().toString();
	renderCharts(initialYear);

	// 2. 년도 선택 드롭다운 이벤트 리스너 설정
	if (yearSelect) {
		yearSelect.addEventListener('change', (event) => {
			const selectedYear = event.target.value;
			renderCharts(selectedYear);
		});
	}
	
	// 3. 보고서 생성 버튼 이벤트 리스너 설정 (더미 기능)
	if (reportButton) {
		reportButton.addEventListener('click', () => {
			// 현재 선택된 년도를 가져와서 보고서 생성 로직을 호출합니다.
			const selectedYear = yearSelect ? yearSelect.value : initialYear;
			console.log(`${selectedYear}년도에 대한 보고서 생성을 시작합니다.`);
			
			// 사용자에게 상태를 알리는 메시지 표시 (alert 대신 사용)
			showStatusMessage(`${selectedYear}년 보고서 생성 요청 완료!`);
		});
	}
}

// 페이지 로드 시 차트 렌더링 및 이벤트 설정
window.onload = setupDashboard;