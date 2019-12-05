/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    VOID = 259,
    UINT = 260,
    FLOAT = 261,
    WHILE = 262,
    FOR = 263,
    IF = 264,
    ELSE = 265,
    BREAK = 266,
    NUM = 267,
    ID = 268,
    INCLUDE = 269,
    ASGN = 270,
    LOR = 271,
    LAND = 272,
    BOR = 273,
    BXOR = 274,
    BAND = 275,
    EQ = 276,
    NE = 277,
    LE = 278,
    GE = 279,
    LT = 280,
    GT = 281,
    IFX = 282,
    IFX1 = 283
  };
#endif
/* Tokens.  */
#define INT 258
#define VOID 259
#define UINT 260
#define FLOAT 261
#define WHILE 262
#define FOR 263
#define IF 264
#define ELSE 265
#define BREAK 266
#define NUM 267
#define ID 268
#define INCLUDE 269
#define ASGN 270
#define LOR 271
#define LAND 272
#define BOR 273
#define BXOR 274
#define BAND 275
#define EQ 276
#define NE 277
#define LE 278
#define GE 279
#define LT 280
#define GT 281
#define IFX 282
#define IFX1 283

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
