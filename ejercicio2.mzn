% Defición del conjunto de posiciones de los arrays.
set of int: POS = 1..8;

% Definición del valor de las monedas como un array de constantes en céntimos, 
% correspondientes respectivamente a las monedas de 1 céntimo, 2 céntimos,
% 5 céntimos, 20 céntimos, 50 céntimos, 1 euro y 2 euros.
array [POS] of int: valorMonedas = [1, 2, 5, 10, 20, 50, 100, 200];
% Definición del número (en cantidad) que hay de cada moneda como un array de variables, 
% donde cada posición corresponde a las del vector anterior.
array [POS] of var int: numMonedas;
% Variable donde almacenar el total de monedas.
var int: totalMonedas;

% Constante para almacenar el importe respecto al cual se va a minimizar el 
% número de monedas.
int: importe = 799;

constraint forall(i in POS)(numMonedas[i] >= 0); % 1ª restricción: el número de monedas es siempre mayor o igual a 0 (no tendría sentido tener cantidad negativas de monedas).
constraint sum(i in POS)(valorMonedas[i]*numMonedas[i]) == importe; % 2ª restricción: la suma de cada n monedas por su valor es igual al importe.
totalMonedas = sum(i in POS)(numMonedas[i]); % Se almacena el total de monedas como la suma de las cantidades de cada moneda.
solve minimize totalMonedas; % Se resuelve minimizando el total de monedas.

% Se imprime por pantalla los resultados formateados.
output ["monedas: \(numMonedas)\ntotal monedas: \(totalMonedas)"];