#XQuery Summer Institute

##September Practice Exercise

A good use case for XQuery is developing word frequency lists for digital texts. Among the first poems I learned as a child was "Eldorado" by Edgar Allen Poe. I recall being struck by the repetition of the word "shadow" in the poem. Why did Poe repeat the word so many times in so few lines? While this month's XQuery exercise won't sort out the answer to that question, it will help us find out how many times he used the phrase.

Let's start with a TEI edition of the poem:

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0">
   <teiHeader>
      <fileDesc>
         <titleStmt>
            <title>Eldorado</title>
            <author>Edgar Allen Poe</author>
         </titleStmt>
         <publicationStmt>
            <p>Originally published in <title>The Flag of Our Union</title> (<date>April 21, 1849</date>)</p>
         </publicationStmt>
         <sourceDesc>
            <p>Converted from the digital text provided by The Poetry Foundation.</p>
         </sourceDesc>
      </fileDesc>
   </teiHeader>
   <text>
      <body>
         <lg type="poem">
            <head>Eldorado</head>
            <lg type="stanza" n="1">
               <l n="1">Gaily bedight,</l>
               <l n="2">A gallant knight,</l>
               <l n="3">In sunshine and in shadow,</l>
               <l n="4">Had journeyed long,</l>
               <l n="5">Singing a song,</l>
               <l n="6">In search of Eldorado.</l>
            </lg>
            <lg type="stanza" n="2">
               <l n="7">But he grew old-</l>
               <l n="8">This knight so bold-</l>
               <l n="9">And o'er his heart a shadow-</l>
               <l n="10">Fell as he found</l>
               <l n="11">No spot of ground</l>
               <l n="12">That looked like Eldorado.</l>
            </lg>
            <lg type="stanza" n="3">
               <l n="13">And, as his strength</l>
               <l n="14">Failed him at length,</l>
               <l n="15">He met a pilgrim shadow.</l>
               <l n="16">'Shadow,' said he-</l>
               <l n="17">'Where can it be-</l>
               <l n="18">This land of Eldorado?'</l>
            </lg>
            <lg type="stanza" n="4">
               <l n="19">'Over the Mountains</l>
               <l n="20">Of the Moon,</l>
               <l n="21">Down the Valley of the Shadow,</l>
               <l n="22">Ride, boldly ride,'</l>
               <l n="23">The shade replied,</l>
               <l n="24">'If you seek for Eldorado!'</l>
            </lg>
         </lg>
      </body>
   </text>
</TEI>
```

I've also provided [a gist with the poem](https://gist.github.com/CliffordAnderson/2045cefaf2a687e5d078/), in case you'd like to use it.

Obviously, we could simply count the words with such a short poem. But our goal is to write an XQuery expression to do the counting for us. Your mission, should you choose to accept it, is to write an XQuery expression that takes the text nodes from the l elements of the source poem and produces a dictionary of the unique words in the poem along with their frequency.

The output should look like this:

```xml
<dictionary>
  <word frequency="5">the</word>
  <word frequency="5">shadow</word>
  ...
  <word frequency="1">no</word>
  <word frequency="1">gaily</word>
  <word frequency="1">ground</word>
  <word frequency="1">that</word>
  <word frequency="1">looked</word>
  <word frequency="1">like</word>
  <word frequency="1">strength</word>
</dictionary>
```

Hint: You'll probably need to use regular expressions to clean up the strings. If so, this function ```fn:replace($words, "[!?.',/-]", "")``` should do the trick nicely.

Give it a try yourself before checking out [what I came up with](http://try.zorba.io/queries/xquery/ZZf2fGYOwtkBvN8sbzI4cX4plYw%3D). I'm sure you can do better, right? If you've found a simpler solution, tweet it out to #XQY14.

Extra Credit: Add an expression to the query to eliminate common stop-words–i.e. "of," "the," etc.–from your dictionary.