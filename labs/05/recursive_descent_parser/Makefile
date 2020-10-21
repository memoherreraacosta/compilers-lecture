all :
	lex lexic_analyzer.l
	yacc -d semantic_analyzer.y
	cc y.tab.c lex.yy.c
	./a.out
clean:
	rm lex.yy.c a.out y.tab.c y.tab.h	