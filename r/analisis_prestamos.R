# Predicción del monto de préstamos personales
# Regresión lineal múltiple vs. árbol de regresión
# Analítica de Negocios y Big Data · Universidad ORT Uruguay · 2024
#
# Datos: 35.000 préstamos personales de una institución financiera, 12 variables.
# El archivo de datos no se publica por confidencialidad. Ubicalo en data/Datos 2024.csv y corré el script desde la raíz del repo

# Librerías ------------------------------------------------------------------
paquetes <- c("rio", "car", "rpart", "rpart.plot", "rattle")
nuevos <- paquetes[!paquetes %in% installed.packages()[, "Package"]]
if (length(nuevos)) install.packages(nuevos)

library(rio)
library(car)
library(rpart)
library(rpart.plot)
library(rattle)

# Datos ----------------------------------------------------------------------
mydata <- import("data/Datos 2024.csv")
dim(mydata)
summary(mydata)

# Variables dummy ------------------------------------------------------------
mydata$Genero_dum            <- ifelse(mydata$Genero == "Mujer", 1, 0)
mydata$Region_residencia_dum <- ifelse(mydata$Region_residencia == "Zona Urbana", 1, 0)
mydata$Sector_empleo_dum     <- ifelse(mydata$Sector_empleo == "Privado", 1, 0)
mydata$Educacion_dum         <- ifelse(mydata$Educacion == 1, 1, 0)
mydata$Estado_civil_dum      <- ifelse(mydata$Estado_civil == 1, 1, 0)

# 1. Análisis descriptivo ----------------------------------------------------
cor_matriz <- cor(mydata[, c("Ingresos_cliente", "Credito_disponible", "Monto_prestamo", "Edad")])
print(cor_matriz)

par(mfrow = c(2, 2))
hist(mydata$Ingresos_cliente, col = "steelblue", main = "Histograma de ingresos")
boxplot(mydata$Monto_prestamo ~ mydata$Genero, col = "tomato", main = "Monto por género")
plot(mydata$Edad, mydata$Monto_prestamo, col = "purple", main = "Edad vs. monto del préstamo")
abline(lm(Monto_prestamo ~ Edad, data = mydata), col = "black")

tabla_frec_abs <- table(mydata$Educacion)
tabla_frec_rel <- prop.table(tabla_frec_abs) * 100
print(tabla_frec_abs)
print(round(tabla_frec_rel, 2))

# 2. Train / test ------------------------------------------------------------
set.seed(1234)
train_index <- sample(seq_len(nrow(mydata)), size = 0.5 * nrow(mydata))
train <- mydata[train_index, ]
test  <- mydata[-train_index, ]

# 3. Regresión lineal múltiple -----------------------------------------------
reg <- lm(Monto_prestamo ~ Genero_dum + Region_residencia_dum + Sector_empleo_dum +
            Educacion_dum + Estado_civil_dum + Ingresos_cliente + Credito_disponible +
            Numero_dependientes, data = train)
summary(reg)

reg_step <- step(reg, direction = "both")   # selección stepwise
summary(reg_step)
print(vif(reg_step))                         # multicolinealidad

pred_train <- predict(reg_step, newdata = train)
pred_test  <- predict(reg_step, newdata = test)
mse_train  <- mean((train$Monto_prestamo - pred_train)^2)
mse_test   <- mean((test$Monto_prestamo - pred_test)^2)
cat("Regresión lineal | MSE train:", mse_train, "| MSE test:", mse_test, "\n")

# 4. Árbol de regresión ------------------------------------------------------
arbol <- rpart(Monto_prestamo ~ Genero_dum + Region_residencia_dum + Sector_empleo_dum +
                 Educacion_dum + Estado_civil_dum + Ingresos_cliente + Credito_disponible +
                 Numero_dependientes, data = train, method = "anova")

plotcp(arbol)
cp_opt <- arbol$cptable[which.min(arbol$cptable[, "xerror"]), "CP"]
arbol_podado <- prune(arbol, cp = cp_opt)
fancyRpartPlot(arbol_podado)
asRules(arbol_podado)

print(arbol_podado$variable.importance / sum(arbol_podado$variable.importance))

pred_arbol_train <- predict(arbol_podado, newdata = train)
pred_arbol_test  <- predict(arbol_podado, newdata = test)
mse_arbol_train  <- mean((train$Monto_prestamo - pred_arbol_train)^2)
mse_arbol_test   <- mean((test$Monto_prestamo - pred_arbol_test)^2)
cat("Árbol de regresión | MSE train:", mse_arbol_train, "| MSE test:", mse_arbol_test, "\n")

# 5. Comparación -------------------------------------------------------------
if (mse_test < mse_arbol_test) {
  cat("La regresión lineal predice mejor en test.\n")
} else {
  cat("El árbol de regresión predice mejor en test.\n")
}
