% 荣格八维
功能(X) :-
    member(X, [t,f,s,n]).

倾向(X) :-
    member(X, [i,e]).

维度((A,V)) :-
    功能(A),倾向(V).

八维(L) :-
    findall(X, 维度(X),L).

理性((X,_)) :-
    member(X, [t,f]).

非理性((X,_)) :-
    member(X, [s,n]).

理性组(X,Y):-
    理性(X),理性(Y),X\=Y,!.

非理性组(X,Y):-
    非理性(X),非理性(Y),X\=Y,!.

反向((_,X),(_,Y)) :-
    倾向(X),倾向(Y),X\=Y.

同组(X,Y) :-
    (非理性组(X,Y);理性组(X,Y)).

异组(X,Y) :-
    (理性(X),非理性(Y));
    (理性(Y),非理性(X)).

互补(X,Y) :-
    同组(X,Y),反向(X,Y).

遍历((X,_),(Y,_),(Z,_),(W,_)):-
    permutation([t,f,s,n], [X,Y,Z,W]).


穿插((_,i),(_,e),(_,i),(_,e)).
穿插((_,e),(_,i),(_,e),(_,i)).
% 等价的
% 穿插((_,V1),(_,V2),(_,V3),(_,V4)):-
%     倾向(V1), 倾向(V2), 倾向(V3), 倾向(V4), V1 = V3, V2 = V4, V1 \= V2.

% 采样([X,Y,Z,W]) :-
%     遍历(X,Y,Z,W),穿插(X,Y,Z,W),互补(X,Z),互补(Y,W).
十六型([X_主位,X_辅位,X_三位,X_四位]) :-
    遍历(X_主位,X_辅位,X_三位,X_四位),
    (互补(X_主位,X_三位),互补(X_辅位,X_四位);互补(X_主位,X_四位),互补(X_辅位,X_三位)),
    异组(X_主位,X_辅位),异组(X_三位,X_四位),
    穿插(X_主位,X_辅位,X_三位,X_四位).

主位转换((A,V), (V,A)).
非理性转换((A,V), (A,PJ)) :-
    V=i, PJ=j;V=e, PJ=p.
    

jung2mbti([(A_主位,V_主位), (A_辅位,V_辅位), _, _], (V_主位, X2, X3, X4)):-
    理性((A_主位,_)),X3=A_主位,X2=A_辅位,(V_辅位=i,X4=j;V_辅位=e,X4=p);
    理性((A_辅位,_)),X3=A_辅位,X2=A_主位,(V_主位=i,X4=j;V_主位=e,X4=p).

table() :-
    十六型(X),jung2mbti(X,Y),
    write(X),write('->'),write(Y),nl.