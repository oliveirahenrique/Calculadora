calc : 	lexico.l calc.y
	flex -t lexico.l > lexico.c
	bison -v -d calc.y -o calc.c
	gcc calc.c -o calc

limpa : 
	rm -f lexico.c calc.c calc.output +~ calc.h calc\