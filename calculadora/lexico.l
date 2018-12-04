%{
#include "tree.h"
#define YYSTYPE ptno
#include "calc.h" /*serão inseridos no cabecalho do programa em c tudo que estiver aqui*/

void yyerror (char *);
%}

%%

[a-z]	{
	yylval = criaNo (VAR,*yytext - 'a');
	return VAR;
	}

[A-Z]	{
	yylval = criaNo (VAR,*yytext - 'A');
	return VAR;
	}

[0-9]+	{
	yylval = criaNo (NUM,atoi(yytext));
	return VAR;
	}

"+"		return MAIS; /*agora os retornos serão enviados para o analisador sintático*/
"-"		return MENOS;
"*" 	return VEZES;
"/" 	return BARRA;
"(" 	return ABRE;
")" 	return FECHA;
"=" 	return IGUAL;
\n		return ENTER;
[ /t]	; /*não faz nada */
.	yyerror("simbolo invalido");

%%

int yywrap(void) {
	return 0;
}

			
