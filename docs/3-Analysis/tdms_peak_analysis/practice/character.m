

%{
CHARACTERS:
- similar to a numeric array
- however, things get printed differently!
- similar, to regular arrays

- char('','') creates vertical array, and padds spaces
- deblanck: removes any trailing spaces. (useful when extracting data)
- with character arrays, you will want to store different words in
different columns! because concatenating horizantally produces longer
strings!!!
- cellstr(): character -> cell array
- char(): converts back
- iscellstr: checks for array of "strings" (character arrays are strings???)

QUESTIONS:
- "" vs ''
- string-"" vs character array-'' (things upgrade to string when concatenated)

OTHER:
- structs are unique in that you extend an array by indexing to it.
%}

% strings()
% strlength(str)
% split(str,delimiter)
%
%
%

a = "This is cool";
disp(split(a))







