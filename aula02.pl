% Questão 1
% Na transformação de números decimais inteiros para binário, utilizamos a divisão por 2 para encontrar o resto da divisão e utilizá-lo na transformação. Na transformação de números decimais fracionários para binário, fazemos a operação inversa por 2. Escolha 10 números (10 sequências diferentes do seu número de matrícula) e crie 10 números fracionários estritamente menores que 1, com 4 algarismos. Transforme-os em binário.
1702 => 1,702 => 1.10110100
1376 => 1,376 => 1.01100000
1676 => 1,676 => 1.10101101
1023 => 1,023 => 1.00000110
1776 => 1,776 => 1.11000111
1360 => 1,360 => 1.01011100
1632 => 1,632 => 1.10100010
1630 => 1,630 => 1.10100001
1667 => 1.667 => 1.10101011
1663 => 1,663 => 1.10101010

% Questão 2
% Explique os seguintes resultados obtidos com Python:
>>> 0.1**2
0.010000000000000002
>>> 1 + .1234 - 1
0.12339999999999995
O Python exibe apenas uma aproximação decimal do verdadeiro valor decimal da aproximação binária armazenada pela máquina.

% Questão 3
% Dê mais 3 exemplos de discrepância de resultados em operações simples com divisão e multiplicação de reais em Python.
602879701896397 / 2 ** 55
110.1 * 3
99.91 * 5

% Questão 4
% Encontre a representação binária, em precisão simples, dos números do exercício 1.
1.10110100 => (-1)-1 *(1 + 0,10110100)* 2(126-127)
1.01100000 => (-1)-1 *(1 + 0,01100000)* 2(126-127)
1.10101101 => (-1)-1 *(1 + 0,10101101)* 2(126-127)
1.00000110 => (-1)-1 *(1 + 0,00000110)* 2(126-127)
1.11000111 => (-1)-1 *(1 + 0, 11000111)* 2(126-127))
1.01011100 => (-1)-1 *(1 + 0, 01011100)* 2(126-127)
1.10100010 => (-1)-1 *(1 + 0, 10100010)* 2(126-127)
1.10100001 => (-1)-1 *(1 + 0, 10100001)* 2(126-127)
1.10101011 => (-1)-1 *(1 + 0, 10101011)* 2(126-127)
1.10101010 => (-1)-1 *(1 + 0, 10101010)* 2(126-127)

% Questão 5
% Faça 3 somas e 3 subtrações de binários a partir de 6 números decimais diferentes com 3 algarismos cada.
Números Decimais = 756, 856, 635, 356, 256, 365.
756 – 856 = 1011110100 – 1101011000 = -1100100
635 – 356 = 1001111011 – 101100100 = 100010111
635 – 256 = 1001111011 – 100000000 = 101111011
365 + 756 = 101101101 + 1011110100 = 10001100001
856 + 256 = 1101011000 + 100000000 = 10001011000
756 + 356 = 1011110100 + 101100100 = 10001011000

% Questão 6
% Dê a representação dos dois últimos algarismos do seu número de matrícula como ponto flutuante no padrão IEEE 754, considerando-os como: número inteiro; número fracionário; cada um dos números acima positivos ou negativos; em precisão simples e dupla.
Número:
76 (-1)-1 *(1 + 0,0110000000000000000001)* 2(121-127) Positivo – Precisão Simples
76 (-1)1 *(1 + 0,0110000000000000000011)* 2(121-127) Negativo – Precisão Simples
76 (-1)-1 *(1 + 0,0110000000000000000001)* 2(1017-1023) Positivo – Precisão Dupla
76 (-1)1 *(1 + 0,0110000000000000000011)* 2(1017-1023) Negativo – Precisão Dupla