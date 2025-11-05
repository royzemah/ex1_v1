/***************************/
/* FILE NAME: LEX_FILE.lex */
/***************************/

/*************/
/* USER CODE */
/*************/

import java_cup.runtime.*;

/******************************/
/* DOLLAR DOLLAR - DON'T TOUCH! */
/******************************/

%%

/************************************/
/* OPTIONS AND DECLARATIONS SECTION */
/************************************/
   
/*****************************************************/ 
/* Lexer is the name of the class JFlex will create. */
/* The code will be written to the file Lexer.java.  */
/*****************************************************/ 
%class Lexer

/********************************************************************/
/* The current line number can be accessed with the variable yyline */
/* and the current column number with the variable yycolumn.        */
/********************************************************************/
%line
%column

/*******************************************************************************/
/* Note that this has to be the EXACT same name of the class the CUP generates */
/*******************************************************************************/
%cupsym TokenNames

/******************************************************************/
/* CUP compatibility mode interfaces with a CUP generated parser. */
/******************************************************************/
%cup

/****************/
/* DECLARATIONS */
/****************/
/*****************************************************************************/   
/* Code between %{ and %}, both of which must be at the beginning of a line, */
/* will be copied verbatim (letter to letter) into the Lexer class code.     */
/* Here you declare member variables and functions that are used inside the  */
/* scanner actions.                                                          */  
/*****************************************************************************/   
%{
	/*********************************************************************************/
	/* Create a new java_cup.runtime.Symbol with information about the current token */
	/*********************************************************************************/
	private Symbol symbol(int type)               {return new Symbol(type, yyline, yycolumn);}
	private Symbol symbol(int type, Object value) {return new Symbol(type, yyline, yycolumn, value);}

	/*******************************************/
	/* Enable line number extraction from main */
	/*******************************************/
	public int getLine() { return yyline + 1; } 

	/**********************************************/
	/* Enable token position extraction from main */
	/**********************************************/
	public int getTokenStartPosition() { return yycolumn + 1; } 
%}

/***********************/
/* MACRO DECLARATIONS */
/***********************/
WS        = [ \t\n]+
LETTER    = [A-Za-z]
DIGIT     = [0-9]
ID        = {LETTER}({LETTER}|{DIGIT})*
ZERO      = 0
INT_OK    = {ZERO}|[1-9]{DIGIT}*
STR_OK    = \"[A-Za-z]*\"
COMMENT1_CHAR    = [A-Za-z0-9()\[\]\{\}\?\!\+\-\*/\.; \t]
COMMENT2_CHAR = [A-Za-z0-9()\[\]\{\}\?\!\+\-\*/\.; \t\n]

/******************************/
/* DOLLAR DOLLAR - DON'T TOUCH! */
/******************************/

%%

/************************************************************/
/* LEXER matches regular expressions to actions (Java code) */
/************************************************************/

/**************************************************************/
/* YYINITIAL is the state at which the lexer begins scanning. */
/* So these regular expressions will only be matched if the   */
/* scanner is in the start state YYINITIAL.                   */
/**************************************************************/

<YYINITIAL> {
// Type 1 Comments: line comments
  "//"{COMMENT1_CHAR}*\n      { /* skip line comment */ }
/* Type 2 Comments: block comment */
  "/*"                         { throw new RuntimeException("lex"); } //An unclosed Type-2 comment
  "/*"({COMMENT2_CHAR})*"*/"   { /* skip block comment */ }


/*  Whitespace: */
{WS}                           { /* skip */ }


/*  Keywords (before ID) */
"int"                          { return symbol(TokenNames.TYPE_INT); }
"string"                       { return symbol(TokenNames.TYPE_STRING); }
"void"                         { return symbol(TokenNames.TYPE_VOID); }
"if"                           { return symbol(TokenNames.IF); }
"else"                         { return symbol(TokenNames.ELSE); }
"while"                        { return symbol(TokenNames.WHILE); }
"return"                       { return symbol(TokenNames.RETURN); }
"class"                        { return symbol(TokenNames.CLASS); }
"extends"                      { return symbol(TokenNames.EXTENDS); }
"new"                          { return symbol(TokenNames.NEW); }
"nil"                          { return symbol(TokenNames.NIL); }

/* Operators / punctuation */
":="                           { return symbol(TokenNames.ASSIGN); }
"="                            { return symbol(TokenNames.EQ); }
"<"                            { return symbol(TokenNames.LT); }
">"                            { return symbol(TokenNames.GT); }
"("                            { return symbol(TokenNames.LPAREN); }
")"                            { return symbol(TokenNames.RPAREN); }
"["                            { return symbol(TokenNames.LBRACK); }
"]"                            { return symbol(TokenNames.RBRACK); }
"{"                            { return symbol(TokenNames.LBRACE); }
"}"                            { return symbol(TokenNames.RBRACE); }
"+"                            { return symbol(TokenNames.PLUS); }
"-"                            { return symbol(TokenNames.MINUS); }
"*"                            { return symbol(TokenNames.TIMES); }
"/"                            { return symbol(TokenNames.DIVIDE); }
","                            { return symbol(TokenNames.COMMA); }
"."                            { return symbol(TokenNames.DOT); }
";"                            { return symbol(TokenNames.SEMICOLON); }

/* Strings:*/
{STR_OK}                       {
                                  String s = yytext();
                                  return symbol(TokenNames.STRING, s.substring(1, s.length()-1));
                               }

/* Integers: 0..32767, no leading zeros except "0" */
{INT_OK}                       {
                                  String t = yytext();
                                  int v = Integer.parseInt(t);
                                  if (v > 32767) throw new RuntimeException("lex");
                                  return symbol(TokenNames.INT, v);
                               }

/* Identifiers */
{ID}                           { return symbol(TokenNames.ID, yytext()); }

/* EOF */
<<EOF>> { return symbol(TokenNames.EOF); }

}  /* end of YYINITIAL */