# Transcripciones

Leídas: clases 1 a 6, y `tips-trabajo-parcial-final.txt`. No se abrió `videos/`. Lo que el docente pide del parcial y del final está en `05-como-pide-el-profesor.md`. El modelo del parcial es Ramzy et al. (2024), en `03-modelo.md`.

## Lo que la clase 2 ya cierra

La directa del G1. \(L_1=75\) mm y la segunda distancia \(100\) mm. En home el brazo apunta a \(x\) y esa coordenada es 175. La pizarra escribe \(z=-d_3\) porque la prismática solo toma valores negativos. El producto de Denavit–Hartenberg imprime \(z=+d_3\); para igualar al programa, él pone el menos. El orden del algoritmo es rotación en \(z\), traslación en \(z\), traslación en \(x\) y rotación en \(x\).

La primera articulación, ya corregida, va de \(-135^\circ\) a \(135^\circ\). \(d_3\) va de \(-100\) a \(0\). El rango de la segunda no queda cerrado en la transcripción.

No da metros del antropomórfico. Dice que masas, centros de masa e inercias los trae el paper, o un CAD, y que en esta parte no se calculan.

## Lo que la clase 3 ya cierra

El caso de estudio de los trabajos es un antropomórfico. Lo dice al cierre: suele pedir antropomórficos, y en esa clase explicó el de 3 grados de libertad. No da los metros de ese ejemplo.

La inversa de ese brazo, en la diapositiva, es geométrica. Con la trama arriba y sin columna, \(\theta_1 = \operatorname{atan2}(p_y, p_x)\) y el codo se resuelve en el plano \(R\)–\(z\). Codo arriba y codo abajo son los dos signos del seno. No da metros de ese robot.

En el SCARA del G1, \(d_3 = p_z\) cuando la trama coincide con el manual, y la prismática solo admite valores negativos. Los 75 y 100 son de ese G1.

## Lo que la clase 4 ya cierra

El signo de \(z\) del RRP. Las dos escrituras son las que él mismo da: \(z = d_3\) con \(d_3\) negativo, o \(z = -d_3\). Al derivar usa \(\dot z = -\dot d_3\). Eso es el brazo de la práctica, no el antropomórfico. En Ramzy et al. (2024), \(p_z\) suma \(l_1\).

La singularidad del jacobiano de 3 grados de libertad del RRP. \(\det J = -L_1 L_2 \sin\theta_2 = 0\) cuando \(\theta_2 = 0 \pm n\pi\). \(\theta_2 = 0\) lo muestra como el borde exterior del área de trabajo. Distingue ese borde, donde se pierde un grado de libertad, de las singularidades de adentro, donde las velocidades articulares se van al infinito. La singularidad de muñeca alineada con la primera articulación la menciona y la deja para después.

## Lo que sigue abierto

1. La opinión personal, el nombre en la carátula y el nombre oficial de la maestría.
2. Si en la exposición se muestra el control cartesiano, el punto a punto articular, o los dos. El script trae los dos. La clase 6 deja la elección al grupo.
3. La singularidad de adentro que la clase 4 anuncia para el RRP y no calcula. En este antropomórfico, \(A = 0\) (punta en el eje de \(q_1\)) es la que el jacobiano sí deja en cero con \(\sin q_3 \neq 0\).
