%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File learner.pl                                                              %
% Un pequeño programa que modifica su propia base de conocimientos.            %
% Autor: Oscar Víquez. Lenguajes de Programación                               %
% Fecha: 09/10/2007                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% En consola se puede hacer un retract(capital_of(pais,_)).
%Reglas para cosultas

start :- dynamic(capital_of/2),
         consult(bdc),
         nl,
         write('Escribe los nombres completamente en minúsculas,'), nl,
         write('seguidos de un punto.'), nl,
         nl,
         process_a_query.

process_a_query :- write('País? '),
                   read(Pais),
                   answer(Pais).

% Si el usuario ingresa "stop.", entonces grabar la nueva
% base de conocimientos y salir.
answer(stop) :- write('Grabando la base de conocimientos...'), nl,
                tell('bdc.pl'),
                listing(capital_of),
                told,
		retractall(capital_of(_,_)), %limpia la base de datos para evitar incongruencias
                write('Listo.'), nl.

% Si el país ya está en la base de conocimientos, entonces retornar
% el nombre de su capital.
answer(Pais) :- capital_of(Pais, Ciudad),
                write('La capital de '),
                write(Pais),
                write(' es '),
                write(Ciudad), nl,
                nl,
                process_a_query.

% Si el país no está en la base de conocimientos, entonces pedir
% el nombre de la capital e ingresar este fact a la base.
answer(Pais) :- \+ capital_of(Pais, _), %% analogo a "not(capital_of(Pais, Ciudad))"
                write('No conozco la capital de ese país.'), nl,
                write('Por favor, dime cual es.'), nl,
                write('Capital? '),
                read(Ciudad),
                write('Gracias.'), nl, nl,
                assert(capital_of(Pais, Ciudad)),
                process_a_query.

