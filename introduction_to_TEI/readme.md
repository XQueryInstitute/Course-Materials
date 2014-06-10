#*Introduction to the TEI P5 specification*
---
#I. Very Brief Intro to TEI
##Resources:

* [TEI Guidelines](http://www.tei-c.org/index.xml)
* [TEI Wiki](http://wiki.tei-c.org/index.php/Main_Page)
* [TEI-L](http://www.tei-c.org/Support/index.xml#tei-l)
* [Journal of the Text Encoding Initiative](http://journal.tei-c.org/journal/index)
* [TEI Conference](http://tei.northwestern.edu/)
* [TEI @ Oxford Teaching Pages](http://tei.oucs.ox.ac.uk/Talks/)
* [Brown University's Resources for Teaching and Learning Text Encoding](http://www.wwp.brown.edu/outreach/resources.html)
* [Lou Burnard, What is the Text Encoding Initiative?](http://books.openedition.org/oep/426)

##What is the TEI?

"The Text Encoding Initiative is an attempt to prevent the digital equivalent of the Tower of Babel. It proposes a community standard for representing digital texts in a way that is both powerful and responsive to the research needs of humanities scholars. In practical terms, it is several things:

*     it is a set of guidelines for encoding humanities texts using XML, the eXtensible Markup Language
*     it is a standards organization that maintains and develops an XML encoding language for encoding humanities texts;
*     it is an international consortium that exists to support this standards development work
*     it is a community of projects and individuals who use the TEI Guidelines

Like many standardization efforts, the TEI faces the challenges inherent in such a project. How can the many disciplines and communities within the humanities domain find common ground in a single encoding language? How do we agree on the level of detail that is necessary or appropriate in describing our textual materials? How do we reconcile the advantages to be gained by consistency and agreement with the need for individual specialization? How do we handle the truly idiosyncratic and unexpected?" -[http://www.wwp.brown.edu/outreach/seminars/tei.html](http://www.wwp.brown.edu/outreach/seminars/tei.html)

##History and User Base
* Established in 1987 (before XML!)
* Over 50 supporting institutions
* Over 800 users on the e-mail list
* Approximately 550 tags and numerous attributes defined by a community.
* Well represented across a variety of disciplines, such as Literature, Linguistics Classics, Medieval Studies. Fewer historians, however.
* Originally created for marking up digital editions of existing print texts, but now widely expanded to create born-digital texts, finding aids (for manuscripts), and even databases (composite documents containting multiple texts).
* Single purpose is not possible (different thus from EAD for example). The flexibility of the TEI makes it robust for use by humanists. In fact the TEI makes provisions for [customization](http://www.tei-c.org/Guidelines/Customization/).

```
Group Exercise: Old Fashioned Encoding & Discussion
```

#II. Discussion of Participant Use Cases

* Syriaca.org
* ?
* Folger Digital Editions of Shakespeare

#III. Overview of Structures
Data and Metadata
##A. TEI Body
* [Elements Available in All TEI Documents](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/CO.html)

```
Group Exercise: From Paper to Screen
```

* [Elements actually used in the Folger Julius Caesar](https://github.com/XQueryInstitute/Course-Materials/blob/master/folger%20shakespeare%20texts/readme.md) (This list is the result of [this](https://github.com/CliffordAnderson/teiDocs) XQuery)

##B. TEI Header

"The TEI header has four main components, corresponding to the parts defined in one of the first attempts at a universal bibliographic description the International Bibliographic Standard Description (ISBD):

*     ```<fileDesc>``` (file description) contains a full bibliographic description of an electronic file;
*     ```<encodingDesc>``` (encoding description) documents the relationship between an electronic text and the source or sources from which it was derived;
*     ```<profileDesc>``` (profile description) provides a detailed description of non-bibliographic aspects of a text, specifically the languages and sublanguages used, the situation in which it was produced, the participants and their setting. (just about everything not covered in the other header elements);
*     ```<revisionDesc>``` (revision description) summarizes the revision history for a file." - [Lou Burnard](http://books.openedition.org/oep/691)

##C. Walking through Julius Caesar in XML

* [JC.xml](https://github.com/XQueryInstitute/Course-Materials/blob/master/folger%20shakespeare%20texts/JC.xml)

Questions about the encoding?



