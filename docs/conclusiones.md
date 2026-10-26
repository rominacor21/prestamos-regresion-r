# Conclusiones

## Análisis descriptivo
- Monto promedio del préstamo: $69.685, con un rango de $2.300 a $218.500.
- Ingresos promedio: $37.048. Crédito disponible promedio: $78.863.
- Edad promedio: 35 años, con un rango de 21 a 79.
- El 18 % de los clientes tiene antecedentes de incumplimiento.
- Correlaciones con el monto: ingresos r = 0,83, crédito disponible r = -0,69 y edad r = 0,15.

## Regresión lineal
Ecuación final, después de stepwise:

```
Monto_prestamo = 83.730 + 3.131·Educacion_dum + 542,8·Estado_civil_dum
                 + 1,35·Ingresos_cliente − 0,88·Credito_disponible
                 + 1.858·Numero_dependientes
```

- Significativas (p < 0,05): ingresos, crédito disponible, dependientes, educación y estado civil.
- No significativas: género, región y sector de empleo.
- VIF menores a 2: no hay multicolinealidad.
- R² ajustado de 95,67 %. MSE train de 48.853.938 y MSE test de 47.986.853: no hay sobreajuste.

## Árbol de regresión
- Variables más importantes: dependientes, ingresos y crédito disponible.
- R² train de 87,52 % y R² test de 86,94 %: generaliza bien.
- MSE test de 165.822.160, más del triple que la regresión.

## Cuál conviene
La **regresión lineal** predice mejor y muestra cuánto pesa cada variable. El **árbol** sirve como complemento para segmentar clientes con reglas fáciles de explicar al negocio.
