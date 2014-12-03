#XQuery Summer Institute

##Thanksgiving Practice Exercise

Among other things, XQuery is a fantastic language for connecting different sources of data on the Internet. If you find a web service with an XML endpoint, you can write an XQuery expression to extract data and present it as a nicely-formated webpage. 

As I celebrated the Thanksiving holiday last week, I began wondering whether our agricultural production in the United States is trending upward or downward. So I decided to write an expression to query the [World Bank](http://data.worldbank.org/) to chart the annual cereal production in the United States. The following exercise demonstrates how to use XQuery to gather data from the [World Bank's API](http://data.worldbank.org/node/9) and to render that data using [Google Charts](https://developers.google.com/chart/). 

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

How do you go about querying this API with XQuery? The [XQuery Recommendation](http://www.w3.org/TR/xquery-30/) does not define how to send an HTTP request. Such matters are deemed implementation-dependent. In other words, every XQuery processor is free to define its own functions for making HTTP requests. In the past few years, a community of XQuery developers has formed [ExPath.org](http://expath.org/) to develop shared standards for commonly-implemented functionality. Among these is a standard for [making HTTP requests](http://expath.org/modules/http-client/). 
