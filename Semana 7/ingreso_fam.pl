% familias

familia(% padre
	persona(juan, perez, fecha(7, mayo, 1950), trabajo(usm, 450000)),
	% madre
	persona(maria, toledo, fecha(9, julio, 1956), cesante),
	% hijos
	[persona(tomas, perez, fecha(12, diciembre, 1976),
		 trabajo(aduana, 650000)),
	persona(ana, perez, fecha(23, enero, 1978),
		trabajo(falabella, 550000)),
	persona(pedro, perez, fecha(16, octubre, 1985),
		cesante)]
       ).

familia(% padre
	persona(juan, perez, fecha(7, mayo, 1950), trabajo(usm, 250000)),
	% madre
	persona(maria, toledo, fecha(9, julio, 1956), cesante),
	% hijos
	[persona(tomas, perez, fecha(12, diciembre, 1976),
		 trabajo(aduana, 650000)),
	persona(ana, perez, fecha(23, enero, 1978),
		trabajo(falabella, 450000)),
	persona(pedro, perez, fecha(16, octubre, 1985),
		cesante)]
       ).


% agregar varias familias más

%verifica si una persona es marido o mujer en la base de datos

marido(X) :- familia(X, _, _).
mujer(Y) :- familia(_, Y, _).

%verifica si una persona es un hijo en la base de datos

hijo(Z) :-
	familia(_, _, Hijos),
	member(Z, Hijos).

%verifica si existe una persona en la base de datos

existe(P) :- marido(P); mujer(P); hijo(P).

% salario de una persona

salario(persona(_, _,_, trabajo(_, S)), S).
salario(persona(_, _,_, cesante), 0).

% calcular el ingreso de lista de personas

ingresos_l([], 0).
ingresos_l([Persona | Lista], Suma) :-
	   salario(Persona, S), % salario del primero
	   ingresos_l(Lista, Resto), % salarios del resto
	   Suma is S + Resto,!.

% ahora se puede calcular ingreso familiar
ingresos(Pat, Mat, S) :-
	familia(persona(_,Pat,_,_),persona(_,Mat,_,_),_),
	Papa = persona(_,Pat,_,_),
	Mama = persona(_,Mat,_,_),
	familia(Papa, Mama, Hijos),
	ingresos_l([Papa, Mama | Hijos], S).

% y ahora se hace una consulta
%?- ingresos(X, Y, Z).
%X = perez
%Y = toledo
%Z = 1650000.
