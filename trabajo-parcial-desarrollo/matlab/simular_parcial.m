% SIMULAR_PARCIAL  Cinemática y control del antropomórfico de Ramzy et al. (2024).
% Sube esta carpeta a MATLAB Online y ejecuta: simular_parcial
% No usa Robotics System Toolbox. El control sigue a la clase 7 (pinv y tanh).
% Los largos son los de la Tabla 2: l1 = 0.04 m, l2 = 0.29 m, l3 = 0.240 m.

clear
close all
clc

p = parametros_robot();
fprintf('Robot de Ramzy, Hammad y Maged (2024), Tabla 2.\n');
fprintf('l1 = %.3f m, l2 = %.3f m, l3 = %.3f m.\n\n', p.l1, p.l2, p.l3);

%% Directa contra las ecuaciones (6)-(8), e inversa
q_prueba = [0.4; 0.7; -0.8];
[xyz_m, ~, origenes] = cinematica_directa(q_prueba, p);
xyz_eq = posicion_paper(q_prueba, p);
fprintf('Error directa DHL vs ecuaciones (6)-(8): %.3e m\n', norm(xyz_m - xyz_eq));

q_inv = cinematica_inversa(xyz_m, p, -1, 1);
[xyz_vuelta, ~, ~] = cinematica_directa(q_inv, p);
fprintf('Error inversa luego directa: %.3e m\n', norm(xyz_m - xyz_vuelta));
fprintf('q pedido     = [% .4f % .4f % .4f] rad\n', q_prueba);
fprintf('q recuperado = [% .4f % .4f % .4f] rad\n\n', q_inv);

%% La inversa impresa del paper, ecuaciones (9)-(12), no cierra esta directa
x = xyz_eq(1);
y = xyz_eq(2);
z = xyz_eq(3);
arg_paper = (x^2 + y^2 + z^2 - (p.l2^2) * (p.l3^2)) / (2 * p.l2 * p.l3);
fprintf('Argumento del arccos de la ecuación (11) en este punto: %.3f\n', arg_paper);
fprintf('Queda fuera de [-1, 1]. Esa inversa no se usa.\n\n');

%% Singularidades: codo estirado, codo plegado, punta en el eje de q1
q_reg = q_prueba;
q_est = [0.2; 0.4; 0];
q_ple = [0.2; 0.4; pi];
% A = l2*cos(q2)+l3*cos(q2+q3) = 0 con q2 = 2*pi/3, sin dejar q3 en 0 o pi.
q2e = 2 * pi / 3;
c23 = -(p.l2 / p.l3) * cos(q2e);
q3e = acos(c23) - q2e;
q_eje = [0.4; q2e; q3e];
Areg = p.l2 * cos(q_reg(2)) + p.l3 * cos(q_reg(2) + q_reg(3));
det_cerrado = -Areg * p.l2 * p.l3 * sin(q_reg(3));
fprintf('det J regular              = %.6f\n', det(jacobiano_posicion(q_reg, p)));
fprintf('det cerrado - det J        = %.3e\n', det_cerrado - det(jacobiano_posicion(q_reg, p)));
fprintf('det J codo estirado        = %.3e\n', det(jacobiano_posicion(q_est, p)));
fprintf('det J codo plegado         = %.3e\n', det(jacobiano_posicion(q_ple, p)));
punta_eje = cinematica_directa(q_eje, p);
fprintf('det J punta en el eje de q1 = %.3e\n', det(jacobiano_posicion(q_eje, p)));
fprintf('sin(q3) en esa postura     = %.3f\n', sin(q_eje(3)));
fprintf('punta en esa postura (m)   = [% .3e % .3e % .4f]\n\n', punta_eje);

%% Control de posición. Ley de la clase 7: qp = pinv(J) * K * tanh(e), K = 8 I
q_meta = [0.4; 0.8; -0.7];
objetivo = cinematica_directa(q_meta, p);
q = [0.15; 0.55; -0.4];
tf = 8;
ts = 0.05;
Kpos = 8 * eye(3);
N = floor(tf / ts);
historia = zeros(3, N + 1);
qs = zeros(3, N + 1);
historia(:, 1) = cinematica_directa(q, p);
qs(:, 1) = q;
nfin = 1;
singular = false;
for k = 1:N
    e = objetivo - historia(:, nfin);
    J = jacobiano_posicion(q, p);
    if abs(det(J)) < 1e-4
        singular = true;
        break
    end
    qp = pinv(J) * (Kpos * tanh(e));
    q = q + ts * qp;
    nfin = k + 1;
    qs(:, nfin) = q;
    historia(:, nfin) = cinematica_directa(q, p);
end
fprintf('Control de posición. Error final = %.3e m. Pasos = %d.\n', ...
    norm(objetivo - historia(:, nfin)), nfin - 1);
if singular
    fprintf('Se detuvo: |det J| < 1e-4.\n');
end

%% Seguimiento cartesiano. Ley de la clase 7: qp = pinv(J) * (hd_punto + K e)
tf2 = 20;
ts2 = 0.05;
t2 = 0:ts2:tf2;
N2 = numel(t2);
centro = cinematica_directa([0.5; 0.9; -0.8], p);
hd = zeros(3, N2);
hdp = zeros(3, N2);
for k = 1:N2
    tk = t2(k);
    hd(:, k) = centro + [0.03 * cos(0.3 * tk); ...
                         0.03 * sin(0.3 * tk); ...
                         0.02 * sin(0.5 * tk)];
    hdp(:, k) = [-0.03 * 0.3 * sin(0.3 * tk); ...
                  0.03 * 0.3 * cos(0.3 * tk); ...
                  0.02 * 0.5 * cos(0.5 * tk)];
end
q = cinematica_inversa(hd(:, 1), p, -1, 1);
h = zeros(3, N2);
h(:, 1) = cinematica_directa(q, p);
singular_seg = false;
for k = 1:N2 - 1
    e = hd(:, k) - h(:, k);
    J = jacobiano_posicion(q, p);
    if abs(det(J)) < 1e-4
        singular_seg = true;
        h = h(:, 1:k);
        hd = hd(:, 1:k);
        break
    end
    qp = pinv(J) * (hdp(:, k) + e);
    q = q + ts2 * qp;
    h(:, k + 1) = cinematica_directa(q, p);
end
err_seg = vecnorm(hd - h);
fprintf('Seguimiento. Error máximo = %.4e m. Error final = %.4e m.\n', ...
    max(err_seg), err_seg(end));
if singular_seg
    fprintf('El seguimiento se detuvo: |det J| < 1e-4.\n');
end
fprintf('\n');

%% Punto a punto articular. Polinomios de la clase 6
t_pol = 0:0.1:3;
qi = cinematica_inversa(cinematica_directa([0.3; 0.6; -0.5], p), p, -1, 1);
qf = cinematica_inversa(cinematica_directa([0.7; 1.0; -0.9], p), p, -1, 1);
[q_cub, qp_cub, ~] = interpolador_articular(qi, qf, t_pol, "cubica");
[~, ~, qpp_qui] = interpolador_articular(qi, qf, t_pol, "quintica");
fprintf('Cúbica: velocidad inicial = %.3e, final = %.3e rad/s\n', ...
    norm(qp_cub(:, 1)), norm(qp_cub(:, end)));
fprintf('Quíntica: aceleración inicial = %.3e, final = %.3e rad/s^2\n', ...
    norm(qpp_qui(:, 1)), norm(qpp_qui(:, end)));

punta_cub = zeros(3, numel(t_pol));
for k = 1:numel(t_pol)
    punta_cub(:, k) = cinematica_directa(q_cub(:, k), p);
end

%% Esquemas
figure('Name', 'Control de posición')
plot3(historia(1, 1:nfin), historia(2, 1:nfin), historia(3, 1:nfin), 'b')
hold on
[~, ~, cad0] = cinematica_directa(qs(:, 1), p);
[~, ~, cadf] = cinematica_directa(qs(:, nfin), p);
plot3(cad0(1, :), cad0(2, :), cad0(3, :), 'k-o')
plot3(cadf(1, :), cadf(2, :), cadf(3, :), 'g-o')
plot3(objetivo(1), objetivo(2), objetivo(3), 'r*')
grid on
axis equal
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
title('Posición: cadena inicial, cadena final y camino de la punta')
legend('punta', 'inicio', 'final', 'objetivo', 'Location', 'best')

figure('Name', 'Seguimiento')
plot3(hd(1, :), hd(2, :), hd(3, :), 'k--')
hold on
plot3(h(1, :), h(2, :), h(3, :), 'b')
grid on
axis equal
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
title('Seguimiento: referencia punteada, punta en azul')
legend('referencia', 'punta', 'Location', 'best')

figure('Name', 'Interpolador cúbico')
subplot(2, 1, 1)
plot(t_pol, q_cub')
grid on
ylabel('q (rad)')
title('Articulaciones, polinomio cúbico de la clase 6')
legend('q1', 'q2', 'q3')
subplot(2, 1, 2)
plot3(punta_cub(1, :), punta_cub(2, :), punta_cub(3, :), 'b')
grid on
axis equal
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
title('Punta al pasar el polinomio por la directa')

fprintf('\nOrígenes de la cadena en q de prueba (columnas: base, 1, 2, punta):\n')
disp(origenes)

function xyz = posicion_paper(q, p)
q1 = q(1);
q2 = q(2);
q3 = q(3);
A = p.l2 * cos(q2) + p.l3 * cos(q2 + q3);
xyz = [cos(q1) * A; ...
       sin(q1) * A; ...
       p.l1 + p.l2 * sin(q2) + p.l3 * sin(q2 + q3)];
end
