use_module(library(clpfd)).

moyenne(A, B, C, Resultat) :-
    Resultat is (A+B+C) / 3.

testMoyenne([A, B, C], SortieAttendue) :-
    moyenne(A, B, C, SortieAttendue).

test("La moyenne de 1, 2 et 3 est 2", testMoyenne([1, 2, 3], 2)).
test("La moyenne de 2, 2 et 2 est 2", testMoyenne([2, 2, 2], 2)).
test("La moyenne de 2, 2 et 2 est 4", testMoyenne([2, 2, 2], 4)).

green(GreenTestName) :-
    test(GreenTestName,  TestBody),
    call(TestBody).

red(RedTestName) :-
    test(RedTestName, TestBody),
    not(call(TestBody)).
