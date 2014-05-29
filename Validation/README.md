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



###Document Type Definitions (DTDs)


###XML SCHEMA

XQuery incorporates the simple types defined in the [XML Schema](http://www.w3.org/TR/xmlschema-2/). This is why atomic types in XQuery use the 'xs' namespace prefix. The 'xs' prefix is a shorthand for 'http://www.w3.org/2001/XMLSchema'.  

###RELAX NG

Relax NG stands for "REgular LAnguage for XML Next Generation".

###Schematron

Schematron allows you to specify more specific and complex rules for validating documents. The key difference between DTDs, XML Schema, and RelaxNG one the one hand, and Schematron on the other is that the former are grammar-based whereas Schematron is rule-based. (See Priscilla Walmsley, [Definitive XML Schema](http://www.worldcat.org/title/definitive-xml-schema/oclc/48362767), second edition, p. 13)

###Example

N.B. These examples are modified and expanded versions of the corresponding examples in [Beginning XML](http://www.amazon.com/Beginning-XML-5th-Edition-Fawcett/dp/1118162137). 

Let's start with an example XML file for a book:

```xml

<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="book.rnc" type="application/relax-ng-compact-syntax"?>
<?xml-model href="book.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
<book isbn="0099470438" oclc="50604879">
    <author authorized="Haddon, Mark">Clifford Anderson</author>
    <title short="curious incident">The curious incident of the dog in the night-time</title>
    <date type="publication">2003</date>
    <genre></genre>
    <publisher>
        <name>Doubleday
        </name>
        <city>New York
        </city>
    </publisher>
    <price>$14.95</price>
</book>

```

Here's a RELAX NG file to validate the book

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

And here's a Schematron file to perform additional validation on the contents

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
            <assert test="text() castable as xs:gYear" diagnostics="publicationDate">The
                publication date must contain a valid year.</assert>
        </rule>
    </pattern>
    <diagnostics>
        <diagnostic id="authorized">The "authorized" attribute is missing for this book: <value-of
                select="../title/text()"/></diagnostic>
        <diagnostic id="publicationDate">The publication date is missing or invalid for this
            book: <value-of select="./text()"/></diagnostic>
    </diagnostics>
</schema>

```
