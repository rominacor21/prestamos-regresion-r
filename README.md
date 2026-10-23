# Predicción del monto de préstamos personales

Modelo en R para estimar cuánto dinero pide cada cliente de una institución financiera, comparando **regresión lineal múltiple** y **árbol de regresión**.

> Trabajo grupal de Analítica de Negocios y Big Data, Licenciatura en Negocios Digitales, Universidad ORT Uruguay, 2024.

## El problema

Una institución financiera quiere entender qué características del cliente explican el monto del préstamo que solicita, para predecirlo y ajustar su oferta y su gestión de riesgo.

- 35.000 préstamos personales
- 12 variables: ingresos, crédito disponible, edad, educación, estado civil, sector de empleo, región, dependientes y default

## Qué hicimos

1. **Análisis descriptivo:** correlaciones, histogramas, boxplots, dispersión y tablas de frecuencia.
2. **Regresión lineal múltiple** por mínimos cuadrados, con selección **stepwise**, chequeo de **multicolinealidad (VIF)** y validación **train / test**.
3. **Árbol de regresión** con poda por parámetro de complejidad, reglas inducidas e importancia de variables.
4. **Comparación** de ambos modelos por MSE y R².

## Resultados

| Indicador | Regresión lineal | Árbol de regresión |
|---|---|---|
| R² | 95,67 % (ajustado) | 86,94 % (test) |
| MSE test | 47.986.853 | 165.822.160 |

- Los ingresos tienen una correlación fuerte y positiva con el monto (r = 0,83).
- El crédito disponible tiene una correlación negativa (r = -0,69).
- Variables significativas: ingresos, crédito disponible, dependientes, educación y estado civil. Género, región y sector de empleo no lo fueron.
- Todos los VIF dieron menores a 2, sin multicolinealidad.
- **Conclusión:** la regresión lineal predice mejor y es más fácil de interpretar. El árbol suma valor para segmentar clientes con reglas simples.

## Cómo correrlo

```r
# Ubicá el archivo de datos en data/Datos 2024.csv
source("analisis_prestamos.R")
```

Los datos no se publican porque pertenecen a la institución.

## Stack

R · rio · car · rpart · rattle

---

**Romina Cor Castro** · [LinkedIn](https://www.linkedin.com/in/rominacor/)
