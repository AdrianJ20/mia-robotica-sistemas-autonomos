% SIMULAR_PARCIAL  Cinemática y control del antropomórfico de 3 GDL.
% Sube esta carpeta a MATLAB Online y ejecuta: simular_parcial
% No usa Robotics System Toolbox. El control sigue a la clase 7 (pinv y tanh).

clear
close all
clc

p = parametros_comprobacion();
fprintf('Longitudes de comprobación, no las del robot de la Tabla I.\n');
fprintf('a1 = 0 y alpha = [pi/2, 0, 0] sí salen de esa tabla.\n\n');

%% Directa contra la ecuación (5), e inversa
q_prueba = [0.3; 0.5; -0.8];
[xyz_m, ~, origenes] = cinematica_directa(q_prueba, p);
xyz_eq = posicion_ecuacion5(q_prueba, p);
fprintf('Error directa DHL vs ecuación (5): %.3e m\n', norm(xyz_m - xyz_eq));

q_inv = cinematica_inversa(xyz_m, p, -1, 1);
[xyz_vuelta, ~, ~] = cinematica_directa(q_inv, p);
fprintf('Error inversa luego directa: %.3e m\n', norm(xyz_m - xyz_vuelta));
fprintf('q pedido    = [% .4f % .4f % .4f] rad\n', q_prueba);
fprintf('q recuperado = [% .4f % .4f % .4f] rad\n\n', q_inv);

%% Singularidad: codo estirado y codo plegado
q_reg = [0.3; 0.5; -0.8];
q_est = [0.2; 0.4; 0];
q_ple = [0.2; 0.4; pi];
fprintf('det J regular          = %.6f\n', det(jacobiano_posicion(q_reg, p)));
fprintf('det J codo estirado    = %.3e\n', det(jacobiano_posicion(q_est, p)));
fprintf('det J codo plegado     = %.3e\n\n', det(jacobiano_posicion(q_ple, p)));

%% Control de posición. Ley de la clase 7: qp = pinv(J) * K * tanh(e), K = 8 I
objetivo = [0.45; 0.15; 0.55];
q = [0.2; 0.6; 0.7];
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

%% Seguimiento. Ley de la clase 7: qp = pinv(J) * (hd_punto + K e), K = I
tf2 = 20;
ts2 = 0.05;
t2 = 0:ts2:tf2;
N2 = numel(t2);
hd = zeros(3, N2);
hdp = zeros(3, N2);
for k = 1:N2
    tk = t2(k);
    hd(:, k) = [0.40 + 0.06 * cos(0.3 * tk); ...
                0.12 + 0.06 * sin(0.3 * tk); ...
                0.48 + 0.03 * sin(0.5 * tk)];
    hdp(:, k) = [-0.06 * 0.3 * sin(0.3 * tk); ...
                  0.06 * 0.3 * cos(0.3 * tk); ...
                  0.03 * 0.5 * cos(0.5 * tk)];
end
q = cinematica_inversa(hd(:, 1), p, 1, 1);
h = zeros(3, N2);
h(:, 1) = cinematica_directa(q, p);
for k = 1:N2 - 1
    e = hd(:, k) - h(:, k);
    J = jacobiano_posicion(q, p);
    qp = pinv(J) * (hdp(:, k) + e);
    q = q + ts2 * qp;
    h(:, k + 1) = cinematica_directa(q, p);
end
err_seg = vecnorm(hd - h);
fprintf('Seguimiento. Error máximo = %.4f m. Error final = %.3e m.\n\n', ...
    max(err_seg), err_seg(end));

%% Interpoladores de la clase 6, en el espacio articular
t_pol = 0:0.1:3;
qi = cinematica_inversa([0.50; 0.10; 0.40], p, 1, 1);
qf = cinematica_inversa([0.35; 0.20; 0.60], p, 1, 1);
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

function xyz = posicion_ecuacion5(q, p)
delta = p.d2 + p.d3;
q1 = q(1);
q2 = q(2);
q3 = q(3);
A = p.a3 * cos(q2 + q3) + p.a2 * cos(q2);
xyz = [cos(q1) * A + delta * sin(q1); ...
       sin(q1) * A - delta * cos(q1); ...
       p.a3 * sin(q2 + q3) + p.a2 * sin(q2) + p.d1];
end
