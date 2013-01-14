
mysqlparse: lex.yy.c
	gcc $< -lfl -o $@

lex.yy.c: mysql.flex
	flex -Cf -8 $<

