[reference](http://zvon.org/comp/r/tut-XPath_1.html#Pages~List_of_XPaths)


## /

if path starts with /, it represent an absolute path to the required element.

## //

if starts with // then all elements in the documents fulfill following criteria are selected.

## *

The * select all elements located by preceeding path

## []

Expression in square can further specify an element.
* a number in the brackets gives the position of the elements.
* the function last() selects the last element in the selection.

## Attributes

### //@id
select all id

### //BBB[@id]
select BBB elements which have attribute id

### `//BBB[@*]`
select BBB elements which have any Attributes

### `//BBB[not(@*)]`
Select BBB elements without an attribute

## Attribute Values

Value of attributes can be used as selection critiria.

* ///BBB[@id="b1"] select BBB elements which have attribute id with value b1

* //BBB[normalize-space(@name)='bbb']

Select BBB elements which have attribute name with value bbb, leading and trailing spaces are removed before comparison

## Nodes counting

Function count() counts the number of selected elements

`//*[count(BBB)=2]`
Select elements which have two children BBB

`//*[count(*)=2]`
Select elements which have 2 children

## Names of selected elements
Function name() returns name of the element

`//*[name()='BBB']`
Select all elements with name BBB, equivalent with //BBB

`//*[starts-with(name(),'B')]`
Select all elements name of which starts with letter B

`//*[contains(name(),'C')]`
Select all elements name of which contain letter C

## Combining XPaths With |
Several paths can be combined with | separator.
`//CCC | //BBB`
Select all elements CCC and BBB

## Different Axis

* child
* parent
* etc
