# Modelamiento Logístico Avanzado y Regresión Multivariada 📈

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Quarto](https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white)
![Data Science](https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white)

Bienvenido a esta colección de modelos de regresión para variables respuesta categóricas y de conteo. Este repositorio demuestra la implementación de cinco enfoques de modelamiento logístico avanzado, desde la regresión binaria clásica hasta modelos multinomiales, ordinales y robustos, evaluando cuándo cada técnica es estadísticamente apropiada.

---

## 🎯 Enfoque del Repositorio

Seleccionar el modelo de regresión óptimo según la naturaleza de la variable respuesta (binaria, multinomial, ordinal, conteo), validar supuestos de convergencia y calibración, e interpretar medidas de efecto (OR, RR, IRR) con intervalos de confianza robustos para la toma de decisiones basada en evidencia.

---

## 📁 Estructura del Repositorio

```text
Applied-Multivariate-Analysis/Final
│
├── 📖 README.md
├── 📂 notebooks/
│   └── 🧪 Final - Grupo 1.qmd
│
├── 📂 data/
│   ├── 🎓 data_abandono_estudiantil.csv
│   ├── 🏦 datos_hipotecas_final.csv
│   └── 🩺 datos_anemia_1.csv
│
├── 📂 scripts/
│   └── 💻 Codigo_Completo_Final.R
│
├── 📦 modelos/
│   ├── modelo_logit.rds
│   └── modelo_logbinomial.rds
│
└── ⚙️ .gitignore
```

---

## 📂 Casos de Estudio y Arquitectura de Datos

### 1. Regresión Logística Binaria — Abandono Estudiantil

**Contexto:** Identificación de factores asociados al abandono durante el primer año de estudios universitarios, con el objetivo de diseñar estrategias de retención temprana.

**Dataset:** `data_abandono_estudiantil.csv` (n = 700 estudiantes simulados con distribución realista)

**Variables:**
- Respuesta: `abandono` (No / Sí) — prevalencia ≈ 31%
- Predictores: `promedio_previo`, `asistencia_pct`, `horas_estudio`, `materias_reprobadas`, `beca`, `trabaja`, `nivel_socioeconomico`

**Metodología:**
- Partición 70/30 estratificada con `createDataPartition`
- Selección de variables vía StepAIC (backward, forward, both)
- Pruebas de significancia: Ómnibus (LR Test), Wald individual, Devianza marginal
- Calibración: Hosmer-Lemeshow + Bootstrap (110 repeticiones con `rms::calibrate`)
- Pseudo R²: McFadden, Cox-Snell, Nagelkerke

**Hallazgo clave:** `materias_reprobadas` (OR = 1.91) y `trabaja` (OR = 2.35) son los principales factores de riesgo. `beca` (OR = 0.32) y `promedio_previo` (OR = 0.80) actúan como factores protectores. AUC = 0.785 con umbral óptimo de Youden = 0.265 (Sensibilidad = 81.5%, Especificidad = 61.1%).

---

### 2. Regresión Log-Binomial — Aprobación de Hipotecas

**Contexto:** Modelado de la probabilidad de aprobación de hipotecas según perfil financiero del solicitante, con estimación directa de Risk Ratios (RR) en lugar de Odds Ratios.

**Dataset:** `datos_hipotecas_final.csv` (n = 1,000 solicitantes)

**Variables:**
- Respuesta: `compra` (No_Compra / Compra_Hipoteca) — prevalencia ≈ 43%
- Predictores: `empleo`, `hist_cred`, `ingresos`, `ahorros_cat`

**Justificación metodológica:** Con prevalencia > 10%, el OR sobreestima groseramente el efecto real. El modelo Log-Binomial estima RR directamente mediante enlace log con distribución Binomial.

**Metodología:**
- Valores iniciales calibrados (`start`) para garantizar convergencia en espacio paramétrico restringido
- Validación de supuestos: VIF, autocorrelación, sobredispersión, observaciones influyentes
- Umbral óptimo: Índice de Youden (0.4899) vs. prevalencia (0.4314)

**Hallazgo clave:** `hist_credExcelente` (RR = 1.72), `empleoFijo` (RR = 1.63) e `ingresosAlto` (RR = 1.61) son los predictores más fuertes. AUC = 0.701 con Especificidad = 84.1% y DOR = 5.72. El perfil ideal alcanza 97.1% de probabilidad de aprobación.

---

### 3. Regresión Poisson Robusta — Anemia Infantil

**Contexto:** Identificación de factores determinantes de anemia en niños menores de 5 años mediante estimación de Incidence Rate Ratios (IRR) con errores estándar robustos (sandwich).

**Dataset:** `datos_anemia_1.csv` (n = 1,200 niños simulados con modelo de logit acumulados)

**Variables:**
- Respuesta: `anemia` (0 / 1) — prevalencia ≈ 20.5%
- Predictores: `sexo`, `riqueza`, `suplemento_hierro`, `edad_meses`

**Justificación metodológica:** Al aplicar Poisson sobre variable binaria se viola el supuesto de equidispersión. Los errores estándar robustos (sandwich) corrigen la sobredispersión y producen inferencias válidas.

**Metodología:**
- Categorías de referencia: Femenino, Rico, Sí suplemento (menor riesgo esperado)
- Diagnósticos visuales: Posterior Predictive Check, Binned Residuals, VIF
- Comparaciones por pares con `emmeans` y ajuste por Tukey

**Hallazgo clave:** `suplemento_hierroNo` (IRR = 2.31, IC 95% [1.81–2.95]) es el factor de mayor impacto. `riquezaPobre` (IRR = 1.75) muestra que la brecha es umbral, no gradiente. `edad_meses` reduce el riesgo 2.1% por mes adicional (IRR = 0.979). `sexo` no es significativo (p = 0.614).

---

### 4. Regresión Logística Multinomial — Elección de Programa de Especialización

**Contexto:** Predicción de la elección entre tres programas de posgrado (Data Science, Marketing Digital, Finanzas Corporativas) según perfil sociodemográfico y académico del postulante.

**Dataset:** Datos simulados (n = 1,200 postulantes, 400 por programa, 4 cohortes históricas)

**Variables:**
- Respuesta: `Programa` (3 categorías nominales sin orden jerárquico) — referencia: Marketing Digital
- Predictores: `Edad`, `Ingreso_Mensual`, `Puntaje_Aptitud_Cuantitativa`, `Horas_Semanales_Disponibles`, `Experiencia_Previa`, `Carrera_Origen`

**Justificación metodológica:** Prueba de Brant rechazó el supuesto de probabilidades proporcionales (χ² = 355.80, p ≈ 0), invalidando la regresión ordinal. Prueba de Hausman-McFadden confirmó el supuesto IIA (p = 1).

**Metodología:**
- Selección de variables: StepAIC convergió en las 3 direcciones, eliminando `Edad` (absorbida por `Ingreso_Mensual`, r = 0.56)
- Contraste global: LR Test (χ² = 1058.02, df = 12, p ≈ 0)
- Importancia comparada: Wald vs. Random Forest (disociación metodológica clásica)
- Efectos marginales promedio (AME) con `marginaleffects::avg_slopes`

**Hallazgo clave:** Accuracy = 83.89%, Kappa = 0.758. Marketing Digital alcanza DOR = 187.77 y AUC = 0.980. El `Puntaje_Aptitud_Cuantitativa` estructura la narrativa de decisión: Marketing (< 50 pts), Finanzas (50–67 pts), Data Science (> 72 pts). Zona de ambigüedad entre Data Science y Finanzas alrededor de los 67 puntos.

---

### 5. Regresión Logística Ordinal — Desempeño Académico

**Contexto:** Análisis del impacto de contar con beca y las inasistencias sobre el desempeño académico ordinal (deficiente, regular, bueno, sobresaliente) bajo el supuesto de odds proporcionales.

**Dataset:** Datos simulados con modelo de logit acumulados (n = 150 estudiantes, seed = 77)

**Variables:**
- Respuesta: `desempeno` (4 categorías ordenadas: deficiente < regular < bueno < sobresaliente)
- Predictores: `beca` (binaria), `inasistencias` (conteo)

**Metodología:**
- Ajuste con `MASS::polr` y `Hess = TRUE` para cálculo de errores estándar
- Verificación formal del supuesto de odds proporcionales mediante prueba de Brant
- Cálculo manual de p-valores con distribución t de Student (N − K gl)
- Importancia comparada: Anova Tipo II vs. Random Forest (MeanDecreaseGini)

**Hallazgo clave:** Prueba de Brant confirma el supuesto de odds proporcionales (p omnibus = 0.993, p beca = 0.926, p inasistencias = 0.966). `beca` (OR = 4.91) aumenta 390.8% los odds de mejor desempeño. `inasistencias` (OR = 0.64) reduce 36.5% los odds por cada falta adicional. Pseudo R² Nagelkerke ≈ 0.29.

---

## 🛠️ Stack Tecnológico

| Categoría | Herramientas |
|---|---|
| Lenguaje | R |
| Modelamiento Binario | `MASS`, `rms`, `stats` (glm) |
| Modelamiento Ordinal | `MASS` (polr), `brant`, `ordinal` |
| Modelamiento Multinomial | `nnet` (multinom), `mlogit`, `dfidx` |
| Modelamiento Robusto | `sandwich`, `lmtest` (coeftest) |
| Manipulación y Visualización | `tidyverse`, `dplyr`, `ggplot2`, `GGally`, `sjPlot`, `ggeffects` |
| Validación y Métricas | `caret`, `pROC`, `ROSE`, `caTools`, `epiR`, `performance`, `DHARMa` |
| Selección de Variables | `car` (Anova, VIF), `randomForest`, `vip` |
| Reportes y Tablas | Quarto / RMarkdown (`knitr`, `kableExtra`, `gtsummary`, `broom.helpers`) |
| Efectos Marginales | `marginaleffects`, `emmeans` |

---

## 💡 Flujo de Trabajo (Pipeline)

### Para Regresión Logística Binaria / Log-Binomial
1. **Preparación:** Definir categorías de referencia con `relevel()` y `contrasts()`
2. **Partición:** División 70/30 estratificada con `createDataPartition`
3. **Ajuste del modelo:** `glm()` con familia `binomial(link = "logit")` o `binomial(link = "log")`
4. **Validación de supuestos:**
   - Multicolinealidad (VIF < 5)
   - Sobredispersión (ratio ≈ 1)
   - Observaciones influyentes (distancia de Cook)
   - Autocorrelación de residuos
5. **Significancia:** Prueba Ómnibus (LR Test), Wald individual, Devianza marginal
6. **Calibración:** Hosmer-Lemeshow + Bootstrap con `rms::calibrate`
7. **Interpretación:** OR/RR con IC 95%, efectos marginales con `emmeans`
8. **Evaluación:** Matriz de confusión, AUC, Índice de Youden, DOR, LR+, LR−

### Para Regresión Poisson Robusta
1. **Preparación:** Categorías de referencia (menor riesgo esperado)
2. **Ajuste:** `glm()` con familia `poisson(link = "log")`
3. **Diagnóstico visual:** Posterior Predictive Check, Binned Residuals
4. **Corrección de sobredispersión:** Errores estándar robustos (sandwich)
5. **Inferencia:** `coeftest()` con `vcov = sandwich`
6. **Interpretación:** IRR con IC 95%, comparaciones por pares con `emmeans`

### Para Regresión Logística Multinomial
1. **Justificación:** Prueba de Brant (descarta ordinal) + Prueba IIA (Hausman-McFadden)
2. **Ajuste:** `nnet::multinom()` con `trace = FALSE`
3. **Validación:** VIF, selección de variables con StepAIC
4. **Contrastes:** LR Test global, Wald individual (Anova Tipo II)
5. **Interpretación:** OR por cada logit vs. categoría base, AME con `avg_slopes`
6. **Evaluación:** Matriz de confusión, DOR por clase, curvas ROC one-vs-rest

### Para Regresión Logística Ordinal
1. **Preparación:** Factor ordenado con `ordered = TRUE`
2. **Ajuste:** `MASS::polr()` con `Hess = TRUE`
3. **Verificación formal:** Prueba de Brant (odds proporcionales)
4. **Significancia:** Valor t + p-valor manual (distribución t)
5. **Interpretación:** OR acumulados, puntos de corte (zeta)
6. **Validación cruzada:** Anova Tipo II vs. Random Forest (MeanDecreaseGini)

---

## 📊 Métricas de Evaluación

| Modelo | Métrica Principal | Resultado Obtenido |
|---|---|---|
| Logística Binaria | AUC + Índice de Youden | AUC = 0.785, Sens = 81.5% |
| Log-Binomial | AUC + DOR | AUC = 0.701, DOR = 5.72 |
| Poisson Robusta | IRR + IC 95% | IRR = 2.31 [1.81–2.95] |
| Multinomial | Accuracy + Kappa | 83.89%, κ = 0.758 |
| Ordinal | Prueba de Brant | p = 0.993 (cumple supuesto) |
| Todos | Pseudo R² Nagelkerke | 0.23 – 0.30 |

---

## 👨‍💻 Sobre el Proyecto y el Equipo

Este repositorio es el resultado de un esfuerzo analítico y colaborativo desarrollado en el curso de Técnicas Multivariadas de la Universidad Nacional Agraria La Molina (UNALM).

**Jose Luis Garay Ramos**
Estudiante de Estadística especializado en transformar datos complejos en análisis interpretables mediante metodologías estadísticas sólidas y programación en R/Python. En este proyecto, desempeñé el rol principal de integrar y consolidar todas las bases de datos, unificando los pipelines de análisis y estructurando el código de este repositorio.

**Equipo de Investigación (Grupo 1):**
El desarrollo del marco teórico, análisis y revisión metodológica fue posible gracias al trabajo conjunto con mis compañeros:
- Meza Asto, Angel D.
- Ormeño Sakihama, Daniel Kenyi
- Ancco Guzman, Melany Alexandra
- Pedraza Laboriano, Jonnathan
- Fuentes Bueno, Fiorella
- Sobero Aguirre, Fiorella Romina

---

📄 **Ver informe completo:** [Final - Grupo 1](./notebooks/Final%20-%20Grupo%201.qmd)
