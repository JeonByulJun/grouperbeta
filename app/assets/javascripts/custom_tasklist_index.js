
function first(labelString, dataString, dataString2){
	var barChartData = {
		labels : labelString,
		datasets : [
			{
        label: "Given",
				fillColor : "rgba(220,220,220,0.5)",
				strokeColor : "rgba(220,220,220,0.8)",
				highlightFill: "rgba(220,220,220,0.75)",
				highlightStroke: "rgba(220,220,220,1)",
				data : dataString
			},
      {
        label: "Done",
        fillColor : "rgba(75,192,192,0.5)",
        strokeColor : "rgba(75,192,192,0.8)",
        highlightFill: "rgba(75,192,192,0.75)",
        highlightStroke: "rgba(75,192,192,1)",
        data : dataString2
      }
		]
	};
	return barChartData;
};

function onld(lineChartData){
    $(document).ready(function(){
  		var ctx = document.getElementById("canvas").getContext("2d");
    	var chart = new Chart(ctx).Line(lineChartData, {
        scaleBeginAtZero: true,
  			responsive: false,
  			scaleFontSize: 17,
  			tooltipEvents: ["mousemove", "touchstart", "touchmove"]
  		});
		});
};