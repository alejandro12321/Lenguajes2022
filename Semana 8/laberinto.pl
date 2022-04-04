conectado(i,2).
conectado(2,3).
conectado(2,8).
conectado(8,9).
conectado(9,3).
conectado(3,4).
conectado(4,10).
conectado(10,16).
conectado(16,22).
conectado(22,21).
conectado(21,15).
conectado(15,14).
conectado(14,13).
conectado(13,7).
conectado(7,1).
conectado(14,20).
conectado(20,26).
conectado(26,27).
conectado(27,28).
conectado(28,34).
conectado(34,33).
conectado(33,32).
conectado(32,f).

camino(X,Y) :- conectado(X,Y); conectado(Y,X).
ruta2(X,X,L,L).
ruta2(X,Y,Ruta,Res) :-
    camino(X,W),
    not(member(W,Ruta)),
    ruta2(W,Y,[X|Ruta],Res).
ruta(X,Y,Ruta) :-  ruta2(X,Y,[],Ruta).
