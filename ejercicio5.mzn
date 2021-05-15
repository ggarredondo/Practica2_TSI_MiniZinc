include "alldifferent.mzn"; % Se incluye una librería para poder hacer uso de la función 'alldifferent'.

set of int: numProf = 1..4; % Prof1, Prof2, Prof3, Prof4
set of int: numAulas = 1..3; % Aula1, Aula2, Aula3
set of int: numHoras = 1..4; % 9 - 10, 10 - 11, 11 - 12, 12 -13
set of int: numClases = 1..12; % Organizo las asignaturas y los grupos como un valor par, llamado clases.
array[numClases] of string: strClases = ["IA-G1","IA-G2","IA-G3","IA-G4","TSI-G1","TSI-G2","TSI-G3","TSI-G4","FBD-G1","FBD-G2","FBD-G3","FBD-G4"];
                                      %     1       2       3       4        5       6        7         8        9       10        11       12
array[numHoras] of string: strHoras = ["9-10","10-11","11-12","12-13"];

% Para cada hora y cada aula, un profesor imparte una asignatura a un grupo (clase).
array[numHoras, numAulas] of var numClases: Clases;
array[numHoras, numAulas] of var numProf: Profs;

% Un profesor solo puede dar clase en un aula para una misma hora.
% Es necesario separarlo para que la restricción de 'alldifferent' se aplique
% únicamente por fila, ya que un mismo profesor sí podría dar clase durante varias
% horas.
constraint alldifferent([Profs[1, j] | j in numAulas]);
constraint alldifferent([Profs[2, j] | j in numAulas]);
constraint alldifferent([Profs[3, j] | j in numAulas]);
constraint alldifferent([Profs[4, j] | j in numAulas]);

% En la semana sólo se imparte una misma asignatura para un mismo grupo.
constraint alldifferent(Clases);

% Cada grupo recibe docencia de una única asignatura en cada momento.


% El profesor 2 solo puede dar clase en el aula 2.
constraint forall(i in numHoras, j in numAulas where j != 2)(Profs[i,j] != 2);
% El profesor 4 solo puede dar clase en el aula 3.
constraint forall(i in numHoras, j in numAulas where j != 3)(Profs[i,j] != 4);
% Las asignatura de TSI solo se puede dar en las aulas 2 o 3.
constraint forall(i in numHoras)(Clases[i,1] != 5 /\ Clases[i,1] != 6 /\ Clases[i,1] != 7 /\ Clases[i,1] != 8);
% IA-G1 debe ser de 9 a 10.
constraint forall(i in numHoras, j in numAulas where i != 1)(Clases[i,j] != 1);
% IA-G3 debe ser de 11 a 12.
constraint forall(i in numHoras, j in numAulas where i != 3)(Clases[i,j] != 3);
% IA-G3 debe ser en el aula 1.
constraint forall(i in numHoras, j in numAulas where j != 1)(Clases[i,j] != 3);

% El profesor 1 da clase de FBD al G1, G2 y G3, y de IA al G1.
constraint forall(i in numHoras, j in numAulas where Clases[i,j] == 9 \/ Clases[i,j] == 10 \/ Clases[i,j] == 11 \/ Clases[i,j] == 1)(Profs[i,j] == 1);
% El profesor 2 da clase de IA al G2 y de FBD al G4.
constraint forall(i in numHoras, j in numAulas where Clases[i,j] == 2 \/ Clases[i,j] == 12)(Profs[i,j] == 2);
% El profesor 3 da clase de IA al G3 y de TSI al G1, G2 y G4.
constraint forall(i in numHoras, j in numAulas where Clases[i,j] == 3 \/ Clases[i,j] == 5 \/ Clases[i,j] == 6 \/ Clases[i,j] == 8)(Profs[i,j] == 3);
% El profesor 4 da clase de IA al G4 y de TSI al G3.
constraint forall(i in numHoras, j in numAulas where Clases[i,j] == 4 \/ Clases[i,j] == 7)(Profs[i,j] == 4);

% El profesor 2 solo tiene disponibles las horas 9-10 y 10-11.
constraint forall(j in numAulas)(Profs[3,j] != 2 /\ Profs[4,j] != 2);

% Se imprime por pantalla el resultado con formato.
output ["            Aula 1    Aula 2      Aula 3\n"];
output ["\(strHoras[i]) -> " ++ strClases[fix(Clases[i,1])] ++ "(P\(Profs[i,1])) " 
                             ++ strClases[fix(Clases[i,2])] ++ "(P\(Profs[i,2])) "
                             ++ strClases[fix(Clases[i,3])] ++ "(P\(Profs[i,3]))\n" | i in numHoras];