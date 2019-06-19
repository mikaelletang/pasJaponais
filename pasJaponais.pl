depart(N,  Rs) :-
    even(N),
    N2 is N/2,
    fill(regarde_a_droite, N2, Ds),
    fill(regarde_a_gauche, N2, Gs),
    append(Ds, [vide|Gs], Rs).

arrivee(N, Rs) :-
    depart(N, Xs),
    reverse(Xs, Rs).

marche(L, N, Rs) :-
    V is N + 1,
    nth1(N, L, regarde_a_droite),
    nth1(V, L, vide),
    list_i_j_swapped(L, N, V, Rs).

marche(L, N, Rs) :-
    V is N - 1,
    nth1(N, L, regarde_a_gauche),
    nth1(V, L, vide),
    list_i_j_swapped(L, N, V, Rs).


%-----------%
%   Tests   %
%-----------%

% Find all failing tests with : ?- red(X).
% Find all passing tests with : ?- green(X).

assert("position de départ à 2 joueurs", depart(2, [regarde_a_droite, vide, regarde_a_gauche])).
assert("position de départ à 4 joueurs", depart(4, [regarde_a_droite, regarde_a_droite, vide, regarde_a_gauche, regarde_a_gauche])).
assert("position d'arrivée à 2 joueurs", arrivee(2, [regarde_a_gauche, vide, regarde_a_droite])).
assert("position d'arrivée à 4 joueurs", arrivee(4, [regarde_a_gauche, regarde_a_gauche, vide, regarde_a_droite, regarde_a_droite])).
assert("Marche droite", marche([regarde_a_droite, vide, regarde_a_gauche], 1, [vide, regarde_a_droite, regarde_a_gauche])).
assert("Marche gauche", marche([regarde_a_droite, vide, regarde_a_gauche], 3, [regarde_a_droite, regarde_a_gauche, vide])).
assertFalse("Vide peut marcher", marche([regarde_a_droite, vide, regarde_a_gauche], 2, _)).

red(X) :-
    assert(X, T),
    not(call(T)).

red(X) :-
    assertFalse(X, T),
    call(T).

green(X) :-
    assert(X, T),
    call(T).

green(X) :-
    assertFalse(X, T),
    not(call(T)).

%-----------%
%  helpers  %
%-----------%

even(X) :-
    0 is mod(X, 2).

fill(_, 0, []).

fill(X, N, [X|Xs]) :-
    succ(N0, N),
    fill(X, N0, Xs).

list_i_j_swapped(As,I,J,Cs) :-
    I1 is I - 1,
    J1 is J - 1,
    same_length(As,Cs),
    length(BeforeI,I1),
    length(BeforeJ,J1),
    append(BeforeI,[AtI1|PastI1],As),
    append(BeforeI,[AtJ1|PastI1],Bs),
    append(BeforeJ,[AtJ1|PastJ1],Bs),
    append(BeforeJ,[AtI1|PastJ1],Cs).
