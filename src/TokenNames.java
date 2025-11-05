public interface TokenNames {
    /* terminals */
    public static final int EOF      = 0;
    public static final int PLUS     = 1;
    public static final int MINUS    = 2;
    public static final int TIMES    = 3;
    public static final int DIVIDE   = 4;
    public static final int LPAREN   = 5;
    public static final int RPAREN   = 6;
    public static final int INT      = 7;
    public static final int ID       = 8;

    // keywords / types
    public static final int TYPE_INT    = 9;
    public static final int TYPE_STRING = 10;
    public static final int TYPE_VOID   = 11;
    public static final int IF          = 12;
    public static final int ELSE        = 13;
    public static final int WHILE       = 14;
    public static final int RETURN      = 15;
    public static final int CLASS       = 16;
    public static final int EXTENDS     = 17;
    public static final int NEW         = 18;
    public static final int NIL         = 19;

    // punctuation / operators
    public static final int LBRACE    = 20;  // {
    public static final int RBRACE    = 21;  // }
    public static final int LBRACK    = 22;  // [
    public static final int RBRACK    = 23;  // ]
    public static final int ASSIGN    = 24;  // :=  (assignment)
    public static final int EQ        = 25;  // =   (equality)
    public static final int LT        = 26;  // <
    public static final int GT        = 27;  // >
    public static final int COMMA     = 28;  // ,
    public static final int DOT       = 29;  // .
    public static final int SEMICOLON = 30;  // ;
    public static final int STRING = 31;

}
