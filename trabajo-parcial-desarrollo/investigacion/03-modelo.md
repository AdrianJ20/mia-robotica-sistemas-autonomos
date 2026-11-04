# Modelo del parcial

Ramzy, M. R., Hammad, S. y Maged, S. A. (2024). *Kinematic and dynamic modeling of 3DOF variable stiffness links manipulator with experimental validation*. Applied Sciences, 14(12), 5285. https://doi.org/10.3390/app14125285

Copia en `fuentes/applsci-14-05285-v2.pdf`. El resumen está en `fuentes/resumen-ramzy-2024.md`.

Es un banco de tres rotativas con eslabones de rigidez variable. La Figura 1 y la Tabla 1 son un antropomórfico: \(q_1\) vertical, \(q_2\) y \(q_3\) con ejes horizontales paralelos. El artículo dice que, para la cinemática de posición, el brazo se puede tratar como rígido. El parcial usa esa parte.

## Denavit–Hartenberg

| i | θ | α | a | d |
| --- | --- | --- | --- | --- |
| 1 | q1 | 90° | 0 | l1 |
| 2 | q2 | 0 | l2 | 0 |
| 3 | q3 | 0 | l3 | 0 |

Tabla 2: \(l_1 = 0{,}04\) m, \(l_2 = 0{,}29\) m, \(l_3 = 0{,}240\) m. Las matrices (3) y (4) imprimen 0,29 y 0,24. La (2) imprime 0,04 en \(z\), y deja en cero la fila de la rotación que con \(\alpha = 90^\circ\) vale \([0,\ 1,\ 0]\). La simulación arma la cadena con `DHL` de la clase 2, no con esa matriz impresa.

Posición, ecuaciones (6)–(8). En (8) sobra un paréntesis de cierre:

\[
\begin{aligned}
p_x &= \cos q_1 (l_2 \cos q_2 + l_3 \cos(q_2+q_3)),\\
p_y &= \sin q_1 (l_2 \cos q_2 + l_3 \cos(q_2+q_3)),\\
p_z &= l_1 + l_2 \sin q_2 + l_3 \sin(q_2+q_3).
\end{aligned}
\]

\(z_0\) apunta hacia arriba. No hay offset lateral.

## Inversa que no se copia

Las ecuaciones (9)–(12) no cierran (6)–(8). En \(q = (0{,}4;\ 0{,}7;\ -0{,}8)\) rad el argumento del arccos de (11) es 1,785. La inversa del código es la geométrica de la clase 3: \(q_1 = \operatorname{atan2}(p_y, p_x)\), altura \(p_z - l_1\), dos signos de \(\sin q_3\), y la cintura opuesta \(q_1 + \pi\).

## Lo que la Tabla 2 trae y el parcial no usa

Masas: \(m_1 = 0{,}77189\) kg, \(m_2 = 0{,}215\) kg, \(m_3 = 0{,}14752\) kg.

Centros de masa, en metros: \((X_1, Y_1, Z_1) = (0;\ 0{,}04;\ 0{,}0245)\), \((X_2, Y_2, Z_2) = (0{,}157;\ 0;\ 0)\), \((X_3, Y_3, Z_3) = (0{,}125;\ 0;\ 0)\). También aparece \(Y_4 = 0\), sin definición en el texto leído.

Momentos principales: \(I_{1xx} = 2{,}47\times 10^{-4}\), \(I_{1yy} = 1{,}83\times 10^{-3}\), \(I_{1zz} = 1{,}86\times 10^{-3}\); \(I_{2xx} = 3{,}82\times 10^{-5}\), \(I_{2yy} = 1{,}6\times 10^{-3}\), \(I_{2zz} = 1{,}59\times 10^{-3}\); \(I_{3xx} = 4{,}26\times 10^{-5}\), \(I_{3yy} = 7{,}45\times 10^{-4}\), \(I_{3zz} = 7{,}25\times 10^{-4}\). El texto dice que los productos de inercia se toman como cero. La tabla no escribe la unidad de \(I\).

\(k_{1f} = k_{2f} = k_{3f} = 1{,}66\) y \(c_{1f} = c_{2f} = c_{3f} = 1{,}3\), sin unidad. Entran en la ecuación (19), que es la dinámica flexible. El control del parcial es el cinemático de la clase 7, no ese modelo.

La columna teórica de la Tabla 3 no coincide al milímetro con (6)–(8) y estos largos: la punta queda unos milímetros más adentro que esa columna. El parcial no ajusta \(l_2\) para perseguir la tabla. Sigue la Tabla 2 y las ecuaciones (6)–(8), que sí cierran entre sí.
