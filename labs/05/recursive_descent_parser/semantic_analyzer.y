%{
#include <stdio.h>
%}
%start inicial
%token I E PLUS MUL
%left '\n'
%%                  
inicial:                       
        I segundo
        |
        I {printf("Valido\n");} 
        ;
segundo:
        PLUS I segundo
        |
        MUL  I segundo
        |
        MUL  I segundo {printf("Valido\n");}
        |
        PLUS I {printf("Valido\n");}
        ;
%%
int main(){
    return(yyparse());
}
int yyerror(s)
char *s;
{
  fprintf(stderr, "The input was invalid for the given grammar\n");
}
int yywrap()
{
  return(1);
}
