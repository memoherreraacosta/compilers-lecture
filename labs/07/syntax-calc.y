%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    extern FILE *yyin;
    extern FILE *yyout;
    extern int yylineno;
%}

%union{
    int intVal;
    double doubleVal;
    char *stringVal;
}

%start lines
%token newline
%token floatdcl intdcl
%token print
%token assign
%token plus minus divi mult
%token <stringVal> id
%token <doubleVal> fnum 
%token <intVal> inum

%%
lines: /* empty */
    | lines line /* do nothing */ 

line: dec newline       { fprintf(yyout, "digraph Line%d {\n\t%s\n}\n",yylineno,$<stringVal>$); }
    | assig newline     { fprintf(yyout, "digraph Line%d {\n\t%s\n}\n",yylineno,$<stringVal>$); }
    | prin newline      { fprintf(yyout, "digraph Line%d {\n\t%s\n}\n",yylineno,$<stringVal>$); }
    ;

dec:  intdcl id { 
        char s[100];
        strcpy(s, "intdcl -> id -> ");
        strcat(s, $<stringVal>2);
        $<stringVal>$ = s;
        }
    | floatdcl id { 
        char s[100];
        strcpy(s, "floatdcl -> id -> ");
        strcat(s, $<stringVal>2);
        $<stringVal>$ = s;
        }
    ;

assig: id assign inum {
            char s[100];
            char snum[100];
            sprintf(s, "assign -> id, inum\n");
            strcat(s, "\tid -> ");
            strcat(s, $<stringVal>1);
            strcat(s, "\n ");
            strcat(s, "\tinum -> ");
            sprintf(snum, "%d", $<intVal>3);
            strcat(s, snum);
            $<stringVal>$ = s;
        }
    | id assign fnum {
        char s[100];
            char snum[100];
            sprintf(s, "assign -> id, fnum\n");
            strcat(s, "\tid -> ");
            strcat(s, $<stringVal>1);
            strcat(s, "\n ");
            strcat(s, "\tfnum -> ");
            sprintf(snum, "%f", $<doubleVal>3);
            strcat(s, snum);
            $<stringVal>$ = s;
    }
    | id assign id op inum {
            char s[100];
            char snum[100];
            // Assign -> id1, op
            sprintf(s, "assign -> id1, ");
            sprintf(snum, "%s", $<stringVal>4);
            strcat(s, snum);
            strcat(s, "\n");

            // op -> id2, inum
            strcat(s, "\t");
            strcat(s, snum);
            strcat(s, " -> id2, inum\n");

            // id1 -> idValue
            strcat(s, "\tid1 -> ");
            strcat(s, $<stringVal>1);
            strcat(s, "\n ");

            // id2 -> idValue
            strcat(s, "\tid2 -> ");
            strcat(s, $<stringVal>3);
            strcat(s, "\n ");

            //inum -> inumValue
            strcat(s, "\tinum -> ");
            sprintf(snum, "%d", $<intVal>5);
            strcat(s, snum);
            $<stringVal>$ = s;
    }

    | id assign id op fnum {
            char s[100];
            char snum[100];
            // Assign -> id1, op
            sprintf(s, "assign -> id1, ");
            sprintf(snum, "%s", $<stringVal>4);
            strcat(s, snum);
            strcat(s, "\n");

            // op -> id2, fnum
            strcat(s, "\t");
            strcat(s, snum);
            strcat(s, " -> id2, fnum\n");

            // id1 -> idValue
            strcat(s, "\tid1 -> ");
            strcat(s, $<stringVal>1);
            strcat(s, "\n ");

            // id2 -> idValue
            strcat(s, "\tid2 -> ");
            strcat(s, $<stringVal>3);
            strcat(s, "\n ");

            //inum -> inumValue
            strcat(s, "\tfnum -> ");
            sprintf(snum, "%f", $<doubleVal>5);
            strcat(s, snum);
            $<stringVal>$ = s;
    }
    ;

prin: print id {
            char s[100];
            char snum[100];
            sprintf(s, "print -> id\n\tid -> "); 
            strcat(s, $<stringVal>2);
            $<stringVal>$ = s;
        }
    | print inum{
            char s[100];
            char snum[100];
            sprintf(s, "print -> inum\n\tid -> "); 
            sprintf(snum, "%d", $<intVal>2);
            strcat(s, snum);
            $<stringVal>$ = s;
        }
    | print fnum{
            char s[100];
            char snum[100];
            sprintf(s, "print -> fnum\n\tid -> "); 
            sprintf(snum, "%f", $<doubleVal>2);
            strcat(s, snum);
            $<stringVal>$ = s;
        }
    ;

op: plus {$<stringVal>$ = "plus";}
    | minus {$<stringVal>$ = "minus";}
    | divi {$<stringVal>$ = "div";}
    | mult {$<stringVal>$ = "mult";}
    ;

%%

int main(int argc, char **argv){
    if(argc > 1){
        FILE *file;

        file = fopen(argv[1], "r");
        if(!file){
            printf("Error opening file\n");
            exit(1);
        }
        yyin = file;
    }

    yyout = fopen("AST.dot", "w");
    if(!yyout){
        printf("Couldn't open destination file\n");
        return 0;
    }
    return yyparse();
}

int yyerror (char *s) {fprintf (stderr, "%s\n", s);}