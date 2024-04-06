:- include('KB.pl').

state(F,M,E,0,0,s0):-
  food(F),materials(M),energy(E).

state(X2,Y2,Z2,B1,B2,result(A,S)):-
    state(X1,Y1,Z1,B10,B20,S),
    ((A=reqm,Y2 is Y1+1,X2=X1,Z2=Z1,B1=B10,B2=B20);
     (A=reqf,X2 is X1+1,Y2 = Y1,Z2=Z1,B1=B10,B2=B20);
     (A=reqe,Z2 is Z1+1,X2=X1,Y2=Y1,B1=B10,B2=B20);
     (A=b1, build1(B1Food,B1Materials,B1Energy),X1>=B1Food, Y1>=B1Materials, Z1>=B1Energy, B1 is 1,
         X2 is X1-B1Food, Y2 is Y1-B1Materials, Z2 is Z1-B1Energy, B2=B20);
     (A=b2, build2(B2Food,B2Materials,B2Energy),X1>=B2Food, Y1>=B2Materials, Z1>=B2Energy, B1=B10,B2 is 1, X2 is X1-B2Food, Y2 is Y1-B2Materials, Z2 is Z1-B2Energy)).
     
goal(S):-
  %  write('The value of X'),
    ids(S,1).

ids(S,L):-
    (call_with_depth_limit(goal_test(S),L,R), number(R));
    (call_with_depth_limit(goal_test(S),L,R), R=depth_limit_exceeded, L1 is L+1, ids(S,L1)).

goal_test(S):-
    state(_,_,_,1,1,S).



