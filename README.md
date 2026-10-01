# Analizador Léxico (Scanner) - Lenguaje Temático "Química"

Este proyecto consiste en un analizador léxico (scanner) desarrollado en **C** y **Flex** (`lex`). Su propósito es procesar el código fuente de un lenguaje de programación inventado que utiliza una **temática de química**, transformando el texto de entrada en una secuencia de tokens (componentes léxicos) válidos o reportando errores léxicos.

## Características Principales

* **Temática Química:** Las palabras reservadas tradicionales se han reemplazado por términos químicos. Por ejemplo:
  * `MOL` $\rightarrow$ `int`
  * `GRAMO` $\rightarrow$ `float`
  * `REACCIONA` $\rightarrow$ `if`
  * `INERTE` $\rightarrow$ `else`
  * `SINTETIZA` $\rightarrow$ `def` (para definir funciones)
  * `DESTILA` $\rightarrow$ `while`
* **Operadores Clásicos y Textuales:** Soporta los operadores simbólicos habituales (`+`, `-`, `==`, `&&`, etc.) y también versiones en texto con nombres personalizados (ej. `MAS`, `ELEVA`, `EQUILIBRA`).
* **Soporte de Literales:** Detecta enteros (decimal, hexadecimal, binario), punto flotante (incluyendo notación científica), caracteres (`'c'`) y cadenas de texto (`"texto"`).
* **Manejo de Errores Robustos:** Utiliza "estados exclusivos" (`%x`) en Flex para detectar de forma inteligente:
  * Cadenas sin cerrar o con secuencias de escape inválidas (ej. `\q`).
  * Comentarios de bloque sin cerrar (`/* ...`).
  * Caracteres extraños o no ASCII.
* **Comentarios:** Ignora comentarios de línea (`//`) y de bloque (`/* */`).

## Estructura de Archivos

* `scanner.l`: Archivo de reglas de **Flex**. Define las expresiones regulares y los estados del escáner.
* `scanner.h`: Define el enum `ScannerToken` con todos los identificadores de tokens válidos.
* `scanner.c`: Programa principal en C. Llama a `yylex()` en un bucle y formatea la salida mostrando el nombre del token y su lexema (`yytext`).
* `demo.lang`: Archivo de código fuente de prueba que demuestra la sintaxis del lenguaje, e incluye de forma intencional algunos errores para probar la robustez del escáner.
* `Makefile`: Script para automatizar la compilación y prueba del proyecto.

## Requisitos

Para compilar y ejecutar este proyecto necesitas:

* Un compilador de C (por defecto `gcc`).
* `flex` (Generador de analizadores léxicos).
* `make` (Herramienta de construcción).

## Compilación y Ejecución

### 1. Compilar el proyecto
Simplemente ejecuta el comando `make` en la raíz del proyecto:

```bash
make

 **Alumnos:**

| Nombre Completo                 | Número de cuenta |
|---------------------------------| ---------------- |
| Chávez Martínez Marco Antonio   | 320328594        |
| Lugo Díaz Ordaz Gretel Alexandra| 321115128        |
| Hernández Islas Leonardo Daniel | ---------        |
| Vega Alonso Diego Hazael        | 321301183        |
