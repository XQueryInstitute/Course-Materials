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
