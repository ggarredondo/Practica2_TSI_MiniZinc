set of int: POS = 1..13; % Conjunto de posición del array de países.
set of int: VALUES = 1..5; % Conjunto de valores numéricos para los colores. 1 = Verde, 2 = Naranja, 3 = Rojo, 4 = Azul, 5 = Amarillo.
array[VALUES] of int: COSTES = [100, 200, 300, 400, 500]; % Array de constantes enteras con el coste de cada color respectivamente.
array[VALUES] of string: COLORES = ["Verde","Naranja","Rojo","Azul","Amarillo"]; % Array de constantes string con el nombre de cada color respectivamente.
var int: costeTotal; % Variable entera para almacenar el coste total de la solución.

% Array de variables con dominio 1..5 para almacenar el color (numérico) asignado a cada país.
array[POS] of var VALUES: paises;
% Array de constantes string con el nombre de cada país.
array[POS] of string: strPaises = ["Argentina","Bolivia","Brasil","Chile","Colombia","Ecuador","Guayana Francesa","Guyana","Paraguay","Perú","Surinam","Urugay","Venezuela"];
                                %       1          2         3       4         5         6             7              8         9       10       11        12        13

% Restricciones para que los países limítrofes. Se busca que cada valor del array 'paises' no sea igual al de los países con los que hace frontera.
constraint paises[1] != paises[2] /\ paises[1] != paises[3] /\ paises[1] != paises[4] /\ paises[1] != paises[9] /\ paises[1] != paises[12];
constraint paises[2] != paises[3] /\ paises[2] != paises[4] /\ paises[2] != paises[9] /\ paises[2] != paises[10];
constraint paises[3] != paises[5] /\ paises[3] != paises[7] /\ paises[3] != paises[8] /\ paises[3] != paises[9] /\ paises[3] != paises[10] /\ paises[3] != paises[11] /\ paises[3] != paises[12] /\ paises[3] != paises[13];
constraint paises[4] != paises[10];
constraint paises[5] != paises[6] /\ paises[5] != paises[10] /\ paises[5] != paises[13];
constraint paises[6] != paises[10];
constraint paises[7] != paises[11];
constraint paises[8] != paises[11] /\ paises[8] != paises[13];
constraint paises[9] != paises[12];
costeTotal = sum(i in POS)(COSTES[paises[i]]); % Se almacena el coste total de los colores asignados a cada país.

solve minimize costeTotal; % Se resuelve minimizando el coste total.

% Se imprime por pantalla el resultado con formato.
output ["total: \(costeTotal)\n"];
output ["\n\(strPaises[i]) = \(COLORES[fix(paises[i])]) \(COSTES[paises[i]])" | i in POS];