function q = cinematica_inversa(xyz, p, codo, cintura)
% CINEMATICA_INVERSA  Geométrica, dos signos como en la clase 3.
% codo    = +1 codo arriba del plano del brazo, -1 el otro.
% cintura = +1 una solución de q1, -1 la otra.
% Sale de la ecuación (5) del paper. El escaneo de la (6) no se lee
% entero, así que esta forma se comprobó contra la directa, no se copió
% de una celda ilegible.

x = xyz(1);
y = xyz(2);
z = xyz(3);
delta = p.d2 + p.d3;
rho = hypot(x, y);

if rho < abs(delta) - 1e-12
    error('Fuera de alcance: el radio en xy es menor que |d2+d3|.');
end

phi = atan2(y, x);
beta = asin(delta / rho);
if cintura > 0
    q1 = phi + beta;
else
    q1 = phi + pi - beta;
end

A = x * cos(q1) + y * sin(q1);
zp = z - p.d1;
c3 = (A^2 + zp^2 - p.a2^2 - p.a3^2) / (2 * p.a2 * p.a3);
if abs(c3) > 1 + 1e-9
    error('Fuera de alcance: el codo no cierra para ese punto.');
end
c3 = max(-1, min(1, c3));
s3 = codo * sqrt(1 - c3^2);
q3 = atan2(s3, c3);
q2 = atan2(zp, A) - atan2(p.a3 * s3, p.a2 + p.a3 * c3);
q = [q1; q2; q3];
end
