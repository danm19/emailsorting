%{

#include <stdio.h>
#include <string.h>
int fee = 0, unicamp = 0, valido = 0;
%}

LETRA   [a-zA-Z]
DIGITO  [0-9]

PALAVRA  {LETRA}+
INTEIRO  {DIGITO}+	

%%

[a-zA-Z.0-9]+"@"[a-z]+".unicamp."[a-z]{3} {unicamp++;}  
[a-zA-Z.0-9]+"@unicamp."[a-z]{3} {unicamp++;}  	// domínio @unicamp.xxx
[a-zA-Z.0-9]+"@unicamp."[a-z]{2} {unicamp++;}	// domínio @unicamp.xx

[a-zA-Z.0-9]+"@fee.unicamp."[a-z]{2} {unicamp++, fee++, valido--;}
[a-zA-Z.0-9]+"@"[a-z]+".fee.unicamp."[a-z]{2} {fee++, unicamp++;}
[a-zA-Z.0-9]+"@fee.unicamp."[a-z]{3}"."[a-z]{2} {valido++;}


[a-zA-Z.0-9]+"@"[a-z]+"."[a-z]{3} {valido++;} //dominio diferente de unicamp
[a-zA-Z.0-9]+"@"[a-z]+"."[a-z]{2} {valido++;}
[a-zA-Z.0-9]+"@"[a-z]+"."[a-z]{3}"."[a-z]{2} {valido++;}

[[:space:]]+ ;
[[:^space:]]+ ;



%%




int main() {
  
  yylex();
  

  printf("%d %d %d\n", fee+unicamp+valido, unicamp, fee);


  return 0;
}
