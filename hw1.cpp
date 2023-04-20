#include "tokens.hpp"
#include <string>
#include <iostream>

void handleString();


int main()
{
    std::vector<std::string> map = {"EMPTY", "VOID", "INT", "BYTE", "B", "BOOL", "AND", "OR", "NOT", "TRUE", "FALSE",
                                    "RETURN", "IF", "ELSE", "WHILE", "BREAK", "CONTINUE", "SC", "COMMA", "LPAREN", "RPAREN",
                                    "LBRACE", "RBRACE" ,"ASSIGN", "RELOP", "BINOP", "COMMENT", "ID", "NUM", "STRING", "OVERRIDE",
                                    "ILLEGAL_ESCAPE", "GENERAL_ERROR","OPEN_STRING", "ILLEGAL_HEX"}
	int token;
	while ((token = yylex())) {
	  if(token >= VOID && token < COMMENT || token > COMMENT && token <= NUM || token == OVERRIDE) {
          std::cout << yylineno << " " << map[token] << " " << yytext << "\n";
      }
      else if (token == COMMENT) {
          std::cout << yylineno << " " << name << " //" << "\n";
      }
      else if(token == STRING) {

      }
      else if(token == ILLEGAL_ESCAPE) {
          std::cout << "Error undefined escape sequence " << yylex[yyleng - 1] << "\n";
      }

      else if(token == GENERAL_ERROR) {
          std::cout << "Error " << yytext[0] << "\n";
      }
      else if(token == OPEN_STRING) {
          std::cout << "Error unclosed string\n";
      }
	}
	return 0;
}
