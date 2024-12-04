% Solving a clamped, supported beam

syms v(x) x q EI L 

theta(x) = diff(v(x),x)
eq1 = EI*diff(v,x,4) == - q

v_sol = dsolve(eq1)
theta_sol = diff(v_sol,x)
M_sol = EI*diff(theta_sol,x)


bc1 = subs(v_sol,x,0) == 0
bc2 = subs(theta_sol,x,0) == 0
bc3 = subs(M_sol,x,L) == 0
bc4 = subs(v_sol,x,L) == 0

% Now, we impose the boundary conditions 
% to determine the constants C1 C2 C3 C4

syms C1 C2 C3 C4
solution = solve([bc1, bc2, bc3, bc4], [C1, C2, C3, C4])


C1_sol = solution.C1
C2_sol = solution.C2
C3_sol = solution.C3
C4_sol = solution.C4

v_true = subs(v_sol,{C1,C2,C3,C4},...
    {C1_sol,C2_sol,C3_sol,C4_sol})
theta_true = diff(v_true,x)
kappa_true = diff(theta_true,x)
M_true = simplify(EI*kappa_true)



% Now we plot v_true
figure
L_val = 1;
EI_val = 1;
q_val = 1;

v_numeric = subs(v_true,{L,EI,q},{L_val,EI_val,q_val})
fplot(v_numeric, [0 1])

M_numeric = subs(M_true,{L,EI,q},{L_val,EI_val,q_val})
fplot(-M_numeric, [0 1])
grid on



