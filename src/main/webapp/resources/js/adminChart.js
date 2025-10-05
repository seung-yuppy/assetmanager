/**
 * 
 */
	    function getColor(name) {
	        // :root 요소에서 CSS 변수 값을 가져옵니다.
	        return getComputedStyle(document.documentElement).getPropertyValue(name).trim();
	    }
	
        // Chart.js 렌더링 함수
        function renderCharts() {
            // 1. 부서별 자산 현황 (막대 차트)
            const departmentCtx = document.getElementById('departmentChart');

            const departmentData = {
                labels: ['경영', '마케팅', '개발팀', 'HR', '영업'],
                datasets: [{
                    label: '자산 개수 합계 (개)',
                    data: [30, 40, 67, 21, 14],
                    backgroundColor: [
                    	getColor('--primary-color'),
                    	getColor('--primary-color'),
                    	getColor('--primary-color'),
                    	getColor('--primary-color'),
                    	getColor('--primary-color')
                    ],
                    borderColor: getColor('--primary-color'),
                    borderRadius: 4,
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

            const inventoryData = {
                labels: ['사용 가능 재고', '사용 중인 재고', '불용 처리 재고'],
                datasets: [{
                    data: [65, 20, 15], // 백분율 데이터
                    backgroundColor: [
                        getColor('--green-color'),
                        getColor('--blue-color'),  
                        getColor('--red-color')   
                    ],
                    hoverOffset: 4,
                    borderWidth: 0,
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
                        tooltip: {
                             callbacks: {
                                label: function(context) {
                                    return context.label + ': ' + context.formattedValue + '%';
                                }
                            }
                        }
                    }
                },
                // 중앙 텍스트 표시 플러그인 (Total 100% 표시)
                plugins: [{
                    id: 'centerText',
                    beforeDraw: function(chart) {
                        const { width, height, ctx } = chart;
                        ctx.restore();
                        const fontSize = '130px';
                        ctx.textBaseline = 'middle';
                        ctx.fillStyle = 'var(--dark-color)';
                        ctx.fontWeight = '700';
                        
                        const text = '100%';
                        const textX = Math.round((width - ctx.measureText(text).width) / 2);
                        const textY = height / 2;

                        ctx.fillText(text, textX, textY);
                        ctx.save();
                    }
                }]
            });
        }
        
        // 페이지 로드 시 차트 렌더링
        window.onload = renderCharts;