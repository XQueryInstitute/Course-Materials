#XQuery Summer Institute

##December Practice Exercise

Among other things, XQuery is a fantastic language for connecting different sources of data on the Internet. If you find a web service with an XML endpoint, you can write an XQuery expression to extract data and present it as a nicely-formated webpage.

###The Problem

As I celebrated the Thanksiving holiday last month, I began wondering whether our agricultural production in the United States is trending upward or downward. So I decided to write an expression to query the [World Bank](http://data.worldbank.org/) to chart the annual cereal production in the United States. The following exercise demonstrates how to use XQuery to gather data from the [World Bank's API](http://data.worldbank.org/node/9) and to render that data using [Google Charts](https://developers.google.com/chart/). 

###Querying an API

Let's start by checking out the World Bank's API. The World Bank has a handy [query builder](http://data.worldbank.org/querybuilder) for its API, which allows you to fine tune your request. In that case, we'll build a query for the annual cereal production in the United States from 1961 to 2013. The [resulting query](http://data.worldbank.org/querybuilder) looks (in part) like this:

```xml
<wb:data xmlns:wb="http://www.worldbank.org" page="1" pages="1" per_page="100" total="55">
    <wb:data>
        <wb:indicator id="AG.PRD.CREL.MT">Cereal production (metric tons)</wb:indicator>
        <wb:country id="US">United States</wb:country>
        <wb:date>2014</wb:date>
        <wb:value/>
        <wb:decimal>0</wb:decimal>
    </wb:data>
    <wb:data>
        <wb:indicator id="AG.PRD.CREL.MT">Cereal production (metric tons)</wb:indicator>
        <wb:country id="US">United States</wb:country>
        <wb:date>2013</wb:date>
        <wb:value>436553678</wb:value>
        <wb:decimal>0</wb:decimal>
    </wb:data>
</wb:data>
```

How do you go about querying this API with XQuery? The [XQuery Recommendation](http://www.w3.org/TR/xquery-30/) does not define how to send an HTTP request. Such matters are deemed implementation-dependent. In other words, every XQuery processor is free to define its own functions for making HTTP requests. Recently, a community of XQuery developers formed [ExPath.org](http://expath.org/) to develop shared standards for commonly-implemented functionality. Among these is a specification for [making HTTP requests](http://expath.org/spec/http-client).

The HTTP Client provides a straightforward way to send a HTTP request: 

```xquery
http:send-request($request as element(http:request)?,
                  $href as xs:string?,
                  $bodies as item()*) as item()+
```

Since we're sending a GET request to the World Bank API, we only need to pass in a single parameter. This paramater is not a string or a URI, however, but a ```http:request``` element with href and method attributes. A simple GET request to our API looks like this

```xquery
import module namespace http = "http://expath.org/ns/http-client";

http:send-request(<http:request href="http://api.worldbank.org/countries/USA/indicators/AG.PRD.CREL.MT?per_page=100&amp;date=1961:2013" method="get"/>)
```

Remember when adding the URL as the value of the href attribute to change any ampersands from '&' to '&amp;' in order to avoid parsing errors. If you [try out this expression](http://try.zorba.io/queries/xquery/KNZpFFTpUW%2FI1NxeEevZBBzrino%3D), you'll find that you've connected to the World Bank API.

###Getting Data into the Right Format

So the next step is to extract the data we'll need. But what *do* we need, exactly? To answer this question, we'll need to peek ahead a little at the [Google Charts API](https://developers.google.com/chart/interactive/docs/reference). We're going to be displaying our data using a [Column Chart](https://developers.google.com/chart/interactive/docs/gallery/columnchart) so let's see how we pass information into that chart in particular. We want to pass a year to the X-axis and the harvested amount to the Y-axis. It seems we need an array that looks something like this:
```js
    [
        [1961, 163619978],
        [1962, 162455780], 
        [1963, 174812487],
        [1964, 160937079]
    ]
```

OK, that's clearly [JSON](http://www.json.org/) rather than XML. We'll need to extract the information we need from the World Bank API and then write it back out as JSON or, perhaps more more correctly, into a syntax that can be evaluated as a Javascript array. Just to complicate things a bit, we'll actually need to pass our years into a JavaScript data constructor because we want the X-Axis to be continous rather than discrete (i.e. not just discrete strings indicating years, but a continuous series of dates). The importance of having continuous variables will become apparent when we draw a trendline in a moment.

Our JSON should really look like this
```js
    [
        [ new Date(1961, 0, 1), 163619978],
        [ new Date(1962, 0, 1), 162455780],
        [ new Date(1963, 0, 1), 174812487],
        [ new Date(1964, 0, 1), 160937079]
    ]
```

Granted, [XQuery 3.1](http://www.w3.org/TR/xquery-31/) will provide an output method for [JSON serialization](http://docs.basex.org/wiki/XQuery_3.1#JSON_Serialization). Still, it's not difficult to write an XQuery 3.0 expression that evaluates to a sequence of strings with JSON-like syntax. 

```xquery
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
return $data
```
A tricky thing is to make sure that the last member of the sequence terminates without a comma. The expression above will cause problems in our JavaScript code because it leaves a dangling comma at the end of our array of arrays.

```js
[
    // ...
    [ new Date(2012, 0, 1), 356932761],
    [ new Date(2013, 0, 1), 436553678], // Bad comma
]
```

To get rid of this comma, we need to remove it from the last item in our sequence. Note how we achieve that effect below using position to filter our sequence appropriately. The regular expression ```,$``` in the ```fn:replace``` function finds any comma immediately preceeding an end of life and replaces it with an empty string, effectively eliminating our trailing comma.

```xquery
let $json-data := (
  $data[position() = (1 to last()-1)], 
  fn:replace($data[last()], ",$", "") 
  )
return $json-data
```

###Using XQuery and JavaScript together

Now we have our transformed our World Bank information from XML [into the JSON-like format required by our Google Chart](http://tryzorba.28.io/query.jq?id=3LOuzI5W8SAl1YFAvc82dQu%2FSsA%3D&format=text). Our next step will be to mix together a bit of XQuery and JavaScript.

The JavaScript for our Google Chart (gently modified from [the source code on Google's website](https://developers.google.com/chart/interactive/docs/gallery/columnchart)) looks like this:

```JavaScript
// Where's the data? We need to supply it from our XQuery expression.
var data_jason = []; // just an empty array for now

// Load the Visualization API and the piechart package.
google.load('visualization', '1.0', {
  'packages': ['corechart']
});

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
  data.addRows(json_data); // Where's the data? We need to supply it from our XQuery expression.
  // Set chart options
  var options = {
    title: 'Cereal Production in the United States',
    width: 1200,
    height: 800,
    trendlines: { 0: {
                    labelInLegend: 'Annual Production',
                    visibleInLegend: true
               } }  // We will be able to add this trendline (or regression line)  
                    // because we converted our data from discrete strings into
                    // continuous values (i.e. dates).
  };
  // Instantiate and draw our chart, passing in some options.
  var chart = new google.visualization.ColumnChart(document.getElementById(
    'chart_div'));
  chart.draw(data, options);
}
```
As our goal is not to learn JavaScript, I'll skip over most of this code (though note the comment about our trend line). The main thing is that we need to provide an array of arrays to populate our data rows. Note the statement ```var data_json = [];```. This statement defines a Javascript variable called ```data_json``` and assigns it an empty array. We need to pass in our JSON-like arrays into this statement. The trick to achieving this goal is to remember the difference between server-side and client-side processing. In this case, our XQuery executes on the server while our JavaScript executes on the client. So we can write an XQuery expression on the server to edit our JavaScript file before it's provided to the client. 

The technique is actually very simple. We just insert an XQuery expression into the relevant JavaScript variable definition. ```var json_data = [ { $json-data } ];``` In fact, that's pretty much all we need to do. Our XQuery expression above will provide the arrays the Google Chart needs to populate its rows. From the client perspective, it will just look like a plain old Javascript array of arrays.

```js
var json_data = [
  [new Date(1961, 0, 1), 163619978],
  [new Date(1962, 0, 1), 162455780],
  // ...
  [new Date(2012, 0, 1), 356932761],
  [new Date(2013, 0, 1), 436553678]
];
```

###Rendering Our Chart

Now let's package everything together. Instead of returning data from the World Bank API directly from our XQuery expression, we'll return HTML with JavaScript (including the data from our XQuery expression) in script elements. To avoid having to re-write the JavaScript to conform with XML rules (like substituting ```&amp;``` for '&' characters, we'll wrap all the JavaScript apart from our variable definition in a [CDATA](https://en.wikipedia.org/wiki/CDATA) section.

```js
<script type="text/javascript">
          // Instantiate array of arrays 
          var json_data = [ { $json-data } ];
        <![CDATA[
          //... the rest of the Javascript goes here.
        ]]>
</script>
```
That should do it! You can see the full code [here](http://try.zorba.io/queries/xquery/5LMJ3uKtjSCVZ%2FJDh0cUAgUn20Q%3D) or try it out [here](http://tryzorba.28.io/query.jq?id=5LMJ3uKtjSCVZ%2FJDh0cUAgUn20Q%3D&format=html). The result should look like this chart: ![Grain Production in the United States](http://i.imgur.com/C4ZNGfY.png)

###Summing Up

So, to review, you've learned how to use XQuery to connect with an online data source, select and transform the data into a JSON-like format, and then pass that data into a JavaScript variable to render an nice chart in a client's web browser. By using these techniques, you can create many kinds of mashups–potentially aggretating data from many sources into a unified display.

###Extra Credit

If you'd like to try something a litte more complicated, you can add another column to our chart. For instance, it would be interesting to know whether and how much the quantity of arable land has been decreasing in the United States even while our cereal output has been increasing. Here's the [API call](http://api.worldbank.org/countries/USA/indicators/AG.LND.ARBL.ZS?per_page=10&date=1961:2013) to get you started. As always, please share your results (especially if you improve my code) on Twitter with the hashtag #XQY14.
