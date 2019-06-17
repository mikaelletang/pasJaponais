use_module(library(clpfd)).

red(Name) :-
    test(Name,  Test),
    L =.. Test,
    not(call(L)).

even(X) :-
    0 is mod(X, 2).

fill([], _, 0).

fill([X|Xs], X, N) :-
    succ(N0, N),
    fill(Xs, X, N0).

depart(N,  Xs) :-
    even(N),
    N2 is N/2,
    fill(Ds, regarde_a_droite, N2),
    fill(Gs, regarde_a_gauche, N2),
    append(Ds, [vide|Gs], Xs).

arrivee(N, Xs) :-
    depart(N, Ys),
    reverse(Ys, Xs).


test("position de départ à 2 joueurs", [depart, 2, [regarde_a_droite, vide, regarde_a_gauche]]).
test("position de départ à 4 joueurs", [depart, 4, [regarde_a_droite, regarde_a_droite, vide, regarde_a_gauche, regarde_a_gauche]]).
test("position d'arrivée à 2 joueurs", [depart, 2, [regarde_a_gauche, vide, regarde_a_droite]]).
test("position d'arrivée à 4 joueurs", [depart, 4, [regarde_a_gauche, regarde_a_gauche, vide, regarde_a_droite, regarde_a_droite]]).

