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
