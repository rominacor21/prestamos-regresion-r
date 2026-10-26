# Datos

Base de una institución financiera con **35.000 préstamos personales** y 12 variables. No se publica porque pertenece a la institución. Para correr el análisis, ubicala en `data/Datos 2024.csv`.

## Diccionario de datos

| Variable | Tipo | Descripción |
|---|---|---|
| `Identificacion` | ID | Identificador único del préstamo |
| `Ingresos_cliente` | Numérica continua | Ingresos de quien pide el préstamo |
| `Credito_disponible` | Numérica continua | Crédito que le queda después del préstamo |
| `Monto_prestamo` | Numérica continua | Monto del préstamo en pesos uruguayos (**variable a predecir**) |
| `Genero` | Categórica | Género de quien pide el préstamo |
| `Region_residencia` | Categórica | Zona de residencia |
| `Numero_dependientes` | Numérica discreta | Personas a cargo |
| `Educacion` | Categórica ordinal | 1 Universidad, 2 Secundaria, 3 Primaria, 4 Otra |
| `Edad` | Numérica discreta | Edad al sacar el préstamo |
| `Sector_empleo` | Categórica | Público, privado o autónomo |
| `Default` | Binaria | 1 si incumple el mes siguiente. No se usa para predecir el monto |
| `Estado_civil` | Categórica | 1 Casado o concubino, 2 Soltero, divorciado o viudo |
