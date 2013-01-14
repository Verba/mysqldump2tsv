mysqlparse: lex.yy.c
	gcc $< -lfl -o $@

lex.yy.c: mysql.flex
	flex -Cf -8 $<

test: mysqlparse
	./$< test/one_row_one_col.sql | diff - test/one_row_one_col.tsv

