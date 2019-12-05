#Documentation for Three address intermediate code generator

###Requirements:
These requirements are for users running Debian based Operating Systems like Ubuntu/Fedora

One needs `Flex`(lex) and `Bison`(upward compatible with yacc) for lexical analyzer generator and parser generator

To install flex and yacc in Ubuntu:

* __sudo apt-get install flex__
* __sudo apt-get install bison__

To install flex and yacc in Fedora:

* __sudo yum install flex flex-devel__
* __sudo yum install bison__

Steps to execute the project:

* lex program.l
* yacc program.y
* gcc y.tab.c -ll -ly
* ./a.out testfilename

or simply use shellscript to automate , run 

* chmod 777 build.sh
(this is for making the script executable)
execute by running
* ./build.sh
The output will be displayed and written into file named output


This documentation is signed off by [Venkatesh B H](https://www.linkedin.com/in/venkatesh-b-h-052a17175/) and [VenkateshBH99](https://github.com/VenkateshBH99), B.Tech , Information Technology, NIT Surathkal.
