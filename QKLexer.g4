lexer grammar QKLexer; 

@lexer::members {
    public static final int WHITESPACE = 1;
    public static final int COMMENTS = 2;

    boolean isDigit(int i) {
       return (i>='0' && i<='9');
    }
} 

fragment 
WS_TOKEN: ' '|'\t'; 

fragment 
NOT_WS_TOKEN: ~(' '|'\t'); 

fragment 
NL_TOKEN: '\r'?'\n'; 

fragment 
NOT_NL_TOKEN: ~('\r'|'\n'); 

fragment 
WS_OR_NL_TOKEN: ' '|'\t'|'\r'|'\n'; 

fragment 
NOT_WS_NOR_NL_TOKEN: ~(' '|'\t'|'\r'|'\n'); 

fragment
DIGIT: '0'..'9';

fragment
HEX: DIGIT | 'A' .. 'F' | 'a' .. 'f';

fragment
LETTER: ('a'..'z'|'A'..'Z');

fragment
ASCII_PRINTABLE: ('!'|'#'..'['|']'..'~');

FUNS: '{' ;
FUNE: '}' ;
ARGS: '[' ; //args start in Q | table key defs start | block in if, while, $ map start in k)
ARGE: '[' ; //args end in Q | table key defs end | block end in if, while, $ map end in k)
LS: '(' ; //precedence, table, list start
LE: ')' ; //precedence, table, list end

NOT_EQUAL: '<>';
EQUAL: '=';
LESS_THAN: '<'{_input.LA(1) != '>'}?;
GREATER_THAN: {_input.LA(-1) != '<'}?'>';
MATCH: '~';

MAX: '|';
MIN: '&';

PLUS: '+';
MINUS: '-';
TIMES: '*';
DIVIDE: '%';
FILL: '^'; //coalesce

JOIN: ','; //enlist in some cases in k)
DROP_CUT: '_';
TAKE: '#';

SEPARATOR: ';';

COLON: {_input.LA(-1) != '\'' && _input.LA(-1) != '\\' && _input.LA(-1) != '/' && _input.LA(-1) != ':'}?':';
COLON0: '0:'; //TEXT FILE
COLON1: '1:'; //BINARY FILE
COLON2: '2:'; //LIB | PROC/MESSAGE
DOUBLECOLON: '::';
PEACH: '\':';
EACHRIGHT: '/:';
EACHLEFT: '\\:';
EACH: '\''{_input.LA(1) != ':'}?; //each or throw

OVER:'/'{_input.LA(1) != ':'}?;
SCAN:'\\'{_input.LA(1) != ':'}?;

DOT: '.';
//DOT_AMEND_TRAP_MODE: '.';
AT: '@';
//AT_AMEND_TRAP_MODE: '.';
CAST: '$';
// SYMBOL $ arg | CHAR $ arg | SHORT $ arg
// LONG $ CHAR_LIST padding
// calculate the dot product of two float lists
// q)1 2 3f$4 5 6f
// 32f
// calculate the product of two float matrices
// q)(1 2 3f;4 5 6f)$(7 8f;9 10f;11 12f)
// 58  64
// 139 154
// $[ ; ; ] conditional evaluation
// $[0b;`a;] `b
// $[1b;;`b] `a
//$[;`a;`b]1b
//'2014.08.04T15:05:13.472 type

//TODO -1! 0! etc
EMARK: '!';
//UPDATE_QUERY_MODE: '!';
//ENUM
//KEY
//DICT
//0N ! etc...
QMARK: '?';
//QMARK_COND_QUERY_MODE: '?';
//FIND
//RAND
//`:sym?

//1 | -1 WS+ "asd" stdout
//2 | -2 WS+ "asd" stderr
//other pos/neg int followed by () or "" is handle call
/*
This seems to allow spaces in between arg and $
ICAST:  '1h$' | '2h$' | '4h$' | '5h$' | '6h$' | '7h$' | '8h$' | '9h$' | '10h$' | '11h$' | '12h$' | '13h$' | '14h$' | '15h$' | '16h$' | '17h$' | '18h$' | '19h$';
CCAST: '"b"$' | '"g"$' | '"x"$' | '"h"$' | '"i"$' | '"j"$' | '"e"$' | '"f"$' | '"c"$' | '"s"$' | '"p"$' | '"m"$' | '"d"$' | '"z"$' | '"n"$' | '"u"$' | '"v"$' | '"t"$';
CPARSE: '"B"$' | '"G"$' | '"X"$' | '"H"$' | '"I"$' | '"J"$' | '"E"$' | '"F"$' | '"C"$' | '"S"$' | '"P"$' | '"M"$' | '"D"$' | '"Z"$' | '"N"$' | '"U"$' | '"V"$' | '"T"$';
SCAST:  '`boolean$1' | '`guid$1' | '`byte$' | '`short$' | '`int$' | '`long$' | '`real$' | '`float$' | '`char$' | '`$' | '`timestamp$' | '`month$' | '`date$' | '`datetime$' | '`timespan$' | '`minute$' | '`second$' | '`time$';
ENUMEMPTYLIST: '`'(DOT (LETTER | LETTER (DROP_CUT|LETTER|DIGIT)* (LETTER|DIGIT)))+
              | (LETTER | LETTER (DROP_CUT|LETTER|DIGIT)* (LETTER|DIGIT))'$()';
ENUMCAST: '`'(DOT (LETTER | LETTER (DROP_CUT|LETTER|DIGIT)* (LETTER|DIGIT)))+
              | (LETTER | LETTER (DROP_CUT|LETTER|DIGIT)* (LETTER|DIGIT))'$';
*/

DATETIMEOP: '.date' | '.year' | '.mm' | '.dd' | '.time' | '.hh' | '.minute' | '.ss';

//atoms and lists
//   numeric
fragment
NUM_DEC_PREFIX: ('-')? DIGIT+;

LONG: NUM_DEC_PREFIX | '0N' | '0W' | '-0W';
LONG_SUFFIXED: NUM_DEC_PREFIX 'j' | '0Nj' | '0Wj' | '-0Wj';
               
INT: NUM_DEC_PREFIX 'i' | '0Ni' | '0Wi' | '-0Wi';	

SHORT: NUM_DEC_PREFIX 'h' | '0Nh' | '0Wh' | '-0Wh';	

FLOAT: (('-.'| NUM_DEC_PREFIX?'.')DIGIT+|NUM_DEC_PREFIX'.'DIGIT*)('e''-'?DIGIT+)? | '0n' | '0w' | '-0w';
FLOAT_SUFFIXED: (NUM_DEC_PREFIX|(('-.'| NUM_DEC_PREFIX?'.')DIGIT+|NUM_DEC_PREFIX'.'DIGIT*)('e''-'?DIGIT+)?)'f' | '0nf' | '0wf' | '-0wf';

REAL: (NUM_DEC_PREFIX|(('-.'| NUM_DEC_PREFIX?'.')DIGIT+|NUM_DEC_PREFIX'.'DIGIT*)('e''-'?DIGIT+)?) 'e' { !isDigit(_input.LA(1)) &&  _input.LA(1)!= '-' }? | '0ne' | '0we' | '-0we' | '0Ne' | '0We' | '-0We';	

//   binary
BOOLEAN: '0b' | '1b';
BOOLEAN_LIST: ('0'|'1')('0'|'1')+'b';

BYTE: '0x' HEX HEX;
BYTE_LIST: '0x' HEX HEX HEX+;

//   guid
GUID: '0Ng';

//   temporal

MONTH: DIGIT DIGIT DIGIT DIGIT '.' DIGIT DIGIT 'm' | '0Nm' | '0Wm' | '-0Wm';

DATE: DIGIT DIGIT DIGIT DIGIT '.' DIGIT DIGIT '.' DIGIT DIGIT;
DATE_SUFFIXED: DIGIT DIGIT DIGIT DIGIT '.' DIGIT DIGIT '.' DIGIT DIGIT 'd' | '0Nd' | '0Wd' | '-0Wd';

MINUTE: DIGIT DIGIT ':' (DIGIT DIGIT)?; 
MINUTE_SUFFIXED: DIGIT DIGIT ':'? 'u'
    | DIGIT DIGIT ':' DIGIT DIGIT 'u'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 'u'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT* 'u'
    | '0Nu' | '0Wu' | '-0Wu';   
// MINUTE_LIST is of form MINUTE+ (MINUTE | MINUTE_SUFFIXED)
//                        | (MINUTE|SECOND|TIME)+ (MINUTE_SUFFIXED)

SECOND: DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT;
SECOND_SUFFIXED: DIGIT DIGIT ':'? 'v'
    | DIGIT DIGIT ':' DIGIT DIGIT 'v'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 'v'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT* 'v'
    | '0Nv' | '0Wv' | '-0Wv';
// SECOND_LIST is of form ((MINUTE)+? SECOND (MINUTE|SECOND)* | SECOND (MINUTE|SECOND)*) (SECOND|SECOND_SUFFIXED)?
//                        | ((MINUTE|SECOND)+? TIME (MINUTE|SECOND|TIME)* | TIME (MINUTE|SECOND|TIME)*) (SECOND_SUFFIXED)?

TIME: DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT DIGIT? DIGIT? DIGIT?;
TIME_SUFFIXED: DIGIT DIGIT ':' 't'
    | DIGIT+? ('.' DIGIT?)? 't'
    | DIGIT DIGIT ':' DIGIT DIGIT 't'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 't'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT* 't'
    | '0Nt' | '0Wt' | '-0Wt';
// TIME_LIST is of form ((MINUTE|SECOND)+? TIME (MINUTE|SECOND|TIME)* | TIME (MINUTE|SECOND|TIME)*) ((MINUTE|SECOND|TIME) TIME_SUFFIX?|TIME_SUFFIXED)?
//                        | (MINUTE|SECOND|TIME)+ ((MINUTE 't' |SECOND|TIME) TIME_SUFFIX|TIME_SUFFIXED)


fragment
DATE_FRAGMENT: DIGIT DIGIT DIGIT DIGIT '.' DIGIT DIGIT '.' DIGIT DIGIT;
DATETIME: DATE_FRAGMENT 'T'
    | DATE_FRAGMENT 'T' DIGIT DIGIT
    | DATE_FRAGMENT 'T' DIGIT DIGIT ':' DIGIT DIGIT
    | DATE_FRAGMENT 'T' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT ('.' DIGIT*)?;
DATETIME_SUFFIXED: DATE_FRAGMENT 'T' 'z'
    | DATE_FRAGMENT 'T' DIGIT DIGIT 'z'
    | DATE_FRAGMENT 'T' DIGIT DIGIT ':' DIGIT DIGIT 'z'
    | DATE_FRAGMENT 'T' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT ('.' DIGIT*)? 'z'
    | '0Nz' | '0Wz' | '-0Wz';
//DATE_TIME LIST is of form (DATE|DATETIME|TIMESTAMP)+ (DATETIME | DATETIME_SUFFIXED)

TIMESPAN: DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT DIGIT DIGIT DIGIT DIGIT+
    | DIGIT+ 'D' DIGIT*? ('.' DIGIT?)?
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT*;
TIMESPAN_SUFFIXED: DIGIT+? ('.' DIGIT?)? 'n'
    | DIGIT DIGIT ':' 'n'
    | DIGIT DIGIT ':' DIGIT DIGIT 'n'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 'n'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT* 'n'
    | DIGIT+ 'D' DIGIT*? ('.' DIGIT?)? 'n'
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT 'n'
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 'n'
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT* 'n'
    | '0Nn' | '0Wn' | '-0Wn';
// TIMESPAN_LIST is of form (FLOAT|MINUTE|SECOND|TIME|TIMESPAN)+? (TIMESPAN|TIMESPAN_SUFFIXED)?
    
TIMESTAMP: DATE_FRAGMENT 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT DIGIT DIGIT DIGIT DIGIT+
    | DATE_FRAGMENT 'D' DIGIT*? ('.' DIGIT?)?
    | DATE_FRAGMENT 'D' DIGIT DIGIT ':' DIGIT DIGIT
    | DATE_FRAGMENT 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT
    | DATE_FRAGMENT 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT*;
TIMESTAMP_SUFFIXED: DIGIT+? ('.' DIGIT?)? 'p'
    | DIGIT DIGIT ':' 'p'
    | DIGIT DIGIT ':' DIGIT DIGIT 'p'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 'p'
    | DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT* 'p'
    | DIGIT+ 'D' DIGIT*? ('.' DIGIT?)? 'p'
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT 'p'
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT 'p'
    | DIGIT+ 'D' DIGIT DIGIT ':' DIGIT DIGIT ':' DIGIT DIGIT '.' DIGIT* 'p'
    | '0Np' | '0Wp' | '-0Wp';
// TIMESTAMP_LIST is of form (FLOAT|MINUTE|SECOND|TIME|TIMESPAN|DATE|TIMESTAMP)+? (TIMESTAMP|TIMESTAMP_SUFFIXED)?

//   char related
SYMBOL: '`'((LETTER|DIGIT|'.'|':') (LETTER|DIGIT|'.'|':'|'_')* | (LETTER|DIGIT|'.'|':')* );
SYMBOL_LIST: SYMBOL SYMBOL+;

CHAR: '"'('\\' DIGIT DIGIT DIGIT | '\\\\' |  '\\"' | ' ' | '\\t' | '\\r' | '\\n' | ASCII_PRINTABLE )'"';
EMPTY_CHAR_LIST: '""';
CHAR_LIST_START: '"'  { (_input.LA(1)=='\\' && isDigit(_input.LA(2)) && isDigit(_input.LA(3)) && isDigit(_input.LA(4)) && _input.LA(5) != '"')
                 || (_input.LA(1)=='\\' && (_input.LA(2) == '\\' || _input.LA(2) == '"' || _input.LA(2) == 't' || _input.LA(2) == 'n' || _input.LA(2) == 'r' ) && _input.LA(3) != '"')
                 || (_input.LA(1)!='\\' &&  _input.LA(2) != '"') }? -> pushMode(INSIDE_CHAR_LIST);

ID: LETTER 
    | LETTER (DROP_CUT|LETTER|DIGIT)* (LETTER|DIGIT)
    | (DOT ID)+
    ;

//System commands


STATEMENT_SEPARATOR: WS_TOKEN*? NL_TOKEN { if(_input.LA(1) == '/' || _input.LA(1) == '\r' || _input.LA(1) == '\n' || _input.LA(1) == ' ' || _input.LA(1) == '\t') skip(); };

EL_COMMENT: {_input.LA(-1) != '\\' && _input.LA(-1) != '\n' && _input.LA(-1) != ' ' && _input.LA(-1) != '\t'}? WS_TOKEN+ '/' NOT_NL_TOKEN* -> channel(COMMENTS);

SL_COMMENT: ({getCharPositionInLine() == 0}?'/'NOT_WS_NOR_NL_TOKEN NOT_NL_TOKEN* 
            | {getCharPositionInLine() == 0}?'/'WS_TOKEN+ NOT_WS_NOR_NL_TOKEN NOT_NL_TOKEN*) -> channel(COMMENTS);

ML_COMMENT: {getCharPositionInLine() == 0}?'/' WS_TOKEN* NL_TOKEN .*?
            ({getCharPositionInLine() == 0}? '\\' WS_TOKEN* {_input.LA(1) == '\r' || _input.LA(1) == '\n'}? | EOF) -> channel(COMMENTS);

SKIP_WS: WS_TOKEN+ -> channel(WHITESPACE); 

mode INSIDE_CHAR_LIST;
CHAR_LIST_END: {_input.LA(-1) != '\\'}? '"' -> popMode;

INSIDE_CHAR_LIST_EL_COMMENT: {_input.LA(-1) != '\\' && _input.LA(-1) != '\n' && _input.LA(-1) != ' ' && _input.LA(-1) != '\t'}? WS_TOKEN+ '/' NOT_NL_TOKEN* -> channel(COMMENTS);

INSIDE_CHAR_LIST_SL_COMMENT: ({getCharPositionInLine() == 0}?'/'NOT_WS_NOR_NL_TOKEN NOT_NL_TOKEN*? NL_TOKEN 
            | {getCharPositionInLine() == 0}?'/'WS_TOKEN+ NOT_WS_NOR_NL_TOKEN NOT_NL_TOKEN*? NL_TOKEN) -> channel(COMMENTS);

INSIDE_CHAR_LIST_ML_COMMENT: {getCharPositionInLine() == 0}?'/' WS_TOKEN* NL_TOKEN .*?
            ({getCharPositionInLine() == 0}? '\\' WS_TOKEN* ? NL_TOKEN | EOF) -> channel(COMMENTS);

//TODO Better error check on disallowed \1 \12 \~[\"trn] etc
CHAR_LIST_PART: .+?;
