/* EA876 - INTRODUÇÃO A SOFTWARE DE SISTEMA
 * Professor: Tiago Fernandes Tavares
 *
 * Nome: Danilo Aparecido Rossi Moraes  
 * RA: 169649
 *
 * Laboratório: Detector de email.
 * Prazo: 22/03/2019 ás 23:59h
 *
 * Descrição: Através da entrada de uma string pelo usuário, o programa irá reconhecer na mesma se haverão emails válidos, 
 * e através destes, irá contabilizar os emails "válidos" e os com domínios "fee" e "unicamp"  
 */ 


%{

#include <stdio.h>
#include <string.h>

unsigned int fee = 0, unicamp = 0, valido = 0;

%}

LETRA   [a-zA-Z.0-9]
DIGITO  [0-9]

PALAVRA  {LETRA}+
INTEIRO  {DIGITO}+	

%%

[a-zA-Z.0-9]+@[a-z]{2}.unicamp.[a-z]{2} {unicamp++;} 	// domino @xx.unicamp.xx
[a-zA-Z.0-9]+@[a-z]{2}.unicamp.[a-z]{3} {unicamp++;}  	// domino @xx.unicamp.xxx
[a-zA-Z.0-9]+@unicamp.[a-z]{3} {unicamp++;}  	// domínio @unicamp.xxx
[a-zA-Z.0-9]+@unicamp.[a-z]{2} {unicamp++;}	// domínio @unicamp.xx

[a-zA-Z.0-9]+@dca.fee.unicamp.[a-z]{2} {unicamp++, fee++, valido--;}	// dominio @dca.fee.unicamp.br
[a-zA-Z.0-9]+@fee.unicamp.[a-z]{2} {unicamp++, fee++, valido--;}	// dominio @fee.unicamp.br
[a-zA-Z.0-9]+@[a-z]+.fee.unicamp.[a-z]{2} {fee++, unicamp++;}	// dominio @xxx.fee.unicamp.br
[a-zA-Z.0-9]+@fee.unicamp.[a-z]{3}.[a-z]{2} {valido++;}	// dominio @fee.unicamp.com

[a-zA-Z.0-9]+@[a-z]+ {valido++;}
[a-zA-Z.0-9]+@[a-z]+.[a-z]{3} {valido++;}    //dominios sem relações com unicamp e fee.
[a-zA-Z.0-9]+@[a-z]+.[a-z]{2} {valido++;}	 
[a-zA-Z.0-9]+@[a-z]+.[a-z]{3}.[a-z]{2} {valido++;}

[[:space:]]+ ;
[[:^space:]]+ ;

%%


int main() {
  

  yylex();
  

  printf("%d %d %d\n", fee+unicamp+valido, unicamp, fee);


  return 0;
}
