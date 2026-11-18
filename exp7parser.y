%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%%
stmt: S '\n' { printf("Valid string for a^n b^n (n >= 0)\n"); exit(0); }
    ;

S   : 'a' S 'b'
    | /* empty string allows n = 0 */
    ;
%%

void yyerror(const char *s) {
    printf("Invalid string: does not match a^n b^n\n");
    exit(0);
}

int main(void) {
    printf("Enter string to test: ");
    yyparse();
    return 0;
}
