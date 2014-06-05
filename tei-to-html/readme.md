#TEI to HTML

##Introduction

A common need is to render TEI documents as HTML documents. Generally, XSLT does a good job at these transformation. However, it is perfectly feasible to transform TEI into HTML using XQuery. In fact, the pattern may be even easier to learn and use.

The following examples are based on the excellent [Typeswitch Transformations](http://en.wikibooks.org/wiki/XQuery/Typeswitch_Transformations) chapter of the [XQuery Wikibook](http://en.wikibooks.org/wiki/XQuery). 

##Recursive Typeswitch Expressions

[Joe Wicentowski](https://github.com/joewiz) has helpfully provided a [gist](https://gist.github.com/joewiz/2331558#file-typeswitch-skeleton-xq) that provides the framework for this approach. I've reproduced his gist below.

```xquery
xquery version "1.0";
 
declare namespace tei="http://www.tei-c.org/ns/1.0";
 
declare function local:render($node) {
    typeswitch($node)
        case text() return $node
        case element(tei:div) return <div>{local:recurse($node)}</div>
        case element(tei:p) return <p>{local:recurse($node)}</p>
        default return local:recurse($node)
};
 
declare function local:recurse($node) {
    for $child in $node/node()
    return
        local:render($child)
};
```

These two functions are recursive, meaning that they call each other until the run out of nodes to transform.

##Sample Code for Folger Digital TExts

Here is some [sample code](tei-to-html.xqy) to transform any Act of Julius Caesar from TEI to HTML.

```xquery
xquery version "3.0";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace html="http://www.w3.org/1999/xhtml";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
 
declare function local:render($node as item()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:ab) return local:recurse($node)
        case element(tei:c) return " "
        case element(tei:div1) return <html:div>{local:recurse($node)}</html:div>
        case element(tei:div2) return <html:div>{local:recurse($node)}</html:div>
        case element(tei:lb) return "/ "
        case element(tei:head) return <html:h1>{local:recurse($node)}</html:h1>
        case element(tei:sp) return (<html:p>{local:recurse($node)}</html:p>)
        case element(tei:speaker) return (<html:b>{local:recurse($node)}: </html:b>)
        case element(tei:stage) return local:set-stage($node)
        case element(tei:fw) return ()
        default return local:recurse($node)
};

declare function local:set-stage($node as element()) as element()* {
        (<html:b>Stage direction: </html:b>, 
        <html:i>{fn:normalize-space(fn:string-join(local:recurse($node)))}</html:i>)
};
 
declare function local:recurse($node as item()) as item()* {
    for $node in $node/node()
    return
        local:render($node)
};

local:render((fn:doc("/db/apps/shakespeare/JC.xml")//tei:div1)[1])
```

Let's walk through the sections of this code in turn.

First, we declare the namespaces that we'll be using. We'll be targeting elements in the TEI namespace and transforming them into elements in the XHTML namespace. (It would be perfectly feasible to transform them into elements in the HTML5 namespace too.)

```xquery
xquery version "3.0";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace html="http://www.w3.org/1999/xhtml";
```

Next, we indicate that we will serialize our results as XHTML rather than simply as XML. This is an eXist-specific declaration.

```xquery
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
```

Skipping down a bit, we see a function called ```local:recurse```, which takes an item as its argument and returns a sequence of items. This function iteratates through all the child nodes of $node and send them to another function ```local:render```. 

```xquery
declare function local:recurse($node as item()) as item()* {
    for $node in $node/node()
    return
        local:render($node)
};
```

The next function provides the rules for transforming TEI to XHTML. It accepts an item and returns a sequence of items. All the child nodes from ```local:recurse``` get passed in to the typeswitch expression. The typeswitch expression dispatches the nodes it receives based on their node types.

```xquery
declare function local:render($node as item()) as item()* {
    typeswitch($node)
        case text() return $node
        case element(tei:ab) return local:recurse($node)
        case element(tei:c) return " "
        case element(tei:div1) return <html:div>{local:recurse($node)}</html:div>
        case element(tei:div2) return <html:div>{local:recurse($node)}</html:div>
        case element(tei:lb) return "/ "
        case element(tei:head) return <html:h1>{local:recurse($node)}</html:h1>
        case element(tei:sp) return (<html:p>{local:recurse($node)}</html:p>)
        case element(tei:speaker) return (<html:b>{local:recurse($node)}: </html:b>)
        case element(tei:stage) return local:set-stage($node)
        case element(tei:fw) return ()
        default return local:recurse($node)
};
```
The key to this function is the use of ```local:recurse``` to handle the child elements of nodes. By using recursion, this expression can walk down all the branches of the tree, applying the rules in ```local:render``` as it goes.

What is the base case in this recursive expression? As we recall, recursion continues until a base case is reached. If there is no base case, then we'll get a stack overflow error. In this expression, the base case is when a node has no child nodes. When that happens, ```local:recurse``` will return an empty sequence rather than calling ```local:render```. This base case is reached whenever we hit a leaf on our tree and cannot proceed any further. When we hit the last leaf on the last branch of the tree, the expression has no more work to do and returns the transformed tree as its value.


