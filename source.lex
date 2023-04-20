%{
/* Declaration section*/
#include <stdio.h>
%}

%option yylineno
%option noyywrap
%option warn
%option debug
relop       ==|!=|[<>]|<=|>= //TODO: maybe needs ()
binop       [+-*/]
comment     \/\/[^\r\n]*
whitespace [\t\n\r ]
digit ([0-9])
positivedigit ([1-9])
letter ([a-zA-Z])
printable [ !#-\[\]-~]
escape \\[\\"nrt0]
hex \\x[0-7A-Fa-f][0-9A-Fa-f]
string ({printable}|{escape}|{hex})*
illegalescape \\[^\\"nrt0]


%%
void return VOID;
int return INT;
byte return BYTE;
b return B; //TODO: check the literal thing
bool return BOOL;
override return OVERRIDE;
and return AND;
or return OR;
not return NOT;
true return TRUE;
false return FALSE;
return return RETURN;
else return ELSE;
while return WHILE;
break return BREAK;
continue return CONTINUE;
; return SC;
, return COMMA;
\( return LPAREN;
\) return RPAREN;
{ return LBRACE;
} return RBRACE;
= return ASSIGN;
relop return RELOP;
binop return BINOP;
comment return COMMENT;
{letter}{letter | digit}* return ID;
(0 | {positivedigit}{digit}*) return NUM;
\"{string}\" return STRING;
\"{string}{illegalescape} return ILLEGAL_ESCAPE;
\"{string}\\x([0-9A-Za-z]){1,2} return ILLEGAL_HEX;
\"{string} return OPEN_STRING;
\"{string}[\n] return OPEN_STRING;
{whitespace} ;
. return GENERAL_ERROR
%%


