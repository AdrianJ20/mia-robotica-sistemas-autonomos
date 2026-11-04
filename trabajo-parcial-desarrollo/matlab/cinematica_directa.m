function [xyz, T, origenes] = cinematica_directa(q, p)
% CINEMATICA_DIRECTA  Punta del antropomórfico de 3 rotativas.
% Cadena de la Tabla 1 de Ramzy et al. (2024), armada con DHL.
% La posición es la de las ecuaciones (6)-(8) de ese paper:
%   x = cos(q1)*(l2*cos(q2) + l3*cos(q2+q3))
%   y = sin(q1)*(l2*cos(q2) + l3*cos(q2+q3))
%   z = l1 + l2*sin(q2) + l3*sin(q2+q3)

q = q(:);
M01 = dhl(q(1), p.d1, p.a1, p.alpha(1));
M12 = dhl(q(2), p.d2, p.a2, p.alpha(2));
M23 = dhl(q(3), p.d3, p.a3, p.alpha(3));
M02 = M01 * M12;
T = M02 * M23;
xyz = T(1:3, 4);
origenes = [zeros(3, 1), M01(1:3, 4), M02(1:3, 4), xyz];
end
