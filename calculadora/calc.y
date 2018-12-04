%{
#include <stdio.h>
#include <stdlib.h>
#include "lexico.c" /*arquivo do lexico vindo do lexico.l*/
#include "tree.c"


ptno raiz = NULL, pt;
int valores[26];
%}


//vocabulário
%token NUM
%token MENOS
%token MAIS
%token VAR
%token VEZES
%token BARRA
%token ABRE
%token FECHA
%token IGUAL
%token ENTER

%start programa /*Variavel de partida*/

%left MAIS MENOS/*precendencia das operações da esquerda. Associatividade as operações de MAIS e MENOS*/
%left VEZES BARRA //precedencia * e / maior que + -

//leitra da preferencia será da direta para esquerda e baixo para cima
%%

    /*aqui vem as regras da gramatica*/
    /*regra                          ação semantica*/
    /*     -------------------------->*/

programa:
	programa calculo ENTER
		{
			raiz = $2;
			mostra (raiz,0);
		}
	|
	;

calculo :
	expr {$$ = $1;}
	| VAR IGUAL expr
		{
			pt = criaNo (IGUAL,0);
			adicionaFilho (pt,$3);
			adicionaFilho (pt,$1);
			$$ = pt;
		}
;

expr :	NUM             {$$ = $1;}
	| VAR 		{$$ = $1;}
	| expr MAIS expr 
		{
			pt = criaNo (MAIS,0);
			adicionaFilho (pt,$3);
			adicionaFilho (pt,$3);
			$$ = pt;
		}
	| expr MENOS expr
		{
			pt = criaNo (MENOS,0);
			adicionaFilho (pt,$3);
			adicionaFilho (pt,$3);
			$$ = pt;
		}
	| expr VEZES expr
		{
			pt = criaNo (VEZES,0);
			adicionaFilho (pt,$3);
			adicionaFilho (pt,$3);
			$$ = pt;
		}
	| expr BARRA expr
		{
			pt = criaNo (BARRA,0);
			adicionaFilho (pt,$3);
			adicionaFilho (pt,$3);
			$$ = pt;
		}
	| ABRE expr FECHA
		{
			$$ = $2;
		}
	;

%%

void yyerror (char *s) { printf("%s\n", s); }

int main() {
	yyparse();//funcao do analisador sintático, é nele que esta toda a funcao do analisador sintatico
	return 0;
}
