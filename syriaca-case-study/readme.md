#*The challenges of scholarly editing in XML*
---
#I. Case Study: [Syriaca.org](http://syriaca.org/)

Syriaca.org is a born-digital reference work compsed of TEI XML data which is processed using XQuery & eXistDB. 

##A. Project Design
Data (TEI, Github, oXygen) > App (eXistDB, XQuery, XSL) > Front-end ([Bootstrap](getbootstrap.com/), HTML, CSS, Javascript)

##B. Front-end

Model publication: [The Syriac Gazetteer
](http://syriaca.org/geo/index.html) (A Dictionary of Historical Geography)

* Sample entry: [Edessa](http://syriaca.org/place/78.html)
* Table of contents: [All entries sorted alphabetically](http://syriaca.org/geo/browse.html)
* Table of contents: [All entries sorted by type](http://syriaca.org/geo/browse.html?view=type)
* Map functions: [All entries plotted to a map](http://syriaca.org/geo/browse.html?view=map)
* [Search](http://syriaca.org/geo/search.html)
* Data serialized: [Atom](http://syriaca.org/geo/atom.xql?id=78)

##C. Back-end

* Sample Entry in TEI: [Inside eXist](http://syriaca.org/place/78/tei)
* Data Repositories: Master Copy on [Github](https://github.com/srophe/srophe-eXist-app/tree/master/srophe-app/data). A copy for you to play with is also in our [course-materials](https://github.com/XQueryInstitute/Course-Materials/tree/master/participant-datasets).

```<!-- Note: At present the data on Github is inside the code for the eXist app, in the final design of the app the data will reside in its own mirrored repository -->``` 

Different Data Types:

* [Places](https://github.com/XQueryInstitute/Course-Materials/blob/master/participant-datasets/syriaca/places/tei/78.xml) 
* [Bibliography](https://github.com/XQueryInstitute/Course-Materials/blob/master/participant-datasets/syriaca/bibl/tei/1.xml)
* [Persons](https://github.com/XQueryInstitute/Course-Materials/blob/master/participant-datasets/syriaca/persons/tei/13.xml)
* [Editors](http://)

##D. The App: XQuery and eXistDB
* Code on [Github](https://github.com/srophe/srophe-eXist-app/tree/master/srophe-app)
* [XQuery processes the data](https://github.com/srophe/srophe-eXist-app/blob/master/srophe-app/modules/place.xql) from each entry's TEI file creating related data (such as Dublin Core records or a map) as needed and passes the data on to XSL for conversion to HTML.
* Some [XQueries](https://github.com/srophe/srophe-eXist-app/blob/master/srophe-app/modules/app.xql) are used across the whole app:
	* A user feedback button tied to individual records
	* Controlled vocabularies including the list of persons creating the XML
* Data clean up is also done using [XQueries](https://github.com/srophe/srophe-eXist-app/blob/master/srophe-app/modules/data-admin.xql) which can be done either in an automated way or through an admin. module.
* [Index and data sorting](https://github.com/srophe/srophe-eXist-app/blob/master/srophe-app/modules/browse.xql) functions are aslo done with XQuery.
* [Search functions](https://github.com/srophe/srophe-eXist-app/blob/master/srophe-app/modules/search-test.xql) are also achieved with XQuery (though this is just one of several options including using [SOLR/LUCENE](http://exist-db.org:8098/exist/apps/fundocs/view.html?uri=http://exist-db.org/xquery/lucene&location=java:org.exist.xquery.modules.lucene.LuceneModule))

##E. Conclusions:
Because the entire app is downloadable as an archive, users can run the app locally and modify it as needed. Thus student research assistants built their own functions:

* A Natural Language Processor that recongnized and matched Named Entities
* A an image module that embedded related images of manuscripts
* A quick and simple notes view that passed through as a TEXT file on data that matched a particular research parameter.

#II. Discussion of Scholarly Editing

* Open up your App to the scholarly community, not just your data. 
* Design your data structure around the sorts of search possible.
* What can TEI do and what can't it do?
