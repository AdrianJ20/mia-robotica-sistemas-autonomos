function [xyz, T, origenes] = cinematica_directa(q, p)
% CINEMATICA_DIRECTA  Punta del RRR antropomórfico.
% Cadena de la Tabla I de Kostić et al. (ICRA 2002), armada con DHL.
% La posición coincide con la ecuación (5) de ese paper:
%   x = cos(q1)*(a3*cos(q2+q3) + a2*cos(q2)) + (d2+d3)*sin(q1)
%   y = sin(q1)*(a3*cos(q2+q3) + a2*cos(q2)) - (d2+d3)*cos(q1)
%   z = a3*sin(q2+q3) + a2*sin(q2) + d1

q = q(:);
M01 = dhl(q(1), p.d1, p.a1, p.alpha(1));
M12 = dhl(q(2), p.d2, p.a2, p.alpha(2));
M23 = dhl(q(3), p.d3, p.a3, p.alpha(3));
M02 = M01 * M12;
T = M02 * M23;
xyz = T(1:3, 4);
origenes = [zeros(3, 1), M01(1:3, 4), M02(1:3, 4), xyz];
end
