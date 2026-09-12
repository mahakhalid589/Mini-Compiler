# Mini Compiler
A mini compiler project developed using C++. It performs lexical analysis and parsing for basic arithmetic expressions and variable declarations/assignments, demonstrating fundamental concepts of compiler design.
## Features
- Variable declaration (`int x;`)
- Variable assignment (`x = 10;`)
- Arithmetic operations: `+`, `-`, `*`, `/`
- Operator precedence handling
- Basic error detection (undeclared variables, division by zero)
## Files
- `lexer` — Lexical analyzer (tokenizer) written in Lex
- `parser` — Grammar rules and parser logic written in Yacc
## How to Compile & Run
```bash
flex lexer
bison -d parser
gcc lex.yy.c parser.tab.c -o mini_compiler
./mini_compiler
```
## Example Input
```
int a;
int b;
a = 5;
b = a + 3;
c = b + 2;
```

## Example Output
```
Declare variable a
Declare variable b
a = 5
b = 8
Error: variable c not declared
```

## Author
Maham Khalid
