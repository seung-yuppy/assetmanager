

// --- Mock 데이터 ---
// 참고 이미지 2의 데이터를 기반으로 Mock 데이터 생성
const annualData = [
	{ year: "2023", amount: 25000000 }, { year: "2024", amount: 22000000 },
	{ year: "2025", amount: 30000000 }
	];


let categoryData = [
    { categoryName: "노트북", amount: 75000000 },
    { categoryName: "모니터", amount: 42000000 },
    { categoryName: "태블릿", amount: 18000000 },
    { categoryName: "스마트폰", amount: 10000000 },
    { categoryName: "복합기", amount: 20000000 },
    { categoryName: "데스크탑", amount: 18000000 },
    { categoryName: "TV", amount: 8000000 },
    { categoryName: "프로젝터", amount: 18000000 },
    { categoryName: "기타", amount: 11000000 },
];

const deptData = [
	{ dept: "경영지원팀", amount: 59000000 },
	{ dept: "공공사업1팀", amount: 32000000 },
	{ dept: "공공사업2팀", amount: 22000000 },
	{ dept: "전략사업1팀", amount: 18000000 },
	{ dept: "전략사업2팀", amount: 15000000 },
	{ dept: "영업팀", amount: 31000000 }
	];

fetch(`/assetmanager/admin/stats/category?year=2025`)
.then(res => res.json())
.then(data => {
	categoryData = data;
	renderCharts();
	renderTables();
});

// --- 헬퍼 함수 ---
// 통화 형식 (예: 123,456,789 원)
function formatCurrency(amount) {
    return new Intl.NumberFormat('ko-KR').format(amount) + ' 원';
}

// 백분율 계산
function getPercentage(part, total) {
    return total > 0 ? ((part / total) * 100).toFixed(1) + ' %' : '0 %';
}

// 증감률 계산
function getChangeRate(current, previous) {
    if (previous === 0) return current > 0 ? 'N/A' : '0.0 %';
    const rate = ((current - previous) / previous) * 100;
    const sign = rate > 0 ? '▲' : (rate < 0 ? '▼' : '');
    return `${sign} ${Math.abs(rate).toFixed(1)} %`;
}

// --- 차트 렌더링 ---
function renderCharts() {
	// 2.전체 구매 금액 (꺾은선 차트)
    const annualCtx = document.getElementById('annualLineChart').getContext('2d');
    new Chart(annualCtx, {
        type: 'line',
        data: {
            labels: annualData.map(d => d.year),
            datasets: [{
                label: '월별 구매 금액',
                data: annualData.map(d => d.amount > 0 ? d.amount : null), // 0인 데이터는 차트에서 제외
                fill: true,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return (value / 1000000) + '백만';
                        }
                    }
                }
            }
        }
    });
    // 3. 카테고리별 구매 총액 (도넛 차트)
    const categoryCtx = document.getElementById('categoryDonutChart').getContext('2d');
    new Chart(categoryCtx, {
        type: 'doughnut',
        data: {
            labels: categoryData.map(d => d.categoryName),
            datasets: [{
                data: categoryData.map(d => d.amount),
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)',   // red
                    'rgba(54, 162, 235, 0.7)',   // blue
                    'rgba(255, 206, 86, 0.7)',   // yellow
                    'rgba(75, 192, 192, 0.7)',   // teal
                    'rgba(153, 102, 255, 0.7)',  // purple
                    'rgba(255, 159, 64, 0.7)',   // orange
                    'rgba(255, 99, 71, 0.7)',    // tomato-ish red
                    'rgba(100, 181, 246, 0.7)',  // light blue
                    'rgba(144, 238, 144, 0.7)'   // light green
                ],
                hoverOffset: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '60%', // 도넛 중앙 빈 공간
            plugins: {
                legend: {
                    position: 'right', // 범례 위치
                }
            }
        }
    });
	
    // 1. 부서별 구매 금액 (막대 차트)
    const deptCtx = document.getElementById('deptBarChart').getContext('2d');
    new Chart(deptCtx, {
        type: 'bar',
        data: {
            labels: deptData.map(d => d.dept),
            datasets: [{
                label: '구매 금액',
                data: deptData.map(d => d.amount),
                backgroundColor: [
                    'rgba(54, 162, 235, 0.6)',
                    'rgba(75, 192, 192, 0.6)',
                    'rgba(255, 206, 86, 0.6)',
                    'rgba(153, 102, 255, 0.6)',
                    'rgba(255, 159, 64, 0.6)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return (value / 1000000) + '백만'; // Y축 레이블 포맷
                        }
                    }
                }
            }
        }
    });
}

// --- 테이블 렌더링 ---
function renderTables() {
	const annualTableBody = document.getElementById('annualTableBody');
	const categoryTableBody = document.getElementById('categoryTableBody');
    const deptTableBody = document.getElementById('deptTableBody');

    annualTableBody.innerHTML = '';
    categoryTableBody.innerHTML = '';
    deptTableBody.innerHTML = '';

    const totalDeptAmount = deptData.reduce((sum, d) => sum + d.amount, 0);
    const totalCategoryAmount = categoryData.reduce((sum, d) => sum + d.amount, 0);

    //  연간 테이블
    for(let i = 0; i < annualData.length; i++) {
        const d = annualData[i];
        if (d.amount === 0) continue; // 0원인 달은 표시 안함

        const prevAmount = (i > 0) ? annualData[i-1].amount : 0;
        const change = getChangeRate(d.amount, prevAmount);
        const changeColor = change.includes('▲') ? 'text-red-600' : (change.includes('▼') ? 'text-blue-600' : 'text-gray-600');
        
        const row = `
            <tr class="hover:bg-gray-50">
                <td class="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-900">${d.year}</td>
                <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-600 text-right">${formatCurrency(d.amount)}</td>
                <td class="px-4 py-3 whitespace-nowrap text-sm ${changeColor} text-right">${change}</td>
            </tr>
        `;
        annualTableBody.innerHTML += row;
    }


    //  카테고리별 테이블
    categoryData.forEach(d => {
        const row = `
            <tr class="hover:bg-gray-50">
                <td class="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-900">${d.categoryName}</td>
                <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-600 text-right">${formatCurrency(d.amount)}</td>
                <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-600 text-right">${getPercentage(d.amount, totalCategoryAmount)}</td>
            </tr>
        `;
        categoryTableBody.innerHTML += row;
    });
    
    // 부서별 테이블
    deptData.forEach(d => {
        const row = `
            <tr class="hover:bg-gray-50">
                <td class="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-900">${d.dept}</td>
                <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-600 text-right">${formatCurrency(d.amount)}</td>
                <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-600 text-right">${getPercentage(d.amount, totalDeptAmount)}</td>
            </tr>
        `;
        deptTableBody.innerHTML += row;
    });
}

// --- PDF 내보내기 ---
async function exportPDF() {
    const { jsPDF } = window.jspdf;
    const reportContent = document.getElementById('report-content');
    const loader = document.getElementById('loader');
    
    loader.style.display = 'flex'; // 로더 표시

    try {
        // html2canvas로 #report-content 요소를 캡처
        const canvas = await html2canvas(reportContent, {
            scale: 2, // 해상도 2배로 높여 품질 개선
            useCORS: true,
            logging: false
        });
        
        const imgData = canvas.toDataURL('image/png');
        
        const pdf = new jsPDF('p', 'mm', 'a4'); // A4 용지 (세로)
        const pdfWidth = pdf.internal.pageSize.getWidth();
        const pdfHeight = pdf.internal.pageSize.getHeight();
        
        const imgProps = pdf.getImageProperties(imgData);
        const imgWidth = imgProps.width;
        const imgHeight = imgProps.height;
        
        // 이미지 비율을 유지하면서 A4 너비에 맞춤
        const ratio = imgHeight / imgWidth;
        const reportHeight = pdfWidth * ratio;

        // 이미지가 A4 높이보다 클 경우 여러 페이지로 나누기
        let heightLeft = reportHeight;
        let position = 0;

        pdf.addImage(imgData, 'PNG', 0, position, pdfWidth, reportHeight);
        heightLeft -= pdfHeight;

        while (heightLeft > 0) {
            position = heightLeft - reportHeight;
            pdf.addPage();
            pdf.addImage(imgData, 'PNG', 0, position, pdfWidth, reportHeight);
            heightLeft -= pdfHeight;
        }

        pdf.save('구매_리포트.pdf'); // PDF 파일 저장

    } catch (error) {
        console.error("PDF 생성 중 오류 발생:", error);
        alert("PDF 생성 중 오류가 발생했습니다.");
    } finally {
        loader.style.display = 'none'; // 로더 숨기기
    }
}

// --- 초기화 ---
document.addEventListener('DOMContentLoaded', () => {
    //renderCharts();
    //renderTables();

    // PDF 내보내기 버튼 이벤트 리스너
    document.getElementById('export-pdf-btn').addEventListener('click', exportPDF);
});
