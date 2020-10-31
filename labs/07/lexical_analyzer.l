%{
    #include <stdio.h>
    #include "y.tab.h"
%}
%option yylineno
%option noyywrap

%%
[\t]+                           // Ignore tabs
[/]{2}[[a-zA-Z0-9]*[\t ]*]*\n   // Ignore comments
[\n]                            return newline;
f                               return floatdcl;
i                               return intdcl;
p                               return print;
=                               return assign;
\-                              return minus;
\+                              return plus;
\/                              return divi;
\*                              return mult;
[a-e]|[g-h]|[j-o]|[q-z]         {yylval.stringVal = strdup(yytext); return id;}
[0-9]+"."[0-9]+                 {yylval.doubleVal = atof(yytext); return fnum;}
[0-9]+                          {yylval.intVal = atoi(yytext); return inum; }
%%

