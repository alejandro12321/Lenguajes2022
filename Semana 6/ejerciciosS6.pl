%Sumatoria de todos los elementos de una lista
%La sumatoria de lista vacia es 0
% Recorre la lista y va acumulando la suma del primer elemento en S
% sumList(L,S).
sumList([],0).
sumList([H|T],S) :-
    sumList(T,S2),
    S is S2+H.

%Define si el largo de una lista es par
%Largo de una lista vacia es par
%Obtiene el largo de la lista usando funciones ya existentes en prolog
%Obtiene el resultado de la division modular del tama?o evaluado en 2
%Si el resultado es 0, es tama?o par
%largoPar(L).
largoPar([]).
largoPar(Lista) :-
    length(Lista,X),
    Y is X mod 2,
    Y is 0.

%Define si el largo de una lista es impar
%Largo de una lista con solo un elemento cualquiera es impar
%Si el resultado de la division modular es mayor que 0, es impar
%largoImpar(L).
largoImpar([_]).
largoImpar(Lista):-
    length(Lista,X),
    Y is X mod 2,
    Y > 0.

%Define si S1 es subconjunto de S
%subconj(S,S1).
%Lista vacia es subconjunto de una lista vacia
% Si el elemento se encuentra en ambas listas, lo toma como posible
% resultado y continua con backtracking
% Si el elemento no se encuentra en la lista, continua con backtracking
subconj([],[]).
subconj([H|T1],[H|T2]) :- subconj(T1,T2).
subconj([_|T1],L2) :- subconj(T1,L2).

%Define si la lista R es la inversa de la lista L
%La inversa de una lista vacia tambien es una lista vacia
%Va formando una lista con la cabeza de la lista 1 y llama
%recursivamente con la cola. Es decir, hace una nueva lista con el
%orden: resultado de recursividad, cabeza de la lista
%As? le da la vuelta a la lista y la compara con la lista 2 que se mand?
%por parametro
%invertir(L,R).

invertir([],[]).
invertir([X|T1],L2) :-
    invertir(T1,L3),
    append(L3,[X],L2).

%Divide una lista segun umbral
% Si la lista esta vacia, si importar el umbral , el resultado es lista
% vacia
% Divide la lista en cabeza cola.
% Si la cabeza es mayor al umbral, se hace la llamada recursiva para
% recorrer la cola con una lista nueva de mayores, se genera una lista
% nueva de mayores que contiene la cabeza de la lista, junto con la
% lista de mayores
% Si al contrario, la cabeza es menor que el umbral, se aplica la misma
% l?gica, pero se va generando la nueva lista con la lista de menores

%partir(L,U,Ma,Me).

partir([],_,[],[]).
partir([H|T],U,Ma,Me) :-
    H > U,
    partir(T,U,Ma2,Me),
    append(Ma2,[H],Ma).

partir([H|T],U,Ma,Me) :-
    H < U,
    partir(T,U,Ma,Me2),
    append(Me2,[H],Me).
