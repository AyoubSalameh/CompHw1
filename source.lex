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



%%
"void" showToken("VOID");
"int" showToken("INT");
"byte" showToken("BYTE");
"b" showToken("B"); //TODO: check the literal thing
"bool" showToken("BOOL");
"override" showToken("OVERRIDE");
"and" showToken("AND");
"or" showToken("OR");
"not" showToken("NOT");
"true" showToken("TRUE");
"false" showToken("FALSE");
"return" showToken("RETURN");
"else" showToken("ELSE");
"while" showToken("WHILE");
"break" showToken("BREAK");
"continue" showToken("CONTINUE");
";" showToken("SC");
"," showToken("COMMA");
"(" showToken("LPAREN");
")" showToken("RPAREN");
"{" showToken("LBRACE");
"}" showToken("RBRACE");
"=" showToken("ASSIGN");
relop showToken("RELOP");
binop showToken("BINOP");
comment showToken("COMMENT");

.
%%

void showToken(char* name){
    printf("%d %d %s\n", yylineno, name, yytext); //TODO:todo
}