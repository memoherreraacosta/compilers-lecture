%{
#include <stdio.h>
%}

%%
\/\/.*\n                {}
[\t]+                   {fprintf(yyout, " ");}
f                       {fprintf(yyout, "floatdcl");}
i                       {fprintf(yyout, "intdcl");}
p                       {fprintf(yyout, "print");}
=                       {fprintf(yyout, "assign");}
[a-eg-hj-oq-z]          {fprintf(yyout, "id");}
\+                      {fprintf(yyout, "plus");}
-                      {fprintf(yyout, "minus");}
\*                      {fprintf(yyout, "multiply");}
\/                      {fprintf(yyout, "divide");}
[0-9]+                  {fprintf(yyout, "inum");}
[0-9]+.[0-9]+           {fprintf(yyout, "fnum");}
<<EOF>>                 { return 0 ; }
%%

int yywrap(){} 
int main(int argc, char *argv[]) 
{ 
    yyin = fopen(argv[1], "r"); 
    yyout = fopen("lex.out", "w"); 
    yylex(); 
    return 0; 
}
