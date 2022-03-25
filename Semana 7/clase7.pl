succ2(Y,X) :- Y is X+1.
add(Y,0,X) :- Y = X.
add(Z,X,Y) :- W is X-1, add(U,W,Y),succ2(Z,U).


not(X) :- X,!,fail.
not(_).
