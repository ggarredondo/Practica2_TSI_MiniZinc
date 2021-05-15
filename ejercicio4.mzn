% Se analiza las afirmaciones de cada persona para simplificarlas en la representación.
% Juan: “Hoy es martes”. -> Martes
% María: “Eso no es correcto, mañana es martes”. -> Lunes
% Carmen: “Ambos estáis equivocados. Ayer fue martes”. -> Miércoles
% Francisco: “No Carmen, ayer fue sábado”. -> Domingo
% Marta: “Hoy es o jueves o viernes”. -> Jueves o Viernes
% Olga: “No es así, hoy es domingo”. -> Domingo
% Pepe: “No, hoy no es domingo”. -> No Domingo

set of int: numDias = 1..7; % Conjunto de los días numéricamente.
array[numDias] of string: dias = ["Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Domingo"]; % Array de constantes string para los nombres de los días.
var numDias: hoy; % Variable del 1 al 7 para almacenar numéricamente el día resultante.

set of int: numPersonas = 1..7; % Conjunto de las personas numéricamente.
array[numPersonas] of string: strPersonas = ["Juan", "Maria", "Carmen", "Francisco", "Marta", "Olga", "Pepe"]; % Array de constantes string para los nombres de cada persona.
% Array de variables booleanas para representar las afirmaciones de cada persona.
array[numPersonas] of var bool: personas = [hoy == 2, hoy == 1, hoy == 3, hoy == 7, hoy == 4 \/ hoy == 5, hoy == 7, hoy != 7];
% Restricción principal como suma de booleanos. Suponiendo true = 1 y false = 0, la suma de todas las afirmaciones debe ser 1. Es decir, sólo una puede ser correcta.
constraint personas[1] + personas[2] + personas[3] + personas[4] + personas[5] + personas[6] + personas[7] == 1;
solve satisfy; % Se resuelve como problema de satisfacción.

% Se imprime por pantalla el resultado con formato.
output ["hoy: " ++ dias[fix(hoy)]];
output ["\nemisor: " ++ strPersonas[i] | i in numPersonas where fix(personas[i]) == true];