<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">
    <ns uri="http://www.w3.org/1999/02/22-rdf-syntax-ns#" prefix="rdf"/>
    <ns uri="http://www.w3.org/2001/XMLSchema" prefix="xs"/>
    <ns uri="http://schema.org/" prefix="schema"/>   
    <pattern>
        <rule context="name">
            <assert test="child::subject=doc('http://www.worldcat.org/oclc/362500.rdf')/rdf:RDF/rdf:Description/schema:name[.='Statesmen--India']">Subject must conform!</assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="author">
            <assert test="@authorized" diagnostics="authorized">The authorized form of the name must
                appear in an authorized attribute of the <name path="."/> element.</assert>
        </rule>
    </pattern>
    <pattern>
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
