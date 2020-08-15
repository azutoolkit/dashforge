$(function () {
  'use strict'

  // Activity Chars - Tracks Total, busy, and failed jobs
  var ctxLabel = ['6am', '10am', '1pm', '4pm', '7pm', '10pm'];
  var ctxData1 = [20, 60, 50, 45, 50, 60];
  var ctxData2 = [10, 40, 30, 40, 55, 25];
  var ctxColor1 = '#65e0e0';
  var ctxColor2 = '#69b2f8'

  var ctx5 = document.getElementById('running-jobs');
  var data = $("#running-jobs").data("chart")["data"]

  new Chart(ctx5, {
    type: 'bar',
    data: {
      labels: data[0].label,
      datasets: [{
        label: data[0].name,
        data: data[0].data,
      }, {
        label: data[1].name,
        data: data[1].data,
      }, {
        label: data[2].name,
        data: data[2].data,
      }]
    },
    options: {
      plugins: {
        colorschemes: {
          scheme: 'tableau.Tableau20'
        }
      },
      responsive: true,
      maintainAspectRatio: false,
      legend: {
        display: true,
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
            beginAtZero: true,
            fontSize: 10
          }
        }],
          xAxes: [{
            stacked: true,
          gridLines: {
            display: false
          },
          type: 'time',
          bounds: 'data',
          distribution: 'series',
          time: {
            unit: 'second',
            displayFormats: {
              quarter: 'MMM YYYY'
            }
          },
          ticks: {
            display: false,
            source: 'labels',
            maxTicksLimit: 3,
            beginAtZero: false,
            fontSize: 11
          }
        }]
      }
    }
  });


  $.plot('#flotChart1', [{
    data: df2,
    color: '#65e0e0'
  }, {
    data: df1,
    color: '#69b2f8'
  }, {
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
      ticks: [[0, 'Mar 10'], [5, 'Mar 11'], [10, 'Mar 12'], [15, 'Mar 13'], [20, 'Mar 14'], [25, 'Mar 15'], [30, 'Mar 16'], [35, 'Mar 17']]
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

  window.darkMode = function () {
    $('.btn-white').addClass('btn-dark').removeClass('btn-white');

    //console.log(chartBar.options.scales);
    chartBar.options.scales.xAxes[0].gridLines.color = 'rgba(255,255,255,.04)';
    chartBar.options.scales.xAxes[0].ticks.minor.fontColor = '#97a3b9';
    chartBar.options.scales.yAxes[0].ticks.minor.fontColor = '#97a3b9';
    chartBar.update();
  }

  window.lightMode = function () {
    $('.btn-dark').addClass('btn-white').removeClass('btn-dark');
  }

  var hasMode = Cookies.get('df-mode');
  if (hasMode === 'dark') {
    darkMode();
  } else {
    lightMode();
  }


})
