function J = jacobiano_posicion(q, p)
% JACOBIANO_POSICION  3x3, derivadas de [x;y;z] respecto de [q1;q2;q3].
% Mismo criterio que Jacobiano_3GDL.mlx: el jacobiano de la posición.
% Aquí la posición es la del antropomórfico, no la del RRP de la práctica.

q1 = q(1);
q2 = q(2);
q3 = q(3);
delta = p.d2 + p.d3;
c1 = cos(q1);
s1 = sin(q1);
c2 = cos(q2);
s2 = sin(q2);
c23 = cos(q2 + q3);
s23 = sin(q2 + q3);
A = p.a2 * c2 + p.a3 * c23;
B = p.a2 * s2 + p.a3 * s23;

J = [-s1 * A + delta * c1,  -c1 * B,  -c1 * p.a3 * s23; ...
      c1 * A + delta * s1,  -s1 * B,  -s1 * p.a3 * s23; ...
      0,                     A,         p.a3 * c23];
end
