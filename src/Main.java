import java.io.*;
import java.io.PrintWriter;

import java_cup.runtime.Symbol;
//
public class Main
{
    static public void main(String argv[])
    {
        Lexer l;
        Symbol s;
        FileReader fileReader = null;
        PrintWriter fileWriter = null;
        String inputFileName = argv[0];
        String outputFileName = argv[1];

        try
        {
            /********************************/
            /* [1] Initialize a file reader */
            /********************************/
            fileReader = new FileReader(inputFileName);

            /********************************/
            /* [2] Initialize a file writer */
            /********************************/
            fileWriter = new PrintWriter(outputFileName);

            /******************************/
            /* [3] Initialize a new lexer */
            /******************************/
            l = new Lexer(fileReader);

            /***********************/
            /* [4] Read next token */
            /***********************/
            s = l.next_token();

            /********************************/
            /* [5] Main reading tokens loop */
            /********************************/
            while (s.sym != TokenNames.EOF)
            {
                String name;
                switch (s.sym) {
                    case TokenNames.EOF:        name = "EOF"; break;
                    case TokenNames.PLUS:       name = "PLUS"; break;
                    case TokenNames.MINUS:      name = "MINUS"; break;
                    case TokenNames.TIMES:      name = "TIMES"; break;
                    case TokenNames.DIVIDE:     name = "DIVIDE"; break;
                    case TokenNames.LPAREN:     name = "LPAREN"; break;
                    case TokenNames.RPAREN:     name = "RPAREN"; break;
                    case TokenNames.INT:        name = "INT"; break;
                    case TokenNames.STRING:     name = "STRING"; break;
                    case TokenNames.ID:         name = "ID"; break;

                    case TokenNames.TYPE_INT:    name = "TYPE_INT"; break;
                    case TokenNames.TYPE_STRING: name = "TYPE_STRING"; break;
                    case TokenNames.TYPE_VOID:   name = "TYPE_VOID"; break;
                    case TokenNames.IF:          name = "IF"; break;
                    case TokenNames.ELSE:        name = "ELSE"; break;
                    case TokenNames.WHILE:       name = "WHILE"; break;
                    case TokenNames.RETURN:      name = "RETURN"; break;
                    case TokenNames.CLASS:       name = "CLASS"; break;
                    case TokenNames.EXTENDS:     name = "EXTENDS"; break;
                    case TokenNames.NEW:         name = "NEW"; break;
                    case TokenNames.NIL:         name = "NIL"; break;

                    case TokenNames.LBRACE:      name = "LBRACE"; break;
                    case TokenNames.RBRACE:      name = "RBRACE"; break;
                    case TokenNames.LBRACK:      name = "LBRACK"; break;
                    case TokenNames.RBRACK:      name = "RBRACK"; break;
                    case TokenNames.ASSIGN:      name = "ASSIGN"; break;   // := assignment
                    case TokenNames.EQ:          name = "EQ"; break;       // = equality
                    case TokenNames.LT:          name = "LT"; break;
                    case TokenNames.GT:          name = "GT"; break;
                    case TokenNames.COMMA:       name = "COMMA"; break;
                    case TokenNames.DOT:         name = "DOT"; break;
                    case TokenNames.SEMICOLON:   name = "SEMICOLON"; break;

                    default:                     name = "UNKNOWN";
                }

                int line = l.getLine();
                int col  = l.getTokenStartPosition();
                /************************/
                /* [6] Print to console */
                /************************/
                /* //DEBUGGING PRINTS
                if (s.value == null) {
                    System.out.printf("%s[%d,%d]%n", name, line, col);
                } else {
                    System.out.printf("%s(%s)[%d,%d]%n", name, s.value, line, col);
                }
                */


                /*********************/
                /* [7] Print to file */
                /*********************/
                if (s.value == null) {
                    fileWriter.printf("%s[%d,%d]%n", name, line, col);
                } else {
                    fileWriter.printf("%s(%s)[%d,%d]%n", name, s.value, line, col);
                }
                /***********************/
                /* [8] Read next token */
                /***********************/
                s = l.next_token();
            }

            /******************************/
            /* [9] Close lexer input file */
            /******************************/
            l.yyclose();

            /**************************/
            /* [10] Close output file */
            /**************************/
            fileWriter.close();
        }
        catch (Throwable e)
        {
            fileWriter.close();
            try (PrintWriter overwrite = new PrintWriter(outputFileName)) {
                overwrite.print("ERROR");   // overwrites file completely
                overwrite.close();
            } catch (FileNotFoundException fnf) { }
        }



    }
}


