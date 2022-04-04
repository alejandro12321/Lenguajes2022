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
	persona(álvaro, gonzález, fecha(7, mayo, 1950), trabajo(usm, 250000)),
	% madre
	persona(rosa, martínez, fecha(9, julio, 1956), trabajo(ice,300000)),
	% hijos
	[persona(maría, gonzález, fecha(12, diciembre, 1976),
		 trabajo(aduana, 500000))]
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

salario(persona(_, A,_, trabajo(_, S)), A, S).
salario(persona(_, A,_, cesante), A, 0).
salario(persona(_,_,_,_),_,0).

% calcular el ingreso de lista de personas

ingresos_l([], _, 0).
ingresos_l([Persona | Lista], Apellido, Suma) :-
	   salario(Persona, Apellido, S), % salario del primero
	   ingresos_l(Lista, Apellido, Resto), % salarios del resto
	   Suma is S + Resto,!.

% ahora se puede calcular ingreso familiar
ingresos(Pat, Mat, S) :-
	familia(persona(_,Pat,_,_),persona(_,Mat,_,_),_),
	Papa = persona(_,Pat,_,_),
	Mama = persona(_,Mat,_,_),
	familia(Papa, Mama, Hijos),
	ingresos_l([Papa|Hijos],Pat, S1),
	ingresos_l([Mama],Mat, S2),
%	ingresos_l(Hijos, Pat, S3),
	S is S1 + S2.

% y ahora se hace una consulta
%?- ingresos(X, Y, Z).
%X = perez
%Y = toledo
%Z = 1650000.
