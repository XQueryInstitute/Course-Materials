xquery version "1.0";

(:~ The purpose of this main module is to demontrate the use of a recursive function.
:   @author Clifford Anderson
:   @version 1.0
:)

(:~ This function raises a given integer by a given power. 
:   @author Clifford Anderson
    @version 1.0
    @see http://stackoverflow.com/a/15369640;;Adapted from Michael Kay's example on Stackoverflow.
    @param $number An integer to be raised by a power
    @param $power An integer indicating the power to be raised
    @return An integer
:)
declare function local:pow($number as xs:integer, $power as xs:integer) as xs:integer {
  if ($power = 0) then 1
  else $number * local:pow($number, $power - 1)
};

local:pow(2,3)