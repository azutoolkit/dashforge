$(document).ready(function(){
  var url = new URL(location.href);
  
  url.protocol = url.protocol.replace('http', 'ws');
  url.pathname = '/charts-data';

  var ws = new WebSocket(url);

  function addData(chart, data) {
    chart.data.datasets = data;
    chart.update({
      easing: 'easeOutBounce'
    });
  }

  ws.addEventListener('message', event => {
    var data = event.data;
    var { data } = JSON.parse(data);
    addData(window.processingChart, data);
  });
});