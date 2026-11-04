# Trabajo parcial — desarrollo

Simulación del antropomórfico de 3 grados de libertad de Ramzy, Hammad y Maged (2024): cinemática directa, inversa, diferencial, singularidades y control cinemático. El PDF está en `fuentes/applsci-14-05285-v2.pdf`.

Esta carpeta no reemplaza el enunciado. El informe para entregar es `informe/informe.pdf`. Faltan el nombre en la carátula, el logotipo de la UNI, el nombre oficial de la maestría y la opinión personal con tus palabras.

## Cómo correrlo

En MATLAB Online, sube la carpeta `matlab/` y, desde esa carpeta, ejecuta:

```matlab
simular_parcial
```

No hace falta Robotics System Toolbox. El archivo imprime los errores y abre tres figuras.

Los largos son los de la Tabla 2: \(l_1 = 0{,}04\) m, \(l_2 = 0{,}29\) m, \(l_3 = 0{,}240\) m. Masas, centros de masa, momentos, resortes y amortiguadores de esa tabla no entran en este script.

## Qué hay

| Carpeta | Contenido |
| --- | --- |
| `investigacion/` | Enunciado, clases, modelo y lo que el docente pide |
| `matlab/` | Simulación |
| `informe/` | Borrador y PDF |
| `fuentes/` | El artículo y `resumen-ramzy-2024.md` |

No se usó `videos/`. Las transcripciones de las clases 1 a 6 y `tips-trabajo-parcial-final.txt` están resumidas, en lo que toca al encargo, en `investigacion/05-como-pide-el-profesor.md`.
