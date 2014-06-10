# I. Bibliography
---
W3C, "[XML Essentials](http://www.w3.org/standards/xml/core)"

**W3C (World Wide Web Consortium):** international body which sets standards for the Web including HTML and XML 

w3schools.com, "[XML Tutorial](http://www.w3schools.com/xml/default.asp)"

Fawcett, Joe, Danny Ayers, and Liam R. E. Quin. [*Beginning XML,*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466) 5th edition. Indianapolis: Wrox, 2012. *NB: This link is accessible only from within the VU campus network.*

David J. Birnbaum, ["What is XML and why should humanists care? An even gentler introduction to XML."](http://dh.obdurodon.org/what-is-xml.xhtml) 

# II. Wherefore XML?
---
"**XML The eXtensible Markup Language (XML)** is a simple text-based format for representing structured information: documents, data, configuration, books, transactions, invoices, and much more."" - [W3C](http://www.w3.org/standards/xml/core)

Enables data to be both human and machine readable

Encodes implicit human meaning into explicit machine processable data

Facilitates interoperability and exchange of data, yet is also "extensible" to fit the particularity of humanist research

The XML DOM (Document Object Model) is document-centric and thus similar in some ways to humanists' interest in "*texts*""

**DOM Document Object Model:** a tree-like hierarchical representation of the data.- [*Beginning XML*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466) *NB: See XPath below.*

Timeline of the development of XML: SGML (Standard Generalized Markup Language, 1986), HTML (an application of SGML, 1991), XML (a subset of SGML, 1998).

# III. Basic Concepts of XML
##Data and Metadata
---
Markup is metadata (data about the data), but markup is also data itself, so markup has metadata…(Danger: Infinite loop!)

Importance of the "XML Prolog" and "TEI Header" (data before the data)

**XML Prolog:** All information occuring *before* the root element containing the XML document.

**XML Declaration:** "Specification of what version of XML is being used" - [W3C](http://www.w3.org/TR/2008/REC-xml-20081126/#sec-prolog-dtd)

```xml
<?xml version="1.0" encoding="utf-8"?>
```

**Encoding Declaration:** The XML Declaration also includes a declaration of the character encoding used: ```…encoding="utf-8"?>```

**Comments:** The prolog (and anywhere in the document) may contain comments. Comments are not considered to be part of the "character data" of the document. Comments are marked in this manner: 

```<!-- Et tu, Brutè? -->```

**Document Type Declaration:** "The XML document type declaration contains or points to markup declarations that provide a grammar for a class of documents. This grammar is known as a **document type definition**, or **DTD**." - [W3C](http://www.w3.org/TR/2008/REC-xml-20081126/#sec-prolog-dtd) *NB: DTDs have now largely been superseeded by schema languages. See Schema below.*

**Processing Instructions:** Instructions for applications which will process the XML document (for example a Web browser or an XML editor). In many cases these instructions may associate an external stylesheet or a schema with an XML document.

```xml
<?xml-stylesheet type="text/xsl" href="fdt.xsl"?>
```

```xml
<?xml-model href="tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
```

**Schema:** "An XML Schema is a language for expressing constraints about XML documents. There are several different schema languages in widespread use, but the main ones are Document Type Definitions (DTDs), Relax-NG, Schematron and W3C XSD (XML Schema Definitions)." - [W3C](http://www.w3.org/standards/xml/schema)

**Stylesheet:** "A style sheet language, or style language, is a computer language that expresses the presentation of structured documents. One attractive feature of structured documents is that the content can be reused in many contexts and presented in various ways. Different style sheets can be attached to the logical structure to produce different presentations." - [Wikipedia](http://en.wikipedia.org/wiki/Style_sheet_language)

**XSLT:** "**XSL Transformations (XSLT 2.0)** is a language for transforming XML documents into other XML documents, text documents or HTML documents." - [W3C](http://www.w3.org/standards/xml/transformation#xslt)

**Root Element:** "XML documents must contain one element that is the parent of all other elements. XML documents form a tree structure that starts at 'the root' and branches to 'the leaves'." - [W3Schools.com](http://www.w3schools.com/xml/xml_tree.asp)

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0">
```

##Three Core XML Structures:
---
**Elements** (also informally called "tags"): Logical structure marked with start ```<``` and end ```>``` tags, e.g.

```xml 
<name>Flavius</name>
```

**Attributes:** Additional information about an element or data in an element

```xml
<person xml:id="Flavius_JC"><persName><name>Flavius</name></persName></person>
```

**(Parsed) Character Data (PCDATA):** Data contained by elements and attributes (informally known as "text"). Usually character data in XML documents is "parsed," but in some cases it may be intentionally unparsed. See CDATA below.

```xml
<person xml:id="Flavius_JC"><persName><name>Flavius</name></persName></person>
```

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
 
#IV. Working within the XML Document
---
**XML Parsers:** An XML parser breaksdown an XML document into an its constituent parts - which can then be manipulated. A common parser is included in the Saxon Library of XML processing tools. See Fawcett, et al., [*Beginning XML*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466), p. 16ff.

**Entity Reference:** ""Some characters have a special meaning in XML. If you place a character like ```<``` inside an XML element, it will generate an error because the parser interprets it as the start of a new element. To avoid this error, replace the ```<``` character with an entity reference. There are 5 predefined entity references in XML:
 	
```< = &lt;```
 	
```> = &gt;```

```" = &quot;```

```' = &apos;```

```& = &amp;```

**Unparsed CDATA:** CDATA can be parsed or unparsed. "The term CDATA is often used about text data that should not be parsed by the XML parser. Some text, like JavaScript code, contains a lot of "<" or "&" characters. To avoid errors script code can be defined as CDATA. Everything inside a CDATA section is ignored by the parser. A CDATA section starts with ```<![CDATA[``` and ends with ```]]>``` - [W3Schools.com](http://www.w3schools.com/xml/xml_cdata.asp)

See the additional tutorial here: [https://gist.github.com/CliffordAnderson/53c178665b277b5371cd](https://gist.github.com/CliffordAnderson/53c178665b277b5371cd)

**XPath:** "XPath (the XML Path language) is a language for finding information in an XML document." -[W3Schools.com](http://www.w3schools.com/xml/xml_xpath.asp)

See [XML Path Language (XPath)](http://www.w3.org/TR/xpath20/) a W3C recommendation.

**Nodes:** "In XPath, there are seven kinds of nodes: element, attribute, text, namespace, processing-instruction, comment, and document nodes. XML documents are treated as trees of nodes. The topmost element of the tree is called the root element." - [W3Schools.com](http://www.w3schools.com/xpath/xpath_nodes.asp)

```xml
<!-- This code is from the document jc.xml, thus jc.xml is the document node. -->
<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="fdt.xsl"?>
<?xml-model href="tei_all.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader>
    <fileDesc>
      <titleStmt>
        <title>Julius Caesar</title>
        <author>William Shakespeare</author>
        <editor xml:id="BAM">Barbara A. Mowat</editor>
        <editor xml:id="PW">Paul Werstine</editor>
```

In its most simple form XPath is literally the path to information in the document. In the example above the path for the text "Julius Caesar" is:

```xpath
/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]
```

The tree relationships between the nodes are expressed with the following terminology:

* Root
* Parent
* Child 
* Sibling
* Ancestors
* Descendants
* Atomic Value: nodes with no children or parent
	
	-[W3Schools.com](http://www.w3schools.com/xpath/xpath_nodes.asp), see also Fawcett, et al., [*Beginning XML*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466), p. 47ff. on "The XML Infoset"

The following are common expressions in XPath which allow one to select nodes, specific values, or relationships:

```
nodename 	Selects all nodes with the name "nodename"
/ 	Selects from the root node
// 	Selects nodes in the document from the current node that match the selection no matter where they are
. 	Selects the current node
.. 	Selects the parent of the current node
@ 	Selects attributes
[ ]	Predicates [in square brackets] are used to find a specific node or a node that contains a specific value
* 	Matches any element node
@* 	Matches any attribute node
node() 	Matches any node of any kind
|	operator allowing one to select several paths
```
-[W3Schools.com](http://www.w3schools.com/xpath/xpath_syntax.asp)

# V. What's in a Name?
---
**Well-Formed XML:** All true XML must be well-formed (follow the syntax rules of XML). The main principle is that the markup must successfully separate the content from the metadata. An XML document with correct syntax is "Well Formed".

6 Rules for "well-formedness":
*     XML documents must have a root element
*     XML elements must have a closing tag
*     XML tags are case sensitive
*     XML elements must be properly nested
*     XML attribute values must be quoted
-[W3Schools.com](http://www.w3schools.com/xml/xml_syntax.asp)
 	
**Whitespace**
"In XML documents, some whitespace is significant, some is not. For example, inside the brackets that mark XML elements extra whitespace is not significant. For any program processing these as pieces of XML, ```xml <title type="main">``` and ```xml <title     type = "main" >``` are the same. There is no significance to the extra space. By XML rules, no application that processes the data in this XML file (processing it as XML and not just as text) is allowed to treat these two representations differently. A person or computer editing this file is free to use either one, based merely on readability and aesthetics. The fact that there is whitespace between title and type is significant, but how much or of what kind (space characters, tabs, carriage returns, new lines) is not significant. The space between type and = is not significant.

Whitespace can be significant, however, in the content of an element. For example, ```xml <name>JoAnn</name>``` and ```xml <name>Jo Ann</name>``` are different because of that space between Jo and Ann, and any program reading this element in an XML file is obliged to maintain the distinction.

But things can get complicated. Consider this:
```xml
<persName>    
    <forename>Jo</forename>
    <forename>Ann</forename>
</persName>
``` -[TEI Wiki](http://wiki.tei-c.org/index.php/XML_Whitespace)

A similar case is found in Julius Caesar:
```xml
              <foreign xml:id="for-0001" xml:lang="la">
                <w xml:id="w0198350" n="3.1.85">Et</w>
                <c xml:id="c0198360" n="3.1.85"> </c>
                <w xml:id="w0198370" n="3.1.85">tu</w>
                <pc xml:id="p0198380" n="3.1.85">,</pc>
                <c xml:id="c0198390" n="3.1.85"> </c>
                <w xml:id="w0198400" n="3.1.85">Brutè</w>
              </foreign>
```
            
**XML Namespaces:** XML Namespaces provide a method to avoid element name conflicts. Name conflicts in XML can easily be avoided using a name prefix. Namespaces can be declared in the elements where they are used or in the XML root element using the xmlns Attribute (not really an attribute!). -[W3Schools.com](http://www.w3schools.com/xml/xml_namespaces.asp)

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0">
```

```xml
        <tei:title xmlns:tei="http://www.tei-c.org/ns/1.0">Julius Caesar</title>
        <tei:author>William Shakespeare</author>
```

The namespace declaration must be a **URI: Uniform Resource Identifier**. A URI does not have to be a resolvable URL even thought it may take the same form.

**The XML Namespace:** is a default namespace that relies upon the XML schema and thus is built-in in addition to any other schemas used. It's elements are universally available. For example: ```xml <xml:lang>```

#VI. Mistakes and Best Guesses 
---
 
**Elements or Attributes?** This is a bit of a editorial decision, though Fawcett, et al., [*Beginning XML*](http://site.ebrary.com/lib/vanderbilt/Doc?id=10575466) recommend elements for complex structures and attributes for atomic values

**Overlap Problem in XML:** Because element tags cannot overlap this excludes certain kinds of markup. In those cases a standoff markup may be needed.
 	
**Errors and Validation:** The current generation of XML tools offer many ways to evaluate your content, learn to harness the power of your XML editor.
 
