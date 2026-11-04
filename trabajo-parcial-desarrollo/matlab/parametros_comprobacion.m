function p = parametros_comprobacion()
% PARAMETROS_COMPROBACION  Juego numérico para correr la simulación.
%
% De la Tabla I de Kostić et al. (ICRA 2002) sí se usa:
%   a1 = 0, alpha = [pi/2; 0; 0], tres rotativas q1, q2, q3.
% Los offsets y las dos longitudes de esa tabla están en símbolos
% (C0C1, C1P1, P1C2, C2P2, P2C3). El PDF no imprime metros.
%
% Los cinco números de abajo NO son el robot de Eindhoven.
% Sirven para comprobar que la inversa cierra, que el jacobiano
% se anula con el codo estirado y que el control de la clase 7 converge.
% Cuando haya metros publicados, se reemplaza este archivo y no las fórmulas.

p.a1 = 0;
p.a2 = 0.40;
p.a3 = 0.35;
p.d1 = 0.30;
p.d2 = 0.05;
p.d3 = 0.02;
p.alpha = [pi/2; 0; 0];
p.es_el_robot = false;
end
