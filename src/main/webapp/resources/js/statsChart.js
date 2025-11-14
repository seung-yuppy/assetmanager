// --- 초기화 ---
document.addEventListener('DOMContentLoaded', () => {
	// 코멘트 추가 버튼 이벤트 추가
	document.querySelectorAll('.report-comment').forEach(btn => {
		btn.addEventListener('click', function(e) {
			const commentText = e.target.closest('.comment-area').querySelector('.report-comment-text');
			const chartDiv = document.querySelector('#annualLineChart').closest('div'); // 차트 div 가져오기
			// 현재 보이는 상태인지 확인
			const isVisible = getComputedStyle(commentText).display !== 'none';
			// 토글
			commentText.style.display = isVisible ? 'none' : 'block';
		});
	});
	// PDF 내보내기 버튼 이벤트 리스너
	document.getElementById('export-pdf-btn').addEventListener('click', exportPDF);
	getData();
});

let annualChart, categoryChart, deptChart; // 전역 변수로 차트 인스턴스 저장

// 차트 데이터 변수
let annualData, categoryData,deptData;

async function getData(){
	const params = new URLSearchParams(window.location.search);
	const yearParam = params.get("year");
	const year = yearParam ? `?year=${yearParam}` : "";
	
	const res1 = await fetch(`/assetmanager/admin/stats/total${year}`);
	const data1 = await res1.json();
	annualData = data1;
	
	const res2 = await fetch(`/assetmanager/admin/stats/category${year}`);
	const data2 = await res2.json();
	categoryData = data2;
	
	const res3 = await fetch(`/assetmanager/admin/stats/dept${year}`);
	const data3 = await res3.json();
	deptData = data3;
	
	renderCharts();
	renderTables();
}

// --- 헬퍼 함수 ---
// 통화 형식 (예: 123,456,789 원)
function formatCurrency(amount) {
    return new Intl.NumberFormat('ko-KR').format(amount);
}

// 백분율 계산
function getPercentage(part, total) {
    return total > 0 ? ((part / total) * 100).toFixed(1) : '0';
}

// 증감률 계산
function getChangeRate(current, previous) {
    if (previous === 0) return current > 0 ? ' - ' : '0.0 %';
    const rate = ((current - previous) / previous) * 100;
    const sign = rate > 0 ? '▲' : (rate < 0 ? '▼' : '');
    return `${sign} ${Math.abs(rate).toFixed(1)} %`;
}

// --- 차트 렌더링 ---
function renderCharts() {
    if (annualChart) annualChart.destroy();
    if (categoryChart) categoryChart.destroy();
    if (deptChart) deptChart.destroy();
	
	// 전체 구매 금액 (꺾은선 차트)
    const annualCtx = document.getElementById('annualLineChart').getContext('2d');
    
    //빈 데이터 처리
    const noDataPlugin = {
	    id: 'noData',
	    afterDraw: (chart) => {
	        const dataset = chart.data.datasets[0];
	        const hasData = dataset && dataset.data.some(value => value !== null && value !== 0);

	        if (!hasData) {
	            const { ctx, chartArea } = chart;
	            ctx.save();
	            ctx.textAlign = 'center';
	            ctx.textBaseline = 'middle';
	            ctx.font = '16px Arial';
	            ctx.fillStyle = '#999';
	            ctx.fillText('데이터가 없습니다.', chartArea.left + chartArea.width / 2, chartArea.top + chartArea.height / 2);
	            ctx.restore();
	        }
	    }
	};
    //금액 단위 처리
    const unitPlugin = {
    	    id: 'unitLabel',
    	    beforeDraw: (chart) => {
    	        const ctx = chart.ctx;
    	        ctx.save();
    	        ctx.font = '14px Arial';
    	        ctx.fillStyle = '#999';
    	        ctx.textAlign = 'right';
    	        ctx.fillText('단위: 백만 원', chart.chartArea.left + 40, chart.chartArea.bottom + 50);
    	        ctx.restore();
    	    }
    	};
    // 연간 구매 차트
	annualChart = new Chart(annualCtx, {
	    type: 'line',
	    data: {
	        labels: annualData.map(d => d.year),
	        datasets: [{
	            label: '연간 구매 금액',
	            data: annualData.map(d => d.amount > 0 ? d.amount : null), // 0인 데이터 제외
	            fill: false,
	            backgroundColor: 'rgba(255, 80, 80, 0.2)',
	            borderColor: 'rgba(255, 80, 80, 1)',
	            tension: 0.1
	        }]
	    },
	    options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        plugins: {
	            legend: { display: false }
	        },
			layout: {
		        padding: {
		            top: 30,   // 상단 여백
		            bottom: 30,
		            left: 10,
		            right: 10
		        }
		    },
	        scales: {
	            y: {
	                beginAtZero: true,
	                ticks: {
	                    callback: function(value) {
	                    	if(value > 1){
	                    		return (value / 1000000);
	                    	}else{
	                    		return value;
	                    	}
	                    }
	                }
	            }
	        }
	    },
	    plugins: [noDataPlugin, unitPlugin] // 여기서 플러그인 등록
	});
    // 카테고리별 구매 총액 (도넛 차트)
    const categoryCtx = document.getElementById('categoryDonutChart').getContext('2d');
	categoryChart = new Chart(categoryCtx, {
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
		},
		plugins: [noDataPlugin] // 여기서 플러그인 등록
	});
	
    // 부서별 구매 금액 (막대 차트)
    const deptCtx = document.getElementById('deptBarChart').getContext('2d');
	deptChart = new Chart(deptCtx, {
		type: 'bar',
		data: {
			labels: deptData.map(d => d.deptName),
			datasets: [{
				label: '구매 금액',
				data: deptData.map(d => d.amount),
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
					borderColor: [
						'rgba(255, 99, 132, 1)',   // red
						'rgba(54, 162, 235, 1)',   // blue
						'rgba(255, 206, 86, 1)',   // yellow
						'rgba(75, 192, 192, 1)',   // teal
						'rgba(153, 102, 255, 1)',  // purple
						'rgba(255, 159, 64, 1)',   // orange
						'rgba(255, 99, 71, 1)',    // tomato-ish red
						'rgba(100, 181, 246, 1)',  // light blue
						'rgba(144, 238, 144, 1)'   // light green
						],
						borderWidth: 1,
						maxBarThickness: 60
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			plugins: {
				legend: { display: false }
			},
			layout: {
		        padding: {
		            top: 30,   // 상단 여백
		            bottom: 30,
		            left: 10,
		            right: 10
		        }
		    },
			scales: {
				y: {
					beginAtZero: true,
					ticks: {
						callback: function(value) {
	                    	if(value > 1){
	                    		return (value / 1000000);
	                    	}else{
	                    		return value;
	                    	}
						}
					}
				}
			}
		},
		plugins: [noDataPlugin, unitPlugin] // 여기서 플러그인 등록
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

    // 연간 테이블
    if(annualData.length > 0){
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
    }else{
    	annualTableBody.innerHTML += '<td colspan="3" style="text-align: center; padding: 20px; color: gray;">데이터가 없습니다.</td>';
    }

    // 카테고리별 테이블
    if(categoryData.length > 0){
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
    }else{
    	categoryTableBody.innerHTML += '<td colspan="3" style="text-align: center; padding: 20px; color: gray;">데이터가 없습니다.</td>';
    }

    // 부서별 테이블
    if(deptData.length > 0){
        deptData.forEach(d => {
            const row = `
                <tr class="hover:bg-gray-50">
                    <td class="px-4 py-3 whitespace-nowrap text-sm font-medium text-gray-900">${d.deptName}</td>
                    <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-600 text-right">${formatCurrency(d.amount)}</td>
                    <td class="px-4 py-3 whitespace-nowrap text-sm text-gray-600 text-right">${getPercentage(d.amount, totalDeptAmount)}</td>
                </tr>
            `;
            deptTableBody.innerHTML += row;
        });
    }else{
    	deptTableBody.innerHTML += '<td colspan="3" style="text-align: center; padding: 20px; color: gray;">데이터가 없습니다.</td>';
    }
    
}

//--- PDF 내보내기 ---
async function exportPDF() {
    const { jsPDF } = window.jspdf;
    const reportContent = document.getElementById('report-content');
    const loader = document.getElementById('loader');
    
    // 마진 설정 (단위: mm)
    const MARGIN = 20;
    const TOTAL_MARGIN_WIDTH = MARGIN * 2; // 좌우 마진 합계 (20mm + 20mm = 40mm)
    
    loader.style.display = 'flex'; // 로더 표시
    
    //pdf화를 위한 추가설명 textarea의 스타일 제거
    const textAreas = document.querySelectorAll('.report-comment-text');
    textAreas.forEach(textarea =>{
    	textarea.classList.remove('border','focus:ring-2','shadow-sm');
    });
    
    // 출력 안할 요소 제외
    const pageELs = document.querySelectorAll('.no-pdf')
    pageELs.forEach(el => {
		el.style.display = 'none';
	})
	
	// grid div 선택
	const gridDivs = document.querySelectorAll('section > div.grid');
    gridDivs.forEach(gridDiv => {
    	gridDiv.classList.remove('lg:grid-cols-5');
    	gridDiv.classList.add('lg:grid-cols-1');
    });

    try {
        // html2canvas로 #report-content 요소를 캡처
        const canvas = await html2canvas(reportContent, {
            scale: 2, // 해상도 2배로 높여 품질 개선
            useCORS: true,
            logging: false
        });
        
        const imgData = canvas.toDataURL('image/png');
        
        const pdf = new jsPDF('p', 'mm', 'a4'); // A4 용지 (세로)
        const pdfWidth = pdf.internal.pageSize.getWidth(); // A4 너비 (약 210mm)
        const pdfHeight = pdf.internal.pageSize.getHeight(); // A4 높이 (약 297mm)
        
        // **마진이 적용된 이미지 출력 너비 계산**
        const contentWidth = pdfWidth - TOTAL_MARGIN_WIDTH; // 210mm - 40mm = 170mm
        
        const imgProps = pdf.getImageProperties(imgData);
        const imgWidth = imgProps.width;
        const imgHeight = imgProps.height;
        
        // 이미지 비율을 유지하면서 'contentWidth'에 맞게 높이 계산
        const ratio = imgHeight / imgWidth;
        const reportHeight = contentWidth * ratio; // 마진이 적용된 너비에 대한 이미지 높이
        
        // 이미지가 A4 높이보다 클 경우 여러 페이지로 나누기
        let heightLeft = reportHeight;
        let position = 0; // 이미지의 Y 위치 (페이지를 넘길 때 조정됨)

        // **첫 페이지 이미지 추가: x 시작 위치는 MARGIN(20mm)으로, 너비는 contentWidth로 설정**
        pdf.addImage(imgData, 'PNG', MARGIN, position, contentWidth, reportHeight);
        heightLeft -= pdfHeight;

        while (heightLeft > 0) {
            position = heightLeft - reportHeight; // 다음 페이지에서 시작할 Y 위치
            pdf.addPage();
            // **추가 페이지 이미지 추가: x 시작 위치는 MARGIN(20mm)으로 유지**
            pdf.addImage(imgData, 'PNG', MARGIN, position, contentWidth, reportHeight);
            heightLeft -= pdfHeight;
        }

        pdf.save('구매_리포트.pdf'); // PDF 파일 저장

    } catch (error) {
        console.error("PDF 생성 중 오류 발생:", error);
        alert("PDF 생성 중 오류가 발생했습니다.");
    } finally {
        loader.style.display = 'none'; // 로더 숨기기
        // pdf 생성을 위해 숨겼던 요소들 복구
        pageELs.forEach(el => {
    		el.style.display = 'inline-block';
    	})
    	
    	textAreas.forEach(textarea =>{
    		textarea.classList.add('border','focus:ring-2','shadow-sm');
    	});
    	
    	gridDivs.forEach(gridDiv => {
	    	gridDiv.classList.remove('lg:grid-cols-1');
	    	gridDiv.classList.add('lg:grid-cols-5');
	    });
    	
    }
}