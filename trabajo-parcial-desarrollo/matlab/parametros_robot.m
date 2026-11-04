function p = parametros_robot()
% PARAMETROS_ROBOT  Antropomórfico de Ramzy, Hammad y Maged (2024).
% Tabla 1 de Denavit-Hartenberg y largos de la Tabla 2.
%   l1 = 0.04 m, l2 = 0.29 m, l3 = 0.240 m.
% alpha = [pi/2; 0; 0], a = [0; l2; l3], d = [l1; 0; 0].
% Masas, centros de masa y momentos de la misma Tabla 2 no entran
% en esta simulación: el parcial es cinemático.

p.l1 = 0.04;
p.l2 = 0.29;
p.l3 = 0.240;
p.a1 = 0;
p.a2 = p.l2;
p.a3 = p.l3;
p.d1 = p.l1;
p.d2 = 0;
p.d3 = 0;
p.alpha = [pi / 2; 0; 0];
end
