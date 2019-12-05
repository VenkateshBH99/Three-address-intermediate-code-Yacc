%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *fp;
FILE * f1;

%}

%token INT VOID UINT FLOAT
%token WHILE FOR DO
%token IF ELSE BREAK
%token NUM ID
%token INCLUDE
%right ASGN 
%left LOR
%left LAND
%left BOR
%left BXOR
%left BAND
%left EQ NE 
%left LE GE LT GT
%left '+' '-' 
%left '*' '/' 
%left '~'

%%

StartProgram		: TYPE ID '(' ')' STMT_START
				;

STMT_START 			: '{' STMT_BODY '}'|
				;

STMT_BODY			: STMT  STMT_BODY
				|
				;

STMT 			: DECLARE_STMT 
				| ASSGN_STMT  
				| IF_STMT
				| WHILE_STMT
				| FOR_STMT
				| DO_STMT
				| ';'
				;

FOR_STMT		: {for_start();} FOR '(' ASSGN_STMT_2 ';' {for_inter();} EXP ';' {for_rep();} ASSGN_STMT_2')' WHILEBODY
				;

DO_STMT         : {while_start();} DO DOWHILEBODY WHILE '(' EXP {while_rep();} ')' ';' {while_end();}
                ;

IF_STMT 		: IF '(' EXP ')'  {if_label1();} STMT_START ELSESTMT 
				;
ELSESTMT		: ELSE {if_label2();} STMT_START {if_label3();}
				| {if_label3();}
				;

WHILE_STMT		:{while_start();} WHILE '(' EXP ')' {while_rep();} WHILEBODY  
				;

DOWHILEBODY    : STMT_START 
                | STMT 
                 ;
WHILEBODY		: STMT_START {while_end();}
				| STMT {while_end();}
				
				;

DECLARE_STMT 	: TYPE {setType();}  ID {DECLARE_STMT();} IDS   //setting type for that line
				;

IDS 			: ';'
				| ','  ID {DECLARE_STMT();} IDS 
				;

ASSGN_STMT		: ID {push();} ASGN {push();} EXP {codegen_assign();} ';'
                
                ;

ASSGN_STMT_2      : ID {push();} ASGN {push();} EXP {codegen_assign();}
                ;

EXP 			: EXP '+'{push();} EXP {Algebric_gen();}
				| EXP '-'{push();} EXP {Algebric_gen();}
				| EXP '*'{push();} EXP {Algebric_gen();}
				| EXP '/'{push();} EXP {Algebric_gen();}
                | EXP LT{push();} EXP {Logical_gen();}
				| EXP LE{push();} EXP {Logical_gen();}
				| EXP GT{push();} EXP {Logical_gen();}
				| EXP GE{push();} EXP {Logical_gen();}
				| EXP NE{push();} EXP {Logical_gen();}
				| EXP EQ{push();} EXP {Logical_gen();}
                | EXP {push();} LOR EXP {Logical_gen();}
				| EXP {push();} LAND EXP {Logical_gen();}
				| EXP {push();} BOR EXP {Logical_gen();}
				| EXP {push();} BXOR EXP {Logical_gen();}
				| EXP {push();} BAND EXP {Logical_gen();}
				| '-'EXP {sub();}
				| '(' EXP ')'
				| EXP '+' '(' '-' {push();} EXP')' {Algebric_gen();}
				| ID {check();push();}
				| NUM {push();}
				;


				

TYPE			: INT
				| VOID
				| UINT
				| FLOAT
				;

%%

#include <ctype.h>
#include"lex.yy.c"
int count=0;

char st[1000][10];
int top=0;
int i=0;
char temp[2]="t";

int label[200];
int lnum=0;
int ltop=0;
int stop=0;
char type[10];

struct Table
{
	char id[20];
	char type[10];
}table[10000];

int tableCount=0;

int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	f1=fopen("output","w");
	
   if(!yyparse())
		printf("\nParsing complete\n");
	else
	{
		printf("\nParsing failed\n");
		exit(0);
	}
	
	fclose(yyin);
	fclose(f1);
	
    return 0;
}
         
yyerror(char *s) {
	printf("Syntex Error in line number : %d : %s %s\n", yylineno, s, yytext );
}
    
push()
{
  	strcpy(st[++top],yytext);
}

Logical_gen()
{
 	sprintf(temp,"t%d",i);
  	fprintf(f1,"\t%s=%s%s%s\n",temp,st[top-2],st[top-1],st[top]);
  	top-=2;
 	strcpy(st[top],temp);
 	i++;
}

Algebric_gen()
{
 	sprintf(temp,"t%d",i); // converts temp to reqd format
  	fprintf(f1,"\t%s=%s%s%s\n",temp,st[top-2],st[top-1],st[top]);
  	top-=2;
 	strcpy(st[top],temp);
 	i++;
}
codegen_assign()
{
 	fprintf(f1,"\t%s=%s\n",st[top-2],st[top]);
 	top-=3;
}
sub()
{
   	sprintf(temp,"t%d",i);
   	fprintf(f1,"\t%s=-%s\n",temp,st[top]);
   	strcpy(st[top],temp);
   	i++;
}
if_label1()
{
 	lnum++;
 	fprintf(f1,"\tif( not %s)",st[top]);
 	fprintf(f1,"\tgoto L%d\n",lnum);
 	label[++ltop]=lnum;
}

if_label2()
{
	int x;
	lnum++;
	x=label[ltop--]; 
	fprintf(f1,"\tgoto L%d\n",lnum);
	fprintf(f1,"L%d: \n",x); 
	label[++ltop]=lnum;
}

if_label3()
{
	int y;
	y=label[ltop--];
	fprintf(f1,"L%d: \n",y);
	top--;
}
for_start()
{
	lnum++;
	
	fprintf(f1,"L%d:\n",lnum);
}
for_inter()
{
	lnum++;
	label[++ltop]=lnum;
	fprintf(f1,"L%d:\n",lnum);
}
for_rep()
{
	lnum++;
 	fprintf(f1,"\tif( not %s)",st[top]);
 	fprintf(f1,"\tgoto L%d\n",lnum);
 	label[++ltop]=lnum;
}
while_start()
{
	lnum++;
	label[++ltop]=lnum;
	fprintf(f1,"L%d:\n",lnum);
}
while_rep()
{
	lnum++;
 	fprintf(f1,"\tif( not %s)",st[top]);
 	fprintf(f1,"\tgoto L%d\n",lnum);
 	label[++ltop]=lnum;
}
while_end()
{
	int x,y;	y=label[ltop--];
	x=label[ltop--];
	fprintf(f1,"\tgoto L%d\n",x);
	fprintf(f1,"L%d: \n",y);
	top--;
}

/* for symbol table*/

check()
{
	char temp[20];
	strcpy(temp,yytext);
	int flag=0;
	for(i=0;i<tableCount;i++)
	{
		if(!strcmp(table[i].id,temp))
		{
			flag=1;
			break;
		}
	}
	if(!flag)
	{
		yyerror("Variable not declard");
		exit(0);
	}
}

setType()
{
	strcpy(type,yytext);
}


DECLARE_STMT()
{
	char temp[20];
	int i,flag;
	flag=0;
	strcpy(temp,yytext);
	for(i=0;i<tableCount;i++)
	{
		if(!strcmp(table[i].id,temp))
			{
			flag=1;
			break;
				}
	}
	if(flag)
	{
		yyerror("reDECLARE_STMT of ");
		exit(0);
	}
	else
	{
		strcpy(table[tableCount].id,temp);
		strcpy(table[tableCount].type,type);
		tableCount++;
	}
}

