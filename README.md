# Projeto_Arquitetura

## Projeto Fechadura Digital
### Projeto utilizado com programa EDSIM51, com o Intel 8051

O programa tem como objetivo criar uma fechadura digital utilizando o simulador EDSIM51 e o teclado disponível no software. As teclas digitadas são exibidas no display LCD em tempo real e armazenada no endereço 51 a 54. Após inserir, faz a verificação com o endereço de memória 61 a 64. Se o usuário inserir a combinação correta, os tres ultimos LEDs acendem na cor verde, o motor gira 180º no sentido horário e no LCD aparece a palavra OPEN. Caso contrário, os três primeiros LEDs acendem e no LCD aparece a palavra ERRADO indicando que a senha está incorreta e o motor gira em sentido anti-horário. O usuário tem 3 tentativas para acertar a senha. Número máximo de dígitos 4.

## Diagrama de blocos do programa
![diagrama de blocos](https://github.com/user-attachments/assets/23f33101-6df2-4fa0-aa3c-70951cbf6e82)


## Modificações para funcionamento do Projeto
### Ao colar o codigo no programa no EDSIM51, ajuste o teclado do Keyboard a opção 'pulse' e a Update Freq. em 50. 

![keyboard](https://github.com/user-attachments/assets/ccb4c0d7-3bbf-4a46-b39a-6e9ad799e13b)

### Após, modifique as cores dos leds seguintes para verde:
![leds](https://github.com/user-attachments/assets/a6ff16fe-3731-43fa-8548-5f1e2dfbb999)

### E os seguintes leds para cor vermelha:
![led errado](https://github.com/user-attachments/assets/dde2a129-e56c-4eec-907e-280d6e042207)


## Funcionamento do projeto
Após feito essa modificação, clique em RUN e aparecerá no LCD para inserir a senha:

![ldc senha](https://github.com/user-attachments/assets/4c0b2a69-d2a1-4d63-a99e-cc3197a50977)


Digite a senha no Keyboard e aparecerá no LCD. Senha apenas de 4 dígitos.

![lcd digitos](https://github.com/user-attachments/assets/30847b5e-ebed-4b4d-8e11-3907c18979be)


Após a inserção dos 4 digitos, caso seja a senha certa aparecerá no display _OPEN_. E acenderá 3 leds verdes e o motor girará em sentido horário. *SENHA INICIAL CORRETA 9999*


![lcd open](https://github.com/user-attachments/assets/99f34d60-00de-4a44-8235-fdac4f6d2381)   ![motor open](https://github.com/user-attachments/assets/12109dc7-c26e-4b1c-af13-9431756f77b2)   ![led open](https://github.com/user-attachments/assets/7793ea48-a2bc-4172-95c1-7d3f784d8aee)


Caso a senha esteja errada, aparecerá no display _ERRADO_.

![lcd errado](https://github.com/user-attachments/assets/9662387e-6818-456b-85ce-4b67528c84bc)


O usuário tem 3 tentativas antes de aparecer _CLOSED_ que será o fim das tentativas. O motor girará no sentido anti-horário e 3 leds se acenderão.

![lcd close](https://github.com/user-attachments/assets/6cd3e5f0-584c-452d-83f2-91ba9bd41060)   ![motor close](https://github.com/user-attachments/assets/9a64146f-f11b-430e-86e8-8a5368523a67)   ![led errado](https://github.com/user-attachments/assets/dde2a129-e56c-4eec-907e-280d6e042207)


# Feito por:
Kayky Pires de Paula e Rafael Dias Silva Costa

