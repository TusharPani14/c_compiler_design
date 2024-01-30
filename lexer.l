%{
#include <stdio.h>
#include <string.h>

int l = 1;
int t = 0;
int j = 0;
int i, flag;
char str[20];

char keyword[30][30] = {"int", "main", "if", "else", "do", "while"};
%}

%%
[+-/*]    { printf("%7d\t\t %7d\t\t Operator\t %7c\n", l, t, yytext[0]); t++; }
[;{}()?@!%]    { printf("%7d\t\t %7d\t\t Special symbol\t %7c\n", l, t, yytext[0]); t++; }
[0-9]+    { printf("%7d\t\t %7d\t\t Digit\t\t %7s\n", l, t, yytext); t++; }
[a-zA-Z][a-zA-Z0-9]* {
    flag = 0;
    strcpy(str, yytext);
    for (j = 0; j < 30; j++) {
        if (strcmp(str, keyword[j]) == 0) {
            flag = 1;
            break;
        }
    }
    if (flag == 1) {
        printf("%7d\t\t %7d\t\t Keyword\t %7s\n", l, t, str);
        t++;
    } else {
        printf("%7d\t\t %7d\t\t Identifier\t %7s\n", l, t, str);
        t++;
    }
}
\n    { l++; }
.     { } // Ignore other characters

%%

int main()
{
    yylex();
    return 0;
}

