##############################################################################
# TECNICAS MULTIVARIADAS - Examen Final 2026-I
##############################################################################

# ============================================================================
# CARGA DE PAQUETES
# ============================================================================
suppressPackageStartupMessages({
  suppressWarnings({
    # Manipulacion y formateo de datos
    library(dplyr)
    library(tidyverse)
    library(readxl)
    library(haven)
    library(insight)
    library(broom.helpers)
    
    # Modelamiento y Regresion (Binaria y Ordinal)
    library(MASS)
    library(rms)
    library(car)
    library(lmtest)
    library(brant)
    library(pscl)
    library(survey)
    
    # Evaluacion, Desempeno y Validacion del Modelo
    library(performance)
    library(DHARMa)
    library(ResourceSelection)
    library(caret)
    library(pROC)
    library(randomForest)
    library(ROSE)
    library(caTools)
    library(effectsize)
    library(epiR)
    library(sandwich)
    
    # Tablas y Reportes Profesionales
    library(gtsummary)
    library(cardx)
    library(knitr)
    library(kableExtra)
    library(nnet)
    library(mvnormtest)
    library(mlogit)  
    library(dfidx)
    library(marginaleffects)
    
    # Visualizacion y Graficos
    library(ggplot2)
    library(sjPlot)
    library(ggeffects)
    library(patchwork)
    library(vip)
    library(see)
    library(ggthemes)
    library(RColorBrewer)
    library(ggstatsplot)
  })
})

theme_set(theme_bw())

suppressPackageStartupMessages({
  library(dplyr); library(tidyverse); library(caret); library(rms)
  library(lmtest); library(sjPlot); library(jtools); library(forestmodel)
  library(emmeans); library(performance); library(survey); library(epiR)
  library(tinytable); library(pscl); library(rcompanion); library(blorr)
  library(pROC); library(ROSE); library(caTools); library(randomForest)
  library(vip); library(car); library(gtsummary); library(ggeffects)
})


##############################################################################
# PREGUNTA 1: REGRESION LOGISTICA DICOTOMICA
##############################################################################

# --- Crear datos ---
set.seed(2024)
n <- 700

nivel_socioeconomico <- factor(
  sample(c("Bajo", "Medio", "Alto"), n, replace = TRUE, prob = c(0.35, 0.45, 0.20)),
  levels = c("Bajo", "Medio", "Alto")
)
beca    <- factor(sample(c("No", "Si"), n, replace = TRUE, prob = c(0.7, 0.3)), levels = c("No", "Si"))
trabaja <- factor(sample(c("No", "Si"), n, replace = TRUE, prob = c(0.55, 0.45)), levels = c("No", "Si"))

promedio_previo <- round(rnorm(n, mean = 13.5, sd = 2.2), 1)
promedio_previo <- pmin(pmax(promedio_previo, 6), 20)

asistencia_pct <- round(rnorm(n, mean = 80, sd = 12), 1)
asistencia_pct <- pmin(pmax(asistencia_pct, 30), 100)

horas_estudio <- round(rgamma(n, shape = 4, scale = 2.5), 1)

materias_reprobadas <- rpois(n, lambda = ifelse(promedio_previo < 12, 1.6, 0.5))
materias_reprobadas <- pmin(materias_reprobadas, 6)

z <- -1.3 +
  (-0.18) * (promedio_previo - 13.5) +
  (-0.035) * (asistencia_pct - 80) +
  (-0.07)  * (horas_estudio - 8) +
  ( 0.55)  * materias_reprobadas +
  (-0.65)  * (beca == "Si") +
  ( 0.45)  * (trabaja == "Si") +
  ( 0.55)  * (nivel_socioeconomico == "Bajo") +
  (-0.30)  * (nivel_socioeconomico == "Alto")

p_real <- 1 / (1 + exp(-z))
abandono <- factor(rbinom(n, 1, p_real), levels = c(0, 1), labels = c("No", "Si"))

datos <- data.frame(
  promedio_previo, asistencia_pct, horas_estudio,
  materias_reprobadas, beca, trabaja, nivel_socioeconomico, abandono
)

str(datos)
head(datos, 10)

# --- Categorias de referencia ---
levels(c(datos$abandono, datos$beca, datos$trabaja, datos$nivel_socioeconomico))

contrasts(datos$abandono)
contrasts(datos$beca)
contrasts(datos$trabaja)
contrasts(datos$nivel_socioeconomico)

datos$abandono <- relevel(datos$abandono, ref = "No")
datos$beca     <- relevel(datos$beca, ref = "No")
datos$trabaja  <- relevel(datos$trabaja, ref = "No")
datos$nivel_socioeconomico <- relevel(datos$nivel_socioeconomico, ref = "Medio")

contrasts(datos$abandono)
contrasts(datos$nivel_socioeconomico)

# --- Medidas descriptivas ---
datos %>% plot_frq(nivel_socioeconomico)

datos %>%
  group_by(abandono) %>%
  plot_frq(nivel_socioeconomico) %>%
  plot_grid()

datos %>%
  group_by(abandono) %>%
  plot_frq(promedio_previo, type = "histogram", show.mean = TRUE, normal.curve = TRUE) %>%
  plot_grid()

datos %>%
  group_by(abandono) %>%
  plot_frq(asistencia_pct, type = "violin", show.mean = TRUE, normal.curve = TRUE) %>%
  plot_grid()

tbl_summary(datos, by = abandono, statistic = all_continuous() ~ "{mean} ({sd})")

tabla_combinada <- datos %>%
  select(abandono, beca, trabaja, nivel_socioeconomico) %>%
  tbl_summary(
    by = abandono,
    include = c(beca, trabaja, nivel_socioeconomico),
    percent = "row",
    statistic = list(all_categorical() ~ "{n} ({p})"),
    digits = all_categorical() ~ c(0, 2)
  ) %>%
  add_overall(last = TRUE) %>%
  add_p(
    test = everything() ~ "chisq.test",
    pvalue_fun = ~ style_pvalue(.x, digits = 3)
  ) %>%
  modify_header(label ~ "**Variable**") %>%
  modify_caption("Tabla 1: Comparacion de Beca, Trabaja y Nivel Socioeconomico por Abandono")

tabla_combinada

# --- Particion de datos ---
set.seed(8)
ind_train <- createDataPartition(y = datos$abandono, p = 0.7, list = FALSE)
base_entrenamiento <- datos[ind_train, ]
base_prueba        <- datos[-ind_train, ]

dim(base_entrenamiento)[1] / dim(datos)[1]
dim(base_prueba)[1] / dim(datos)[1]

prop.table(table(datos$abandono))
prop.table(table(base_entrenamiento$abandono))
prop.table(table(base_prueba$abandono))

# --- Modelo de regresion logistica binaria ---
modelo <- glm(abandono ~ ., family = binomial(link = logit), data = base_entrenamiento)
summary(modelo)

step <- stepAIC(modelo, direction = "forward", trace = FALSE)
step$anova

# --- Estadistico Omnibus y Wald ---
mod_lrm <- lrm(formula = abandono ~ ., data = base_entrenamiento, x = TRUE, y = TRUE)
mod_lrm

deviance_model <- modelo$deviance
deviance_base  <- modelo$null.deviance
ji    <- deviance_base - deviance_model
ji_gl <- modelo$df.null - modelo$df.residual
pvalor <- pchisq(ji, df = ji_gl, lower.tail = FALSE)
ji; ji_gl; pvalor

m0 <- glm(abandono ~ 1, family = binomial(link = logit), data = base_entrenamiento)
lrtest(m0, modelo)

anova(modelo, test = "Chisq")

modelo1 <- glm(abandono ~ ., family = binomial(link = logit), data = base_entrenamiento)
summary(modelo1)

regTermTest(modelo1, "promedio_previo", method = "Wald")
regTermTest(modelo1, "asistencia_pct", method = "Wald")
regTermTest(modelo1, "horas_estudio", method = "Wald")
regTermTest(modelo1, "materias_reprobadas", method = "Wald")
regTermTest(modelo1, "beca", method = "Wald")
regTermTest(modelo1, "trabaja", method = "Wald")
regTermTest(modelo1, "nivel_socioeconomico", method = "Wald")

# --- Calibracion del modelo ---
hl <- hoslem.test(modelo1$y, fitted(modelo1), g = 10)
hl
cbind(hl$observed, hl$expected)

# --- Pseudo R-cuadrado ---
pR2(modelo1)
nagelkerke(modelo1)

blr_rsq_count(modelo1)
blr_rsq_nagelkerke(modelo1)
blr_rsq_mcfadden(modelo1)
blr_rsq_cox_snell(modelo1)

calibracion <- rms::calibrate(mod_lrm, B = 110)
plot(calibracion)

# --- Chequeo visual de supuestos ---
check_model(modelo1)
check_autocorrelation(modelo1)
check_residuals(modelo1)
check_collinearity(modelo1)
check_outliers(modelo1)
check_overdispersion(modelo1)

# --- Importancia de variables ---
import <- caret::varImp(modelo1)
dplyr::arrange(import, desc(Overall))

car::Anova(modelo1)

vip(modelo1)

rf <- randomForest(
  abandono ~ promedio_previo + asistencia_pct + horas_estudio +
    materias_reprobadas + beca + trabaja + nivel_socioeconomico,
  data = base_entrenamiento
)
vip(rf)

ggeffect(modelo1) %>% plot() %>% plot_grid()

# --- Odds Ratio ---
exp(coef(modelo1))
cbind(Coeficientes = modelo1$coef, ExpB = exp(modelo1$coef))

exp(cbind(OR = coef(modelo1), confint.default(modelo1, level = 0.95)))

forest_model(modelo1, exponentiate = TRUE)
summ(modelo1, confint = TRUE, exp = TRUE)
plot_summs(modelo1, confint = TRUE, exp = TRUE) + scale_x_log10()

plot_model(modelo1, show.values = TRUE, width = 0.1) +
  ylab('Abandono - "odds ratio"')

tab_model(modelo1, show.reflvl = TRUE, show.intercept = FALSE, p.style = "numeric_stars")

# --- emmeans ---
emmeans(modelo1, pairwise ~ nivel_socioeconomico, type = "response", infer = TRUE)

emmeans(modelo1, ~ nivel_socioeconomico, type = "response") %>%
  pairs(reverse = TRUE, infer = TRUE)

emmeans(modelo1, ~ nivel_socioeconomico, infer = TRUE) %>%
  as_tibble() %>%
  dplyr::select(nivel_socioeconomico, emmean) %>%
  mutate(odds = exp(emmean)) %>%
  mutate_if(is.numeric, ~ round(., 2))

emmeans(modelo1, pairwise ~ beca, type = "response", infer = TRUE)
emmeans(modelo1, pairwise ~ trabaja, type = "response", infer = TRUE)

plot_model(modelo1, type = "eff", terms = c("nivel_socioeconomico"))

# --- Probabilidades y grupos estimados (entrenamiento) ---
proba.pred <- predict(modelo1, type = "response")
clase.pred <- ifelse(proba.pred >= 0.5, "Si", "No")

finaldata <- cbind(base_entrenamiento, proba.pred, clase.pred)
head(finaldata, 10)

ggplot(finaldata, aes(x = proba.pred, fill = abandono)) +
  geom_density(alpha = 0.7) +
  theme_minimal()

# --- Prediccion para nuevos individuos ---
coef(modelo1)

nuevo1 <- data.frame(
  promedio_previo = 18, asistencia_pct = 95, horas_estudio = 15,
  materias_reprobadas = 0, beca = "Si", trabaja = "No",
  nivel_socioeconomico = "Alto"
)
predict(modelo1, newdata = nuevo1, type = "response")

nuevo2 <- data.frame(
  promedio_previo = 10, asistencia_pct = 55, horas_estudio = 3,
  materias_reprobadas = 4, beca = "No", trabaja = "Si",
  nivel_socioeconomico = "Bajo"
)
predict(modelo1, newdata = nuevo2, type = "response")

saveRDS(modelo1, "./modelo_logit.rds")
super_model <- readRDS("./modelo_logit.rds")
print(super_model)

# --- Indicadores con data de prueba ---
modelo2 <- glm(
  abandono ~ promedio_previo + asistencia_pct + horas_estudio +
    materias_reprobadas + beca + trabaja + nivel_socioeconomico,
  family = binomial(link = logit), data = base_prueba
)

proba.pred1 <- predict(modelo2, type = "response")
clase.pred1 <- ifelse(proba.pred1 >= 0.5, "Si", "No")

finaldata1 <- cbind(base_prueba, proba.pred1, clase.pred1)
head(finaldata1, 10)

ggplot(finaldata1, aes(x = proba.pred1, fill = abandono)) +
  geom_density(alpha = 0.9) +
  theme_minimal()

# --- Matriz de confusion ---
d2 <- base_prueba %>%
  mutate(pred_probs = predict(modelo2, base_prueba, "response")) %>%
  mutate(pred_classes = ifelse(pred_probs > 0.5, "Si", "No")) %>%
  mutate(
    abandono = factor(abandono, levels = c("Si", "No")),
    pred_classes = factor(pred_classes, levels = c("Si", "No"))
  )

cm2 <- xtabs(data = d2, ~ pred_classes + abandono)
confusionMatrix(cm2, mode = "everything", positive = "Si")

accuracy <- mean(base_prueba$abandono == clase.pred1)
error    <- mean(base_prueba$abandono != clase.pred1)
accuracy
error

# --- Curva ROC y AUC ---
roc.curve(d2$abandono, d2$pred_probs, lty = 2, lwd = 1.8, col = "blue", main = "ROC curves")

colAUC(d2$pred_probs, d2$abandono, plotROC = TRUE)
abline(0, 1, col = "tomato", lty = 4)

roc(abandono ~ fitted.values(modelo2), data = d2, plot = TRUE,
    legacy.axes = TRUE, print.auc = TRUE, ci = TRUE)

# --- Punto de corte optimo (Youden) ---
roc_obj <- roc(response = d2$abandono, predictor = d2$pred_probs,
               levels = c("No", "Si"), direction = "<")
roc_obj

corte_youden <- coords(roc_obj, "best", best.method = "youden")
corte_youden

umbral_youden <- as.numeric(corte_youden["threshold"])

d2 <- d2 %>%
  mutate(pred_youden = ifelse(pred_probs >= umbral_youden, "Si", "No")) %>%
  mutate(pred_youden = factor(pred_youden, levels = c("Si", "No")))

cm_youden <- xtabs(data = d2, ~ pred_youden + abandono)
confusionMatrix(cm_youden, mode = "everything", positive = "Si")

cm_05     <- confusionMatrix(cm2, positive = "Si")
cm_youden2 <- confusionMatrix(cm_youden, positive = "Si")

comparacion_umbral <- data.frame(
  Umbral        = c("0.5 (por defecto)", paste0("Youden (", round(umbral_youden, 3), ")")),
  Accuracy      = c(cm_05$overall["Accuracy"], cm_youden2$overall["Accuracy"]),
  Sensibilidad  = c(cm_05$byClass["Sensitivity"], cm_youden2$byClass["Sensitivity"]),
  Especificidad = c(cm_05$byClass["Specificity"], cm_youden2$byClass["Specificity"])
)
comparacion_umbral

plot(roc_obj, main = "Curva ROC - Modelo de Abandono (umbral de Youden)", col = "darkred")
points(corte_youden["specificity"], corte_youden["sensitivity"], col = "blue", pch = 19, cex = 1.3)

# --- DOR, LR+ y LR- ---
cm_tab <- table(d2$pred_classes, d2$abandono)
epi.tests(cm_tab)

TP <- cm_tab["Si", "Si"]; FN <- cm_tab["No", "Si"]
FP <- cm_tab["Si", "No"]; TN <- cm_tab["No", "No"]

Sensitivity <- TP / (TP + FN)
Specifity   <- TN / (TN + FP)

LRmas  <- Sensitivity / (1 - Specifity)
LRmenos <- (1 - Sensitivity) / Specifity
DOR <- LRmas / LRmenos

LRmas; LRmenos; DOR

cm_tab_youden <- table(d2$pred_youden, d2$abandono)
epi.tests(cm_tab_youden)


##############################################################################
# PREGUNTA 2: MODELO LOG BINOMIAL
##############################################################################

datos <- read.csv("datos_hipotecas_final.csv", stringsAsFactors = FALSE)

datos <- datos %>%
  mutate(
    compra = factor(
      compra,
      levels = c("No_Compra","Compra_Hipoteca")
    ),

    empleo = factor(
      empleo,
      levels = c("Independiente","Fijo")
    ),

    hist_cred = factor(
      hist_cred,
      levels = c("Regular","Bueno","Excelente")
    ),

    ingresos = factor(
      ingresos,
      levels = c("Medio","Alto")
    ),

    ahorros_cat = factor(
      ahorros_cat,
      levels = c("Bajo","Medio","Alto")
    )
  )

dim(datos)
str(datos)
head(datos, 8)

levels(datos$compra)
levels(datos$empleo)
levels(datos$hist_cred)
levels(datos$ingresos)
levels(datos$ahorros_cat)

contrasts(datos$compra)
contrasts(datos$empleo)
contrasts(datos$hist_cred)
contrasts(datos$ingresos)
contrasts(datos$ahorros_cat)

tbl_summary(datos,
            by = compra,
            statistic = list(all_continuous()  ~ "{mean} ({sd})",
                             all_categorical() ~ "{n} ({p}%)")) |>
  add_overall(last = TRUE) |>
  add_p() |>
  modify_caption("Tabla 1: Caracteristicas de los clientes segun aprobacion de hipoteca")

prop.table(table(datos$compra))

datos |>
  group_by(compra) |>
  plot_frq(hist_cred) |>
  plot_grid()

datos |>
  group_by(compra) |>
  plot_frq(ahorros_cat) |>
  plot_grid()

# --- Particion de datos ---
set.seed(8)
ind_train          <- createDataPartition(y = datos$compra, p = 0.7, list = FALSE)
base_entrenamiento <- datos[ind_train, ]
base_prueba        <- datos[-ind_train, ]

dim(base_entrenamiento)
dim(base_prueba)
dim(base_entrenamiento)[1] / dim(datos)[1]
dim(base_prueba)[1]        / dim(datos)[1]

prop.table(table(datos$compra))
prop.table(table(base_entrenamiento$compra))
prop.table(table(base_prueba$compra))

# --- Modelo Log-Binomial ---
modelo1 <- glm(
  compra ~ empleo + hist_cred + ingresos + ahorros_cat,
  data = base_entrenamiento,
  family = binomial(link = "log"),
  start = c(-1, 0, 0, 0, 0, 0, 0)
)

summary(modelo1)
cat("\n¿Convergio?:", modelo1$converged, "\n")

# --- Omnibus ---
deviance_model <- modelo1$deviance
deviance_base  <- modelo1$null.deviance
ji    <- deviance_base - deviance_model
ji_gl <- modelo1$df.null - modelo1$df.residual
pvalor <- pchisq(ji, df = ji_gl, lower.tail = FALSE)

cat("Chi2 =", round(ji, 4),
    "| gl =", ji_gl,
    "| p-valor =", format(pvalor, scientific = TRUE), "\n")

m0 <- glm(compra ~ 1,
          family = binomial(link = "log"),
          data   = base_entrenamiento,
          start  = c(log(0.40)))

lrtest0 <- lrtest(m0, modelo1)
lrtest0

mod_lrm <- lrm(formula = compra ~ empleo + hist_cred +
                 ingresos + ahorros_cat,
               data = base_entrenamiento, x = TRUE, y = TRUE)
mod_lrm

# --- Devianza marginal ---
p_base <- mean(as.numeric(base_entrenamiento$compra) - 1)

formulas_sin <- list(
  empleo      = compra ~ hist_cred + ingresos + ahorros_cat,
  hist_cred   = compra ~ empleo + ingresos + ahorros_cat,
  ingresos    = compra ~ empleo + hist_cred + ahorros_cat,
  ahorros_cat = compra ~ empleo + hist_cred + ingresos
)

resultados_dev <- data.frame()
for(v in names(formulas_sin)){
  
  mm <- model.matrix(formulas_sin[[v]], data = base_entrenamiento)
  nc <- ncol(mm)
  
  m_sin <- glm(
    formulas_sin[[v]],
    data = base_entrenamiento,
    family = binomial(link="log"),
    start = c(log(p_base), rep(0, nc-1))
  )

  delta_dev <- m_sin$deviance - modelo1$deviance
  gl <- m_sin$df.residual - modelo1$df.residual
  pv <- pchisq(delta_dev, gl, lower.tail = FALSE)

  resultados_dev <- rbind(
    resultados_dev,
    data.frame(
      Variable = v,
      Delta_Dev = round(delta_dev,3),
      gl = gl,
      p_valor = round(pv,4)
    )
  )
}
kable(resultados_dev,
      caption = "Reduccion de Devianza Marginal por Variable",
      col.names = c("Variable", "DeltaDevianza", "gl", "p-valor"))

regTermTest(modelo1, "empleo",         method = "Wald")
regTermTest(modelo1, "hist_cred", method = "Wald")
regTermTest(modelo1, "ingresos", method = "Wald")
regTermTest(modelo1, "ahorros_cat",    method = "Wald")

car::Anova(modelo1, type = 2, test.statistic = "Wald")

# --- Calibracion y validacion ---
calibracion <- rms::calibrate(mod_lrm, B = nrow(base_entrenamiento))
plot(calibracion)

llh     <- logLik(modelo1)[1]
llhNull <- logLik(m0)[1]
G2      <- -2 * (llhNull - llh)
n_train <- nrow(base_entrenamiento)

McFadden <- 1 - (llh / llhNull)
r2ML     <- 1 - exp(-G2 / n_train)
r2CU     <- r2ML / (1 - exp(2 * llhNull / n_train))

data.frame(
  Indice     = c("McFadden", "Cox-Snell", "Nagelkerke"),
  Valor      = round(c(McFadden, r2ML, r2CU), 4),
  Referencia = c("optimo: 0.2-0.4", "-", "optimo: 0.4-0.6")
) |>
  kable(caption = "Pseudo R-cuadrado del modelo log-binomial")

r2(modelo1)
model_performance(modelo1)

check_model(modelo1)

check_autocorrelation(modelo1)

check_dag(modelo1)

check_predictions(modelo1)

check_collinearity(modelo1)
plot(check_collinearity(modelo1))

check_overdispersion(modelo1)

# --- Importancia de variables ---
import <- varImp(modelo1)
orden  <- dplyr::arrange(import, desc(Overall))
orden

vip(modelo1, aesthetics = list(color = "steelblue", fill = "lightblue"))

car::Anova(modelo1, type = 2, test.statistic = "Wald")

rf_model <- randomForest(compra ~ empleo + hist_cred +
                           ingresos + ahorros_cat,
                         data = base_entrenamiento)

vip(rf_model, aesthetics = list(color = "darkorchid3", fill = "#A2CD5A"))

# --- RR e IC ---
summary(modelo1)$coef

exp(coef(modelo1))

exp(cbind(RR = coef(modelo1), confint.default(modelo1, level = 0.95)))

tbl_regression(modelo1,
               exponentiate           = TRUE,
               tidy_fun               = broom.helpers::tidy_parameters,
               add_pairwise_contrasts = TRUE,
               weights                = "prop",
               pairwise_reverse       = FALSE) |>
  add_significance_stars(hide_p = FALSE, hide_se = TRUE) |>
  modify_header(label = "**Predictor**") |>
  modify_caption("Tabla 3: Risk Ratios - Modelo Log-Binomial de Hipotecas") |>
  bold_labels() |>
  italicize_levels() |>
  bold_p()

plot_model(modelo1, show.values = TRUE, width = 0.1) +
  ylab('Aprobacion de Hipoteca - "Risk Ratio"')

# --- emmeans ---
emmeans(modelo1, pairwise ~ hist_cred,
        type = "response", infer = TRUE)

plot_model(modelo1, type = "eff", terms = "hist_cred")

emmeans(modelo1, ~ hist_cred, infer = TRUE) |>
  as_tibble() |>
  dplyr::select(hist_cred, emmean) |>
  mutate(prob = round(exp(emmean), 3),
         odds = round(exp(emmean) / (1 - exp(emmean)), 3)) |>
  kable(caption = "Probabilidades y Odds por historial crediticio")

emmeans(modelo1, ~ hist_cred, type = "response") |>
  pairs(reverse = TRUE, infer = TRUE)

emmeans(modelo1, pairwise ~ ahorros_cat,
        type = "response", infer = TRUE)

emmeans(modelo1, pairwise ~ empleo,
        type = "response", infer = TRUE)

emmeans(modelo1, pairwise ~ ingresos,
        type = "response", infer = TRUE)

fancy_plot <- ggeffect(modelo1) |> plot() |> plot_grid()
fancy_plot

marginalModelPlots(modelo1, col.line = c("#CD8162", "#3A5FCD"))

# --- Probabilidades y grupos estimados (entrenamiento) ---
proba.pred    <- predict(modelo1, type = "response")

umbral_optimo <- mean(base_entrenamiento$compra == "Compra_Hipoteca")
cat("Umbral basado en prevalencia (entrenamiento):", round(umbral_optimo, 3), "\n")

head(proba.pred, 10)

clase.pred <- ifelse(proba.pred >= umbral_optimo, "si", "no")
head(clase.pred, 10)

finaldata <- cbind(base_entrenamiento, proba.pred, clase.pred)
head(finaldata, 10)

a <- ggplot(finaldata, aes(x = proba.pred, fill = compra)) +
  geom_density(alpha = 0.7) +
  labs(title = "Densidad de probabilidades predichas",
       x = "Probabilidad estimada", fill = "Hipoteca") +
  theme_bw()

b <- ggplot(finaldata, aes(x = proba.pred, fill = compra)) +
  geom_histogram(alpha = 0.7, bins = 20) +
  labs(title = "Histograma de probabilidades predichas",
       x = "Probabilidad estimada", fill = "Hipoteca") +
  theme_bw()

a + b

# --- Indicadores con data de prueba ---

# Umbral Youden
proba.pred1 <- predict(modelo1, newdata = base_prueba, type = "response")

roc_test <- roc(
  response = base_prueba$compra, 
  predictor = proba.pred1, 
  levels = c("No_Compra", "Compra_Hipoteca")
)

optimo <- coords(roc_test, "best", 
                 ret = c("threshold", "specificity", "sensitivity", "accuracy"), 
                 best.method = "youden")

optimo

umbral_optimo <- as.numeric(optimo$threshold)
cat("\nEl nuevo umbral optimo a utilizar es:", round(umbral_optimo, 4))

clase.pred1 <- ifelse(
  proba.pred1 >= umbral_optimo,
  "Compra_Hipoteca",
  "No_Compra"
)

d2 <- base_prueba |>
  mutate(
    pred_probs = proba.pred1,
    pred_classes = factor(
      clase.pred1,
      levels = c("No_Compra","Compra_Hipoteca")
    ),
    compra = factor(
      compra,
      levels = c("No_Compra","Compra_Hipoteca")
    )
  )

table(d2$pred_classes)

c_plot <- ggplot(d2, aes(x = pred_probs, fill = compra)) +
  geom_density(alpha = 0.9) +
  labs(title = "Prueba - Densidad") + theme_bw()

d_plot <- ggplot(d2, aes(x = pred_probs, fill = compra)) +
  geom_histogram(alpha = 0.9, bins = 20) +
  labs(title = "Prueba - Histograma") + theme_bw()

(a + b) / (c_plot + d_plot)

table(clase.pred1, base_prueba$compra)

summary(proba.pred1)

min(proba.pred1)
max(proba.pred1)

hist(proba.pred1)

# Umbral basado en prevalencia real
umbral_real <- mean(base_prueba$compra == "Compra_Hipoteca")
cat("\nEl umbral basado en la proporcion real es:", round(umbral_real, 4), "\n")

clase.pred_real <- ifelse(
  proba.pred1 >= umbral_real,
  "Compra_Hipoteca",
  "No_Compra"
)

d_real <- base_prueba |>
  mutate(
    pred_probs = proba.pred1,
    pred_classes = factor(
      clase.pred_real,
      levels = c("No_Compra","Compra_Hipoteca")
    ),
    compra = factor(
      compra,
      levels = c("No_Compra","Compra_Hipoteca")
    )
  )

cat("Conteos reales (Data de Prueba):\n")
table(d_real$compra)

cat("\nProporciones reales (Data de Prueba):\n")
prop.table(table(d_real$compra))

cm_real <- xtabs(~ pred_classes + compra, data = d_real)

confusionMatrix(
  cm_real,
  mode = "everything",
  positive = "Compra_Hipoteca"
)

cm2 <- xtabs(~ pred_classes + compra, data = d2)

confusionMatrix(
  cm2,
  mode = "everything",
  positive = "Compra_Hipoteca"
)

accuracy <- mean(base_prueba$compra == clase.pred1)
error    <- 1 - accuracy
cat("Accuracy:", round(accuracy, 4), "\n")
cat("Error   :", round(error,    4), "\n")

NIR <- max(prop.table(table(base_prueba$compra)))
cat("NIR:", round(NIR, 4), "\n")
cat("Diferencia (Accuracy - NIR):", round(accuracy - NIR, 4), "\n")

n_correctas <- sum(base_prueba$compra == clase.pred1)
binom.test(x = n_correctas, n = nrow(base_prueba),
           p = NIR, alternative = "greater")

# --- Curva ROC y AUC ---
roc.curve(
  response = d2$compra,
  predicted = d2$pred_probs,
  lty = 2,
  lwd = 1.8,
  col = "blue",
  main = "Curva ROC - Hipotecas Log-Binomial")

colAUC(d2$pred_probs, d2$compra, plotROC = TRUE)
abline(0, 1, col = "tomato", lty = 4)

auc(roc_test)

# --- DOR, LR+, LR- ---
epi.tests(cm2[c(2,1), c(2,1)])

summary(epi.tests(cm2[c(2,1), c(2,1)]))

Sensitivity <- confusionMatrix(cm2, positive = "Compra_Hipoteca")$byClass["Sensitivity"]
Specificity <- confusionMatrix(cm2, positive = "Compra_Hipoteca")$byClass["Specificity"]
Precision   <- confusionMatrix(cm2, positive = "Compra_Hipoteca")$byClass["Pos Pred Value"]
VPneg       <- confusionMatrix(cm2, positive = "Compra_Hipoteca")$byClass["Neg Pred Value"]

(LRmas   <- Sensitivity / (1 - Specificity))
(LRmenos <- (1 - Sensitivity) / Specificity)
(DOR     <- LRmas / LRmenos)

(FPR <- 1 - Specificity)
(FNR <- 1 - Sensitivity)
(FDR <- 1 - Precision)
(FOR <- 1 - VPneg)

# --- Guardar y reutilizar modelo ---
saveRDS(modelo1, "./modelo_logbinomial.rds")

super_model <- readRDS("./modelo_logbinomial.rds")
print(super_model)

# --- Prediccion para nuevos clientes ---
summary(modelo1)

b0 <- coef(modelo1)["(Intercept)"]
b1 <- coef(modelo1)["empleoFijo"]
b2 <- coef(modelo1)["hist_credBueno"]
b3 <- coef(modelo1)["hist_credExcelente"]
b4 <- coef(modelo1)["ingresosAlto"]
b5 <- coef(modelo1)["ahorros_catMedio"]
b6 <- coef(modelo1)["ahorros_catAlto"]

nuevo1 <- data.frame(
  empleo = factor("Fijo",
                  levels = c("Independiente","Fijo")),
  hist_cred = factor("Excelente",
                     levels = c("Regular","Bueno","Excelente")),
  ingresos = factor("Alto",
                    levels = c("Medio","Alto")),
  ahorros_cat = factor("Alto",
                       levels = c("Bajo","Medio","Alto"))
)

predict(modelo1, nuevo1, type = "response")

z1 <- b0 + b1 + b3 + b4 + b6
ez1 <- exp(z1)
cat("log(p) manual         =", round(z1, 5), "\n")
cat("Probabilidad manual   =", round(ez1, 4), "\n")

p1 <- predict(modelo1, newdata = nuevo1, type = "response")
cat("Probabilidad predict  =", round(p1, 4), "\n")

log_p1 <- predict(modelo1, newdata = nuevo1, type = "link")
cat("Verificacion exp(link)=", round(exp(log_p1), 4), "\n")

cat("RR respecto al promedio:", round(p1 / mean(proba.pred), 3), "\n")

odds1 <- p1 / (1 - p1)
cat("Odds (cliente ideal)  =", round(odds1, 3), "\n")

nuevo2 <- data.frame(
  empleo = factor("Independiente",
                  levels = c("Independiente","Fijo")),
  hist_cred = factor("Regular",
                     levels = c("Regular","Bueno","Excelente")),
  ingresos = factor("Medio",
                    levels = c("Medio","Alto")),
  ahorros_cat = factor("Bajo",
                       levels = c("Bajo","Medio","Alto")))

z2 <- b0
cat("Probabilidad manual (perfil bajo) =", round(exp(z2), 4), "\n")

p2 <- predict(modelo1, newdata = nuevo2, type = "response")
cat("Probabilidad predict (perfil bajo)=", round(p2, 4), "\n")

log_p2 <- predict(modelo1, newdata = nuevo2, type = "link")
cat("Verificacion pexp(link)           =", round(exp(log_p2), 4), "\n")

odds2 <- p2 / (1 - p2)
cat("Odds (perfil bajo)                =", round(odds2, 3), "\n")

nuevos_clientes <- data.frame(
  empleo = factor(
    c("Fijo","Independiente","Fijo","Independiente"),
    levels = levels(base_entrenamiento$empleo)
  ),

  hist_cred = factor(
    c("Excelente","Regular","Bueno","Excelente"),
    levels = levels(base_entrenamiento$hist_cred)
  ),

  ingresos = factor(
    c("Alto","Medio","Alto","Alto"),
    levels = levels(base_entrenamiento$ingresos)
  ),

  ahorros_cat = factor(
    c("Alto","Bajo","Medio","Alto"),
    levels = levels(base_entrenamiento$ahorros_cat)
  )
)

nuevos_clientes$Probabilidad <- predict(super_model, nuevos_clientes, type = "response")

nuevos_clientes$Decision <- ifelse(
  nuevos_clientes$Probabilidad >= umbral_optimo, 
  "Aprobado", 
  "Rechazado"
)

kable(nuevos_clientes, digits = 3, caption = "Decision crediticia automatizada para 4 nuevos perfiles")


##############################################################################
# PREGUNTA 3: METODO MULTIVARIADO DE REGRESION POISSON ROBUSTO
##############################################################################

tribble(
  ~Atributo,           ~Descripcion,                                     ~Tipo,        ~Valores,
  "edad_meses",        "Edad del nino en meses",                         "Numerica",   "[6 a 59]",
  "sexo",              "Sexo del nino",                                  "Categorica", "Masculino / Femenino",
  "riqueza",           "Nivel socioeconomico del hogar",                 "Categorica", "Pobre / Medio / Rico",
  "suplemento_hierro", "Recibio suplemento de hierro (ultimos 6 meses)", "Categorica", "Si / No",
  "anemia",            "Presencia de anemia - Variable respuesta",       "Binaria",    "1: Si / 0: No"
) %>%
  kable(caption = "Definicion de variables del estudio") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)

set.seed(123)
n <- 1200

sexo              <- factor(sample(c("Masculino", "Femenino"), n, replace = TRUE))
riqueza           <- factor(sample(c("Pobre", "Medio", "Rico"), n, replace = TRUE))
suplemento_hierro <- factor(sample(c("Si", "No"), n, replace = TRUE))
edad_meses        <- round(runif(n, min = 6, max = 59))

beta0         <- -1.6
beta_sexoM    <- 0.20
beta_riqueza  <- c(Medio = 0.25, Pobre = 0.60)
beta_suple_no <- 0.70
beta_edad     <- -0.025

eta <- beta0 +
  ifelse(sexo == "Masculino", beta_sexoM, 0) +
  ifelse(riqueza == "Medio", beta_riqueza["Medio"],
         ifelse(riqueza == "Pobre", beta_riqueza["Pobre"], 0)) +
  ifelse(suplemento_hierro == "No", beta_suple_no, 0) +
  beta_edad * edad_meses

p <- exp(eta)
p[p > 0.95] <- 0.95

anemia <- rbinom(n, size = 1, prob = p)

datos <- data.frame(sexo, riqueza, suplemento_hierro, edad_meses, anemia)
write_csv(datos, "datos_anemia_1.csv")

datos <- read_csv("datos_anemia_1.csv")
head(datos, 6) %>% kable() %>% kable_styling(bootstrap_options = c("striped", "hover"))

datos <- datos %>%
  mutate(across(c(sexo, riqueza, suplemento_hierro), as.factor))
glimpse(datos)

datos$sexo              <- relevel(datos$sexo,              ref = "Femenino")
datos$riqueza            <- relevel(datos$riqueza,           ref = "Rico")
datos$suplemento_hierro <- relevel(datos$suplemento_hierro, ref = "Si")

contrasts(datos$sexo)
contrasts(datos$riqueza)
contrasts(datos$suplemento_hierro)

# --- Descriptivo ---
datos %>%
  count(sexo, anemia) %>%
  group_by(sexo) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = sexo, y = prop, fill = factor(anemia))) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("0" = "#2ca25f", "1" = "#de2d26"),
                     labels = c("No", "Si"), name = "Anemia") +
  scale_y_continuous(labels = scales::percent) +
  labs(x = "Sexo", y = "Proporcion", title = "Anemia segun sexo") +
  theme_minimal()

datos %>%
  count(riqueza, anemia) %>%
  group_by(riqueza) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = riqueza, y = prop, fill = factor(anemia))) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("0" = "#2ca25f", "1" = "#de2d26"),
                     labels = c("No", "Si"), name = "Anemia") +
  scale_y_continuous(labels = scales::percent) +
  labs(x = "Riqueza", y = "Proporcion", title = "Anemia segun nivel de riqueza") +
  theme_minimal()

datos %>%
  count(suplemento_hierro, anemia) %>%
  group_by(suplemento_hierro) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = suplemento_hierro, y = prop, fill = factor(anemia))) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("0" = "#2ca25f", "1" = "#de2d26"),
                     labels = c("No", "Si"), name = "Anemia") +
  scale_y_continuous(labels = scales::percent) +
  labs(x = "Suplemento de hierro", y = "Proporcion", title = "Anemia segun suplementacion de hierro") +
  theme_minimal()

datos %>%
  ggplot(aes(x = factor(anemia), y = edad_meses, fill = factor(anemia))) +
  geom_boxplot(show.legend = FALSE) +
  labs(x = "Anemia (0 = No, 1 = Si)", y = "Edad (meses)",
       title = "Distribucion de edad segun presencia de anemia") +
  theme_minimal()

# --- RR vs OR ---
tabla <- table(datos$riqueza, datos$anemia)
addmargins(tabla, margin = 2) %>%
  kable(caption = "Tabla de contingencia: Riqueza vs Anemia") %>%
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = FALSE)

riesgo_pobre <- tabla["Pobre", "1"] / sum(tabla["Pobre", ])
riesgo_rico  <- tabla["Rico",  "1"] / sum(tabla["Rico", ])
odds_pobre   <- tabla["Pobre", "1"] / tabla["Pobre", "0"]
odds_rico    <- tabla["Rico",  "1"] / tabla["Rico",  "0"]

data.frame(
  Medida = c("Riesgo Relativo (RR)", "Odds Ratio (OR)"),
  Valor  = round(c(riesgo_pobre / riesgo_rico, odds_pobre / odds_rico), 3)
) %>%
  kable(caption = "Comparacion RR vs OR - Pobre respecto a Rico") %>%
  kable_styling(bootstrap_options = c("striped", "hover"), full_width = FALSE)

# --- Modelo Poisson robusto ---
modelo <- glm(anemia ~ sexo + riqueza + suplemento_hierro + edad_meses,
              family = poisson(link = "log"), data = datos)
summary(modelo)

check_model(modelo)

ggeffect(modelo) |> plot() |> plot_grid()

se_robust <- sqrt(diag(sandwich(modelo)))
coeftest(modelo, vcov = sandwich)

est     <- coef(modelo)
RR_vals <- exp(est)
IC_inf  <- exp(est - 1.96 * se_robust)
IC_sup  <- exp(est + 1.96 * se_robust)

data.frame(
  Variable = names(RR_vals),
  RR       = round(RR_vals, 3),
  IC_inf   = round(IC_inf,  3),
  IC_sup   = round(IC_sup,  3),
  row.names = NULL
) %>%
  kable(caption = "Riesgos Relativos e IC 95% - Modelo Poisson Robusta") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))

nice_table <- tbl_regression(
  modelo,
  exponentiate           = TRUE,
  add_pairwise_contrasts = TRUE,
  weights                = "prop",
  pairwise_reverse       = FALSE
) |>
  add_significance_stars(hide_p = FALSE, hide_se = TRUE, hide_ci = FALSE) |>
  modify_header(label = "**Predictor**") |>
  modify_caption("Tabla 1. Riesgos Relativos - Regresion Poisson con Varianza Robusta") |>
  modify_footnote(abbreviation = TRUE) |>
  bold_labels() |>
  italicize_levels() |>
  bold_p()

nice_table

emmeans(modelo, pairwise ~ riqueza,
        type = "response", infer = TRUE)

emmeans(modelo, pairwise ~ suplemento_hierro,
        type = "response", infer = TRUE)

emmeans(modelo, pairwise ~ sexo,
        type = "response", infer = TRUE)


##############################################################################
# PREGUNTA 4: REGRESION LOGISTICA MULTINOMIAL
##############################################################################

set.seed(2026)
iteraciones <- 1
exito <- FALSE
N_por_grupo <- 400

while(iteraciones <= 100 && !exito) {

  edad_ds <- round(rnorm(N_por_grupo, mean = 28, sd = 4))
  ds <- data.frame(
    Programa = rep("Data Science", N_por_grupo),
    Edad = edad_ds,
    Ingreso_Mensual = round((edad_ds * 80) + rnorm(N_por_grupo, 1000, 800)),
    Puntaje_Aptitud_Cuantitativa = round(rnorm(N_por_grupo, 78, 10)),
    Horas_Semanales_Disponibles = round(rnorm(N_por_grupo, 24, 7)),
    Experiencia_Previa = sample(c("Si", "No"), N_por_grupo, replace = TRUE, prob = c(0.55, 0.45)),
    Carrera_Origen = sample(c("Ingenieria", "Negocios/Administracion", "Letras/Comunicaciones"),
                            N_por_grupo, replace = TRUE, prob = c(0.50, 0.30, 0.20))
  )

  edad_mkt <- round(rnorm(N_por_grupo, mean = 26, sd = 3))
  mkt <- data.frame(
    Programa = rep("Marketing Digital", N_por_grupo),
    Edad = edad_mkt,
    Ingreso_Mensual = round((edad_mkt * 60) + rnorm(N_por_grupo, 500, 600)),
    Puntaje_Aptitud_Cuantitativa = round(rnorm(N_por_grupo, 65, 10)),
    Horas_Semanales_Disponibles = round(rnorm(N_por_grupo, 20, 6)),
    Experiencia_Previa = sample(c("Si", "No"), N_por_grupo, replace = TRUE, prob = c(0.40, 0.60)),
    Carrera_Origen = sample(c("Ingenieria", "Negocios/Administracion", "Letras/Comunicaciones"),
                            N_por_grupo, replace = TRUE, prob = c(0.20, 0.30, 0.50))
  )

  edad_fin <- round(rnorm(N_por_grupo, mean = 30, sd = 4))
  fin <- data.frame(
    Programa = rep("Finanzas Corporativas", N_por_grupo),
    Edad = edad_fin,
    Ingreso_Mensual = round((edad_fin * 100) + rnorm(N_por_grupo, 1500, 900)),
    Puntaje_Aptitud_Cuantitativa = round(rnorm(N_por_grupo, 72, 9)),
    Horas_Semanales_Disponibles = round(rnorm(N_por_grupo, 16, 5)),
    Experiencia_Previa = sample(c("Si", "No"), N_por_grupo, replace = TRUE, prob = c(0.70, 0.30)),
    Carrera_Origen = sample(c("Ingenieria", "Negocios/Administracion", "Letras/Comunicaciones"),
                            N_por_grupo, replace = TRUE, prob = c(0.20, 0.60, 0.20))
  )

  df_programas <- bind_rows(ds, mkt, fin)

  df_programas$Puntaje_Aptitud_Cuantitativa <- ifelse(df_programas$Puntaje_Aptitud_Cuantitativa > 100, 100, df_programas$Puntaje_Aptitud_Cuantitativa)
  df_programas$Horas_Semanales_Disponibles <- ifelse(df_programas$Horas_Semanales_Disponibles < 0, 0, df_programas$Horas_Semanales_Disponibles)

  df_programas <- df_programas %>%
    mutate(across(c(Programa, Experiencia_Previa, Carrera_Origen), as.factor))

  df_programas$Programa <- relevel(df_programas$Programa, ref = "Marketing Digital")

  invisible(capture.output(mod_test <- multinom(Programa ~ ., data = df_programas, trace = FALSE)))
  predicciones <- predict(mod_test, df_programas)
  acc <- mean(predicciones == df_programas$Programa)

  mod_vif <- lm(Edad ~ Ingreso_Mensual + Puntaje_Aptitud_Cuantitativa + Horas_Semanales_Disponibles, data = df_programas)
  max_vif <- max(vif(mod_vif))

  if(acc > 0.70 && acc < 0.88 && max_vif < 5) {
    exito <- TRUE
  } else {
    iteraciones <- iteraciones + 1
  }
}

rm(ds, mkt, fin, edad_ds, edad_mkt, edad_fin,
   mod_test, mod_vif, predicciones, acc, max_vif,
   iteraciones, exito, N_por_grupo)
gc()

str(df_programas)
head(df_programas)
summary(df_programas)
table(df_programas$Programa)

contrasts(df_programas$Programa)
contrasts(df_programas$Carrera_Origen)
contrasts(df_programas$Experiencia_Previa)

tabla_desc <- tbl_summary(
  df_programas,
  by = Programa,
  statistic = all_continuous() ~ "{mean} ({sd})"
) %>%
  add_overall() %>%
  modify_caption("**Tabla 1: Perfil de Postulantes por Programa de Especializacion**")

tabla_desc

plot_carrera <- ggbarstats(
  data = df_programas,
  x = Programa,
  y = Carrera_Origen,
  label = "both",
  title = "Distribucion de Eleccion de Programa segun Carrera de Origen",
  legend.title = "Programa Matriculado"
)

plot_exp <- ggbarstats(
  data = df_programas,
  x = Programa,
  y = Experiencia_Previa,
  label = "both",
  title = "Impacto de la Experiencia Previa en la Eleccion",
  legend.title = "Programa Matriculado"
)

plot_carrera
plot_exp

p_edad <- ggplot(df_programas, aes(x = Programa, y = Edad, fill = Programa)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title = "Edad del Postulante", x = "", y = "Anos")

p_ingreso <- ggplot(df_programas, aes(x = Programa, y = Ingreso_Mensual, fill = Programa)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title = "Ingreso Mensual", x = "", y = "Dolares")

p_puntaje <- ggplot(df_programas, aes(x = Programa, y = Puntaje_Aptitud_Cuantitativa, fill = Programa)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title = "Aptitud Cuantitativa", x = "", y = "Puntos (0-100)")

p_horas <- ggplot(df_programas, aes(x = Programa, y = Horas_Semanales_Disponibles, fill = Programa)) +
  geom_boxplot(alpha = 0.7) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title = "Horas Disponibles", x = "", y = "Horas/Semana")

panel_numericas <- (p_edad | p_ingreso) / (p_puntaje | p_horas) +
  plot_annotation(
    title = "Comparativa de Variables Continuas por Programa",
    theme = theme(plot.title = element_text(size = 16, face = "bold"))
  )

panel_numericas

plot_correlacion <- ggcorrmat(
  data = df_programas,
  type = "pearson",
  colors = c("#E46726", "white", "darkgreen"),
  title = "Matriz de Correlacion: Variables Numericas"
)

plot_correlacion

# --- Outliers ---
datos_numericos <- as.data.frame(df_programas)[, c("Edad", "Ingreso_Mensual",
                                                   "Puntaje_Aptitud_Cuantitativa",
                                                   "Horas_Semanales_Disponibles")]

matriz_transpuesta <- t(as.matrix(datos_numericos))
prueba_shapiro_multi <- mshapiro.test(matriz_transpuesta)
prueba_shapiro_multi

centroide <- colMeans(datos_numericos)
matriz_cov <- cov(datos_numericos)

df_programas$Mahalanobis <- mahalanobis(datos_numericos, center = centroide, cov = matriz_cov)

grados_libertad <- ncol(datos_numericos)
umbral_outlier <- qchisq(p = 0.999, df = grados_libertad)

df_programas$Es_Outlier <- ifelse(df_programas$Mahalanobis > umbral_outlier, "Si", "No")
table(df_programas$Es_Outlier)

# --- Particion ---
set.seed(2026)
indice_train <- createDataPartition(df_programas$Programa, p = 0.7, list = FALSE)

data_train <- df_programas[indice_train, ]
data_test  <- df_programas[-indice_train, ]

table(data_train$Programa)
table(data_test$Programa)

# --- Prueba de Brant ---
data_train$Programa_Ord <- factor(data_train$Programa, ordered = TRUE)

modelo_ordinal_prov <- polr(Programa_Ord ~ Edad + Ingreso_Mensual +
                              Puntaje_Aptitud_Cuantitativa + Horas_Semanales_Disponibles +
                              Experiencia_Previa + Carrera_Origen,
                            data = data_train, Hess = TRUE)

prueba_brant <- brant(modelo_ordinal_prov)
prueba_brant

data_train$Programa_Ord <- NULL

# --- Modelo de diagnostico ---
modelo_diagnostico <- multinom(Programa ~ Edad + Ingreso_Mensual +
                                 Puntaje_Aptitud_Cuantitativa +
                                 Horas_Semanales_Disponibles +
                                 Experiencia_Previa + Carrera_Origen,
                               data = data_train, trace = FALSE)

summary(modelo_diagnostico)

# --- VIF ---
modelo_auxiliar <- lm(as.numeric(Programa) ~ Edad + Ingreso_Mensual +
                        Puntaje_Aptitud_Cuantitativa + Horas_Semanales_Disponibles +
                        Experiencia_Previa + Carrera_Origen, data = data_train)

vif_resultados <- car::vif(modelo_auxiliar)
vif_resultados

# --- IIA ---
df_idx <- dfidx(data_train, choice = "Programa", shape = "wide")

mod_completo <- mlogit(Programa ~ 1 | Edad + Ingreso_Mensual +
                         Puntaje_Aptitud_Cuantitativa + Horas_Semanales_Disponibles +
                         Experiencia_Previa + Carrera_Origen, data = df_idx)

data_train_rest <- subset(data_train, Programa != "Data Science")
data_train_rest$Programa <- droplevels(data_train_rest$Programa)
df_idx_rest <- dfidx(data_train_rest, choice = "Programa", shape = "wide")

mod_rest <- mlogit(Programa ~ 1 | Edad + Ingreso_Mensual +
                     Puntaje_Aptitud_Cuantitativa + Horas_Semanales_Disponibles +
                     Experiencia_Previa + Carrera_Origen, data = df_idx_rest)

prueba_iia <- hmftest(mod_completo, mod_rest)
prueba_iia

# --- Stepwise ---
modelo_completo <- modelo_diagnostico
modelo_nulo <- multinom(Programa ~ 1, data = data_train, trace = FALSE)

mod_backward <- stepAIC(modelo_completo, direction = "backward", trace = FALSE)

mod_forward <- stepAIC(modelo_nulo,
                       scope = formula(modelo_completo),
                       direction = "forward", trace = FALSE)

mod_both <- stepAIC(modelo_completo, direction = "both", trace = FALSE)

tabla_aic <- data.frame(
  Metodo_Stepwise = c("Backward", "Forward", "Both (Bidireccional)"),
  AIC = c(AIC(mod_backward), AIC(mod_forward), AIC(mod_both)),
  Formula_Resultante = c(Reduce(paste, deparse(formula(mod_backward))),
                         Reduce(paste, deparse(formula(mod_forward))),
                         Reduce(paste, deparse(formula(mod_both))))
)

tabla_aic

modelo_optimizado <- mod_both

# --- Significacion global ---
prueba_global <- anova(modelo_nulo, modelo_optimizado, test = "Chisq")
prueba_global

# --- Wald individual ---
prueba_individual <- car::Anova(modelo_optimizado, type = "II", test = "Wald")
prueba_individual

# --- Odds Ratios ---
tabla_or <- tbl_regression(modelo_optimizado, exponentiate = TRUE) %>%
  modify_caption("**Tabla 2: Resultados del Modelo Multinomial Optimizado (Odds Ratios)**")

tabla_or

# --- Evaluacion (data de prueba) ---
predicciones_test <- predict(modelo_optimizado, newdata = data_test)

matriz_confusion <- confusionMatrix(predicciones_test, data_test$Programa)
matriz_confusion

# --- Metricas avanzadas ---
metricas_base <- as.data.frame(matriz_confusion$byClass)

metricas_avanzadas <- metricas_base %>%
  mutate(
    `Positive Likelihood Ratio (LR+)` = Sensitivity / (1 - Specificity),
    `Negative Likelihood Ratio (LR-)` = (1 - Sensitivity) / Specificity,
    `Diagnostic Odds Ratio (DOR)` = `Positive Likelihood Ratio (LR+)` / `Negative Likelihood Ratio (LR-)`
  ) %>%
  dplyr::select(Sensitivity, Specificity, `Pos Pred Value`,
                `Positive Likelihood Ratio (LR+)`,
                `Negative Likelihood Ratio (LR-)`,
                `Diagnostic Odds Ratio (DOR)`)

print(round(metricas_avanzadas, 3))

# --- Curvas ROC ---
probs_test_final <- predict(modelo_optimizado, newdata = data_test, type = "probs")

roc_ds <- roc(ifelse(data_test$Programa == "Data Science", 1, 0),
              probs_test_final[, "Data Science"], quiet = TRUE)

roc_mkt <- roc(ifelse(data_test$Programa == "Marketing Digital", 1, 0),
               probs_test_final[, "Marketing Digital"], quiet = TRUE)

roc_fin <- roc(ifelse(data_test$Programa == "Finanzas Corporativas", 1, 0),
               probs_test_final[, "Finanzas Corporativas"], quiet = TRUE)

plot(roc_ds, col = "#E41A1C", main = "Curvas ROC (One-vs-Rest) - Modelo Optimizado",
     lwd = 2.5, legacy.axes = TRUE)
plot(roc_mkt, col = "#377EB8", add = TRUE, lwd = 2.5)
plot(roc_fin, col = "#4DAF4A", add = TRUE, lwd = 2.5)

legend("bottomright",
       legend = c(paste("Data Science (AUC =", round(auc(roc_ds), 3), ")"),
                  paste("Marketing Digital (AUC =", round(auc(roc_mkt), 3), ")"),
                  paste("Finanzas Corporativas (AUC =", round(auc(roc_fin), 3), ")")),
       col = c("#E41A1C", "#377EB8", "#4DAF4A"), lwd = 2.5, bty = "n")

# --- AME ---
efectos_marginales <- avg_slopes(modelo_optimizado)
summary(efectos_marginales)

# --- Curvas de probabilidad predicha ---
plot_predictions(modelo_optimizado,
                 condition = c("Puntaje_Aptitud_Cuantitativa", "group")) +
  theme_minimal() +
  labs(title = "Evolucion de la Decision segun la Aptitud Cuantitativa",
       subtitle = "Probabilidad predicha de matricula para cada programa",
       y = "Probabilidad Predicha (0 a 1)",
       x = "Puntaje de Aptitud Cuantitativa",
       color = "Programa Matriculado",
       fill = "Programa Matriculado") +
  theme(legend.position = "bottom",
        plot.title = element_text(face = "bold"))

# --- Importancia de variables ---
importancia_vars <- varImp(modelo_optimizado)

importancia_df <- as.data.frame(importancia_vars) %>%
  rownames_to_column(var = "Variable") %>%
  arrange(desc(Overall))

print(importancia_df)

ggplot(importancia_df, aes(x = reorder(Variable, Overall), y = Overall)) +
  geom_col(fill = "#2C3E50", alpha = 0.8) +
  coord_flip() +
  labs(title = "Ranking de Importancia de los Predictores",
       subtitle = "Basado en el valor absoluto del estadistico de Wald",
       x = "Variables Predictoras",
       y = "Nivel de Importancia Global") +
  theme_minimal()

rf_modelo <- randomForest(Programa ~ Edad + Ingreso_Mensual + Puntaje_Aptitud_Cuantitativa +
                            Horas_Semanales_Disponibles + Experiencia_Previa + Carrera_Origen,
                          data = data_train)

vip(rf_modelo, title = "Importancia de Variables (Random Forest)",
    aesthetics = list(fill = "#18BC9C")) +
  theme_minimal()


##############################################################################
# PREGUNTA 5: REGRESION LOGISTICA ORDINAL CON ODDS PROPORCIONALES
##############################################################################

library(haven)
library(ggeffects)
library(performance)
library(DHARMa)
library(cardx)
library(tidyverse)
library(sjPlot)
library(gtsummary)
library(readxl)
library(MASS)
library(brant)
library(broom.helpers)
library(see)
library(insight)
library(car)
library(randomForest)
library(vip)

set.seed(77)

n <- 150
estudiante <- 1:n

beca <- rbinom(n, size = 1, prob = 0.5)

inasistencias <- rpois(n, lambda = 3)

beta_beca           <- 1.2
beta_inasistencias  <- -0.25

zeta <- c(-1.5, 0.5, 2.0)

eta <- beta_beca * beca + beta_inasistencias * inasistencias

p_c1 <- plogis(zeta[1] - eta)
p_c2 <- plogis(zeta[2] - eta)
p_c3 <- plogis(zeta[3] - eta)

p_deficiente    <- p_c1
p_regular       <- p_c2 - p_c1
p_bueno         <- p_c3 - p_c2
p_sobresaliente <- 1 - p_c3

desempeno_num <- vapply(seq_len(n), function(i) {
  sample(1:4, size = 1,
         prob = c(p_deficiente[i], p_regular[i], p_bueno[i], p_sobresaliente[i]))
}, numeric(1))

desempeno <- factor(desempeno_num, levels = 1:4,
                     labels = c("deficiente", "regular", "bueno", "sobresaliente"))

odata <- data.frame(estudiante, desempeno = as.character(desempeno), beca, inasistencias)

head(odata)
str(odata)
dim(odata)

head(odata, 10)

table(odata$desempeno)
prop.table(table(odata$desempeno)) * 100

table(odata$beca)
prop.table(table(odata$beca)) * 100

summary(odata$inasistencias)
sd(odata$inasistencias)

odata %>%
  group_by(desempeno) %>%
  summarise(
    n = n(),
    media_inasistencias = mean(inasistencias),
    sd_inasistencias = sd(inasistencias)
  )

odata$desempeno <- factor(odata$desempeno,
                           levels = c("deficiente", "regular", "bueno", "sobresaliente"),
                           ordered = TRUE)

odata$beca <- factor(odata$beca, levels = c(0, 1), labels = c("Sin beca", "Con beca"))

str(odata)
summary(odata)

view_df(odata, show.frq = TRUE, show.prc = TRUE, show.na = TRUE)

odata %>%
  plot_frq(desempeno)

odata %>%
  group_by(desempeno) %>%
  plot_frq(beca) %>%
  plot_grid()

odata %>%
  dplyr::select(-estudiante) %>%
  tbl_summary(by = desempeno,
              statistic = all_continuous() ~ "{mean} ({sd})") %>%
  add_p() %>%
  add_ci() %>%
  modify_header(label ~ "**Variable**") %>%
  bold_labels()

# --- Modelo de Regresion Logistica Ordinal ---
model <- polr(desempeno ~ beca + inasistencias, data = odata, Hess = TRUE)
summary(model)

ggeffect(model) %>%
  plot() %>%
  plot_grid()

model_performance(model)

rl_table <- tbl_regression(model, tidy_fun = broom.helpers::tidy_parameters)
rl_table

rl_table1 <- tbl_regression(model, intercept = TRUE,
                             tidy_fun = broom.helpers::tidy_parameters)
rl_table1

rl_table2 <- tbl_regression(model, exponentiate = TRUE,
                             tidy_fun = broom.helpers::tidy_parameters)
rl_table2

plot_model(model)

plot_model(model, show.intercept = TRUE, show.values = TRUE, width = 0.1) +
  ylab("ODDS RATIO")

tab_model(model,
          show.reflvl = TRUE,
          show.intercept = FALSE,
          p.style = "numeric_stars")

# --- Verificacion de supuestos ---
check_model(model, residual_type = "normal")

check_predictions(model)

check_collinearity(model)
plot(check_collinearity(model))

car::vif(model)

# --- Significancia de los coeficientes ---
coefs <- coef(model)
coefs

ctable <- round(coef(summary(model)), 4)

N <- dim(odata)[1]
K <- dim(odata)[2] - 1

p <- pt(abs(ctable[, "t value"]), N - K, lower.tail = FALSE) * 2

(ctable <- cbind(ctable, "p value" = round(p, 4)))

# --- Intervalos de confianza y Odds Ratios ---
ci <- round(confint(model), 4)

or <- round(coef(model), 4)

round(exp(cbind(OR = or, ci)), 4)

exp(coefs)

(exp(coefs) - 1) * 100

exp(model$zeta)

# --- Prueba de Brant ---
brant(model)

# --- Importancia de variables ---
car::Anova(model)

set.seed(77)
rf <- randomForest(desempeno ~ beca + inasistencias, data = odata, importance = TRUE)

vip(rf)

# --- Clasificacion y prediccion ---
names(odata)
predictdesempeno <- predict(model, odata)
table(predictdesempeno, odata$desempeno, dnn = c("Predicho", "Observado"))

mean(as.character(odata$desempeno) == as.character(predictdesempeno))

mean(as.character(odata$desempeno) != as.character(predictdesempeno))

cm <- caret::confusionMatrix(predictdesempeno, odata$desempeno)
print(cm)

##############################################################################
# FIN DEL SCRIPT
##############################################################################
