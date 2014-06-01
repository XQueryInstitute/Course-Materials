#Error Handling

Learning how to diagnose, interpret, and overcome errors constitutes a major part of learning to program in any language.

###Three Kinds of Error

There are essentially three kinds of error in XQuery: static errors, dynamic errors, and type errors. The [XQuery Recommendation](http://www.w3.org/TR/2014/REC-xquery-30-20140408/#id-kinds-of-errors) defines and discusses the differences between these errors.

* Static Errors

>[Definition: An error that can be detected during the static analysis phase, and is not a type error, is a static error.] A syntax error is an example of a static error.

Static errors are the most common form of mistakes, especially when you are beginning to program. If you make a syntax mistake, such as using ```=``` for assignment rather than ```:=``` or forgetting to include a matching parenthesis/bracket, you have committed a static error. This is a static error because an XQuery interpreter will catch it before your program even runs (technically, it gets caught during the static analysis phase).  

* Dynamics Errors

>[Definition: A dynamic error is an error that must be detected during the dynamic evaluation phase and may be detected during the static analysis phase.] Numeric overflow is an example of a dynamic error.

A dynamic error, by contrast, may not be caught before your program runs. You may have gotten the syntax right but still have gone awry with your program logic. For example, you may have written a recursive function that does not specify properly a base case. If so, the function will continue to call itself until it runs out of space on the stack, resulting in a [stack overflow](http://en.wikipedia.org/wiki/Stack_overflow). This error may not be detectable until the program executes (technically, until the dynamic evaluation phase). This is the kind of "bug" that crashes your program after it begins running. In general, these kinds of "bugs" are harder to diagnose and resolve.

* Type Errors

>[Definition: A type error may be raised during the static analysis phase or the dynamic evaluation phase. During the static analysis phase, a type error occurs when the static type of an expression does not match the expected type of the context in which the expression occurs. During the dynamic evaluation phase, a type error occurs when the dynamic type of a value does not match the expected type of the context in which the value occurs.]

A common source of errors arises from type mismatches. We've already seen how to write functions that check the types of their inputs and outputs. Sending an argument of the wrong type to a function results in type error. A good example of this mistake is when your program produces a "number" that is actually a xs:string and you send that "number" to a function requiring an xs:integer as input. In order to avoid such an error, you will need first to cast the string to an integer first.

For example, this expression checks if a variable can be cast as an xs:integer and, if not, throws an error.

```xquery
let $num := "1"
let $int := if ($num castable as xs:integer) then xs:integer($num) else fn:error()
return $int
```

[Try it!](http://try.zorba.io/queries/xquery/meFXr1HHu%2BGBe7O3l1aj40GxStk%3D)

This style of defensive programing helps to surface type mismatches which might otherwise produce hard-to-diagnose bugs in your code.

###Try...Catch Expressions



