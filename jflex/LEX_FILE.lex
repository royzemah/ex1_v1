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
WS        = [ \t\r\n]+
LETTER    = [A-Za-z]
DIGIT     = [0-9]
ID        = {LETTER}({LETTER}|{DIGIT})*
INT_OK    = 0|[1-9]{DIGIT}*
STR_OK    = \"[A-Za-z]*\"
%state COMMENT

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

/* 1) Whitespace: skip */
{WS}                           { /* skip */ }

/* 2) Comments: skip; unclosed block => ERROR */
/* line comments: skip */
"//".*                         { /* skip */ }

/* start of block comment -> go to COMMENT state */
"/*"                           { yybegin(COMMENT); }


/* 3) Keywords (before ID) */
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

/* 4) Operators / punctuation */
":="                           { return symbol(TokenNames.ASSIGN); }  /* if your PDF says assign is '=', swap with EQ */
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

/* 5) Strings: one valid rule + one generic error for quotes */
{STR_OK}                       {
                                  String s = yytext();
                                  return symbol(TokenNames.STRING, s.substring(1, s.length()-1));
                               }
\"[^\"\r\n]*                   { throw new RuntimeException("lex"); }

/* 6) Integers: 0..32767, no leading zeros except "0" */
{INT_OK}                       {
                                  String t = yytext();
                                  if (t.length() > 5) throw new RuntimeException("lex");
                                  int v = Integer.parseInt(t);
                                  if (v > 32767) throw new RuntimeException("lex");
                                  return symbol(TokenNames.INT, v);
                               }

/* 7) Identifiers */
{ID}                           { return symbol(TokenNames.ID, yytext()); }

/* 9) Anything else => unified lexical error */
.                              { throw new RuntimeException("lex"); }
}  /* end of YYINITIAL */

/* -------- COMMENT state -------- */
<COMMENT> "*/"                 { yybegin(YYINITIAL); }       /* end of block comment */
<COMMENT> <<EOF>>              { throw new RuntimeException("lex"); }  /* unclosed */
<COMMENT> [^]                  { /* skip inside block comment */ }

/* catch-all fallback for anything outside states */
[^] { throw new RuntimeException("lex"); }

/* EOF */
<<EOF>> { return symbol(TokenNames.EOF); }
