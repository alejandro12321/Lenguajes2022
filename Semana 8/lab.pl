%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 parte
% Planificacion de horarios
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%semestre(numero semestre, curso asignado y horas del curso)
semestre(1, curso(4)). %%semestre 1 tiene un curso de 4 horas
semestre(1, curso(2)). %%semestre 1 tiene un curso de 2 horas
semestre(2, curso(4)).
semestre(3, curso(4)).
semestre(4, curso(4)).
semestre(4, curso(2)).
semestre(5, curso(4)).
semestre(6, curso(4)).
semestre(6, curso(2)).
semestre(7, curso(4)).

%Semestres pares e impares
tipo(pares,X,C):-
    semestre(X,C),
    N is X mod 2,
    N = 0.
tipo(impares,X,C):-
    semestre(X,C),
    N is X mod 2,
    N > 0.


%bloque disponible horario(mañana o tarde, horas)
bloque(m,2).
bloque(m,4).
bloque(t,2).
bloque(t,4).

%Horarios
%Tipo de semestre
%horario(Pares_Impares,Bloque).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 parte
% Identificacion de personas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%persona(nombre,listaCromosomas).
persona(juan,[1,1,1,1,1,1,0,1,1,1,0,1]).
persona(ana,[0,1,0,1,1,1,1,1,0,1,1,1]).
persona(maria,[1,1,1,0,1,0,1,1,0,1,1,1]).
persona(pedro,[0,1,1,0,1,1,0,1,0,1,1,1]).
persona(jose,[1,1,1,0,1,1,1,0,1,1,1,0]).
persona(rafael,[0,1,0,1,0,1,0,1,0,1,0,1]).
persona(miguel,[1,0,1,0,1,0,1,0,1,0,1,0]).
persona(rosa,[1,1,0,0,1,1,0,0,1,1,0,0]).
persona(marta,[1,1,1,1,1,1,0,0,0,0,0,0]).
persona(fabian,[0,0,0,0,0,0,1,1,1,1,1,1]).
persona(enrique,[0,0,0,0,0,0,0,0,0,0,0,0]).
persona(bob,[1,1,1,1,1,1,1,1,1,1,1,1]).

/*persona(juan,[1,1,0]).
persona(maria,[0,1,0]).*/
%para toda muestra que sea lista vacia, las coincidencias son 0
parecidos([],[],Cont,Cont,_).
%se dividen las listas muestra y personas en base de datos
parecidos([H|T],[H2|T2],Cont,R,_):-
   H = H2, %%Si son elementos iguales, aumenta el contador
   Suma is Cont + 1,
   parecidos(T,T2,Suma,R,_).
parecidos([H|T],[H2|T2],Cont,R,_):-
   not(H = H2), %%Si no son iguales, no aumenta el contador en la recursividad
   parecidos(T,T2,Cont,R,_).

%muestra, repetido r veces, nombre de la persona
auxConsulta(Muestra,R,N):-
    persona(N,Lista),
    parecidos(Muestra, Lista,0,R,N).
% consulta 2, recibe la muestra que es una lista de 12 elementos, Top es
% la cantidad de elementos que se desean desplegar en el resultado, pro
% ejemplo los primeros 4 elementos, Res es la variable resultado de la
% consulta
con(Muestra,Top,Res) :-
    findall([R,N],auxConsulta(Muestra,R,N),L),
    sort(L,L2),
    reverse(L2,L3),
    take(L3,Top,Res).

% Toma los primeros N elementos de una lista Src y genera una nueva
% lista Lcon esos primeros N elementos
take(Src,N,L) :- findall(E, (nth1(I,Src,E), I =< N), L).
