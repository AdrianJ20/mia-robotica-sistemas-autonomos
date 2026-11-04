# Resumen — Kostić et al., ICRA 2002

Kostić, D., Hensen, R. H. A., de Jager, B. y Steinbuch, M. (2002). *Closed-form kinematic and dynamic models of an industrial-like RRR robot*. IEEE International Conference on Robotics and Automation, Washington, pp. 1309–1314. https://doi.org/10.1109/ROBOT.2002.1014724

Copia leída: `kostic-2002-icra-rrr.pdf` (versión del portal de la TU/e, 7 páginas).

## De qué se trata

El paper arma, en forma cerrada, la cinemática y la dinámica de un robot real de tres rotativas y las comprueba con una tarea de escritura. El robot está en el laboratorio de Dynamics and Control de la TU/e. Tiene cintura, hombro y codo, montados como un industrial antropomórfico. Cada articulación gira sin tope, porque la potencia y las señales pasan por anillos deslizantes. Los motores son brushless de accionamiento directo, sin reductor ni contrapeso. El control corre en una PC. Unos inversores de corriente amplifican la señal antes del motor.

Los parámetros cinemáticos salen de datos de fabricante o de medir el robot. Los inerciales no: se estiman. El procedimiento de estimación está en el CDC 2001 de los mismos autores. Este paper no lo repite. Cambia la fricción: aquí usan una red neuronal, no el modelo de LuGre del 2001, porque estimarla es más rápido.

## La cadena

La Tabla I está en la página como tabla, no como texto recuperable. En la página se lee:

| GDL | twist | longitud | ángulo | offset |
| --- | --- | --- | --- | --- |
| 1 | \(\pi/2\) | 0 | \(q_1\) | \(C_0C_1\) |
| 2 | 0 | \(P_1C_2\) | \(q_2\) | \(C_1P_1\) |
| 3 | 0 | \(P_2C_3\) | \(q_3\) | \(C_2P_2\) |

No hay metros en esas celdas. El primer eje queda perpendicular a los dos siguientes. Hombro y codo quedan paralelos.

Dos espacios. El operacional es la punta, \(\mathbf{x}=[x\;y\;z]^\top\). El articular es \(\mathbf{q}=[q_1\;q_2\;q_3]^\top\).

## Directa

La orientación de la punta es una matriz \(3\times 3\). Los elementos que el texto imprime son:

\[
\begin{aligned}
o_{11}&=\cos q_1\cos(q_2+q_3),&
o_{12}&=-\cos q_1\sin(q_2+q_3),&
o_{13}&=\sin q_1,\\
o_{21}&=\sin q_1\cos(q_2+q_3),&
o_{22}&=-\sin q_1\sin(q_2+q_3),&
o_{23}&=-\cos q_1,\\
o_{31}&=\sin(q_2+q_3),&
o_{32}&=\cos(q_2+q_3),&
o_{33}&=0.
\end{aligned}
\]

La posición, ecuación (5), sí se lee:

\[
\begin{aligned}
x &= \cos q_1\,(a_3\cos(q_2+q_3)+a_2\cos q_2)+(d_2+d_3)\sin q_1,\\
y &= \sin q_1\,(a_3\cos(q_2+q_3)+a_2\cos q_2)-(d_2+d_3)\cos q_1,\\
z &= a_3\sin(q_2+q_3)+a_2\sin q_2+d_1.
\end{aligned}
\]

\(a_2\), \(a_3\), \(d_1\), \(d_2\) y \(d_3\) son los símbolos de la tabla. El paper no les pone número.

## Inversa

Dicen que la inversa también está en forma cerrada, ecuación (6). En el PDF esa ecuación queda partida en la figura y no se puede copiar entera. Lo que el texto sí dice, y sirve, es para qué la quieren:

1. Reconocer enseguida una configuración irregular, por ejemplo una singularidad.
2. Elegir la postura con un signo. El signo menos de la cuarta fórmula de (6) es codo arriba; el más, codo abajo.
3. Gastar menos cuentas que un método numérico. Eso lo miden en la sección V.

## Dinámica

Lagrange–Euler, forma estándar:

\[
D(q)\ddot q + c(q,\dot q) + h(q) = \tau.
\]

\(D\) es la inercia \(3\times 3\), \(c\) junta Coriolis y centrípeto, \(h\) es la gravedad, \(\tau\) son los torques.

El inversor relaciona voltaje y torque de forma lineal y estática. Entran la fricción, la constante de torque y la inercia del rotor (rotor más encoder, anillos y lo que vaya montado).

La fricción de Coulomb más la viscosa no les alcanza. LuGre sí describe más efectos, pero estimarlo es lento. Por eso pasan a una red neuronal: coeficientes fáciles de estimar con un filtro de Kalman extendido y, si se fijan unos pesos, el resto queda lineal y entra por mínimos cuadrados.

El modelo se escribe lineal en un conjunto base de parámetros identificables. En este robot ese vector \(p\) tiene 16 componentes. Son combinaciones de masas, centros de gravedad y momentos y productos de inercia, no la masa ni el tensor de cada eslabón por separado. La matriz de regresión va en las ecuaciones (12) y (13), que en el PDF son fórmulas largas de la dinámica, no una tabla de metros.

Con los términos que llevan \(g\) arman la gravedad; con los que llevan aceleración articular, la inercia; el resto es Coriolis. Sirven para compensar en línea cada efecto, si los parámetros están bien estimados.

## Cómo lo comprueban

La tarea es escribir una secuencia de letras en un plano, con \(z\) fijo, y un perfil de velocidad que alterna tramos rápidos y lentos. La inversa de esa trayectoria da movimientos articulares que no son uniformes.

Comparan la inversa cerrada con la numérica del Robotics Toolbox de Corke. La diferencia queda dentro de la precisión que el toolbox garantiza. El exponente de esa cota no se lee bien en el PDF, así que no lo copio. Lo que sí se lee es el costo: 102 operaciones de punto flotante de MATLAB por postura, contra 2783 del toolbox.

La dinámica cerrada, contra la rutina numérica del mismo toolbox, difiere por redondeo. Cuesta 393 flops por postura, contra 1050.

En el robot real usan par computado. El voltaje de cada eje es un término nominal del modelo, más la fricción, más un PD sobre el error de posición y de velocidad, siguiendo la referencia articular de la escritura.

Solo con el PD, las letras salen corridas respecto de la referencia. Al sumar el término nominal, la diferencia baja. En la segunda articulación el nominal manda y el PD solo corrige. Los valores eficaces, en volt, que imprimen para los tres ejes son

\[
U^{n}=[0{,}25\;\; 1{,}98\;\; 0{,}78]^\top,
\qquad
U^{\mathrm{PD}}=[0{,}11\;\; 0{,}24\;\; 0{,}17]^\top.
\]

Con eso concluyen que el modelo (10)–(13) representa la dinámica del robot. Cierran listando seis propiedades: menos cómputo, precisión numérica, ver la singularidad sin iterar, elegir la postura, linealidad para estimar inercia, y usar el modelo para compensar.

## Qué no hay que pedirle a este PDF

- Metros de \(C_0C_1\), \(P_1C_2\), \(C_1P_1\), \(P_2C_3\) ni \(C_2P_2\).
- Masa, centro de masa o tensor de cada eslabón. El vector \(p\) no los reemplaza.
- La ecuación (6) completa. Hay que rederivarla desde la (5), que es lo que hace la simulación del parcial.
- El control del curso. El paper compensa dinámica con par computado. El parcial pide control cinemático. La directa y la cadena sí se usan; la ley de control, no.
