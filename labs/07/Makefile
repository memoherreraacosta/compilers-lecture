
all:
	yacc -d syntax-calc.y
	lex lexical_analyzer.l
	gcc y.tab.c lex.yy.c -ly -lfl -o analyzer

clean:
	rm -rf lex.yy.c
	rm -rf y.tab.c
	rm -rf y.tab.h
	rm -rf y.tab.h.gch
