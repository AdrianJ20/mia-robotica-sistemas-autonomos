# Modelo real

El parcial pide un antropomórfico de 3 grados de libertad. De los tres PDF de `trabajo-final/pdf/`:

- Mohammed y Abdissa (2026) es un planar de tres ejes paralelos. No es el caso.
- Naveen, Shah y Misra (2018) es un robot espacial de 12 grados de libertad. No es el caso.
- Kostić, Hensen, de Jager y Steinbuch (2001 y 2002) describen un RRR real de la TU/e: cintura, hombro y codo, de accionamiento directo. Ese es el modelo.

Se usa la cinemática en forma cerrada:

Kostić, D., Hensen, R. H. A., de Jager, B. y Steinbuch, M. (2002). *Closed-form kinematic and dynamic models of an industrial-like RRR robot*. IEEE ICRA, pp. 1309–1314. https://doi.org/10.1109/ROBOT.2002.1014724

Copia de autor en `fuentes/kostic-2002-icra-rrr.pdf`.

## Tabla I, leída de la página

El texto extraído no recupera la tabla. En la página se lee:

| GDL | twist \(\alpha\) | longitud \(a\) | ángulo | offset \(d\) |
| --- | --- | --- | --- | --- |
| 1 | \(\pi/2\) | 0 | \(q_1\) | \(C_0C_1\) |
| 2 | 0 | \(P_1C_2\) | \(q_2\) | \(C_1P_1\) |
| 3 | 0 | \(P_2C_3\) | \(q_3\) | \(C_2P_2\) |

No hay metros en esas celdas. La ecuación (5) del mismo paper, sí en texto, es la directa:

\[
\begin{aligned}
x &= \cos q_1\,(a_3\cos(q_2+q_3)+a_2\cos q_2)+(d_2+d_3)\sin q_1,\\
y &= \sin q_1\,(a_3\cos(q_2+q_3)+a_2\cos q_2)-(d_2+d_3)\cos q_1,\\
z &= a_3\sin(q_2+q_3)+a_2\sin q_2+d_1.
\end{aligned}
\]

El producto `DHL` de la clase 2, con \(\alpha=(\pi/2,\,0,\,0)\), \(a_1=0\) y los offsets \(d_1,d_2,d_3\), da esa misma posición. Se comprobó en 200 posturas: la diferencia quedó en el orden de \(10^{-16}\) m.

La inversa impresa, ecuación (6), está en una imagen que no se lee completa. La del código se dedujo de la (5), con el mismo criterio de la clase 3: un signo para el codo y otro para la cintura. En las 200 posturas, `inversa(directa(q))` devolvió el mismo \(q\) cuando el signo del codo era el de \(\sin q_3\).

## Lo que el manual sí dice, y lo que no se usó como longitud

van Beek, A. M. (1998). *RRR-robot: instruction manual* (DCT rapporten, 1998.012). Technische Universiteit Eindhoven. https://pure.tue.nl/ws/files/4377712/632499.pdf

Ahí el marco del extremo, con el brazo 3 todavía sin montar, queda al final de un eslabón virtual de 0,3 m. También hay masas de los actuadores (12 kg, 7,5 kg y 5,5 kg) y tensores del modelo CAD. El parcial es cinemático: esas masas no entran en la simulación. El 0,3 m no se asignó a \(a_2\) ni a \(a_3\), porque el manual no lo escribe como parámetro de Denavit–Hartenberg.

## Números de la simulación

`matlab/parametros_comprobacion.m` usa \(a_2=0{,}40\), \(a_3=0{,}35\), \(d_1=0{,}30\), \(d_2=0{,}05\), \(d_3=0{,}02\), en metros, solo para correr. No salen del paper ni del manual. \(a_1=0\) y los twist sí salen de la Tabla I.

Con ese juego, el determinante del jacobiano 3×3 se anula en el codo estirado (\(q_3=0\)) y en el codo plegado (\(q_3=\pi\)), del mismo modo que en el RRP de la clase 4 se anula cuando \(\sin\theta_2=0\). En una postura regular el determinante no es cero. El control de posición de la clase 7, con \(K=8I\) y \(\tanh\), llegó al objetivo con error de máquina. El seguimiento con \(K=I\) se quedó en la referencia.

Esos resultados demuestran el método. No son medidas del robot de Eindhoven.
