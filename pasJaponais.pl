depart(N,  Rs) :-
    even(N),
    N2 is N/2,
    fill(d, N2, Ds),
    fill(g, N2, Gs),
    append(Ds, [v|Gs], Rs).

arrivee(N, Rs) :-
    depart(N, Xs),
    reverse(Xs, Rs).

deplacement(1, d).
deplacement(-1, g).
deplacement(2, d).
deplacement(-2, g).

deplace(L, N, Rs) :-
    nth1(N, L, Joueur),
    deplacement(Distance, Joueur),
    V is N + Distance,
    nth1(V, L, v),
    list_i_j_swapped(L, N, V, Rs).

chemin(De, De).
chemin(De, A) :-
    deplace(De, _, Intermediaire),
    chemin(Intermediaire, A),
    print(Intermediaire),
    nl().

resoudre(N) :-
    depart(N, As),
    arrivee(N, Bs),
    chemin(As, Bs).

%-----------%
%   Tests   %
%-----------%

% Find all failing tests with : ?- red(X).
% Find all passing tests with : ?- green(X).

assertTrue("Position de départ à 2 joueurs", depart(2, [d, v, g])).
assertTrue("Position de départ à 4 joueurs", depart(4, [d, d, v, g, g])).
assertTrue("Position d'arrivée à 2 joueurs", arrivee(2, [g, v, d])).
assertTrue("Position d'arrivée à 4 joueurs", arrivee(4, [g, g, v, d, d])).
assertTrue("Marche droite", deplace([d, v, g], 1, [v, d, g])).
assertTrue("Marche gauche", deplace([d, v, g], 3, [d, g, v])).
assertTrue("Saute droite", deplace([d, g, v], 1, [v, g, d])).
assertTrue("Saute gauche", deplace([v, d, g], 3, [g, d, v])).
assertFalse("Vide ne peut se déplacer", deplace([d, v, g], 2, _)).

red(X) :-
    assertTrue(X, T),
    not(call(T)).

red(X) :-
    assertFalse(X, T),
    call(T).

green(X) :-
    assertTrue(X, T),
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
