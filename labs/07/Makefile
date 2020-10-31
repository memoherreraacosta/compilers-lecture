
all:
	yacc -d syntax-calc.y
	flex lexical_analyzer.l
	gcc -ly -o syntax-calc y.tab.c lex.yy.c

clean:
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
