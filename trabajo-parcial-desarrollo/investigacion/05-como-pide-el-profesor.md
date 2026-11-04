# Cómo pide el profesor el parcial y el final

Sale de las transcripciones `mia-ro-sis-au-01.txt` a `mia-ro-sis-au-06.txt` y de `tips-trabajo-parcial-final.txt`. El enunciado escrito del parcial sigue en `01-enunciado.md`. Acá va lo que él dice en clase sobre cómo desarrollarlo.

El audio es de reconocimiento de voz. Donde una frase no se entiende, queda marcada y no se convierte en puntaje, fecha ni fórmula. La clase 4 no indica cómo hacer el trabajo: ahí «parcial» es la derivada parcial del Jacobiano.

El brazo de la práctica es el SCARA del G1. El trabajo, parcial y final, es un antropomórfico de 3 grados de libertad sacado de un paper.

## Trabajo parcial

En la clase 1 el sílabo trae la semana 8 como práctica calificada y la semana 16 como trabajo final. En la clase 5 él dice que esa sesión es la clase número 5, y que había asumido examen en la semana 8 porque nadie le observó el sílabo. Ahí abre dos caminos y pide que el salón vote, de forma unánime:

- Examen, con plazo hasta el día siguiente, y a la semana una pregunta por integrante. Esas dos notas se promedian.
- Un avance del trabajo final, que pasa a ser el trabajo parcial.

El salón, en esa clase, se inclina por el avance. Él deja la votación abierta hasta que sea unánime. En la clase 6 ya trata el parcial como trabajo: sube a Información general del aula el archivo «Trabajo parcial 2026-2», su rúbrica y el PPT, y abre salas para ver avances.

Lee el caso en voz alta. Hay que simular:

1. cinemática directa,
2. cinemática inversa,
3. cinemática diferencial,
4. singularidades,
5. control cinemático.

El control cinemático lo deja a criterio del grupo. Una opción es el control en el espacio articular, de un punto A a un punto B. La otra es el control en el espacio cartesiano, el tema de la clase siguiente. Dice que con el punto a punto articular el parcial ya quedaría cubierto, y que otro grupo puede hacer el cartesiano.

En la clase 5, cuando le preguntan si el ejemplo del antropomórfico es el parcial, responde que ese ejemplo es ayuda para el trabajo final. El corte del avance, si el parcial es ese avance, lo pone en control cinemático, porque la semana 7 cierra ese tema.

La nota del parcial, en esa opción, es la exposición de la semana 8. Puede preguntarle a cualquier integrante. Dice que va a acomodar la rúbrica del final para usarla también como rúbrica del parcial. En la clase 6 aclara que la rúbrica que está mostrando es, por el momento, distinta de la del final.

Fechas que sí dice, y que el audio no termina de cuadrar entre sí:

- Clase 5: si eligen el trabajo, en la clase 6 sube la rúbrica y hay dos semanas para prepararlo. En la semana 7, la última hora, entra a los grupos a ver avances, sin nota, y da retroalimentación. La exposición sería en la semana 8.
- Clase 6: «como todo se va a correr una semana», la exposición pasa a la semana 9. Enseguida corrige el tema de la clase siguiente: no es interpoladores, es la séptima, control en el espacio cartesiano.

Esas dos frases se dejan como las dijo. No armo un calendario único.

El formato de carátula, opinión personal, conclusiones, recomendaciones, APA y anexos está en el PDF, no lo vuelve a dictar en estas transcripciones.

## Trabajo final

En la clase 1 el examen final es el trabajo final. Es grupal. Son 27 estudiantes: tres grupos de siete y uno de seis. La semana 16 del sílabo de esa clase es ese trabajo.

Consiste en elegir un paper de un robot de tres grados de libertad. Puede ser paper o tesis, con tal de que el robot sea un manipulador antropomórfico de 3 grados de libertad. En la clase 5 insiste en que esos tres grados no son el SCARA de la práctica: el antropomórfico se mueve en el espacio, con la forma de ese brazo.

El objetivo que da en la clase 1 es verificar. El paper trae su propio análisis. Con los métodos del curso, y con el método que el grupo elija, el resultado tiene que coincidir con lo que reporta el paper. Todo es simulación: llegar a lo pedido, sin tanto sobrepico, y seguir la trayectoria.

Sobre la inversa, el grupo elige el método: geométrico, mínimos cuadrados amortiguados o redes neuronales. Sobre el control, también elige: técnicas modernas o lógica difusa. En las aplicaciones entran visión artificial y lenguaje natural. En la clase 2 ubica el control al final del recorrido, después de la cinemática y de la dinámica, con redes neuronales, lógica difusa y, para una aplicación, lenguaje natural. El ejemplo que pone es un pick and place.

La rúbrica del final, en la clase 1, todavía no estaba subida; dijo que la cargaría esa semana. Mientras la lee se reconocen estos criterios, ya mezclados con la explicación:

- el entorno de operación, resuelto con la cinemática directa, definido con claridad;
- un objetivo concreto y la justificación del enfoque, cinemático, dinámico o con aprendizaje;
- el modelado de la cinemática inversa;
- el diseño y la implementación del control.

Los puntajes no se entienden. Se oye una cuenta que termina en 20. No la paso a tabla.

En algunas clases, y en las tres últimas semanas, suspende la actividad y entra a cada grupo. Pregunta cómo va el final, da retroalimentación y encamina. Dice que no lo hace por ellos.

En la clase 6 la rúbrica del parcial es, por ahora, otra. El final sigue siendo el trabajo de exposición.

## Qué tiene que traer el paper

El criterio se va cerrando de la clase 1 al audio de tips.

Clase 1. Recomienda papers que ya traigan las características dinámicas: longitudes, centros de masa y tensores de inercia, para no trabarse después.

Clase 2. Masas, centros de masa e inercias no se calculan en clase. Los tiene que dar el paper. Si alguien diseñó el robot en CAD, nombra SolidWorks, Fusion e Inventor, puede sacar de ahí esos valores.

Clase 3. Al abrir el paper hay que mirar el sentido de \(\theta_1\). El \(z_0\) puede estar arriba o abajo. Esas dos disposiciones son dos descripciones distintas; no son el mismo robot dado vuelta.

Clase 5. Como no hay robot físico, el trabajo se apoya en el modelo matemático. Pide un paper que, aunque no traiga todos los pasos del curso, sí traiga masas. Con el modelo dinámico se arma el dataset, y con ese dataset entra la parte de inteligencia artificial. Para la dinámica anuncia el camino de Lagrange: energía cinética y energía potencial. La cinética que escribe es un medio de la masa por la velocidad al cuadrado, más un medio de la inercia por la velocidad angular al cuadrado. Si el paper usa cargas puntuales en el extremo del eslabón, no hay tensor y basta la velocidad lineal. Si da centros de masa, hace falta el Jacobiano angular.

Audio de tips. El paper que le muestren tiene que incluir el modelo dinámico. Si no está el desarrollo, al menos la tabla de masas, centros de masa y tensores de inercia. Pide que anoten esas tres cosas. Rechaza en esa revisión:

- un robot planar, aunque tenga tres grados de libertad, porque solo rota en un plano;
- un paper que se queda en cinemática o en cinemática inversa con redes, sin masas, tensores ni centros de masa;
- un control cartesiano armado solo con el Jacobiano, del estilo de mínimos cuadrados amortiguados, cuando al bajar el texto no aparece la dinámica.

Acepta la idea de un robot descrito con su dinámica, su geometría y sus distancias. Sobre ese modelo, más adelante, se acopla la inteligencia artificial. Cuando un estudiante dice que lo que presentarían ahora en el parcial es el análisis dinámico, responde que sí, porque el dataset tiene que salir de algún lado. Esa frase del audio de tips queda al lado de la lista cinemática que lee en la clase 6. Las dos están dichas; este archivo no las funde en un solo encargo.

Si entre semana aparece un paper que cumpla, se lo mandan a su correo y le avisan al delegado para que lo revise. El audio no dice la dirección.

## Cómo armar el análisis

En la clase 5 resuelve un antropomórfico de ejemplo para que, al encontrar el paper, el grupo ya tenga recorrido el camino. El orden que deja resumido es este:

1. Elegir el paper y trabajar el home: \(\theta_1 = \theta_2 = \theta_3 = 0\). En ese ejemplo el brazo apunta de modo que se pueda plantear Denavit–Hartenberg. El sistema base es el del paper; él dice que no sabe cuál van a encontrar y pone uno para poder avanzar.
2. Cinemática directa.
3. Espacio de trabajo.
4. Jacobiano lineal. Para tres grados de libertad dice que la parte lineal alcanza en esta etapa. Lo saca en simbólico.
5. Jacobiano angular, cuando el modelo dinámico lo pida.
6. Singularidades, con las recomendaciones que ya había dado.
7. Cinemática inversa.
8. Control cinemático, con una ley sobre el Jacobiano. En la clase 6 esa ley cambia según sea control de posición o control de trayectoria.

La comprobación que pide en la clase 5 son dos bloques. La directa recibe \(\theta_1, \theta_2, \theta_3\) y devuelve \(p_x, p_y, p_z\). Esa posición entra a la inversa y tiene que devolver las articulaciones. Ahí se toma una de las soluciones.

En el ejemplo dice que el análisis se puede hacer en cualquiera y que el procedimiento es el mismo. Él lo muestra en MATLAB. En el audio de tips, ante la pregunta de si puede ser Python, responde que al llegar a la inteligencia artificial lo van a pasar a Python, porque el trabajo es muy parecido. El PDF del parcial pide la simulación en MATLAB.

## Valores que inventa en el ejemplo

En la clase 5, para poder simular delante de la clase, inventa números y lo dice. No son datos de un paper ni del G1:

- \(\theta_1\) de \(-140^\circ\) a \(140^\circ\), \(\theta_2\) de \(-120^\circ\) a \(120^\circ\), \(\theta_3\) de \(-110^\circ\) a \(110^\circ\);
- \(L_1 = 30\) mm, \(L_2 = 15\) mm, \(L_3 = 10\) mm.

Las longitudes y los límites del trabajo son los del paper elegido. Los del G1, 75 mm y 100 mm, y el \(z = -d_3\), son del SCARA de la práctica.

## Bibliografía que nombra

En la clase 1 señala como libro de la primera parte el de Craig, *Introducción a la robótica. Mecánica y control*. Dice que de ahí saca ejemplos y una ecuación que usa cuando aplica métodos dinámicos. No dicta esa ecuación. También menciona manuales y un texto de control de movimiento de robots manipuladores. El resto de lecturas las iría subiendo al aula.
