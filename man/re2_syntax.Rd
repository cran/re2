% Generated file <Girish Palya>
\name{re2_syntax}
\alias{re2_syntax}
\title{RE2 Regular Expression Syntax}
\description{


The simplest regular expression is a single literal character.
Except for the metacharacters like
*+?()|,
characters match themselves.
To match a metacharacter, escape it with
a backslash:
\\+
matches a literal plus character.



Two regular expressions can be alternated or concatenated to form a new
regular expression:
if e_1 matches
s
and e_2 matches
t,
then e_1|e_2 matches
s
or
t,
and
e_1e_2
matches
st.



The metacharacters
*,
+,
and
?
are repetition operators:
e_1*
matches a sequence of zero or more (possibly different)
strings, each of which match e_1;
e_1+
matches one or more;
e_1?
matches zero or one.



The operator precedence, from weakest to strongest binding, is
first alternation, then concatenation, and finally the
repetition operators.
Explicit parentheses can be used to force different meanings,
just as in arithmetic expressions.
Some examples:
ab|cd
is equivalent to
(ab)|(cd);
ab*
is equivalent to
a(b*).



The syntax described so far is most of the traditional Unix
egrep
regular expression syntax.
This subset suffices to describe all regular
languages: loosely speaking, a regular language is a set
of strings that can be matched in a single pass through
the text using only a fixed amount of memory.
Newer regular expression facilities (notably Perl and
those that have copied it) have added
many new operators and escape sequences, which make the regular
expressions more concise, and sometimes more cryptic, but usually
not more powerful.


This page lists the regular expression syntax accepted by RE2.
It also lists some syntax accepted by PCRE, PERL, and VIM.

\tabular{llll}{
\bold{kinds of single-character expressions} \tab \bold{examples} \cr
any character, possibly including newline (s=true) \tab . \cr
character class \tab [xyz] \cr
negated character class \tab [^xyz] \cr
Perl character class (see below)(link) \tab \\d \cr
negated Perl character class \tab \\D \cr
ASCII character class (see below)(link) \tab [[:alpha:]] \cr
negated ASCII character class \tab [[:^alpha:]] \cr
Unicode character class (one-letter name) \tab \\pN \cr
Unicode character class \tab \\p\{Greek\} \cr
negated Unicode character class (one-letter name) \tab \\PN \cr
negated Unicode character class \tab \\P\{Greek\} \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Composites} \cr
xy \tab x followed by y \cr
x|y \tab x or y (prefer x) \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Repetitions} \cr
x* \tab zero or more x, prefer more \cr
x+ \tab one or more x, prefer more \cr
x? \tab zero or one x, prefer one \cr
x\{n,m\} \tab n or n+1 or ... or m x, prefer more \cr
x\{n,\} \tab n or more x, prefer more \cr
x\{n\} \tab exactly n x \cr
x*? \tab zero or more x, prefer fewer \cr
x+? \tab one or more x, prefer fewer \cr
x?? \tab zero or one x, prefer zero \cr
x\{n,m\}? \tab n or n+1 or ... or m x, prefer fewer \cr
x\{n,\}? \tab n or more x, prefer fewer \cr
x\{n\}? \tab exactly n x \cr
x\{\} \tab (= x*) (NOT SUPPORTED) VIM \cr
x\{-\} \tab (= x*?) (NOT SUPPORTED) VIM \cr
x\{-n\} \tab (= x\{n\}?) (NOT SUPPORTED) VIM \cr
x= \tab (= x?) (NOT SUPPORTED) VIM \cr
} 


Implementation restriction: The counting forms x\{n,m\}, x\{n,\}, and x\{n\} reject forms that create a minimum or maximum repetition count above 1000. Unlimited repetitions are not subject to this restriction.

\tabular{llll}{
\bold{} \tab \bold{Possessive repetitions} \cr
x*+ \tab zero or more x, possessive (NOT SUPPORTED) \cr
x++ \tab one or more x, possessive (NOT SUPPORTED) \cr
x?+ \tab zero or one x, possessive (NOT SUPPORTED) \cr
x\{n,m\}+ \tab n or ... or m x, possessive (NOT SUPPORTED) \cr
x\{n,\}+ \tab n or more x, possessive (NOT SUPPORTED) \cr
x\{n\}+ \tab exactly n x, possessive (NOT SUPPORTED) \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Grouping} \cr
(re) \tab numbered capturing group (submatch) \cr
(?P<name>re) \tab named & numbered capturing group (submatch) \cr
(?<name>re) \tab named & numbered capturing group (submatch) (NOT SUPPORTED) \cr
(?'name're) \tab named & numbered capturing group (submatch) (NOT SUPPORTED) \cr
(?:re) \tab non-capturing group \cr
(?flags) \tab set flags within current group; non-capturing \cr
(?flags:re) \tab set flags during re; non-capturing \cr
(?#text) \tab comment (NOT SUPPORTED) \cr
(?|x|y|z) \tab branch numbering reset (NOT SUPPORTED) \cr
(?>re) \tab possessive match of re (NOT SUPPORTED) \cr
re@> \tab possessive match of re (NOT SUPPORTED) VIM \cr
\%(re) \tab non-capturing group (NOT SUPPORTED) VIM \cr
} 



\tabular{llll}{
\bold{} \tab \bold{Flags} \cr
i \tab case-insensitive (default false) \cr
m \tab multi-line mode: ^ and $ match begin/end line in addition to begin/end text (default false) \cr
s \tab let . match \\n (default false) \cr
U \tab ungreedy: swap meaning of x* and x*?, x+ and x+?, etc (default false) \cr
} 


Flag syntax is xyz (set) or -xyz (clear) or xy-z (set xy, clear z).

\tabular{llll}{
\bold{} \tab \bold{Empty strings} \cr
^ \tab at beginning of text or line (m=true) \cr
$ \tab at end of text (like \\z not \\Z) or line (m=true) \cr
\\A \tab at beginning of text \cr
\\b \tab at ASCII word boundary (\\w on one side and \\W, \\A, or \\z on the other) \cr
\\B \tab not at ASCII word boundary \cr
\\g \tab at beginning of subtext being searched (NOT SUPPORTED) PCRE \cr
\\G \tab at end of last match (NOT SUPPORTED) PERL \cr
\\Z \tab at end of text, or before newline at end of text (NOT SUPPORTED) \cr
\\z \tab at end of text \cr
(?=re) \tab before text matching re (NOT SUPPORTED) \cr
(?!re) \tab before text not matching re (NOT SUPPORTED) \cr
(?<=re) \tab after text matching re (NOT SUPPORTED) \cr
(?<!re) \tab after text not matching re (NOT SUPPORTED) \cr
re& \tab before text matching re (NOT SUPPORTED) VIM \cr
re@= \tab before text matching re (NOT SUPPORTED) VIM \cr
re@! \tab before text not matching re (NOT SUPPORTED) VIM \cr
re@<= \tab after text matching re (NOT SUPPORTED) VIM \cr
re@<! \tab after text not matching re (NOT SUPPORTED) VIM \cr
\\zs \tab sets start of match (= \\K) (NOT SUPPORTED) VIM \cr
\\ze \tab sets end of match (NOT SUPPORTED) VIM \cr
\\\%^ \tab beginning of file (NOT SUPPORTED) VIM \cr
\\\%$ \tab end of file (NOT SUPPORTED) VIM \cr
\\\%V \tab on screen (NOT SUPPORTED) VIM \cr
\\\%# \tab cursor position (NOT SUPPORTED) VIM \cr
\\\%'m \tab mark m position (NOT SUPPORTED) VIM \cr
\\\%23l \tab in line 23 (NOT SUPPORTED) VIM \cr
\\\%23c \tab in column 23 (NOT SUPPORTED) VIM \cr
\\\%23v \tab in virtual column 23 (NOT SUPPORTED) VIM \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Escape sequences} \cr
\\a \tab bell (= \\007) \cr
\\f \tab form feed (= \\014) \cr
\\t \tab horizontal tab (= \\011) \cr
\\n \tab newline (= \\012) \cr
\\r \tab carriage return (= \\015) \cr
\\v \tab vertical tab character (= \\013) \cr
\\* \tab literal *, for any punctuation character * \cr
\\123 \tab octal character code (up to three digits) \cr
\\x7F \tab hex character code (exactly two digits) \cr
\\x\{10FFFF\} \tab hex character code \cr
\\C \tab match a single byte even in UTF-8 mode \cr
\\Q...\\E \tab literal text ... even if ... has punctuation \cr
\\1 \tab backreference (NOT SUPPORTED) \cr
\\b \tab backspace (NOT SUPPORTED) (use \\010) \cr
\\cK \tab control char ^K (NOT SUPPORTED) (use \\001 etc) \cr
\\e \tab escape (NOT SUPPORTED) (use \\033) \cr
\\g1 \tab backreference (NOT SUPPORTED) \cr
\\g\{1\} \tab backreference (NOT SUPPORTED) \cr
\\g\{+1\} \tab backreference (NOT SUPPORTED) \cr
\\g\{-1\} \tab backreference (NOT SUPPORTED) \cr
\\g\{name\} \tab named backreference (NOT SUPPORTED) \cr
\\g<name> \tab subroutine call (NOT SUPPORTED) \cr
\\g'name' \tab subroutine call (NOT SUPPORTED) \cr
\\k<name> \tab named backreference (NOT SUPPORTED) \cr
\\k'name' \tab named backreference (NOT SUPPORTED) \cr
\\lX \tab lowercase X (NOT SUPPORTED) \cr
\\ux \tab uppercase x (NOT SUPPORTED) \cr
\\L...\\E \tab lowercase text ... (NOT SUPPORTED) \cr
\\K \tab reset beginning of $0 (NOT SUPPORTED) \cr
\\N\{name\} \tab named Unicode character (NOT SUPPORTED) \cr
\\R \tab line break (NOT SUPPORTED) \cr
\\U...\\E \tab upper case text ... (NOT SUPPORTED) \cr
\\X \tab extended Unicode sequence (NOT SUPPORTED) \cr
\\\%d123 \tab decimal character 123 (NOT SUPPORTED) VIM \cr
\\\%xFF \tab hex character FF (NOT SUPPORTED) VIM \cr
\\\%o123 \tab octal character 123 (NOT SUPPORTED) VIM \cr
\\\%u1234 \tab Unicode character 0x1234 (NOT SUPPORTED) VIM \cr
\\\%U12345678 \tab Unicode character 0x12345678 (NOT SUPPORTED) VIM \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Character class elements} \cr
x \tab single character \cr
A-Z \tab character range (inclusive) \cr
\\d \tab Perl character class \cr
[:foo:] \tab ASCII character class foo \cr
\\p\{Foo\} \tab Unicode character class Foo \cr
\\pF \tab Unicode character class F (one-letter name) \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Named character classes as character class elements} \cr
[\\d] \tab digits (= \\d) \cr
[^\\d] \tab not digits (= \\D) \cr
[\\D] \tab not digits (= \\D) \cr
[^\\D] \tab not not digits (= \\d) \cr
[[:name:]] \tab named ASCII class inside character class (= [:name:]) \cr
[^[:name:]] \tab named ASCII class inside negated character class (= [:^name:]) \cr
[\\p\{Name\}] \tab named Unicode property inside character class (= \\p\{Name\}) \cr
[^\\p\{Name\}] \tab named Unicode property inside negated character class (= \\P\{Name\}) \cr
} 



\tabular{llll}{
\bold{} \tab \bold{Perl character classes (all ASCII-only)} \cr
\\d \tab digits (= [0-9]) \cr
\\D \tab not digits (= [^0-9]) \cr
\\s \tab whitespace (= [\\t\\n\\f\\r ]) \cr
\\S \tab not whitespace (= [^\\t\\n\\f\\r ]) \cr
\\w \tab word characters (= [0-9A-Za-z_]) \cr
\\W \tab not word characters (= [^0-9A-Za-z_]) \cr
\\h \tab horizontal space (NOT SUPPORTED) \cr
\\H \tab not horizontal space (NOT SUPPORTED) \cr
\\v \tab vertical space (NOT SUPPORTED) \cr
\\V \tab not vertical space (NOT SUPPORTED) \cr
} 



\tabular{llll}{
\bold{} \tab \bold{ASCII character classes} \cr
[[:alnum:]] \tab alphanumeric (= [0-9A-Za-z]) \cr
[[:alpha:]] \tab alphabetic (= [A-Za-z]) \cr
[[:ascii:]] \tab ASCII (= [\\x00-\\x7F]) \cr
[[:blank:]] \tab blank (= [\\t ]) \cr
[[:cntrl:]] \tab control (= [\\x00-\\x1F\\x7F]) \cr
[[:digit:]] \tab digits (= [0-9]) \cr
[[:graph:]] \tab graphical (= [!-~] = [A-Za-z0-9!"#$\%&'()*+,\\-./:;<=>?@[\\\\\\]^_`\{|\}~]) \cr
[[:lower:]] \tab lower case (= [a-z]) \cr
[[:print:]] \tab printable (= [ -~] = [ [:graph:]]) \cr
[[:punct:]] \tab punctuation (= [!-/:-@[-`\{-~]) \cr
[[:space:]] \tab whitespace (= [\\t\\n\\v\\f\\r ]) \cr
[[:upper:]] \tab upper case (= [A-Z]) \cr
[[:word:]] \tab word characters (= [0-9A-Za-z_]) \cr
[[:xdigit:]] \tab hex digit (= [0-9A-Fa-f]) \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Unicode character class names--general category} \cr
C \tab other \cr
Cc \tab control \cr
Cf \tab format \cr
Cn \tab unassigned code points (NOT SUPPORTED) \cr
Co \tab private use \cr
Cs \tab surrogate \cr
L \tab letter \cr
LC \tab cased letter (NOT SUPPORTED) \cr
L& \tab cased letter (NOT SUPPORTED) \cr
Ll \tab lowercase letter \cr
Lm \tab modifier letter \cr
Lo \tab other letter \cr
Lt \tab titlecase letter \cr
Lu \tab uppercase letter \cr
M \tab mark \cr
Mc \tab spacing mark \cr
Me \tab enclosing mark \cr
Mn \tab non-spacing mark \cr
N \tab number \cr
Nd \tab decimal number \cr
Nl \tab letter number \cr
No \tab other number \cr
P \tab punctuation \cr
Pc \tab connector punctuation \cr
Pd \tab dash punctuation \cr
Pe \tab close punctuation \cr
Pf \tab final punctuation \cr
Pi \tab initial punctuation \cr
Po \tab other punctuation \cr
Ps \tab open punctuation \cr
S \tab symbol \cr
Sc \tab currency symbol \cr
Sk \tab modifier symbol \cr
Sm \tab math symbol \cr
So \tab other symbol \cr
Z \tab separator \cr
Zl \tab line separator \cr
Zp \tab paragraph separator \cr
Zs \tab space separator \cr
} 


\tabular{llll}{
\bold{Unicode character class names--scripts} \cr
Adlam \cr
Ahom \cr
Anatolian_Hieroglyphs \cr
Arabic \cr
Armenian \cr
Avestan \cr
Balinese \cr
Bamum \cr
Bassa_Vah \cr
Batak \cr
Bengali \cr
Bhaiksuki \cr
Bopomofo \cr
Brahmi \cr
Braille \cr
Buginese \cr
Buhid \cr
Canadian_Aboriginal \cr
Carian \cr
Caucasian_Albanian \cr
Chakma \cr
Cham \cr
Cherokee \cr
Chorasmian \cr
Common \cr
Coptic \cr
Cuneiform \cr
Cypriot \cr
Cyrillic \cr
Deseret \cr
Devanagari \cr
Dives_Akuru \cr
Dogra \cr
Duployan \cr
Egyptian_Hieroglyphs \cr
Elbasan \cr
Elymaic \cr
Ethiopic \cr
Georgian \cr
Glagolitic \cr
Gothic \cr
Grantha \cr
Greek \cr
Gujarati \cr
Gunjala_Gondi \cr
Gurmukhi \cr
Han \cr
Hangul \cr
Hanifi_Rohingya \cr
Hanunoo \cr
Hatran \cr
Hebrew \cr
Hiragana \cr
Imperial_Aramaic \cr
Inherited \cr
Inscriptional_Pahlavi \cr
Inscriptional_Parthian \cr
Javanese \cr
Kaithi \cr
Kannada \cr
Katakana \cr
Kayah_Li \cr
Kharoshthi \cr
Khitan_Small_Script \cr
Khmer \cr
Khojki \cr
Khudawadi \cr
Lao \cr
Latin \cr
Lepcha \cr
Limbu \cr
Linear_A \cr
Linear_B \cr
Lisu \cr
Lycian \cr
Lydian \cr
Mahajani \cr
Makasar \cr
Malayalam \cr
Mandaic \cr
Manichaean \cr
Marchen \cr
Masaram_Gondi \cr
Medefaidrin \cr
Meetei_Mayek \cr
Mende_Kikakui \cr
Meroitic_Cursive \cr
Meroitic_Hieroglyphs \cr
Miao \cr
Modi \cr
Mongolian \cr
Mro \cr
Multani \cr
Myanmar \cr
Nabataean \cr
Nandinagari \cr
New_Tai_Lue \cr
Newa \cr
Nko \cr
Nushu \cr
Nyiakeng_Puachue_Hmong \cr
Ogham \cr
Ol_Chiki \cr
Old_Hungarian \cr
Old_Italic \cr
Old_North_Arabian \cr
Old_Permic \cr
Old_Persian \cr
Old_Sogdian \cr
Old_South_Arabian \cr
Old_Turkic \cr
Oriya \cr
Osage \cr
Osmanya \cr
Pahawh_Hmong \cr
Palmyrene \cr
Pau_Cin_Hau \cr
Phags_Pa \cr
Phoenician \cr
Psalter_Pahlavi \cr
Rejang \cr
Runic \cr
Samaritan \cr
Saurashtra \cr
Sharada \cr
Shavian \cr
Siddham \cr
SignWriting \cr
Sinhala \cr
Sogdian \cr
Sora_Sompeng \cr
Soyombo \cr
Sundanese \cr
Syloti_Nagri \cr
Syriac \cr
Tagalog \cr
Tagbanwa \cr
Tai_Le \cr
Tai_Tham \cr
Tai_Viet \cr
Takri \cr
Tamil \cr
Tangut \cr
Telugu \cr
Thaana \cr
Thai \cr
Tibetan \cr
Tifinagh \cr
Tirhuta \cr
Ugaritic \cr
Vai \cr
Wancho \cr
Warang_Citi \cr
Yezidi \cr
Yi \cr
Zanabazar_Square \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Vim character classes} \cr
\\i \tab identifier character (NOT SUPPORTED) VIM \cr
\\I \tab \\i except digits (NOT SUPPORTED) VIM \cr
\\k \tab keyword character (NOT SUPPORTED) VIM \cr
\\K \tab \\k except digits (NOT SUPPORTED) VIM \cr
\\f \tab file name character (NOT SUPPORTED) VIM \cr
\\F \tab \\f except digits (NOT SUPPORTED) VIM \cr
\\p \tab printable character (NOT SUPPORTED) VIM \cr
\\P \tab \\p except digits (NOT SUPPORTED) VIM \cr
\\s \tab whitespace character (= [ \\t]) (NOT SUPPORTED) VIM \cr
\\S \tab non-white space character (= [^ \\t]) (NOT SUPPORTED) VIM \cr
\\d \tab digits (= [0-9]) VIM \cr
\\D \tab not \\d VIM \cr
\\x \tab hex digits (= [0-9A-Fa-f]) (NOT SUPPORTED) VIM \cr
\\X \tab not \\x (NOT SUPPORTED) VIM \cr
\\o \tab octal digits (= [0-7]) (NOT SUPPORTED) VIM \cr
\\O \tab not \\o (NOT SUPPORTED) VIM \cr
\\w \tab word character VIM \cr
\\W \tab not \\w VIM \cr
\\h \tab head of word character (NOT SUPPORTED) VIM \cr
\\H \tab not \\h (NOT SUPPORTED) VIM \cr
\\a \tab alphabetic (NOT SUPPORTED) VIM \cr
\\A \tab not \\a (NOT SUPPORTED) VIM \cr
\\l \tab lowercase (NOT SUPPORTED) VIM \cr
\\L \tab not lowercase (NOT SUPPORTED) VIM \cr
\\u \tab uppercase (NOT SUPPORTED) VIM \cr
\\U \tab not uppercase (NOT SUPPORTED) VIM \cr
\\_x \tab \\x plus newline, for any x (NOT SUPPORTED) VIM \cr
\\c \tab ignore case (NOT SUPPORTED) VIM \cr
\\C \tab match case (NOT SUPPORTED) VIM \cr
\\m \tab magic (NOT SUPPORTED) VIM \cr
\\M \tab nomagic (NOT SUPPORTED) VIM \cr
\\v \tab verymagic (NOT SUPPORTED) VIM \cr
\\V \tab verynomagic (NOT SUPPORTED) VIM \cr
\\Z \tab ignore differences in Unicode combining characters (NOT SUPPORTED) VIM \cr
} 


\tabular{llll}{
\bold{} \tab \bold{Magic} \cr
(?\{code\}) \tab arbitrary Perl code (NOT SUPPORTED) PERL \cr
(??\{code\}) \tab postponed arbitrary Perl code (NOT SUPPORTED) PERL \cr
(?n) \tab recursive call to regexp capturing group n (NOT SUPPORTED) \cr
(?+n) \tab recursive call to relative group +n (NOT SUPPORTED) \cr
(?-n) \tab recursive call to relative group -n (NOT SUPPORTED) \cr
(?C) \tab PCRE callout (NOT SUPPORTED) PCRE \cr
(?R) \tab recursive call to entire regexp (= (?0)) (NOT SUPPORTED) \cr
(?&name) \tab recursive call to named group (NOT SUPPORTED) \cr
(?P=name) \tab named backreference (NOT SUPPORTED) \cr
(?P>name) \tab recursive call to named group (NOT SUPPORTED) \cr
(?(cond)true|false) \tab conditional branch (NOT SUPPORTED) \cr
(?(cond)true) \tab conditional branch (NOT SUPPORTED) \cr
(*ACCEPT) \tab make regexps more like Prolog (NOT SUPPORTED) \cr
(*COMMIT) \tab (NOT SUPPORTED) \cr
(*F) \tab (NOT SUPPORTED) \cr
(*FAIL) \tab (NOT SUPPORTED) \cr
(*MARK) \tab (NOT SUPPORTED) \cr
(*PRUNE) \tab (NOT SUPPORTED) \cr
(*SKIP) \tab (NOT SUPPORTED) \cr
(*THEN) \tab (NOT SUPPORTED) \cr
(*ANY) \tab set newline convention (NOT SUPPORTED) \cr
(*ANYCRLF) \tab (NOT SUPPORTED) \cr
(*CR) \tab (NOT SUPPORTED) \cr
(*CRLF) \tab (NOT SUPPORTED) \cr
(*LF) \tab (NOT SUPPORTED) \cr
(*BSR_ANYCRLF) \tab set \\R convention (NOT SUPPORTED) PCRE \cr
(*BSR_UNICODE) \tab (NOT SUPPORTED) PCRE \cr
} 

}

