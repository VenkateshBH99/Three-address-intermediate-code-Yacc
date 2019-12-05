lex program.l
yacc program.y
gcc y.tab.c -ll -ly -w
./a.out test