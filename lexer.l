%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yywrap(void) { return 1; }
%}


%%

[ \t\n]+                ;               // Ignore whitespace
"int"                   { return INT; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.id = strdup(yytext); return ID; }
[0-9]+                  { yylval.num = atoi(yytext); return NUM; }
"="                     { return ASSIGN; }
";"                     { return SEMI; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }

.                       { printf("Unknown character: %s\n", yytext); }

%%
