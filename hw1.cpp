#include "tokens.hpp"
#include <string>
#include <vector>
#include <iostream>

void handleString(){
    std::string s = "";
    for(int i = 1; i < yyleng-1; i++) {
        if(yytext[i] != '\\') {
            s+=yytext[i];
        }
        else {
            i++;
            if(yytext[i] == 'n') {
                s+="\n";
            }
            if(yytext[i] == 'r') {
                s+="\r";
            }
            if(yytext[i] == 't') {
                s+="\t";
            }
            if(yytext[i] == '\\') {
                s+="\\";
            }
            if(yytext[i] == '\"') {
                s+="\"";
            }
            ///added
            if(yytext[i] == '\0') {
                s+="\0";
                break;
            }
            if(yytext[i] == 'x') {
                i++;
                std::string firstDig{yytext[i]};
                i++;
                std::string secondDig{yytext[i]};
                std::string tmp = "x" + firstDig + secondDig;
                int hex_val = std::stoi(tmp.substr(1), nullptr, 16);
                ///added
                if(hex_val == 0) {
                    s+="\0";
                    break;
                }
                char rep_char = static_cast<char>(hex_val);
                s += rep_char;
            }
        }
    }
	std::cout << yylineno << " STRING " << s << "\n";
}



int main()
{
    std::vector<std::string> map = {"EMPTY", "VOID", "INT", "BYTE", "B", "BOOL", "AND", "OR", "NOT", "TRUE", "FALSE",
                                    "RETURN", "IF", "ELSE", "WHILE", "BREAK", "CONTINUE", "SC", "COMMA", "LPAREN", "RPAREN",
                                    "LBRACE", "RBRACE" ,"ASSIGN", "RELOP", "BINOP", "COMMENT", "ID", "NUM", "STRING", "OVERRIDE",
                                    "ILLEGAL_ESCAPE", "GENERAL_ERROR","OPEN_STRING", "ILLEGAL_HEX"};
	int token;
	while ((token = yylex())) {
		if(token >= VOID && token < COMMENT || token > COMMENT && token <= NUM || token == OVERRIDE) {
			std::cout << yylineno << " " << map[token] << " " << yytext << "\n";
		}
		else if (token == COMMENT) {
			std::cout << yylineno << " " << "COMMENT" << " //" << "\n";
		}
		else if(token == STRING) {
			handleString();
		}
		else if(token == ILLEGAL_ESCAPE) {
			int i = yyleng - 1;
			while(yytext[i-1] != '\\') {
				i--;
			}

			std::cout << "Error undefined escape sequence ";
			if(yytext[i] != 'x') {
				std::cout << yytext[i] << "\n";
			}
			else{
				while(i<yyleng) {
					std::cout << yytext[i];
					i++;
				}
				std::cout << "\n";
			}
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
