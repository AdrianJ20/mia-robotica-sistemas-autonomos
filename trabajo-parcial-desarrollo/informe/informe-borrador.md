# Trabajo parcial

Robot antropomórfico de 3 grados de libertad

Curso: Robótica y sistemas autónomos
Docente: Ing. Wilson Dennis Reyes Vásquez
Semestre: 2026-2
Autor: [Apellidos, nombres]
Maestría: [nombre oficial, no está en el enunciado]

La carátula del PDF lleva el logotipo actual de la UNI. Este borrador no lo incluye.

## 1. Introducción

Un antropomórfico de tres grados de libertad tiene cintura, hombro y codo: la primera articulación gira alrededor de un eje vertical y las dos siguientes alrededor de ejes horizontales paralelos. Con eso la punta se mueve en el espacio, no en un solo plano. El trabajo simula, en MATLAB y con el método de las prácticas, la cinemática directa, la inversa, el jacobiano, las singularidades y el control cinemático de un robot real de esa arquitectura.

La pregunta que ordena el desarrollo es esta: si las prácticas resuelven un brazo de dos rotaciones y una prismática, ¿qué parte de ese procedimiento se mantiene cuando el robot pasa a ser el RRR de tres rotaciones, y qué parte hay que volver a escribir?

## 2. Desarrollo

### 2.1 Qué robot, y por qué no es el de la práctica

Los live scripts de las clases 2, 3, 4 y 6 modelan un RRP. Las tres filas de Denavit–Hartenberg tienen twist nulo, las longitudes que aparecen son \(L_1=75\) y \(L_2=100\) sin unidad, y la tercera variable es el desplazamiento \(d_3\). Eso no es un antropomórfico.

El modelo que se simula es el RRR de accionamiento directo del laboratorio de Dynamics and Control de la Technische Universiteit Eindhoven, descrito por Kostić, Hensen, de Jager y Steinbuch (2002). El paper lo llama antropomórfico: cintura, hombro y codo. La Tabla I de ese artículo fija la cadena. En la página se lee \(a_1=0\), \(\alpha_1=\pi/2\), \(\alpha_2=0\), \(\alpha_3=0\), y el resto de longitudes y offsets como símbolos (\(C_0C_1\), \(P_1C_2\), \(C_1P_1\), \(P_2C_3\), \(C_2P_2\)). No hay metros en la tabla. El manual del mismo robot (van Beek, 1998) da 0,3 m para un eslabón virtual del extremo, con el brazo 3 sin montar, y no lo escribe como parámetro de Denavit–Hartenberg. Por eso la simulación separa dos cosas: la estructura, que es la del paper, y un juego de longitudes de comprobación, que no es el del robot. Esas longitudes están en `parametros_comprobacion.m` y el script lo imprime al arrancar.

### 2.2 Cinemática directa

Se usa la función `DHL` de la clase 2: rotación en \(z\), traslación \((a,0,d)\) y rotación en \(x\). La cadena es

\[
{}^{0}T_{3} = \mathrm{DHL}(q_1,d_1,0,\pi/2)\;\mathrm{DHL}(q_2,d_2,a_2,0)\;\mathrm{DHL}(q_3,d_3,a_3,0).
\]

La posición de la punta es la cuarta columna. Coincide con la ecuación (5) del paper:

\[
\begin{aligned}
x &= \cos q_1\,(a_3\cos(q_2+q_3)+a_2\cos q_2)+(d_2+d_3)\sin q_1,\\
y &= \sin q_1\,(a_3\cos(q_2+q_3)+a_2\cos q_2)-(d_2+d_3)\cos q_1,\\
z &= a_3\sin(q_2+q_3)+a_2\sin q_2+d_1.
\end{aligned}
\]

En la comprobación, para \(q=(0{,}3;\,0{,}5;\,-0{,}8)\) rad y las longitudes de prueba, la diferencia entre el producto de matrices y la ecuación (5) quedó en \(10^{-16}\) m. El signo de \(z\) es el de esa ecuación. No se arrastra el \(z=-d_3\) del jacobiano del RRP de la clase 4, porque ese menos pertenece a otro brazo.

### 2.3 Cinemática inversa

El método es el geométrico de la clase 3. En el SCARA llama codo abajo a la postura en que el codo queda abajo y codo arriba a la otra. El coseno no distingue el signo; el seno, sí. La ecuación (6) del paper está en una figura que no se lee completa, así que la inversa se dedujo de la (5) y se comprobó contra la directa.

En la diapositiva del antropomórfico la trama raíz está arriba y la columna no entra: \(\theta_1=\operatorname{atan2}(p_y,p_x)\) y el codo se resuelve en el plano \(R\)–\(z\). Si la trama está abajo, la vertical es \(L_1\), los eslabones del brazo son \(L_2\) y \(L_3\), y la altura que usa es \(p_z-L_1\). En el tablero corrige \(D\) a \(R^2+p_z^2\); la transcripción no deja esa línea limpia y no se copió al código. La Tabla I de Kostić tiene offsets, así que ahí \(\theta_1\) no es ese arco tangente.

Con \(\delta=d_2+d_3\) y \(\rho=\sqrt{x^2+y^2}\),

\[
\sin(q_1-\varphi)=\delta/\rho, \qquad \varphi=\operatorname{atan2}(y,x).
\]

Hay dos \(q_1\). Para cada uno, la proyección del brazo en su plano es \(A=x\cos q_1+y\sin q_1\) y \(z'=z-d_1\). El codo sale de la ley del coseno,

\[
\cos q_3=\frac{A^2+z'^2-a_2^2-a_3^2}{2 a_2 a_3},
\]

y \(\sin q_3\) lleva el signo del codo, como el \(\pm\sqrt{1-C^2}\) del live script de inversa. Si \(\rho<|\delta|\) o \(|\cos q_3|>1\), el punto está fuera de alcance.

Con el signo de \(\sin q_3\) y la cintura que corresponde a la postura de partida, la inversa devolvió el mismo \(q\) en las posturas de prueba.

### 2.4 Cinemática diferencial y singularidades

El jacobiano es el de la posición, 3×3, el mismo criterio que `Jacobiano_3GDL.mlx`: derivar \(x\), \(y\) y \(z\) respecto de las tres variables articulares. No es el 6×4 del SCARA de la clase 4.

\[
J=\begin{bmatrix}
-\sin q_1\, A+\delta\cos q_1 & -\cos q_1\, B & -\cos q_1\, a_3\sin(q_2+q_3)\\
\cos q_1\, A+\delta\sin q_1 & -\sin q_1\, B & -\sin q_1\, a_3\sin(q_2+q_3)\\
0 & A & a_3\cos(q_2+q_3)
\end{bmatrix},
\]

con \(A=a_2\cos q_2+a_3\cos(q_2+q_3)\), \(B=a_2\sin q_2+a_3\sin(q_2+q_3)\) y \(\delta=d_2+d_3\).

En las longitudes de comprobación, \(\det J\) es distinto de cero en \(q=(0{,}3;\,0{,}5;\,-0{,}8)\) y cae a cero numérico con el codo estirado (\(q_3=0\)) y con el codo plegado (\(q_3=\pi\)). En la clase 4, para el RRP, el profesor lee el mismo criterio: \(\det J = -L_1 L_2 \sin\theta_2 = 0\) cuando \(\theta_2 = 0 \pm n\pi\). Con \(\theta_2 = 0\) los eslabones quedan alineados y la punta está en el borde exterior del área de trabajo. Ahí, dice, el brazo pierde un grado de libertad y no puede salir del límite. Las velocidades articulares que se van al infinito las reserva para las singularidades de adentro del área de trabajo, que en esa clase no calcula. La definición que lee, de Barrientos, es la que se usa aquí: configuración singular cuando el determinante del jacobiano es cero.

En el antropomórfico, \(q_3 = 0\) es el análogo del borde estirado. \(q_3 = \pi\) también anula el seno del codo; es el brazo plegado, y la clase 4 no lo dibuja. El script corta el control de posición si \(|\det J|<10^{-4}\), para no integrar una velocidad articular cuando el determinante se acerca a cero. El signo \(z = -d_3\) de esa clase es del RRP. En este robot, \(z\) sigue la ecuación (5) del paper.

### 2.5 Trayectoria articular

Entre dos puntos alcanzables se resuelve la inversa y se une con el polinomio de la clase 6, el mismo \(t_f=3\) s para las tres articulaciones, reposo a reposo. La cúbica anula la velocidad en los extremos. La quíntica anula también la aceleración. La punta se obtiene pasando cada \(q(t)\) por la directa. No es el lazo de control: es la generación de trayectoria del curso, aplicada a este robot.

### 2.6 Control cinemático

La ley es la de la clase 7, pasada de 4 rotativas a 3. La integración sigue siendo Euler.

Posición, referencia fija, \(K=8I\):

\[
\dot q = J^{+}\, K \tanh(e), \qquad e = h_d - h(q).
\]

Seguimiento, \(K=I\):

\[
\dot q = J^{+}(\dot h_d + K e).
\]

\(J^{+}\) es la pseudoinversa, como en esos archivos. Con tres articulaciones y tres coordenadas, y lejos de la singularidad, coincide con la inversa. El \(\tanh\) está en el archivo de posición de la clase y la proporcional sin saturación está comentada; aquí se dejó el \(\tanh\) en la posición y la forma lineal en el seguimiento, que es lo que esos dos scripts ejecutan.

Con las longitudes de comprobación, el objetivo \((0{,}45;\,0{,}15;\,0{,}55)\) m se alcanzó desde \(q=(0{,}2;\,0{,}6;\,0{,}7)\) rad. El seguimiento parte de la inversa del primer punto de la referencia, una curva chica alrededor de \((0{,}40;\,0{,}12;\,0{,}48)\) m, para no pedirle al brazo un salto inicial. Esas curvas están en las figuras del script. Demuestran el lazo. No calibran el robot de la TU/e.

## 3. Opinión personal

Esta sección va en tus palabras. El enunciado lo pide así. Unas preguntas para no dejarla en blanco, no para copiarlas:

- ¿Te cierra usar el método de la práctica en un robot que la práctica no modela?
- ¿Qué te parece entregar una simulación cuya geometría es la del paper pero cuyos metros todavía no están en la tabla?
- ¿El \(\tanh\) del control de posición te parece una decisión del curso o un parche para que la velocidad no se dispare?

## 4. Conclusiones

La cadena de la Tabla I, armada con la `DHL` de clase, reproduce la ecuación (5) del paper. La inversa geométrica de dos signos recupera la postura cuando se elige el codo que corresponde. El jacobiano de la posición detecta el codo estirado y el codo plegado como singularidades. El polinomio articular de la clase 6 y el control con pseudoinversa de la clase 7 se pueden correr en este RRR sin cambiarles la forma, solo la \(J\) y la directa.

Eso no sustituye las longitudes del robot. Hasta leer metros en una tabla, los gráficos son una comprobación del método.

## 5. Recomendaciones

1. Sustituir `parametros_comprobacion.m` por los metros de la Tabla II de Kostić et al. (2004), o por una medida del manual, y volver a correr `simular_parcial` antes de entregar las figuras como resultado del robot.
2. Incorporar lo que digan las transcripciones de las clases 2, 5 y 6. La clase 3 ya enseña la inversa del antropomórfico y dice que los trabajos suelen pedirlo; no da metros ni nombra este RRR.
3. En la exposición, mostrar una postura con \(\det J \approx 0\) y la misma ley de control deteniéndose, para separar el método de un caso que converge.
4. Citar el paper y el manual. El enunciado anula el trabajo si el texto se pega sin procesar y sin referencias.

## 6. Referencias

Kostić, D., Hensen, R. H. A., de Jager, B. y Steinbuch, M. (2001). Modeling and identification of an RRR-robot. *Proceedings of the 40th IEEE Conference on Decision and Control*, 1144–1149. https://doi.org/10.1109/CDC.2001.981039

Kostić, D., Hensen, R. H. A., de Jager, B. y Steinbuch, M. (2002). Closed-form kinematic and dynamic models of an industrial-like RRR robot. *Proceedings of the 2002 IEEE International Conference on Robotics and Automation*, 1309–1314. https://doi.org/10.1109/ROBOT.2002.1014724

Kostić, D., de Jager, B., Steinbuch, M. y Hensen, R. (2004). Modeling and identification for high-performance robot control: An RRR-robotic arm case study. *IEEE Transactions on Control Systems Technology, 12*(6), 904–919. https://doi.org/10.1109/TCST.2004.833641

van Beek, A. M. (1998). *RRR-robot: Instruction manual* (DCT rapporten, vol. 1998.012). Technische Universiteit Eindhoven. https://pure.tue.nl/ws/files/4377712/632499.pdf

Reyes Vásquez, W. D. (2026). *Trabajo parcial: Robot antropomórfico de 3GDL*. Robótica y sistemas autónomos, ciclo 2026-2.

Barrientos, A. *Fundamentos de robótica*. Libro que el docente abre en la clase 4 para la definición de configuración singular. En la transcripción no dice edición ni año.

Los live scripts de las clases 2, 3, 4, 6 y 7 son material del curso. En APA del informe final conviene listarlos como material de clase no publicado, con el nombre del docente y el semestre, no como si fueran un paper.

## 7. Anexos

Los esquemas los genera `matlab/simular_parcial.m`:

1. Cadena inicial, cadena final y camino de la punta en el control de posición.
2. Referencia y punta en el seguimiento.
3. \(q(t)\) del polinomio cúbico y la punta al pasar por la directa.

Cada figura usa las longitudes de comprobación. El título del script lo recuerda en la ventana de comandos.
