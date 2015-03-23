xquery version "3.0";

import module namespace http = "http://expath.org/ns/http-client";

declare namespace wb = "http://www.worldbank.org";

let $url := "http://api.worldbank.org/countries/USA/indicators/AG.PRD.CREL.MT?per_page=100&amp;date=1961:2013"
let $raw-data := http:send-request(<http:request href="{$url}" method="get"/>)/wb:data
let $data :=
  for $value in $raw-data/wb:data
  where $value/wb:value
  order by $value/wb:date
  return fn:concat("[ new Date(", $value/wb:date/text(), ", 0, 1), ", $value/wb:value/text(), "],")
let $json-data := (
  $data[position() = (1 to last()-1)], 
  fn:replace($data[last()], ",$", "")
  )
return 
    <html>
        <head>
        <!--Load the AJAX API-->
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
          // Instantiate array of arrays 
          var json_data = [ { $json-data } ];
        <![CDATA[
          // Load the Visualization API and the piechart package.
          google.load('visualization', '1.0', {'packages':['corechart']});
    
          // Set a callback to run when the Google Visualization API is loaded.
          google.setOnLoadCallback(drawChart);
    
          // Callback that creates and populates a data table,
          // instantiates the pie chart, passes in the data and
          // draws it.
          function drawChart() {
              
            // Create the data table.
            var data = new google.visualization.DataTable();
            data.addColumn('date', 'Year');
            data.addColumn('number', 'Metric Tons');
            data.addRows(json_data);
            // Set chart options
            var options = {title: 'Cereal Production in the United States',
                           width: 1200,
                           height: 800,
                           trendlines: { 0: {
                                labelInLegend: 'Annual Production',
                                visibleInLegend: true,
                           } }  
            };
    
            // Instantiate and draw our chart, passing in some options.
            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
            chart.draw(data, options);
          } ]]>
        </script>
      </head>
      <body>
        <!--Div that will hold the pie chart-->
        <div id="chart_div"></div>
      </body>
    </html>