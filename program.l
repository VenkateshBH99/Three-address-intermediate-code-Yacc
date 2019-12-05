alpha [a-zA-Z]
digit [0-9]

%%
[ \t]		;
[ \n]   { yylineno = yylineno + 1;}
"int"	return INT;
"unsigned int"	return UINT;
"break"	return BREAK;
"void" return VOID;
"while"	return WHILE;
"if"	return IF;
"for"   return FOR;
"else"	return ELSE;
"do"    return DO;
{digit}+       return NUM;
{alpha}({alpha}|{digit})* return ID;
"="     return ASGN;
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
">"	return GT;
"<"	return LT;
"||" 	return LOR;
"&&"  	return LAND;
"|" 	return BOR;
"&"	return BAND;
"^"	return BXOR;
\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
.       return yytext[0];
%%
