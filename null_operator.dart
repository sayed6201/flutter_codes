There are now 4 null aware operators
=====================================================

-------------------------------------------------------
??     provides a default if the subject is null
-------------------------------------------------------
return subject ?? "defaultIfNull";



---------------------------------------------------------------------------------
??=     sets the subject to a default only if the subject is null
This is similar to ?? but sets the subject variable to a default if it is null.
---------------------------------------------------------------------------------
subject ??= "defaultIfNull";



------------------------------------------------------------------------------------------------------
?.     avoid an exception if subject is null when accessing subject's property
object?.x will return null if object is null, object.x would cause an exception if object were null
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
...?     from a spread collection, avoid a null item in the final list if the subject list is null
the result of the following
------------------------------------------------------------------------------------------------------
[
  ...[1, 2],
  null,
]
is [1, 2, null]



------------------------------------------------------------------------------------------------------
to avoid the null value use ...?
------------------------------------------------------------------------------------------------------
var resultingList = [
  ...[1, 2],
  ...?subjectList,
];