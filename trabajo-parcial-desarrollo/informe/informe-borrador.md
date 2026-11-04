# Trabajo parcial — borrador

Carátula: UNI, nombre oficial de la maestría (todavía no está en los PDF del curso), logo, título Trabajo Parcial, autor, curso Robótica y sistemas autónomos, Ing. Wilson Dennis Reyes Vásquez, semestre 2026-2.

La opinión personal queda en preguntas. La escribe el autor.

## Introducción

Antropomórfico de tres rotativas: la primera alrededor de un eje vertical, las dos siguientes alrededor de ejes horizontales paralelos. La simulación en MATLAB cubre directa, inversa geométrica, jacobiano de la posición, singularidades y control cinemático.

El modelo es Ramzy, Hammad y Maged (2024), *Applied Sciences*, 14, 5285. El banco tiene eslabones de rigidez variable. Para la posición, el artículo lo trata como rígido y da la cadena de un antropomórfico. El parcial usa esa cadena y los largos de la Tabla 2. Resortes y amortiguadores no entran aquí.

## Desarrollo

El brazo de la práctica es el RRP del G1: \(L_1 = 75\) mm, segunda distancia \(100\) mm, \(z = -d_3\). Este robot no es ese.

Tabla 1: \(\alpha_1 = 90^\circ\), \(a_1 = 0\), \(d_1 = l_1\); luego \(\alpha = 0\), \(d = 0\), \(a = l_2\) y \(a = l_3\). Tabla 2: \(l_1 = 0{,}04\) m, \(l_2 = 0{,}29\) m, \(l_3 = 0{,}240\) m. La misma tabla trae masas, centros de masa y momentos principales; los productos de inercia se toman como cero. No se usan en esta simulación. \(k = 1{,}66\) y \(c = 1{,}3\) salen sin unidad y pertenecen al modelo flexible.

\(z_0\) apunta hacia arriba. \(d_2 = d_3 = 0\), así que \(q_1 = \operatorname{atan2}(p_y, p_x)\) cuando la cintura apunta al punto.

La directa es `DHL(q1, l1, 0, pi/2) * DHL(q2, 0, l2, 0) * DHL(q3, 0, l3, 0)`. La matriz (2) del PDF imprime en cero la fila que debe llevar el \(1\) de \(\sin 90^\circ\). No se copia. La posición que sí cierra es

\[
\begin{aligned}
p_x &= \cos q_1\,(l_2\cos q_2 + l_3\cos(q_2+q_3)),\\
p_y &= \sin q_1\,(l_2\cos q_2 + l_3\cos(q_2+q_3)),\\
p_z &= l_1 + l_2\sin q_2 + l_3\sin(q_2+q_3).
\end{aligned}
\]

En \(q = (0{,}4;\ 0{,}7;\ -0{,}8)\) rad el producto de matrices y esas ecuaciones coinciden. La columna teórica de la Tabla 3 queda unos milímetros más afuera; la simulación no la persigue y sigue (6)–(8) con la Tabla 2. La inversa geométrica, con el signo de \(\sin q_3\) de esa postura, devuelve el mismo \(q\). Las ecuaciones (9)–(12) del paper, en ese punto, piden un \(\cos^{-1}\) de \(1{,}785\) y no se usan.

\[
\det J = -A\, l_2\, l_3 \sin q_3, \qquad A = l_2\cos q_2 + l_3\cos(q_2+q_3).
\]

En la postura de prueba, \(\det J = 0{,}0230\). Se anula con \(q_3 = 0\), con \(q_3 = \pi\) y con \(A = 0\) (punta en el eje de \(q_1\)). El script arma esta última con \(q_2 = 2\pi/3\) y el \(q_3\) que anula \(A\): \(\sin q_3\) no es cero y el determinante sí.

El punto a punto articular usa la cúbica y la quíntica de la clase 6, \(t_f = 3\) s, reposo a reposo, entre \((0{,}3;\ 0{,}6;\ -0{,}5)\) y \((0{,}7;\ 1{,}0;\ -0{,}9)\) rad.

El control cartesiano es el de la clase 7. Posición: \(K = 8I\), \(\dot q = J^{+} K \tanh(e)\), objetivo \((0{,}406;\ 0{,}172;\ 0{,}272)\) m desde \(q = (0{,}15;\ 0{,}55;\ -0{,}4)\). Error final del orden de \(10^{-16}\) m. Seguimiento: \(K = I\), \(\dot q = J^{+}(\dot h_d + e)\), alrededor de la punta de \(q = (0{,}5;\ 0{,}9;\ -0{,}8)\), amplitudes \(0{,}03\), \(0{,}03\) y \(0{,}02\) m. Error máximo \(1{,}4\times 10^{-4}\) m, error final \(6{,}0\times 10^{-5}\) m. Los dos lazos se detienen si \(|\det J| < 10^{-4}\).

## Opinión personal

La escribe el autor. Preguntas, no un texto para pegar:

- ¿Se sostiene usar la cadena rígida en un paper de eslabones que flexionan?
- ¿Se explica por qué no se copian las ecuaciones (9)–(12)?
- ¿En la exposición se defiende el punto a punto articular, el cartesiano, o los dos?

## Conclusiones

La Tabla 1 con los metros de la Tabla 2 reproduce (6)–(8). La inversa geométrica recupera la postura si se elige el codo de partida. El jacobiano detecta codo estirado, codo plegado y punta sobre el eje de \(q_1\). Las leyes de las clases 6 y 7 corren en este robot. Las masas y los resortes de la Tabla 2 no entran en esta simulación.

## Recomendaciones

1. Correr `simular_parcial` en MATLAB Online y llevar las tres figuras.
2. Mostrar el codo estirado y la punta en el eje de \(q_1\).
3. No copiar la matriz (2) ni las ecuaciones (9)–(12) impresas.
4. Citar el artículo. La opinión, con palabras propias.

## Referencias

Ramzy, M. R., Hammad, S. y Maged, S. A. (2024). Kinematic and dynamic modeling of 3DOF variable stiffness links manipulator with experimental validation. *Applied Sciences, 14*(12), 5285. https://doi.org/10.3390/app14125285

Reyes Vásquez, W. D. (2026). *Trabajo parcial: Robot antropomórfico de 3GDL*. Material de clase, ciclo 2026-2.

Barrientos, A. *Fundamentos de robótica*. El docente lo abre en la clase 4 para la configuración singular. La transcripción no dice edición ni año.
