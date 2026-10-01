%option noyywrap yylineno

%{
#include <stdio.h>
#include "scanner.h"

/* Bandera: la cadena actual contiene una secuencia de escape invalida */
static int str_bad = 0;
/* Linea donde inicio el comentario de bloque / cadena (para reportes) */
static int start_line = 0;
%}

/* Estados exclusivos: dentro de ellos NO aplican las reglas de INITIAL */
%x COMMENT
%x STRING

ID          [a-zA-Z_][a-zA-Z0-9_]*
INT         [0-9]+
HEX         0[xX][0-9a-fA-F]+
BIN         0[bB][01]+
EXP         [eE][+-]?{INT}
FLOAT       ({INT}\.{INT}?{EXP}?|\.{INT}{EXP}?|{INT}{EXP})
WS          [ \t\r\n]+
ESC         \\[ntr0\\'"]

%%

 /* ---------- Comentarios ---------- */
"/*"                    { start_line = yylineno; BEGIN(COMMENT); }
<COMMENT>"*/"           { BEGIN(INITIAL); }
<COMMENT>\n             { /* yylineno se actualiza solo */ }
<COMMENT>[^*\n]+        { /* descartar */ }
<COMMENT>"*"            { /* asterisco suelto, descartar */ }
<COMMENT><<EOF>>        {
                            fprintf(stderr, "Error lexico: comentario de bloque sin cerrar (iniciado en linea %d)\n", start_line);
                            BEGIN(INITIAL);   /* evita ciclo infinito en EOF */
                            return TOK_ERROR;
                        }

"//"[^\n]*              { /* comentario de linea */ }

{WS}                    { /* ignorar espacios */ }

 /* ---------- Palabras reservadas tematica quimica (antes que {ID}) ---------- */
"MOL"                   { return TOK_KW_INT; }
"GRAMO"                 { return TOK_KW_FLOAT; }
"ISOTOPO"                { return TOK_KW_DOUBLE; }
"ION"                  { return TOK_KW_CHAR; }
"MOLECULA"                { return TOK_KW_STRING; }
"ESTADO"                  { return TOK_KW_BOOL; }
"VACIO"                  { return TOK_KW_VOID; }
"REACCIONA"                    { return TOK_KW_IF; }
"INERTE"                  { return TOK_KW_ELSE; }
"DESTILA"                 { return TOK_KW_WHILE; }
"TITULA"                   { return TOK_KW_FOR; }
"CENTRIFUGA"               { return TOK_KW_FOREACH; }
"EN"                    { return TOK_KW_IN; }
"PRODUCTO"                { return TOK_KW_RETURN; }
"PRECIPITA"                 { return TOK_KW_BREAK; }
"DILUYE"              { return TOK_KW_CONTINUE; }
"ATOMO"                   { return TOK_KW_VAR; }
"NOBLE"                 { return TOK_KW_CONST; }
"SINTETIZA"                   { return TOK_KW_DEF; }
"EMITE"                 { return TOK_KW_PRINT; }
"ESTABLE"                  { return TOK_KW_TRUE; }
"INESTABLE"                 { return TOK_KW_FALSE; }

 /* Extras: nativas, rango, arreglo, switch, excepciones, struct, null */
"TABLA"                 { return TOK_KW_TABLA; }
"CAPTURA"               { return TOK_KW_CAPTURA; }
"MIDE"                  { return TOK_KW_MIDE; }
"AVOGADRO"              { return TOK_KW_AVOGADRO; }
"DESDE"                 { return TOK_KW_DESDE; }
"HASTA"                 { return TOK_KW_HASTA; }
"ANALIZA"               { return TOK_KW_ANALIZA; }
"MUESTRA"               { return TOK_KW_MUESTRA; }
"BASE"                  { return TOK_KW_BASE; }
"PRUEBA"                { return TOK_KW_PRUEBA; }
"NEUTRALIZA"            { return TOK_KW_NEUTRALIZA; }
"EXPLOTA"               { return TOK_KW_EXPLOTA; }
"COMPUESTO"             { return TOK_KW_COMPUESTO; }
"NULO"                  { return TOK_KW_NULO; }

 /* ---------- Operadores (longest match resuelve <, <<, <<=, >, >>, >>>, >>>=) ---------- */
 /* Aritmeticos */
"+"                     { return TOK_PLUS; }
"-"                     { return TOK_MINUS; }
"*"                     { return TOK_MULT; }
"/"                     { return TOK_DIV; }
"%"                     { return TOK_MOD; }
"^"                     { return TOK_POW; }

 /* Comparacion */
"=="                    { return TOK_EQ; }
"!="                    { return TOK_NEQ; }
">="                    { return TOK_GTE; }
"<="                    { return TOK_LTE; }
"<"                     { return TOK_LT; }
">"                     { return TOK_GT; }

 /* Logicos */
"&&"                    { return TOK_AND_LOGIC; }
"||"                    { return TOK_OR_LOGIC; }
"!"                     { return TOK_NOT_LOGIC; }

 /* Bitwise (simbolos) */
"&"                     { return TOK_AND_BIT; }
"|"                     { return TOK_OR_BIT; }
"~"                     { return TOK_NOT_BIT; }
"<<"                    { return TOK_SHIFT_LEFT; }
">>"                    { return TOK_SHIFT_RIGHT; }
">>>"                   { return TOK_SHIFT_RIGHT_UNSIGNED; }

 /* Asignacion */
"="                     { return TOK_ASSIGN; }
"+="                    { return TOK_PLUS_ASSIGN; }
"-="                    { return TOK_MINUS_ASSIGN; }
"*="                    { return TOK_MULT_ASSIGN; }
"/="                    { return TOK_DIV_ASSIGN; }
"%="                    { return TOK_MOD_ASSIGN; }
"&="                    { return TOK_AND_ASSIGN; }
"|="                    { return TOK_OR_ASSIGN; }
"^="                    { return TOK_XOR_ASSIGN; }
"<<="                   { return TOK_SHL_ASSIGN; }
">>="                   { return TOK_SHR_ASSIGN; }
">>>="                  { return TOK_SHRU_ASSIGN; }

 /* Incremento / Decremento / Flecha */
"++"                    { return TOK_INCREMENT; }
"--"                    { return TOK_DECREMENT; }
"->"                    { return TOK_ARROW; }
 /* Equilibrio reversible, flecha gruesa, ternario (longest match vs <, <=, =, ->) */
"<->"                   { return TOK_REVERSIBLE; }
"=>"                    { return TOK_FAT_ARROW; }
"?"                     { return TOK_QUESTION; }

 /* Palabras reservadas para operadores (antes que {ID}; longest match
    distingue MAYOR / MAYOR_IGUAL y DERECHA / DERECHA_SIN_SIGNO) */
"MAS"                   { return TOK_MAS; }
"MENOS"                 { return TOK_MENOS; }
"POR"                   { return TOK_POR; }
"ENTRE"                 { return TOK_ENTRE; }
"ELEVA"                 { return TOK_ELEVA; }
"RAIZ"                  { return TOK_RAIZ; }
"RESIDUO_MOD"           { return TOK_RESIDUO_MOD; }
"EQUILIBRA"             { return TOK_EQUILIBRA; }
"DESEQUILIBRA"          { return TOK_DESEQUILIBRA; }
"MAYOR_IGUAL"           { return TOK_MAYOR_IGUAL; }
"MENOR_IGUAL"           { return TOK_MENOR_IGUAL; }
"MAYOR"                 { return TOK_MAYOR; }
"MENOR"                 { return TOK_MENOR; }
"UNIDO"                 { return TOK_UNIDO; }
"MEZCLA"                { return TOK_MEZCLA; }
"INVIERTE"              { return TOK_INVIERTE; }
"ENLACE_BITS"           { return TOK_ENLACE_BITS; }
"MEZCLA_BITS"           { return TOK_MEZCLA_BITS; }
"INTERCAMBIA"           { return TOK_INTERCAMBIA; }
"INVIERTE_BITS"         { return TOK_INVIERTE_BITS; }
"IZQUIERDA"             { return TOK_IZQUIERDA; }
"DERECHA_SIN_SIGNO"     { return TOK_DERECHA_SIN_SIGNO; }
"DERECHA"               { return TOK_DERECHA; }

 /* Delimitadores */
"("                     { return TOK_LPAREN; }
")"                     { return TOK_RPAREN; }
"["                     { return TOK_LBRACKET; }
"]"                     { return TOK_RBRACKET; }
"{"                     { return TOK_LBRACE; }
"}"                     { return TOK_RBRACE; }
","                     { return TOK_COMMA; }
";"                     { return TOK_SEMICOLON; }
"."                     { return TOK_DOT; }
":"                     { return TOK_COLON; }

 /* ---------- Literales ---------- */
{HEX}|{BIN}             { return TOK_INT_LITERAL; }
{FLOAT}                 { return TOK_FLOAT_LITERAL; }
{INT}                   { return TOK_INT_LITERAL; }
\'([^\\'\n]|{ESC})\'    { return TOK_CHAR_LITERAL; }

\"                      { str_bad = 0; start_line = yylineno; yymore(); BEGIN(STRING); }

<STRING>[^\\"\n]+       { yymore(); }
<STRING>{ESC}           { yymore(); }
<STRING>\\(.|\n)        {
                            fprintf(stderr, "Error lexico linea %d: secuencia de escape invalida '%s'\n", yylineno, yytext + yyleng - 2);
                            str_bad = 1;
                            yymore();
                        }
<STRING>\"              {
                            BEGIN(INITIAL);
                            return str_bad ? TOK_ERROR : TOK_STRING_LITERAL;
                        }
<STRING>\n              {
                            yyless(yyleng - 1);   /* devolver el \n: no forma parte del lexema erroneo */
                            fprintf(stderr, "Error lexico linea %d: cadena sin cerrar (salto de linea)\n", yylineno);
                            BEGIN(INITIAL);
                            return TOK_ERROR;
                        }
<STRING><<EOF>>         {
                            fprintf(stderr, "Error lexico: cadena sin cerrar (iniciada en linea %d)\n", start_line);
                            BEGIN(INITIAL);
                            return TOK_ERROR;
                        }

{ID}                    { return TOK_IDENTIFIER; }

<<EOF>>                 { return TOK_EOF; }

 /* ---------- Errores lexicos ---------- */
[\x80-\xFF]+            {
                            fprintf(stderr, "Error lexico linea %d: bytes no ASCII (UTF-8 no soportado) '%s'\n", yylineno, yytext);
                            return TOK_ERROR;
                        }
.                       {
                            fprintf(stderr, "Error lexico linea %d: caracter no reconocido '%s'\n", yylineno, yytext);
                            return TOK_ERROR;
                        }

%%
