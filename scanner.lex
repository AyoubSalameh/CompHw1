%{
/* Declaration section*/
#include <stdio.h>
#include "tokens.hpp"
%}

%option yylineno
%option noyywrap

relop       ==|!=|[<>]|<=|>=
binop       [\+\-\*\/]
comment     \/\/[^\r\n]*
whitespace [\t\n\r ]
tab [\t]
digit ([0-9])
positivedigit ([1-9])
letter ([a-zA-Z])
printable [ !#-\[\]-~]
escape \\[\\"nrt0]
hex \\x[0-7][0-9A-Fa-f]
string ({printable}|{tab}|{escape}|{hex})*
illegalescape \\[^\\"nrt0]
illegalhex \\x([0-9A-Za-z]){1,2}

%%
void return VOID;
int return INT;
byte return BYTE;
b return B;
bool return BOOL;
override return OVERRIDE;
and return AND;
or return OR;
not return NOT;
true return TRUE;
false return FALSE;
return return RETURN;
if return IF;
else return ELSE;
while return WHILE;
break return BREAK;
continue return CONTINUE;
; return SC;
, return COMMA;
\( return LPAREN;
\) return RPAREN;
\{ return LBRACE;
\} return RBRACE;
= return ASSIGN;
{relop} return RELOP;
{binop} return BINOP;
{comment} return COMMENT;
{letter}({letter}|{digit})* return ID;
(0|({positivedigit}{digit}*)) return NUM;
\"{string}\" return STRING;
\"{string}({illegalhex}|{illegalescape}) return ILLEGAL_ESCAPE;
\"{string} return OPEN_STRING;
\"{string}[\n] return OPEN_STRING;
{whitespace} ;
. return GENERAL_ERROR;
%%


