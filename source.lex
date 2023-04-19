%{
/* Declaration section*/
#include <stdio.h>
void showToken(char *);
%}

%option yylineno
%option noyywrap
%option warn
%option debug
relop       ==|!=|[<>]|<=|>= //TODO: maybe needs ()
binop       [+-*/]
comment     \/\/[^\r\n]*
whitespace [\t\n\r ]
printable [ -~\t\n\r]
escape [] //TODO: fill
digit ([0-9])
positivedigit ([1-9])
letter ([a-zA-Z])



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
.
%%

void showToken(char* name){
    printf("%d %d %s\n", yylineno, name, yytext); //TODO:todo
}