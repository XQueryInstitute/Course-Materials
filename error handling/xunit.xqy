xquery version "3.0";

(: imports the test module :)
import module namespace test="http://exist-db.org/xquery/xqsuite" at "resource:org/exist/xquery/lib/xqsuite/xqsuite.xql";

(: annotations come between the declare keyword and the function keyword :)
declare
    %test:name("cube")
    %test:args(2, 3)
    %test:assertEquals(8)
    function local:pow($number as xs:integer, $power as xs:integer) as xs:integer {
        if ($power = 0) then 1
        else $number * local:pow($number, $power - 1)
};

(: pass the function name & arity (i.e. number of arguments) into the test:suite function :)
test:suite(local:pow#2)
