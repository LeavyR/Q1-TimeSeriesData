﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="netWeb.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="style.css" type="text/css">
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="js/pubAjax.js" type="text/javascript"></script>
    <script src="amcharts/amcharts.js" type="text/javascript"></script>
    <script src="amcharts/serial.js" type="text/javascript"></script>
    <script type="text/javascript">

        var chart;

        var chartData = [];

        AmCharts.ready(function () {
            // first we generate some random data
            //generateChartData();
            LoadData();

            // SERIAL CHART
            chart = new AmCharts.AmSerialChart();
            chart.pathToImages = "../amcharts/images/";
            chart.dataProvider = chartData;
            chart.categoryField = "time";

            // data updated event will be fired when chart is first displayed,
            // also when data will be updated. We'll use it to set some
            // initial zoom
            chart.addListener("dataUpdated", zoomChart);

            // AXES
            // Category
            var categoryAxis = chart.categoryAxis;
            categoryAxis.parseDates = true; // in order char to understand dates, we should set parseDates to true
            categoryAxis.minPeriod = "mm"; // as we have data with minute interval, we have to set "mm" here.			 
            categoryAxis.gridAlpha = 0.07;
            categoryAxis.axisColor = "#DADADA";

            // Value
            var valueAxis = new AmCharts.ValueAxis();
            valueAxis.gridAlpha = 0.07;
            valueAxis.title = "Unique visitors";
            chart.addValueAxis(valueAxis);

            // GRAPH
            var graph = new AmCharts.AmGraph();
            graph.type = "line"; // try to change it to "column"
            graph.title = "red line";
            graph.valueField = "values";
            graph.lineAlpha = 1;
            graph.lineColor = "#d1cf2a";
            graph.fillAlphas = 0.3; // setting fillAlphas to > 0 value makes it area graph
            chart.addGraph(graph);

            // CURSOR
            var chartCursor = new AmCharts.ChartCursor();
            chartCursor.cursorPosition = "mouse";
           // chartCursor.categoryBalloonDateFormat = "JJ:NN, DD MMMM";
            chart.addChartCursor(chartCursor);

            // SCROLLBAR
            var chartScrollbar = new AmCharts.ChartScrollbar();

            chart.addChartScrollbar(chartScrollbar);

            // WRITE
            chart.write("chartdiv");
        });
        function LoadData() {

            var FData = {};

            function DealOK(AData) {
                // chartData = AData.myData;
                chartData = [
                 {
                     "time": "2017-08-01",
                     "values": 4025,
                     "color": "#FF0F00"
                 },
                 {
                     "time": "2017-08-02",
                     "values": 1882,
                     "color": "#FF6600"
                 },
                 {
                     "time": "2017-08-03",
                     "values": 1809,
                     "color": "#FF9E01"
                 },
                 {
                     "time": "2017-08-04",
                     "values": 1322,
                     "color": "#FCD202"
                 }
                ];
            }
            var objRet = FBaseJSonDeal(FData, DealOK);
        }

        // generate some random data, quite different range 
        function generateChartData() {
            // current date
            var firstDate = new Date();
            // now set 1000 minutes back                 
            firstDate.setMinutes(firstDate.getDate() - 1000);

            // and generate 1000 data items
            for (var i = 0; i < 1000; i++) {
                var newDate = new Date(firstDate);
                // each time we add one minute
                newDate.setMinutes(newDate.getMinutes() + i);
                // some random number      
                var visits = Math.round(Math.random() * 40) + 10;
                // add data item to the array                          
                chartData.push({
                    date: newDate,
                    visits: visits
                });
            }
        }

        // this method is called when chart is first inited as we listen for "dataUpdated" event
        function zoomChart() {
            // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
            chart.zoomToIndexes(chartData.length - 40, chartData.length - 1);
        }
        </script>
</head>

<body>
    <div id="chartdiv" style="width: 100%; height: 400px;"></div>
</body>

</html>
