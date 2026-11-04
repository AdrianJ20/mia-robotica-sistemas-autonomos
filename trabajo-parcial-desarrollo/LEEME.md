# Trabajo parcial — desarrollo

Simulación del robot antropomórfico de 3 grados de libertad que pide `trabajo-parcial/Trabajo_Parcial_2026_2.pdf`: cinemática directa, inversa, diferencial, singularidades y control cinemático, con un modelo real.

Esta carpeta no reemplaza el enunciado. El informe para entregar es el borrador de `informe/`. Todavía faltan tu nombre en la carátula, la opinión personal con tus palabras, y lo que digan las transcripciones de las clases 2 a 6.

## Cómo correrlo

En MATLAB Online, sube la carpeta `matlab/` y, desde esa carpeta, ejecuta:

```matlab
simular_parcial
```

No hace falta Robotics System Toolbox. El archivo imprime los errores y abre tres figuras.

Los metros de `parametros_comprobacion.m` no son los del robot. `a1 = 0` y los tres twist sí salen de la Tabla I de Kostić et al. (2002). El resto está ahí solo para que la cuenta cierre. Cuando aparezcan los metros, se cambia ese archivo y no las fórmulas.

## Qué hay

| Carpeta | Contenido |
| --- | --- |
| `investigacion/` | Lectura del enunciado, de las clases y del modelo |
| `matlab/` | Simulación |
| `informe/` | Borrador con la estructura que pide el enunciado |
| `fuentes/` | Copia de autor del paper de cinemática (ICRA 2002) |

No se usó `videos/`. Transcripciones leídas: las clases 1, 3 y 4. Faltan las de las clases 2, 5 y 6.

El informe compilado está en `informe/informe.pdf`. El resumen del artículo de cinemática está en `fuentes/resumen-kostic-2002.md`.
