$(function(){
  'use strict'

   // Activity Chars - Tracks Total, busy, and failed jobs
   var ctxLabel = ['6am', '10am', '1pm', '4pm', '7pm', '10pm'];
   var ctxData1 = [20, 60, 50, 45, 50, 60];
   var ctxData2 = [10, 40, 30, 40, 55, 25];
   var ctxColor1 = '#65e0e0';
   var ctxColor2 = '#69b2f8'

   var ctx5 = document.getElementById('running-jobs');
   new Chart(ctx5, {
     type: 'line',
     data: {
       labels: ctxLabel,
       datasets: [{
         data: ctxData1,
         borderColor: ctxColor1,
         borderWidth: 1,
         backgroundColor: 'rgba(0,23,55, .5)'
       },{
         data: ctxData2,
         borderColor: ctxColor2,
         borderWidth: 1,
         backgroundColor: 'rgba(28,225,172, .5)'
       }]
     },
     options: {
       maintainAspectRatio: false,
       legend: {
         display: false,
           labels: {
             display: false
           }
       },
       scales: {
         yAxes: [{
           stacked: true,
           gridLines: {
             color: '#e5e9f2'
           },
           ticks: {
             beginAtZero:true,
             fontSize: 10
           }
         }],
         xAxes: [{
           stacked: true,
           gridLines: {
             display: false
           },
           ticks: {
             beginAtZero:true,
             fontSize: 11
           }
         }]
       }
     }
   });
 

  $.plot('#flotChart1', [{
    data: df2,
    color: '#65e0e0'
  },{
    data: df1,
    color: '#69b2f8'
  },{
    data: df3,
    color: '#0168fa',
    lines: {
      show: true,
      lineWidth: 1.5
    },
    bars: { show: true }
  }], {
    series: {
      shadowSize: 0,
      bars: {
        show: true,
        lineWidth: 0,
        barWidth: .5,
        fill: 1
      }
    },
    grid: {
      color: '#c0ccda',
      borderWidth: 0,
      labelMargin: 10
    },
    yaxis: {
      show: true,
      max: 90,
      tickSize: 15
    },
    xaxis: {
      color: 'transparent',
      show: true,
      max: 37,
      ticks: [[0,'Mar 10'],[5,'Mar 11'],[10,'Mar 12'],[15,'Mar 13'],[20,'Mar 14'],[25,'Mar 15'],[30,'Mar 16'],[35,'Mar 17']]
    }
  });

  // Donut chart
  $('.peity-donut').peity('donut');


  $.plot('#flotChart2', [{
    data: df3,
    color: '#0168fa',
    curvedLines: { apply: true }
  }], {
    series: {
      shadowSize: 0,
      lines: {
        show: true,
        lineWidth: 1.5,
        fill: .05
      }
    },
    grid: {
      borderWidth: 0,
      labelMargin: 0
    },
    yaxis: {
      show: false,
      max: 55
    },
    xaxis: {
      show: true,
      color: 'rgba(131,146,165,.08)',
      min: 48,
      max: 102,
      tickSize: 5
    }
  });

  // Horizontal bar chart
  var ctx2 = document.getElementById('chartBar2').getContext('2d');
  var chartBar = new Chart(ctx2, {
    type: 'horizontalBar',
    data: {
      labels: ['Modification', 'Code Request', 'Feature Request', 'Bug Fix', 'Integration', 'Production'],
      datasets: [{
        data: [90, 60, 50, 95, 50, 60],
        backgroundColor: ['#65e0e0', '#69b2f8','#6fd39b','#f77eb9','#fdb16d','#c693f9']
      },{
        data: [60, 50, 70, 45, 70, 30],
        backgroundColor: '#e5e9f2'
      }]
    },
    options: {
      maintainAspectRatio: false,
      responsive: true,
      legend: {
        display: false,
        labels: {
          display: false
        }
      },
      layout: {
        padding: {
          left: 5
        }
      },
      scales: {
        yAxes: [{
          gridLines: {
            display: false
          },
          barPercentage: 0.5,
          ticks: {
            beginAtZero:true,
            fontSize: 13,
            fontColor: '#7987a1',
            fontFamily: 'IBM Plex Sans'
          }
        }],
        xAxes: [{
          gridLines: {
            color: '#182b49'
          },
          ticks: {
            beginAtZero: true,
            fontSize: 10,
            fontColor: '#7987a1',
            max: 100
          }
        }]
      }
    }
  });




  window.darkMode = function(){
    $('.btn-white').addClass('btn-dark').removeClass('btn-white');

    //console.log(chartBar.options.scales);
    chartBar.options.scales.xAxes[0].gridLines.color = 'rgba(255,255,255,.04)';
    chartBar.options.scales.xAxes[0].ticks.minor.fontColor = '#97a3b9';
    chartBar.options.scales.yAxes[0].ticks.minor.fontColor = '#97a3b9';
    chartBar.update();
  }

  window.lightMode = function() {
    $('.btn-dark').addClass('btn-white').removeClass('btn-dark');
  }

  var hasMode = Cookies.get('df-mode');
  if(hasMode === 'dark') {
    darkMode();
  } else {
    lightMode();
  }


})
