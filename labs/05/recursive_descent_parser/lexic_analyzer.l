%{
 
#include <stdio.h>
#include "y.tab.h"
extern int yylval;
%}
%%
" "                 ;
[0-9]+              {return(I);}
\+                  {return(PLUS);}
\*                  {return(MUL);}
[0-9]+              {return(0);}
\n                  {return(0);}
%%
