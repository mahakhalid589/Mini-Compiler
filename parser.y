%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

typedef struct {
    char* name;
    int value;
} Var;

Var symbolTable[100];
int symbolCount = 0;

int getVarIndex(char* name) {
    for(int i=0;i<symbolCount;i++) {
        if(strcmp(symbolTable[i].name,name)==0) return i;
    }
    return -1;
}
%}

%union {
    int num;
    char* id;
}

%token <id> ID
%token <num> NUM
%token INT ASSIGN SEMI
%token PLUS MINUS MUL DIV
%token LPAREN RPAREN

%type <num> expr term factor

%%

program:
    stmt_list
;

stmt_list:
    stmt_list stmt
  | stmt
;

stmt:
    INT ID SEMI {
        printf("Declare variable %s\n", $2);
        symbolTable[symbolCount].name = $2;
        symbolTable[symbolCount].value = 0;
        symbolCount++;
    }
  | ID ASSIGN expr SEMI {
        int idx = getVarIndex($1);
        if(idx>=0){
            symbolTable[idx].value = $3;
            printf("%s = %d\n", $1, $3);
        } else {
            printf("Error: variable %s not declared\n", $1);
        }
    }
;

expr:
    expr PLUS term  { $$ = $1 + $3; }
  | expr MINUS term { $$ = $1 - $3; }
  | term           { $$ = $1; }
;

term:
    term MUL factor { $$ = $1 * $3; }
  | term DIV factor { if($3==0){ printf("Error: division by zero\n"); $$=0; } else $$=$1/$3; }
  | factor { $$ = $1; }
;

factor:
    NUM { $$ = $1; }
  | ID {
        int idx = getVarIndex($1);
        if(idx>=0) $$ = symbolTable[idx].value;
        else { printf("Error: variable %s not declared\n", $1); $$ = 0; }
    }
  | LPAREN expr RPAREN { $$ = $2; }
;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter code (Ctrl+Z to end Windows / Ctrl+D Linux):\n");
    yyparse();
    return 0;
}
