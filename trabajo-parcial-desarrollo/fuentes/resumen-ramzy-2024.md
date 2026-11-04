# Resumen — Ramzy, Hammad y Maged, Applied Sciences 2024

Ramzy, M. R., Hammad, S. y Maged, S. A. (2024). *Kinematic and dynamic modeling of 3DOF variable stiffness links manipulator with experimental validation*. Applied Sciences, 14(12), 5285. https://doi.org/10.3390/app14125285

Copia leída: `applsci-14-05285-v2.pdf` (23 páginas). Recibido el 29 de marzo de 2024, revisado y aceptado el 20 de mayo de 2024. Sin financiamiento externo. Afiliación: Ain Shams University (El Cairo) y The Higher Technological Institute (10th of Ramadan City).

## De qué trata

El paper arma el modelo cinemático y el dinámico de un manipulador real de tres grados de libertad con eslabones de rigidez variable, y los contrasta con un banco de pruebas. Lo presentan como primer paso para mejorar el desempeño, la seguridad y el costo de ese tipo de brazo. El control del manipulador lo dejan para un trabajo futuro: el artículo no trae la ley de control cinemático del curso.

Los eslabones cambian de rigidez con actuadores de dos barras y presión. Por eso la punta se desvía durante el movimiento. Para la posición, los autores dicen que el brazo puede tratarse como rígido. La dinámica sí mete la flexibilidad, como resorte y amortiguador en cada articulación y la masa en el centro de gravedad.

## El robot

Tres rotativas. En la Figura 1, \(q_1\) gira en la vertical y \(q_2\), \(q_3\) arman el hombro y el codo. No es un robot planar: la Figura 4 es un volumen de trabajo en 3D y la Figura 5 es un corte de ese volumen.

Tabla 1, Denavit–Hartenberg:

| i | θ | α | a | d |
| --- | --- | --- | --- | --- |
| 1 | q1 | 90° | 0 | l1 |
| 2 | q2 | 0 | l2 | 0 |
| 3 | q3 | 0 | l3 | 0 |

No hay offset lateral. \(z_0\) apunta hacia arriba: en la posición, \(l_1\) se suma.

## Cinemática que sí se lee

La cadena es \({}^{0}T_{3} = {}^{0}T_{1}\,{}^{1}T_{2}\,{}^{2}T_{3}\). La posición, ecuaciones (6)–(8):

\[
\begin{aligned}
p_x &= \cos q_1\,(l_2\cos q_2 + l_3\cos(q_2+q_3)),\\
p_y &= \sin q_1\,(l_2\cos q_2 + l_3\cos(q_2+q_3)),\\
p_z &= l_1 + l_2\sin q_2 + l_3\sin(q_2+q_3).
\end{aligned}
\]

En (8) el PDF cierra un paréntesis de más. La expresión es la de arriba.

Los largos que usa esa cuenta están en la Tabla 2 y se repiten en las matrices (3) y (4): \(l_1 = 0{,}04\) m, \(l_2 = 0{,}29\) m, \(l_3 = 0{,}240\) m. La matriz (3) imprime 0,29 y la (4) imprime 0,24.

La matriz (2), la de \(q_1\), no se copia. Con \(\alpha_1 = 90^\circ\) la tercera fila de la rotación es \([0,\ 1,\ 0]\) y la traslación en \(z\) es \(l_1\). En el PDF esa fila de la rotación está en ceros. El producto de Denavit–Hartenberg de la Tabla 1 sí da las ecuaciones (6)–(8). Esa matriz impresa, no.

## Inversa que no cierra

Las ecuaciones (9)–(12) se presentan como la inversa de un antropomórfico rígido de tres rotativas. No recuperan (6)–(8).

- (9) define \(r = \sqrt{x^2+y^2+z^2}\), la distancia al origen, y (8) ya sumó \(l_1\) en \(z\).
- (10) es \(\theta_1 = \tan^{-1}(y/x)\). Ese arco tangente pierde el cuadrante.
- (11) asigna a \(\theta_2\) un \(\cos^{-1}\) cuyo numerador es \(x^2+y^2+z^2 - l_2^2 l_3^2\), el producto de los cuadrados, partido por \(2 l_2 l_3\). En la postura \(q = (0{,}4;\ 0{,}7;\ -0{,}8)\) rad ese argumento vale 1,785, fuera de \([-1,\ 1]\).

La inversa que usa el parcial es la geométrica de la clase 3, deducida de (6)–(8), no estas cuatro ecuaciones.

## Tabla 2

Parámetros del banco, medidos en el equipo y, para el centro de masa y el momento de inercia, sacados en SOLIDWORKS 2020 con los materiales del banco. El texto dice que los productos de inercia se toman como cero, que la dinámica del motor se desprecia y que el peso del motor se suma al eslabón.

Masas: \(m_1 = 0{,}77189\) kg, \(m_2 = 0{,}215\) kg, \(m_3 = 0{,}14752\) kg.

Centros de masa, en metros: \((X_1,Y_1,Z_1) = (0;\ 0{,}04;\ 0{,}0245)\), \((X_2,Y_2,Z_2) = (0{,}157;\ 0;\ 0)\), \((X_3,Y_3,Z_3) = (0{,}125;\ 0;\ 0)\). También aparece \(Y_4 = 0\). El texto leído no dice qué es esa cuarta coordenada.

Momentos principales, sin unidad escrita al lado: \(I_{1xx} = 2{,}47\times 10^{-4}\), \(I_{1yy} = 1{,}83\times 10^{-3}\), \(I_{1zz} = 1{,}86\times 10^{-3}\); \(I_{2xx} = 3{,}82\times 10^{-5}\), \(I_{2yy} = 1{,}6\times 10^{-3}\), \(I_{2zz} = 1{,}59\times 10^{-3}\); \(I_{3xx} = 4{,}26\times 10^{-5}\), \(I_{3yy} = 7{,}45\times 10^{-4}\), \(I_{3zz} = 7{,}25\times 10^{-4}\).

Rigidez y amortiguamiento, también sin unidad: \(k_{1f} = k_{2f} = k_{3f} = 1{,}66\), \(c_{1f} = c_{2f} = c_{3f} = 1{,}3\). La rigidez la midieron; el amortiguamiento lo suponen. El estiramiento axial lo desprecian porque una capa de tela impide que el eslabón se alargue.

El PDF no imprime un rango numérico de las articulaciones. La sección del espacio de trabajo dice que se tienen en cuenta los límites, y no da los ángulos.

## Dinámica

Euler–Lagrange con parámetros concentrados. La energía cinética usa la velocidad lineal del centro de masa y la angular, con la masa y el tensor. La potencial suma la gravedad y los resortes. Hay una función de disipación de Rayleigh con los tres \(c_{if}\).

La forma que queda, ecuación (19), es

\[
M(q)\ddot q + C(q,\dot q)\dot q + G(q) = \tau + \tau_f.
\]

\(M\) es 3×3, \(G\) lleva los términos de gravedad y \(\tau_f\) es el par de los resortes. Los elementos desarrollados de \(M\) y de \(C\) están en el Apéndice A. Varias de esas líneas salen partidas en el PDF; no se copian término a término. La ecuación (25) despeja \(\ddot q\) y es la que integran en la simulación.

## Simulación y experimentos

La Figura 3 es un modelo de MATLAB/Simulink 2022a. La entrada del banco es el ángulo, porque el par del motor no se puede gobernar. Un bloque pasa de ángulo a par, entran las ecuaciones dinámicas, dos integradores devuelven \(q\), y la cinemática directa saca \(X, Y, Z\).

La validación cinemática usa dos cámaras: una de frente, para \(q_2\), \(q_3\) y la punta en el plano \(X\)–\(Z\), y otra desde arriba, para \(q_1\) y la punta en \(X\)–\(Y\). La Tabla 3 trae 26 posturas. En cada fila queda en blanco el eje que esa vista no midió. El pie de la tabla da un error medio de 2,90 mm en \(x\), 2,29 mm en \(y\) y 2,40 mm en \(z\), y un error porcentual medio de 0,81 %, 0,71 % y 1,4 %. Las conclusiones repiten esos porcentajes.

Esa columna teórica no reproduce al milímetro las ecuaciones (6)–(8) con los largos de la Tabla 2. En las filas contrastadas, la punta de (6)–(8) queda unos milímetros más adentro que la columna del paper, del mismo orden que el error experimental que ellos reportan. El parcial no cambia \(l_2\) para acercarse a la Tabla 3.

La validación dinámica mueve el brazo de una postura a otra y filma a 30 cuadros por segundo. El recorrido que describen es \(q_2\) de 90° a 16°, \(q_3\) de 0° a −45° y \(q_1\) de 0° a −43°. Los ángulos los miden a mano sobre las fotos, en SOLIDWORKS. El mismo movimiento entra al modelo de Simulink. El error angular medio que reportan es 0,63° en la primera articulación, 1,06° en la segunda y 1,27° en la tercera. En la punta, durante ese movimiento, dan 6,24 mm, 6,4 mm y 2,93 mm de error medio en \(x\), \(y\) y \(z\). En las conclusiones, el error porcentual medio de esa punta es 3,36 %, 3,29 % y 2,49 %. Dicen que el error máximo ronda el 18 % al inicio del movimiento y baja a cerca del 3 % después. Comparan eso con un modelo de un solo eslabón flexible, referencia [50], cuyos picos ellos citan en 44,6 % y 22 %. La Tabla 4 es una muestra de ese ensayo, no el promedio.

Ellos mismos escriben que la respuesta fue adecuada y que no tuvo la precisión que querían, y que haría falta identificar mejor la rigidez y el amortiguamiento.

## Qué usa el parcial, y qué no

El parcial usa la Tabla 1, los tres largos de la Tabla 2 y las ecuaciones (6)–(8). La inversa, el jacobiano, las singularidades y el control cinemático los pone el curso: el paper no trae el Jacobiano ni una ley de posición o de seguimiento.

Masas, centros de masa, momentos, \(k_{if}\) y \(c_{if}\) quedan para la dinámica del trabajo final. No entran en `simular_parcial`.
