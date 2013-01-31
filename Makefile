all: clean mysqlparse mysqlparse.noheader test

clean:
	rm *.c

mysqlparse: lex.yy.c
	gcc $< -lfl -o $@

lex.yy.c: mysql.flex
	flex -Cf -8 $<

mysqlparse.noheader: lex.noheader.yy.c
	gcc $< -lfl -o $@

lex.noheader.yy.c: mysql.noheader.flex
	flex -Cf -8 --outfile=$@ $<

test_one_row_one_col: mysqlparse
	./$< test/input/one_row_one_col.sql - 2> /dev/null | diff - test/expected/one_row_one_col.tsv

test_one_row_two_col: mysqlparse
	./$< test/input/one_row_two_col.sql - 2> /dev/null | diff - test/expected/one_row_two_col.tsv

test_multiple_commas_per_schema_line: mysqlparse
	./$< test/input/multiple_commas_per_schema_line.sql - 2> /dev/null | diff - test/expected/multiple_commas_per_schema_line.tsv

test_schema_with_index: mysqlparse
	./$< test/input/schema_with_index.sql - 2> /dev/null | diff - test/expected/schema_with_index.tsv

test: test_one_row_one_col test_one_row_two_col test_multiple_commas_per_schema_line test_schema_with_index

