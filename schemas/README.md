#Schemas

Our goal in this session is to review the various means to validate an XML document. We'll look at DTDs and XML Schema first and then briefly try out RELAX NG and Schematron. We're not aiming to teach you how to use these technologies--trust me, there are whole books on the subject. Rather, we want you to be aware of the similarities and differences as well as how the technologies compliment one another.

###Validation

We recall from our XML fundamentals the difference between checking whether any given XML document is well-formed and whether it is valid. The first asks whether the document is XML. If a document is not well-formed, then it isn't actually XML--even if it appears to have lots of angle brackets.

There are multiple ways to validate XML documents:
* DTDs
* XML Schema
* RELAX NG
* Schematron

as well as technologies like Namespace-based Validation Dispatching Language (NVDL) to handle more advanced scenarios.

###Sample Document

So let's imagine we're seeking a standardized way of describing books in a bookstore. We'd like to create a standard that contains all the information we need along with some option information that we might have in certain circumstances. We'll use this standard for a few things. It will help to make sure that our employees are all entering information in the same manner. It will flag cases where someone has left out important information. It will also help us to send information about our inventory to publishers and others.

Here's a sketch of what such a document might look like:

*N.B. These examples are modified and expanded versions of the corresponding examples in [Beginning XML](http://www.amazon.com/Beginning-XML-5th-Edition-Fawcett/dp/1118162137). Of course, if you were really needed a schema for exchanging information about retail books, you'd probably want to consider [ONIX](http://www.editeur.org/93/Release-3.0-Downloads/#Schema defs).*

```xml
<?xml version="1.0" encoding="UTF-8"?>
<book isbn="0099470438" oclc="50604879">
    <author authorized="Haddon, Mark">Mark Haddon</author>
    <title short="curious incident">The curious incident of the dog in the night-time</title>
    <date type="publication">2003</date>
    <genre/>
    <publisher>
        <name>Doubleday </name>
        <city>New York </city>
    </publisher>
    <price>$14.95</price>
</book>
```

###Document Type Definition (DTD)

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

###XML Schema (XSD)

XQuery incorporates the simple types defined in the [XML Schema](http://www.w3.org/TR/xmlschema-2/). This is why atomic types in XQuery use the 'xs' namespace prefix. The 'xs' prefix is a shorthand for the namespace 'http://www.w3.org/2001/XMLSchema'.

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


###RELAX NG

Relax NG stands for "REgular LAnguage for XML Next Generation".

Here's a RELAX NG file to validate the book:

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
        attribute type {text},
        text
    }
genre =
    element genre {
        text
    }

publisher =
    element publisher {
        element name { text }
        & element city { text }
    }

price =
    element price { text }

start =
    element book {
        attribute isbn {xsd:token} &
        attribute oclc {xsd:token} &
        title & author & date & genre & publisher & price
    }
```


###Schematron

Schematron allows you to specify more specific and complex rules for validating documents. The key difference between DTDs, XML Schema, and RelaxNG one the one hand, and Schematron on the other is that the former are grammar-based whereas Schematron is rule-based. (See Priscilla Walmsley, [Definitive XML Schema](http://www.worldcat.org/title/definitive-xml-schema/oclc/48362767), second edition, p. 13)

here's a Schematron file to perform additional validation on the contents

```sch
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
