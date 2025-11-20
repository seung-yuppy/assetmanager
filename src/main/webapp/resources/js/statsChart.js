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
    const purpose = document.getElementById("report-purpose");

    // 마진 설정 (단위: mm)
    const MARGIN = 15; // 좌우 및 상단 마진으로 사용됩니다.
    const TOTAL_MARGIN_WIDTH = MARGIN * 2;

    loader.style.display = 'flex'; // 로더 표시
    
    // 원본 스타일 저장 및 PDF용 스타일 적용
    const originalStyle = {
        width: reportContent.style.width,
        maxWidth: reportContent.style.maxWidth,
        margin: reportContent.style.margin
    };

    reportContent.style.width = "90%";
    reportContent.style.maxWidth = "1300px";
    reportContent.style.margin = "0 auto";
    
    const allSections = reportContent.querySelectorAll('section');
    const contentBeforeThird = Array.from(allSections).slice(0, 2);
    const targetSection = allSections.length > 2 ? allSections[2] : null; // 3번째 section만 선택

    if (!targetSection) {
        console.error("세 번째 section 요소를 찾을 수 없습니다.");
        alert("PDF 생성 중 오류가 발생했습니다. 세 번째 섹션을 확인해주세요.");
        loader.style.display = 'none';
        return;
    }

    // PDF 내보내기 전에 targetSection을 임시로 숨깁니다.
    targetSection.style.display = 'none';

    // **2. textarea를 div로 잠시 대체**
    const replaced = [];
    const textAreas = reportContent.querySelectorAll('.report-comment-text');
    textAreas.forEach(textarea => {
        const div = document.createElement('div');
        div.textContent = textarea.value;

        const style = window.getComputedStyle(textarea);
        div.style.display = 'block';
        div.style.whiteSpace = 'pre-wrap';
        div.style.wordBreak = 'break-word';
        div.style.minHeight = textarea.scrollHeight + 'px';
        div.style.padding = style.padding;
        div.style.font = style.font;
        div.style.color = style.color;
        div.style.background = style.background;
        div.style.width = style.width;

        textarea.parentNode.insertBefore(div, textarea);
        textarea.style.display = 'none';

        replaced.push({ textarea, div });
    });
    
    // 보고 목적 border 숨기기
    purpose.classList.remove("border");
    
    // **3. 출력 안 할 요소 제외 및 grid 클래스 변경**
    const pageELs = reportContent.querySelectorAll('.no-pdf');
    pageELs.forEach(el => {
        el.style.display = 'none';
    });
    
    const gridDivsToChange = [];
    contentBeforeThird.forEach(section => {
        section.querySelectorAll('div.grid').forEach(gridDiv => {
            gridDiv.classList.remove('lg:grid-cols-5');
            gridDiv.classList.add('lg:grid-cols-1');
            gridDivsToChange.push(gridDiv);
        });
    });
    
    try {
        const pdf = new jsPDF('p', 'mm', 'a4');
        const pdfWidth = pdf.internal.pageSize.getWidth();
        const pdfHeight = pdf.internal.pageSize.getHeight();
        const contentWidth = pdfWidth - TOTAL_MARGIN_WIDTH;

        // --- 1단계: 세 번째 섹션 이전의 모든 내용 캡처 및 추가 ---
        
        let canvas = await html2canvas(reportContent, {
            scale: 2,
            useCORS: true,
            logging: false
        });

        let imgData = canvas.toDataURL('image/png');
        let imgProps = pdf.getImageProperties(imgData);
        let imgWidth = imgProps.width;
        let imgHeight = imgProps.height;
        let ratio = imgHeight / imgWidth;
        let reportHeight = contentWidth * ratio; 
        
        let heightLeft = reportHeight;
        let position = MARGIN; // **첫 페이지 Y 시작 위치를 MARGIN으로 설정**

        // 첫 페이지 이미지 추가 (Y 시작 위치: MARGIN)
        pdf.addImage(imgData, 'PNG', MARGIN, position, contentWidth, reportHeight);
        
        // 첫 페이지에서 이미지 출력에 사용된 높이 (상단 MARGIN + 콘텐츠) 만큼 차감
        heightLeft -= (pdfHeight - MARGIN); 
        position -= reportHeight; // 다음 페이지에서 시작할 이미지의 Y 위치 계산

        while (heightLeft > 0) {
            // 다음 페이지는 MARGIN 없이 콘텐츠 상단이 PDF 페이지 상단에 맞닿도록 Y 위치 조정
            pdf.addPage();
            // position은 음수입니다. 이 값이 커질수록 이미지가 위로 당겨져서 나타납니다.
            pdf.addImage(imgData, 'PNG', MARGIN, position, contentWidth, reportHeight);
            heightLeft -= pdfHeight;
            position -= pdfHeight;
        }
        
        // --- 2단계: 세 번째 섹션만 캡처 및 새로운 페이지에 추가 ---
        
        // 타겟 섹션만 보이게 하고 캡처
        targetSection.style.display = '';
        contentBeforeThird.forEach(section => section.style.display = 'none');
        
        // 세 번째 섹션에만 적용할 grid 클래스 변경
        const targetGridDivs = targetSection.querySelectorAll('div.grid');
        targetGridDivs.forEach(gridDiv => {
            gridDiv.classList.remove('lg:grid-cols-5');
            gridDiv.classList.add('lg:grid-cols-1');
        });

        canvas = await html2canvas(targetSection, {
            scale: 2,
            useCORS: true,
            logging: false
        });

        imgData = canvas.toDataURL('image/png');
        imgProps = pdf.getImageProperties(imgData);
        imgWidth = imgProps.width;
        imgHeight = imgProps.height;
        ratio = imgHeight / imgWidth;
        reportHeight = contentWidth * ratio;

        pdf.addPage(); // **새로운 페이지 추가**

        // 새로운 페이지에 세 번째 섹션 이미지 추가
        position = MARGIN; // **새 페이지 Y 시작 위치를 MARGIN으로 설정**
        heightLeft = reportHeight;
        
        // 첫 페이지 (세 번째 섹션의) 이미지 추가
        pdf.addImage(imgData, 'PNG', MARGIN, position, contentWidth, reportHeight);
        
        // 첫 페이지에서 이미지 출력에 사용된 높이 (상단 MARGIN + 콘텐츠) 만큼 차감
        heightLeft -= (pdfHeight - MARGIN);
        position -= reportHeight;

        while (heightLeft > 0) {
            // 다음 페이지는 MARGIN 없이 콘텐츠 상단이 PDF 페이지 상단에 맞닿도록 Y 위치 조정
            pdf.addPage();
            pdf.addImage(imgData, 'PNG', MARGIN, position, contentWidth, reportHeight);
            heightLeft -= pdfHeight;
            position -= pdfHeight;
        }

        pdf.save('구매_리포트.pdf');

    } catch (error) {
        console.error("PDF 생성 중 오류 발생:", error);
        alert("PDF 생성 중 오류가 발생했습니다.");
    } finally {
        loader.style.display = 'none';
        
        // --- 모든 요소 원상 복구 ---
        
        // 1. reportContent 스타일 복구
        reportContent.style.width = originalStyle.width;
        reportContent.style.maxWidth = originalStyle.maxWidth;
        reportContent.style.margin = originalStyle.margin;
        
        // 2. 섹션 display 복구
        contentBeforeThird.forEach(section => section.style.display = '');
        targetSection.style.display = '';
        
        // 3. grid div 원상 복구 (첫 번째 부분)
        gridDivsToChange.forEach(gridDiv => {
            gridDiv.classList.remove('lg:grid-cols-1');
            gridDiv.classList.add('lg:grid-cols-5');
        });
        
        // 4. grid div 원상 복구 (세 번째 섹션)
        targetSection.querySelectorAll('div.grid').forEach(gridDiv => {
            gridDiv.classList.remove('lg:grid-cols-1');
            gridDiv.classList.add('lg:grid-cols-5');
        });
        
        // 5. .no-pdf 요소들 복구
        pageELs.forEach(el => {
            el.style.display = '';
        });
        
        // 6. textarea 복구
        replaced.forEach(({ textarea, div }) => {
            div.remove();
            if (textarea.value.trim() !== "") {
                textarea.style.display = 'block';
            } else {
                textarea.style.display = '';
            }
        });
        
        purpose.classList.add("border");

    }
}