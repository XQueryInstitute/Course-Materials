# Schemas

Our goal in this session is to review the various means to validate an XML document. We'll look at DTDs and XML Schema first and then briefly try out RELAX NG and Schematron. We're not aiming to teach you how to use these technologies--trust me, there are whole books on the subject. Rather, we want you to be aware of the similarities and differences as well as how the technologies complement one another.

## Validation

We recall from our XML fundamentals the difference between checking whether any given XML document is well-formed and whether it is valid. The first asks whether the document is XML. If a document is not well-formed, then it isn't actually XML–even if it appears to have lots of angle brackets. The second checks whether the document conforms, as stated, to a particular grammar or set of rules for a specific kind of XML document.

There are multiple ways to validate XML documents:

* [DTDs](http://www.w3.org/TR/REC-xml/#dt-doctype)
* [XML Schema](http://www.w3.org/TR/xmlschema11-1/)
* [RELAX NG](http://relaxng.org/)
* [Schematron](http://www.schematron.com/)

as well as technologies like Namespace-based Validation Dispatching Language ([NVDL](http://nvdl.org/)) to handle more advanced scenarios.

## Sample Document

So let's imagine we're seeking a standardized way of describing books in a bookstore. We'd like to create a standard that contains all the information we need along with some optional information that we might have in certain circumstances. We'll use this standard for a few things. It will help to make sure that our employees are all entering information in the same manner. It will flag cases where someone has left out important information. It will also help us to send information about our inventory to publishers and others.

Here's a sketch of what such a document based on this standard might look like:

*N.B. These examples are modified and expanded versions of the corresponding examples in [Beginning XML](http://www.amazon.com/Beginning-XML-5th-Edition-Fawcett/dp/1118162137). Of course, if you really needed a schema for exchanging information about retail books, you'd probably want to consider [ONIX](http://www.editeur.org/93/Release-3.0-Downloads/#Schema defs).*

```xml
<?xml version="1.0" encoding="UTF-8"?>
<book isbn="0099470438" oclc="50604879">
    <author authorized="Haddon, Mark">Mark Haddon</author>
    <title short="curious incident">The curious incident of the dog in the night-time</title>
    <date type="publication">2003</date>
    <genre/>
    <publisher>
        <name>Doubleday</name>
        <city>New York</city>
    </publisher>
    <price>$14.95</price>
</book>
```

## Document Type Definition (DTD)

A document type definition (DTD) is a venerable standard developed to validate Standard Generalized Markup Language ([SGML](http://www.iso.org/iso/catalogue_detail?csnumber=16387)). The standard predates the development of XML and XML-related schema standards like XML Schema.

The benefits of using a Document Type Definition include its simplicity and relative compactness along with its ability to be used internally or externally to XML documents.

### Example DTD for Book.xml

Here is a possible DTD for our sample document:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!ELEMENT book (author*, title, date, genre?, publisher?, price?)>
<!ATTLIST book isbn CDATA #IMPLIED>
<!ATTLIST book oclc CDATA #REQUIRED>

<!ELEMENT author (#PCDATA)>
<!ATTLIST author authorized CDATA #REQUIRED>

<!ELEMENT title (#PCDATA)>
<!ATTLIST title short CDATA #REQUIRED>

<!ELEMENT date (#PCDATA)>
<!ATTLIST date type CDATA #IMPLIED>

<!ELEMENT genre (#PCDATA)>
<!ELEMENT publisher (name, city?)>
<!ELEMENT price (#PCDATA)>

<!ELEMENT name (#PCDATA)>
<!ELEMENT city (#PCDATA)>
```
* N.B. PCDATA stands for Parsed Character Data, which is data that will be parsed by the XML interpreter. CDATA stands for Character Data. It will not be parsed as XML, meaning that elements etc. will not be recognized as such. See StackOverflow for a good discussion of the [difference between CDATA and PCDATA](http://stackoverflow.com/questions/918450/difference-between-pcdata-and-cdata-in-dtd).

To associate this DTD with our sample XML document, add the following line to the top of the document (right under the XML Declaration)–assuming that the DTD is located in the same directory as the XML document:

```xml
<!DOCTYPE book SYSTEM "book.dtd">
```

Another common use of DTDs is to declare character entities. This allows you to substitute a unicode character, for example, for an entity reference. For example, let's see how you might declare a character entity for the Greek letter Alpha in an XML document

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE example 
    [
        <!ENTITY Alpha "&#913;">
    ]
>
<example>
    The first letter of the Greek alphabet is &Alpha;.
</example>
```

The downside to this approach is that your XML documents may become more difficult to read and, if you use external entity declarations, slower to parse. 

## XML Schema (XSD)

XML Schema 1.0 is a W3C standard approved in 2001. The current recommendation for [XML Schema 1.1](http://www.w3.org/TR/xmlschema11-1/) dates from 2012.

XML Schema is a more robust standard than Document Type Definitions. Unlike DTDs, XML Schema can perform complex type checking on documents. In other words, XML Schema can verify that a date element actually contains a valid gYear.

In fact, XQuery incorporates the types defined in the [XML Schema](http://www.w3.org/TR/xmlschema-2/). This is why atomic types in XQuery use the 'xs' namespace prefix. The 'xs' prefix is a common shorthand for the namespace 'http://www.w3.org/2001/XMLSchema'.

A major difference between DTDs and XML Schemas is that the former uses a non-XML Syntax whereas the later uses XML syntax. An advantage of using XML syntax is that XML Schemas can be manipulated by XML-aware tools. A disadvantage is the verbosity of its XML syntax.

XML Schema has a reputation for being complex and difficult to understand. This arises, I think, from its incorporation of [object-oriented](http://en.wikipedia.org/wiki/Object-oriented_programming) concepts such as encapsulation and inheritance. 

## Example XML Schema for Book.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" elementFormDefault="qualified">
    <xs:element name="book" type="bookType"/>
    <xs:complexType name="bookType">
        <xs:all>
            <xs:element name="author" type="authorType"/>
            <xs:element name="title" type="titleType"/>
            <xs:element name="date" type="dateType"/>
            <xs:element name="genre" type="xs:string" xsi:nillable="true"/>
            <xs:element name="publisher" type="publisherType"/>
            <xs:element name="price" type="xs:string"/>
        </xs:all>
        <xs:attribute name="isbn" type="xs:string"/>
        <xs:attribute name="oclc" type="xs:integer"/>
    </xs:complexType>
    <xs:complexType name="authorType">
        <xs:simpleContent>
            <xs:extension base="xs:string">
                <xs:attribute name="authorized" type="xs:string"/>
            </xs:extension>
        </xs:simpleContent>
    </xs:complexType>
    <xs:complexType name="titleType">
        <xs:simpleContent>
            <xs:extension base="xs:string">
                <xs:attribute name="short" type="xs:string"/>
            </xs:extension>
        </xs:simpleContent>
    </xs:complexType>
    <xs:complexType name="dateType">
        <xs:simpleContent>
            <xs:extension base="xs:gYear">
                <xs:attribute name="type" type="xs:string"/>
            </xs:extension>
        </xs:simpleContent>
    </xs:complexType>
    <xs:complexType name="priceType">
        <xs:simpleContent>
            <xs:extension base="xs:string"/>
        </xs:simpleContent>
    </xs:complexType>
    <xs:complexType name="publisherType">
        <xs:all>
            <xs:element name="name" type="xs:string"/>
            <xs:element name="city" type="xs:string"/>
        </xs:all>
    </xs:complexType>
</xs:schema>
```

To add a reference to an XML Schema, insert attributes into the document element as follows:

```xml
<book xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xsi:noNamespaceSchemaLocation="book.xsd" isbn="0099470438" oclc="50604879"> 
```

* N.B. that there is no namespace for this schema. We might have defined our schema in a namespace like 'http://xqueryinstitute/book' and targeted this namespace using the ```targetNamespace``` attribute in our XSD. Of course, our document would also have to declare this namespace. In such cases, we would use the attribute ```xsi:schemaLocation``` to identify our namespace and its location. 

A last thing to note about XML Schemas is that it provides primitive datatypes used in XQuery and XSLT. See the list of [Built-in Datatypes](http://www.w3.org/TR/xmlschema-2/#built-in-datatypes) in the [XML Schema Part 2: Datatypes Second Edition](http://www.w3.org/TR/xmlschema-2/) recommendation. 

## RELAX NG

RELAX NG stands for "REgular LAnguage for XML Next Generation". James Clark, a major figure in the XML world, promoted the development of RELAX NG as a more streamlined alternative to XML Schema. The [RELAX NG](https://www.oasis-open.org/committees/relax-ng/compact-20021121.html) standard is maintained by [OASIS](https://www.oasis-open.org/org). 

Among the [stated goals of RELAX NG](http://relaxng.org/) are being simple and easy to learn. In a way, RELAX NG, especially in its compact syntax, draws on the legacy of DTDs while providing the powerful type checking of XML Schema. 

### Example RELAX NG (compact syntax) for Book.xml

Here's a RELAX NG file using the compact syntax to validate our book document:

```rnc
author =
    element author {
        attribute authorized {
            xsd:token { pattern = "([A-Z][a-z]*, [A-Z][a-z]* ?)+" }
        },
        text
    }
title =
    element title {
        attribute short {
            xsd:token { pattern = "(\w* ?){1,3}" }
        },
        text
    }
date =
    element date {
        attribute type { text },
        xsd:gYear
    }
genre = element genre { text }
publisher =
    element publisher {
        element name { text }
        & element city { text }
    }
price = element price { text }
start =
    element book {
        attribute isbn { xsd:token }
        & attribute oclc { xsd:token }
        & title
        & author
        & date
        & genre
        & publisher
        & price
    }

```

To associate this RELAX NG compact schema with an XML document, use the ```xml-model``` processing instruction as follows: ```<?xml-model href="book.rnc" type="application/relax-ng-compact-syntax"?>```

## Schematron

Schematron allows you to specify more specific and complex rules for validating documents. Like RELAX NG, Schematron is not a W3C recommendation; the Schematron standard is maintained jointly by [ISO and IEC](http://www.standardsinfo.net/info/index.html).

A key difference between DTDs, XML Schema, and RelaxNG on the one hand, and Schematron on the other is that the former are grammar-based whereas Schematron is rule-based. (See Priscilla Walmsley, [Definitive XML Schema](http://www.worldcat.org/title/definitive-xml-schema/oclc/48362767), second edition, p. 13)

###Example Schematron document for Book.xml

Here's a Schematron file to perform additional validation on the contents

```xml
<?xml version="1.0" encoding="UTF-8"?>
<schema schemaVersion="1.5" xmlns="http://www.ascc.net/xml/schematron">
    <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <pattern name="author attributes">
        <rule context="author">
            <assert test="@authorized" diagnostics="authorized">The authorized form of the name must
                appear in an authorized attribute of the <name path="."/> element.</assert>
        </rule>
    </pattern>
    <pattern name="publicationDate">
        <rule context="date">
            <assert test="text() castable as xs:gYear" diagnostics="publicationDate">The publication
                date must contain a valid year.</assert>
        </rule>
    </pattern>
    <diagnostics>
        <diagnostic id="authorized">The "authorized" attribute is missing for this book: <value-of
                select="../title/text()"/></diagnostic>
        <diagnostic id="publicationDate">The publication date is missing or invalid for this book:
                <value-of select="./text()"/></diagnostic>
    </diagnostics>
</schema>
```

To associate a set of Schematron rules with an XML document, use the ```xml-model``` processing instruction like this ```<?xml-model href="book.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?> ```. Schematron may be used in conjunction with grammar-based schemas; it's perfectly valid to have two ```xml-model``` instructions – for example,
```
<?xml-model href="book.rnc" type="application/relax-ng-compact-syntax"?>
<?xml-model href="book.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

## Challenge

Working in pairs, write a schema to validate the following (fictitious) check XML document. Select any form of schema (DTD, XSD, RELAX NG, or Schematron) to validate this kind of document.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<check num="001">
    <name>
        <last>Smith</last>
        <first>Jane</first>
    </name>
    <address type="personal">
        <street>1 Banker's Plaza</street>
        <city>Gotham</city>
        <state>NY</state>
        <zip>10000</zip>
    </address>
    <!--See http://en.wikipedia.org/wiki/Routing_transit_number-->
    <routing type="RTN">111000025</routing>
    <transaction currency="bitcoin" type="debit">1</transaction>
    <payee>Acme Corporation</payee>
</check>
```

Think in particular about what aspects of this instance may vary in other instances. What datatypes would be helpful? Would it be useful to impose constraints on certain attributes?
