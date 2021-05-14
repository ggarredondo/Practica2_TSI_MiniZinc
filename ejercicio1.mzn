include "alldifferent.mzn"; % Se incluye una librería para poder hacer uso de la función 'alldifferent'.

% Definición de las variables del problema, las letras del puzzle.
% Como dominio le asignamos el rango 0..9 para asegurarnos de que no se
% incluyen números negativos ni números superiores a 9. Además, para las
% letras S y T acortamos el intervalo a 1..9 para asegurarnos que no se
% le asigna un cero, ya que, debido a su posición en la cifra, 0 no sería
% un valor válido.
var 1..9: S;
var 0..9: I;
var 0..9: X;
var 0..9: E;
var 0..9: V;
var 0..9: N;
var 1..9: T;
var 0..9: W;
var 0..9: Y;

constraint alldifferent([S,I,X,E,V,N,T,W,Y]); % 1ª restricción: todas las variables tienen valores únicos.
% 2ª restricción: la suma de las variables, multiplicando por 10, 100, etc, según la variable esté en la
% posición de las decenas, centenas... 
constraint                       100*S + 10*I + X
            + 10000*S + 1000*E + 100*V + 10*E + N
            + 10000*S + 1000*E + 100*V + 10*E + N
== 100000*T + 10000*W + 1000*E + 100*N + 10*T + Y;
solve satisfy;

% Se imprimen por pantalla los resultados con formato.
output ["       \(S) \(I) \(X)"];
output ["\n + \(S) \(E) \(V) \(E) \(N)"];
output ["\n + \(S) \(E) \(V) \(E) \(N)"];
output ["\n------------"];
output ["\n \(T) \(W) \(E) \(N) \(T) \(Y)"];