%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%%
stmt: S '\n' { printf("Valid: Bracket sequence pairs match perfectly.\n"); exit(0); }
    ;

S   : S '(' S ')'   /* Handles both nested (()) and adjacent ()() pairs */
    | /* empty */   /* Base case for recursion */
    ;
%%

void yyerror(const char *s) {
    printf("Invalid: Bracket mismatch or improper sequence.\n");
    exit(0);
}

int main(void) {
    printf("Enter bracket sequence (e.g., (())()): ");
    yyparse();
    return 0;
}
