%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%%

/* $1 = count of A, $2 = count of B, $3 = count of C, $4 = count of D */

stmt : A B C D '\n'
     {
         if ($1 == $3 && $2 == $4) {
             printf("Valid string for a^n b^m c^n d^m (n=%d, m=%d)\n", $1, $2);
         } else {
             printf("Invalid: Count mismatch (a=%d, b=%d, c=%d, d=%d)\n",
                    $1, $2, $3, $4);
         }
         return 0;
     }
     ;

/* Grammar enforces n >= 1 and m >= 1 automatically (no epsilon rules) */

A : A 'a'   { $$ = $1 + 1; }
  | 'a'     { $$ = 1; }
  ;

B : B 'b'   { $$ = $1 + 1; }
  | 'b'     { $$ = 1; }
  ;

C : C 'c'   { $$ = $1 + 1; }
  | 'c'     { $$ = 1; }
  ;

D : D 'd'   { $$ = $1 + 1; }
  | 'd'     { $$ = 1; }
  ;

%%

void yyerror(const char *s) {
    printf("Invalid syntax sequence: string must strictly follow order a...b...c...d... (n>=1, m>=1)\n");
}

int main(void) {
    printf("Enter string (pattern a^n b^m c^n d^m): ");
    yyparse();
    return 0;
}

