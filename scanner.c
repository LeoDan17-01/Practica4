#include <stdio.h>

#include "scanner.h"

extern int yylex(void);
extern char *yytext;

int main(void)
{
	int token;

	while ((token = yylex()) != TOK_EOF) {
		printf("[%s:%s]\n", scanner_token_name(token), yytext);
	}

	return 0;
}

const char *scanner_token_name(int token)
{
	switch (token) {
		case TOK_EOF: return "EOF";
		case TOK_ERROR: return "ERROR";
		case TOK_KW_INT: return "KW_INT";
		case TOK_KW_FLOAT: return "KW_FLOAT";
		case TOK_KW_DOUBLE: return "KW_DOUBLE";
		case TOK_KW_CHAR: return "KW_CHAR";
		case TOK_KW_STRING: return "KW_STRING";
		case TOK_KW_BOOL: return "KW_BOOL";
		case TOK_KW_VOID: return "KW_VOID";
		case TOK_KW_IF: return "KW_IF";
		case TOK_KW_ELSE: return "KW_ELSE";
		case TOK_KW_WHILE: return "KW_WHILE";
		case TOK_KW_FOR: return "KW_FOR";
		case TOK_KW_FOREACH: return "KW_FOREACH";
		case TOK_KW_IN: return "KW_IN";
		case TOK_KW_RETURN: return "KW_RETURN";
		case TOK_KW_BREAK: return "KW_BREAK";
		case TOK_KW_CONTINUE: return "KW_CONTINUE";
		case TOK_KW_VAR: return "KW_VAR";
		case TOK_KW_CONST: return "KW_CONST";
		case TOK_KW_DEF: return "KW_DEF";
		case TOK_KW_PRINT: return "KW_PRINT";
		case TOK_KW_TRUE: return "KW_TRUE";
		case TOK_KW_FALSE: return "KW_FALSE";
		case TOK_KW_TABLA: return "KW_TABLA";
		case TOK_KW_CAPTURA: return "KW_CAPTURA";
		case TOK_KW_MIDE: return "KW_MIDE";
		case TOK_KW_AVOGADRO: return "KW_AVOGADRO";
		case TOK_KW_DESDE: return "KW_DESDE";
		case TOK_KW_HASTA: return "KW_HASTA";
		case TOK_KW_ANALIZA: return "KW_ANALIZA";
		case TOK_KW_MUESTRA: return "KW_MUESTRA";
		case TOK_KW_BASE: return "KW_BASE";
		case TOK_KW_PRUEBA: return "KW_PRUEBA";
		case TOK_KW_NEUTRALIZA: return "KW_NEUTRALIZA";
		case TOK_KW_EXPLOTA: return "KW_EXPLOTA";
		case TOK_KW_COMPUESTO: return "KW_COMPUESTO";
		case TOK_KW_NULO: return "KW_NULO";
		case TOK_IDENTIFIER: return "IDENTIFIER";
		case TOK_INT_LITERAL: return "INT_LITERAL";
		case TOK_FLOAT_LITERAL: return "FLOAT_LITERAL";
		case TOK_STRING_LITERAL: return "STRING_LITERAL";
		case TOK_CHAR_LITERAL: return "CHAR_LITERAL";
		case TOK_PLUS: return "PLUS";
		case TOK_MINUS: return "MINUS";
		case TOK_MULT: return "MULT";
		case TOK_DIV: return "DIV";
		case TOK_MOD: return "MOD";
		case TOK_POW: return "POW";
		case TOK_EQ: return "EQ";
		case TOK_NEQ: return "NEQ";
		case TOK_GTE: return "GTE";
		case TOK_LTE: return "LTE";
		case TOK_LT: return "LT";
		case TOK_GT: return "GT";
		case TOK_AND_LOGIC: return "AND_LOGIC";
		case TOK_OR_LOGIC: return "OR_LOGIC";
		case TOK_NOT_LOGIC: return "NOT_LOGIC";
		case TOK_AND_BIT: return "AND_BIT";
		case TOK_OR_BIT: return "OR_BIT";
		case TOK_NOT_BIT: return "NOT_BIT";
		case TOK_SHIFT_LEFT: return "SHIFT_LEFT";
		case TOK_SHIFT_RIGHT: return "SHIFT_RIGHT";
		case TOK_SHIFT_RIGHT_UNSIGNED: return "SHIFT_RIGHT_UNSIGNED";
		case TOK_ASSIGN: return "ASSIGN";
		case TOK_PLUS_ASSIGN: return "PLUS_ASSIGN";
		case TOK_MINUS_ASSIGN: return "MINUS_ASSIGN";
		case TOK_MULT_ASSIGN: return "MULT_ASSIGN";
		case TOK_DIV_ASSIGN: return "DIV_ASSIGN";
		case TOK_MOD_ASSIGN: return "MOD_ASSIGN";
		case TOK_AND_ASSIGN: return "AND_ASSIGN";
		case TOK_OR_ASSIGN: return "OR_ASSIGN";
		case TOK_XOR_ASSIGN: return "XOR_ASSIGN";
		case TOK_SHL_ASSIGN: return "SHL_ASSIGN";
		case TOK_SHR_ASSIGN: return "SHR_ASSIGN";
		case TOK_SHRU_ASSIGN: return "SHRU_ASSIGN";
		case TOK_INCREMENT: return "INCREMENT";
		case TOK_DECREMENT: return "DECREMENT";
		case TOK_ARROW: return "ARROW";
		case TOK_REVERSIBLE: return "REVERSIBLE";
		case TOK_FAT_ARROW: return "FAT_ARROW";
		case TOK_QUESTION: return "QUESTION";
		case TOK_MAS: return "MAS";
		case TOK_MENOS: return "MENOS";
		case TOK_POR: return "POR";
		case TOK_ENTRE: return "ENTRE";
		case TOK_ELEVA: return "ELEVA";
		case TOK_RAIZ: return "RAIZ";
		case TOK_RESIDUO_MOD: return "RESIDUO_MOD";
		case TOK_EQUILIBRA: return "EQUILIBRA";
		case TOK_DESEQUILIBRA: return "DESEQUILIBRA";
		case TOK_MAYOR_IGUAL: return "MAYOR_IGUAL";
		case TOK_MENOR_IGUAL: return "MENOR_IGUAL";
		case TOK_MAYOR: return "MAYOR";
		case TOK_MENOR: return "MENOR";
		case TOK_UNIDO: return "UNIDO";
		case TOK_MEZCLA: return "MEZCLA";
		case TOK_INVIERTE: return "INVIERTE";
		case TOK_ENLACE_BITS: return "ENLACE_BITS";
		case TOK_MEZCLA_BITS: return "MEZCLA_BITS";
		case TOK_INTERCAMBIA: return "INTERCAMBIA";
		case TOK_INVIERTE_BITS: return "INVIERTE_BITS";
		case TOK_IZQUIERDA: return "IZQUIERDA";
		case TOK_DERECHA_SIN_SIGNO: return "DERECHA_SIN_SIGNO";
		case TOK_DERECHA: return "DERECHA";
		case TOK_LPAREN: return "LPAREN";
		case TOK_RPAREN: return "RPAREN";
		case TOK_LBRACKET: return "LBRACKET";
		case TOK_RBRACKET: return "RBRACKET";
		case TOK_LBRACE: return "LBRACE";
		case TOK_RBRACE: return "RBRACE";
		case TOK_COMMA: return "COMMA";
		case TOK_SEMICOLON: return "SEMICOLON";
		case TOK_DOT: return "DOT";
		case TOK_COLON: return "COLON";
		default: return "UNKNOWN";
	}
}
