# Wherefore XML?
* Enables data to be both human and machine readable
* Encodes implicit human meaning into explicit machine processable data
* Facilitates interoperability and exchange of data
* The XML DOM (Document Object Model) is document-centric and thus similar in some ways to humanists' interest in "*texts*"

Vocabulary:

```
	DOM Document Object Model: a tree-like hierarchical representation of the data

* Timeline: SGML (1986), HTML application of SGML (1991), XML subset of SGML (1998).
sads
	
	
	W3C (World Wide Web Consortium) publishes standards for HTML and XML 

* Elements
* Attributes
* Character Data (CDATA)
* XML built-in primitive datatypes
* 3.2 Primitive datatypes
        3.2.1 string
        3.2.2 boolean
        3.2.3 decimal
        3.2.4 float
        3.2.5 double
        3.2.6 duration
        3.2.7 dateTime
        3.2.8 time
        3.2.9 date
        3.2.10 gYearMonth
        3.2.11 gYear
        3.2.12 gMonthDay
        3.2.13 gDay
        3.2.14 gMonth
        3.2.15 hexBinary
        3.2.16 base64Binary
        3.2.17 anyURI
        3.2.18 QName
        3.2.19 NOTATION


 * XML Parsers:
 	* Saxon
 * DTD - document type definition
 * XML Schema
 * XML Namespaces
 * XPath
 * XSLT Extensible Stylesheet Language Transformations
 * XQuery
 
 *Well-Formed XML
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
 	
 *Valid Characters in XML 1.0
 http://validchar.com/d/xml10/xml10_namestart
 *Whitespace!
 *Entity References
 
 	& = &amp;
 	< = &lt;
 	> = &rt;
 	" = &quot;
 	' = &apos;
 * Character References
 	
 	Ω  = &#x03A9
 CDATA - (Unparsed) Character Data

The term CDATA is used about text data that should not be parsed by the XML parser.

Characters like "<" and "&" are illegal in XML elements.

"<" will generate an error because the parser interprets it as the start of a new element.

"&" will generate an error because the parser interprets it as the start of an character entity.

Some text, like JavaScript code, contains a lot of "<" or "&" characters. To avoid errors script code can be defined as CDATA.

Everything inside a CDATA section is ignored by the parser.

A CDATA section starts with "<![CDATA[" and ends with "]]>":
http://www.w3schools.com/xml/xml_cdata.asp
 
 UTF-8 and Unicode
 
 XML declaration
 Encoding
 Processing Instructions
 	Stylesheets
 CDATA Sections
 
 Root or Document Element
 Whitespace (To Preserve or Not to Preserve)
 camelCasing for spacing...
 
 Elements for Complex Structures, Attributes for Atomic Values
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
 
 Name spaces…
 XML Namespaces provide a method to avoid element name conflicts.
 Solving the Name Conflict Using a Prefix
XML Namespaces - The xmlns Attribute (not really an attribute!)
Namespaces can be declared in the elements where they are used or in the XML root element
Default Namespace

THE XML Namespace
<xml:lang>

*URI, URL, URN