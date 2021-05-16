set of int: numObjetos = 1..12; % Conjunto para representar los objetos numéricamente.
% Array de constantes de string para representar los objetos textualmente.
array[numObjetos] of string: strObjetos = ["Mapa","Cuchillo","Prismáticos","Agua","Linterna","Cerveza","Novela","Manual de Supervivencia","Plátanos","Caramelos","Cerillas","Espejo"];
% Array de constantes de int para almacenar los pesos de cada objeto.
array[numObjetos] of int: pesos = [50, 500, 1000, 3000, 1500, 3000, 500, 1000, 2000, 500, 250, 500];
% Array de constantes de int para almacenar las preferencias de cada objeto.
array[numObjetos] of int: preferencias = [100, 90, 75, 95, 85, 10, 5, 70, 90, 20, 50, 40];
int: maxPeso = 5000; % Constante para almacenar el peso máximo admitido.

array[numObjetos] of var bool: escogidos; % Para representar la selección, utilizo un array de variables booleanas donde true significa que el objeto ha sido escogido y false que no.
var int: pesoTotal; % Variable para almacenar el peso total final.
var int: preferenciaTotal; % Variable para almacenar la preferencia total final.

% Se almacena el peso total sumando el peso de todos aquellos objetos que han sido escogidos.
% Para ello, se suman aquellos valores que están multiplicando por true (por 1) y no
% aquellos que están multiplicando por false (pues están multiplicados por 0).
pesoTotal = sum(i in numObjetos)(escogidos[i]*pesos[i]); 
constraint pesoTotal <= maxPeso; % El peso total no debe exceder el peso máximo.
preferenciaTotal = sum(i in numObjetos)(escogidos[i]*preferencias[i]); % Se almacena la preferencia total sumando la preferencia que aporta cada objeto escogido.
solve maximize preferenciaTotal; % Se resuelve maximizando la preferencia total.

% Se imprime el resultado por pantalla con formato.
output ["Objetos = "];
output [" \(strObjetos[i])" | i in numObjetos where fix(escogidos[i]) == true];
output [" | Preferencias = \(preferenciaTotal) | PesoFinal = \(pesoTotal/1000) kgs"];