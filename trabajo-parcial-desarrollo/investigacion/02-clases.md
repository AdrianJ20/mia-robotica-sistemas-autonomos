# Lo que sí está en las clases

Se leyeron los archivos de `clase-01` a `clase-08` y las transcripciones de las clases 1 a 6, más `tips-trabajo-parcial-final.txt`. No se abrió `videos/`. Los PDF de pizarra siguen siendo imágenes. Lo que no está en una transcripción sale de los `.mlx` y de los `.m`. Los archivos del control cinemático están en `clase-07` y la misma copia está en `clase-08`.

## La práctica no es el antropomórfico

Los ejercicios de práctica son un RRP de ejes paralelos: dos rotaciones en el plano y una prismática. En `clase-02/DH_3GDL.mlx` y otra vez en `clase-03/Cinematica_Inversa_2026_22.mlx`:

```matlab
M01 = DHL(theta1, 0, L1, 0);
M12 = DHL(theta2, 0, L2, 0);
M23 = DHL(0, d3, 0, 0);
```

`L1 = 75` y `L2 = 100`. El archivo no dice la unidad.

La directa geométrica de `clase-03/Metodo_Geometrico_3GDL.mlx` es

```matlab
x = L1*cosd(theta1) + L2*cosd(theta1 + theta2);
y = L1*sind(theta1) + L2*sind(theta1 + theta2);
z = d3;
```

`clase-04/Jacobiano_3GDL.mlx` escribe `z = -d3` y obtiene

\[
\det J = -L_1 L_2 \sin\theta_2.
\]

En la transcripción de la clase 4 las dos escrituras son las opciones que él da para el G1 recortado a 3 grados de libertad: dejar \(z = d_3\) y tomar \(d_3\) negativo, o escribir \(z = -d_3\). Al derivar usa \(\dot z = -\dot d_3\). El determinante que lee es \(-L_1 L_2 \sin\theta_2\). Se anula si \(\theta_2 = 0 \pm n\pi\). Con \(\theta_2 = 0\) el brazo queda estirado y, desde arriba, la punta cae en la circunferencia de radio \(L_1+L_2\). El punto que calcula, \(\sqrt{33{,}1468^2+171{,}832^2}\), le da prácticamente 175, que es \(75+100\). No dice la unidad.

Separa dos singularidades. En el borde del área de trabajo el brazo pierde un grado de libertad y no sale de ese límite; dice que ahí las velocidades articulares no se van al infinito. Las que se van al infinito son las de adentro del área de trabajo, y en esta clase no las calcula. Abre *Fundamentos de robótica* de Antonio Barrientos: configuración singular cuando el determinante del jacobiano es cero. Al borde alineado lo llama engarrotamiento o atascamiento. La figura en que la muñeca se alinea con la articulación 1 la deja para después, y aclara que esa numeración es de otro robot. El control cinemático no lo escribe: dice que, cuando se haga, hay que planear para no pasar por esos puntos cartesianos.

La tarea de esa noche es un video de 10 a 15 minutos del jacobiano de 4 grados de libertad, el SCARA. No nombra al antropomórfico del parcial.

El parcial no hereda este brazo. El enunciado pide un antropomórfico, y un antropomórfico de 3 rotativas tiene el primer twist en \(\pi/2\), no las tres filas con \(\alpha = 0\).

La inversa geométrica de la práctica está en `Cinematica_Inversa_2026_22.mlx`: ley del coseno, dos betas, dos thetas, y \(d_3 = p_z\). El método (dos soluciones, seno positivo y negativo) sí se reutiliza.

## Clase 2, en voz

`transcription/mia-ro-sis-au-02.txt` es cinemática directa del G1-171SZ, recortado a 3 grados de libertad: dos rotativas y una prismática. No habla del antropomórfico ni del parcial.

Del manual y del simulador saca las longitudes. En home, con las articulaciones en cero, el brazo apunta a \(x\) y esa coordenada vale 175. Con la segunda a 90°, \(x=75\) e \(y=100\). Dice que \(L_1\) vale 75 milímetros y la segunda distancia vale 100 milímetros.

La directa que escribe en la pizarra es

\[
\begin{aligned}
x &= L_1\cos\theta_1 + L_2\cos(\theta_1+\theta_2),\\
y &= L_1\sin\theta_1 + L_2\sin(\theta_1+\theta_2),\\
z &= -d_3.
\end{aligned}
\]

El menos está porque la prismática del G1 solo acepta valores negativos. El ejemplo que muestra es \(d_3=-56{,}734\), y el mundo marca el mismo número en \(z\).

El algoritmo de H lo nombra Denavit–Hartenberg, dicho «Navi Hartenberg». El orden que da es rotación en \(z\), traslación en \(z\), traslación en \(x\) y rotación en \(x\). La tabla que llena, con las articulaciones en cero, es \(\theta_1,0,L_1,0\), luego \(\theta_2,0,L_2,0\), y en la prismática el ángulo fijo en 0, el desplazamiento \(d_3\) y longitud 0. Al multiplicar las tres matrices, \(x\) e \(y\) coinciden con la pizarra y \(z\) sale \(+d_3\). Dice que, para que se parezca al programa, ahí se pone \(-d_3\).

Los rangos los lee del manual y se corrige. La primera articulación queda de \(-135^\circ\) a \(135^\circ\). La segunda la empieza («menos 140») y no la deja cerrada. \(d_3\), después de la corrección, va de \(-100\) a \(0\).

Centros de masa e inercias no se calculan en esta clase. Dice que los tiene que traer el paper que investiguen, o un CAD. Los puntos singulares los nombra y los deja para la cinemática diferencial. El control cinemático lo anuncia como interpoladores en el tiempo y una ley que alimenta al motor; la ley no la escribe.

## Clase 3, en voz

`transcription/mia-ro-sis-au-03.txt` es cinemática inversa. Empieza por el SCARA G1, rotativa, rotativa y prismática, y después pasa a un antropomórfico de 3 grados de libertad. Al cierre dice que en los trabajos suele pedir antropomórficos. No da los metros de ese ejemplo. Los 75 y los 100, que suman 175, siguen siendo del G1. No dice la unidad.

En el SCARA, si la trama raíz coincide con la del manual, \(d_3 = p_z\). El manual del G1 arranca en cero y solo acepta desplazamiento negativo: un valor positivo de la prismática da error de rango.

Las dos soluciones las llama codo abajo y codo arriba. El coseno no distingue el signo; el seno, sí. Cuando más adelante haya control cinemático, entre las dos se queda con la que conviene, por ejemplo la más cercana a la articulación anterior.

En la diapositiva del antropomórfico la trama raíz está arriba y la longitud de la columna no entra. En esa postura de ceros el brazo apunta a \(x\). Entonces

\[
\theta_1 = \operatorname{atan2}(p_y, p_x), \qquad R = \sqrt{p_x^2 + p_y^2},
\]

y \(\theta_2\), \(\theta_3\) salen del mismo triángulo del SCARA, ahora en el plano \(R\)–\(z\). Si la trama está abajo, aparece una vertical \(L_1\) y los eslabones del brazo pasan a llamarse \(L_2\) y \(L_3\). La altura que usa es \(p_z - L_1\). En el tablero escribe \(D\) mal y lo corrige a \(R^2 + p_z^2\); la transcripción no deja esa expresión ya limpia, así que no se copia al código.

Ese \(\theta_1 = \operatorname{atan2}(p_y, p_x)\) es el caso sin offset lateral. También pide mirar, en el paper que se elija, el sentido de \(\theta_1\) y si \(z_0\) está arriba o abajo: no son el mismo robot dado vuelta. En Ramzy et al. (2024) \(d_2 = d_3 = 0\) y \(p_z\) suma \(l_1\), así que \(z_0\) apunta hacia arriba y esa fórmula de \(\theta_1\) sí corresponde.

## Control y trayectorias que sí se reutilizan

`clase-06`: polinomio en el espacio articular, reposo a reposo, mismo \(t_f\) para las tres articulaciones. Cúbica:

\[
a_0 = q_i,\quad a_1 = 0,\quad a_2 = 3(q_f-q_i)/t_f^2,\quad a_3 = -2(q_f-q_i)/t_f^3.
\]

Quíntica, con velocidad y aceleración nulas en los extremos:

\[
a_3 = 10(q_f-q_i)/t_f^3,\quad a_4 = -15(q_f-q_i)/t_f^4,\quad a_5 = 6(q_f-q_i)/t_f^5.
\]

Esos `.mlx` no cierran el lazo con el jacobiano. El nombre del archivo dice «control cinemático»; el código es inversa de dos puntos, polinomio y directa.

El lazo está en la clase 7, en un brazo de 4 rotativas (no es el de 3). Se leyó el `.m` del rar y del zip, sin dejarlo descomprimido en el curso:

- Posición: \(K = 8I\), \(\dot q = J^{+} K \tanh(e)\). La proporcional sin tanh está comentada.
- Seguimiento: \(K = I\), \(\dot q = J^{+}(\dot h_d + K e)\).
- Integración de Euler: \(q(k+1) = q(k) + t_s \dot q\).

`clase-05` es un uniciclo en lazo abierto. No entra en este caso.

## Clase 1, solo la transcripción

No dice «antropomórfico». El robot de esa clase es el SCARA (rotativa, rotativa, prismática y una rotativa al final). El parcial aparece como evaluación, distinto del trabajo final. El trabajo final es un paper de exactamente 3 grados de libertad. El libro que nombra es Craig, *Introducción a la robótica. Mecánica y control*. El manual del Epson G1 es solo para medidas, y ese robot no es de 3 grados de libertad.
