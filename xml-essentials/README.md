# I. Bibliography
W3C, "[XML Essentials](http://www.w3.org/standards/xml/core)"

w3schools.com, "[XML Tutorial](http://www.w3schools.com/xml/default.asp)"

**W3C (World Wide Web Consortium):** international body which sets standards for the Web including HTML and XML 

Fawcett, Joe, Danny Ayers, and Liam R. E. Quin. [*Beginning XML,*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466) 5th edition. Indianapolis: Wrox, 2012. *NB: This link is accessible only from within the VU campus network.*

David J. Birnbaum, ["What is XML and why should humanists care? An even gentler introduction to XML."](http://dh.obdurodon.org/what-is-xml.xhtml) 

# II. Wherefore XML?

"**XML The eXtensible Markup Language (XML)** is a simple text-based format for representing structured information: documents, data, configuration, books, transactions, invoices, and much more."" - [W3C](http://www.w3.org/standards/xml/core)

Enables data to be both human and machine readable

Encodes implicit human meaning into explicit machine processable data

Facilitates interoperability and exchange of data, yet is also "extensible" to fit the particularity of humanist research

The XML DOM (Document Object Model) is document-centric and thus similar in some ways to humanists' interest in "*texts*""

**DOM Document Object Model:** a tree-like hierarchical representation of the data.- [*Beginning XML*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466)

Timeline of the development of XML: SGML (Standard Generalized Markup Language, 1986), HTML (an application of SGML, 1991), XML (a subset of SGML, 1998).

# III. Basic Concepts of XML
##Data and Metadata
---
Markup is metadata (data about the data), but markup is also data itself, so markup has metadata…(Danger: Infinite loop!)

Importance of the "XML Prolog" and "TEI Header" (data before the data)

**XML Prolog:** All information occuring *before* the root element containing the XML document.

**XML Declaration:** "Specification of what version of XML is being used" - [W3C](http://www.w3.org/TR/2008/REC-xml-20081126/#sec-prolog-dtd)

```<?xml version="1.0" encoding="utf-8"?>```

**Encoding Declaration:** The XML Declaration also includes a declaration of the character encoding used: ```…encoding="utf-8"?>```

**Comments:** The prolog (and anywhere in the document) may contain comments. Comments are not considered to be part of the "character data" of the document. Comments are marked in this manner: 

```<!-- Et tu, Brutè? -->```

**Document Type Declaration:** "The XML document type declaration contains or points to markup declarations that provide a grammar for a class of documents. This grammar is known as a **document type definition**, or **DTD**." - [W3C](http://www.w3.org/TR/2008/REC-xml-20081126/#sec-prolog-dtd) *NB: DTDs have now largely been superseeded by schema languages. See Schema below.*

**Processing Instructions:** Instructions for applications which will process the XML document (for example a Web browser or an XML editor). In many cases these instructions may associate an external stylesheet or a schema with an XML document.

```<?xml-stylesheet type="text/xsl" href="fdt.xsl"?>```

```<?xml-model href="tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>```

**Schema:** "An XML Schema is a language for expressing constraints about XML documents. There are several different schema languages in widespread use, but the main ones are Document Type Definitions (DTDs), Relax-NG, Schematron and W3C XSD (XML Schema Definitions)." - [W3C](http://www.w3.org/standards/xml/schema)

**Stylesheet:** "A style sheet language, or style language, is a computer language that expresses the presentation of structured documents. One attractive feature of structured documents is that the content can be reused in many contexts and presented in various ways. Different style sheets can be attached to the logical structure to produce different presentations." - [Wikipedia](http://en.wikipedia.org/wiki/Style_sheet_language)

**XSLT:** "**XSL Transformations (XSLT 2.0)** is a language for transforming XML documents into other XML documents, text documents or HTML documents." - [W3C](http://www.w3.org/standards/xml/transformation#xslt)

**Root Element:** "XML documents must contain one element that is the parent of all other elements. XML documents form a tree structure that starts at 'the root' and branches to 'the leaves'." - [W3Schools.com](http://www.w3schools.com/xml/xml_tree.asp)

```<TEI xmlns="http://www.tei-c.org/ns/1.0">```

##Three Core XML Structures:
---
**Elements** (also informally called "tags"): Logical structure marked with start ```<``` and end ```>``` tags, e.g.

```xml 
<name>Flavius</name>
```

**Attributes:** Additional information about an element or data in an element

```<person xml:id="Flavius_JC"><persName><name>Flavius</name></persName></person>```

**Character Data (CDATA):** Data contained by elements and attributes (informally known as "text")
```<persName><name>Flavius</name></persName>```

**XML Schema built-in primitive datatypes for Character Data:**

* string
* boolean
* decimal
* float
* double
* duration
* dateTime
* time
* date
* gYearMonth
* gYear
* gMonthDay
* gDay
* gMonth
* hexBinary
* base64Binary
* anyURI
* QName
* NOTATION

Datatype References:

* [W3C](http://www.w3.org/TR/xmlschema-2/#built-in-primitive-datatypes)
* [W3Schools.com](http://www.w3schools.com/schema/schema_dtypes_string.asp)
*  Fawcett, et al., [*Beginning XML*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466), p. 148ff.
 
##Working within the XML Document
---
**XML Parsers:** An XML parser breaksdown an XML document into an its constituent parts - which can then be manipulated. A common parser is included in the Saxon Library of XML processing tools. See Fawcett, et al., [*Beginning XML*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466), p. 16ff.

**Entity Reference:** ""Some characters have a special meaning in XML. If you place a character like ```<``` inside an XML element, it will generate an error because the parser interprets it as the start of a new element. To avoid this error, replace the ```<``` character with an entity reference. There are 5 predefined entity references in XML:
 
```& = &amp;```
 	
```< = &lt;```
 	
```> = &rt;```

```" = &quot;```

```' = &apos;```

Working with **CDATA:** CDATA can be parsed or unparsed. "The term CDATA is often used about text data that should not be parsed by the XML parser. Some text, like JavaScript code, contains a lot of "<" or "&" characters. To avoid errors script code can be defined as CDATA. Everything inside a CDATA section is ignored by the parser. A CDATA section starts with ```<![CDATA[``` and ends with ```]]>``` - [W3Schools.com](http://www.w3schools.com/xml/xml_cdata.asp)

See the additional tutorial here: [https://gist.github.com/CliffordAnderson/53c178665b277b5371cd](https://gist.github.com/CliffordAnderson/53c178665b277b5371cd)

**XPath**

**XML Namespaces**
Name spaces…
 XML Namespaces provide a method to avoid element name conflicts.
 Solving the Name Conflict Using a Prefix
XML Namespaces - The xmlns Attribute (not really an attribute!)
Namespaces can be declared in the elements where they are used or in the XML root element
Default Namespace

**The XML Namespace**
```<xml:lang>```

*URI, URL, URN**

##Minding Your XML Manners
---
**Well-Formed XML:**
 	* All true XML is well-formed
 		1. Content separated from metadata (mark up)
 		An XML document with correct syntax is "Well Formed".

An XML document with correct syntax is called "Well Formed". 
    XML documents must have a root element
    XML elements must have a closing tag
    XML tags are case sensitive
    XML elements must be properly nested
    XML attribute values must be quoted
-http://www.w3schools.com/xml/xml_doctypes.asp
 	
**Whitespace** (To Preserve or Not to Preserve)
 camelCasing for spacing...
 
**Elements or Attributes** for Complex Structures, Attributes for Atomic Values
 Gap Problem in XML
 
 XML Infoset
 	Document Information Item
 	Root Element
 		Local Name
 		Children/Parent
 		Attributes
 			Local Name
 			Normalized Value
 			Owner Element
 	Processing Instruction Information Items
 	Character Information Item
 	Comment Information Item
 	Namespace Information Item
 	Document Type Declaration Information Item
 	
 
 Errors!
 
