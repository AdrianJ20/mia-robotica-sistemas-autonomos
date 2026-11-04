# Transcripciones

Leídas: clases 1, 3 y 4. No se abrió `videos/`. Faltan las de las clases 2, 5 y 6.

## Lo que la clase 3 ya cierra

El caso de estudio de los trabajos es un antropomórfico. Lo dice al cierre: suele pedir antropomórficos, y en esa clase explicó el de 3 grados de libertad. No dice que sea el RRR de Eindhoven.

La inversa de ese brazo, en la diapositiva, es geométrica. Con la trama arriba y sin columna, \(\theta_1 = \operatorname{atan2}(p_y, p_x)\) y el codo se resuelve en el plano \(R\)–\(z\). Codo arriba y codo abajo son los dos signos del seno. No da metros de ese robot.

En el SCARA del G1, \(d_3 = p_z\) cuando la trama coincide con el manual, y la prismática solo admite valores negativos. Los 75 y 100 son de ese G1.

## Lo que la clase 4 ya cierra

El signo de \(z\) del RRP. Las dos escrituras son las que él mismo da: \(z = d_3\) con \(d_3\) negativo, o \(z = -d_3\). Al derivar usa \(\dot z = -\dot d_3\). Eso es el brazo de la práctica, no el antropomórfico. La ecuación (5) del paper no se toca.

La singularidad del jacobiano de 3 grados de libertad del RRP. \(\det J = -L_1 L_2 \sin\theta_2 = 0\) cuando \(\theta_2 = 0 \pm n\pi\). \(\theta_2 = 0\) lo muestra como el borde exterior del área de trabajo. Distingue ese borde, donde se pierde un grado de libertad, de las singularidades de adentro, donde las velocidades articulares se van al infinito. La singularidad de muñeca alineada con la primera articulación la menciona y la deja para después.

## Lo que sigue abierto

1. Metros del antropomórfico. Ni la clase 3 ni la 4 los dan. La Tabla I de Kostić sigue en símbolos.
2. Si \(z_0\) del paper que elija el grupo está arriba o abajo, y el sentido de \(\theta_1\). En la clase 3 pide mirar eso en el paper. El de 2002 no numera esas dos opciones.
3. Si el control lleva el \(\tanh\) de la clase 7 o la proporcional comentada. En la clase 3 solo dice que, entre codo arriba y codo abajo, para el control cinemático se elige la articulación que conviene.
4. La singularidad de adentro del área de trabajo, anunciada en la clase 4 y no calculada.
