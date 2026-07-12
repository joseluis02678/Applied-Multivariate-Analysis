<div align="center">

# Modelamiento Logístico Avanzado y Regresión Multivariada 📈

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Quarto](https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white)
![Data Science](https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white)

*Cinco modelos de regresión aplicados a problemas reales de retención estudiantil, riesgo crediticio, salud pública y selección de talento — eligiendo en cada caso la técnica estadísticamente apropiada según la naturaleza de la variable respuesta.*

**[📄 Ver informe completo](./notebooks/Final%20-%20Grupo%201.qmd)** · **[💼 LinkedIn](https://www.linkedin.com/in/jose-l-garay/)**

</div>

---

## 🎯 Resumen Ejecutivo

Este repositorio reúne cinco proyectos de modelamiento de regresión sobre variables respuesta categóricas y de conteo: abandono estudiantil, aprobación de hipotecas, anemia infantil, elección de programa de posgrado y desempeño académico.

**Habilidades demostradas:**
- Selección del modelo óptimo según el tipo de respuesta (binaria, conteo, multinomial, ordinal) y justificación estadística de esa elección
- Diagnóstico riguroso de supuestos: multicolinealidad (VIF), sobredispersión, calibración (Hosmer-Lemeshow), odds proporcionales (Brant), independencia de alternativas irrelevantes (Hausman-McFadden)
- Interpretación de medidas de efecto con intervalos de confianza (OR, RR, IRR) orientadas a decisiones de negocio, no solo a significancia estadística
- Selección de variables combinando criterios clásicos (StepAIC, Wald) con machine learning (Random Forest, Boruta) para contrastar resultados
- Evaluación con métricas apropiadas al contexto: AUC, Índice de Youden, Kappa, DOR, efectos marginales promedio (AME)

---

## 📂 Casos de Estudio

### 1. Retención Estudiantil — Regresión Logística Binaria
**Contexto:** ¿Qué factores predicen el abandono en el primer año universitario? · **Muestra:** 700 estudiantes

Se ajustó un modelo logístico con selección de variables vía StepAIC, calibrado con bootstrap (110 repeticiones) para asegurar que las probabilidades predichas sean confiables.

- **Resultado:** AUC = 0.785 (Sensibilidad 81.5%, Especificidad 61.1%)
- **Insight de negocio:** Las materias reprobadas (OR = 1.91) y trabajar durante la carrera (OR = 2.35) son los principales factores de riesgo; la beca (OR = 0.32) actúa como el mayor factor protector — un argumento cuantitativo directo para programas de becas focalizadas.

### 2. Riesgo Crediticio — Regresión Log-Binomial
**Contexto:** Probabilidad de aprobación de hipotecas según perfil financiero · **Muestra:** 1,000 solicitantes

Con una prevalencia de aprobación del 43%, se optó por Log-Binomial en lugar de logística clásica para evitar la sobreestimación del efecto que produce el Odds Ratio en prevalencias altas, estimando directamente Risk Ratios.

- **Resultado:** AUC = 0.701, Especificidad = 84.1%, DOR = 5.72
- **Insight de negocio:** Historial crediticio excelente (RR = 1.72), empleo fijo (RR = 1.63) e ingresos altos (RR = 1.61) son los predictores más fuertes; un perfil ideal alcanza 97.1% de probabilidad de aprobación — información directamente aplicable a políticas de scoring.

### 3. Salud Pública — Regresión Poisson Robusta
**Contexto:** Determinantes de anemia en niños menores de 5 años · **Muestra:** 1,200 niños

Al tratarse de una variable binaria modelada con Poisson, se corrigió la violación del supuesto de equidispersión mediante errores estándar robustos (sandwich), obteniendo Incidence Rate Ratios (IRR) válidos para inferencia.

- **Resultado:** IRR = 2.31 (IC 95% [1.81–2.95]) para la ausencia de suplemento de hierro
- **Insight de negocio:** La suplementación de hierro es, por amplio margen, la palanca de intervención más efectiva; el nivel socioeconómico bajo actúa como un umbral de riesgo (no un gradiente continuo), lo que sugiere priorizar programas en ese segmento específico.

### 4. Selección de Talento — Regresión Logística Multinomial
**Contexto:** Predicción de elección entre tres programas de posgrado · **Muestra:** 1,200 postulantes

Se validó formalmente por qué el modelo debía ser multinomial y no ordinal (prueba de Brant, χ² = 355.80, p ≈ 0) antes de ajustarlo, evitando un error metodológico común.

- **Resultado:** Accuracy = 83.89%, Kappa = 0.758, AUC = 0.980 para Marketing Digital
- **Insight de negocio:** El puntaje de aptitud cuantitativa estructura casi por completo la decisión (Marketing < 50 pts, Finanzas 50–67, Data Science > 72), con una zona de ambigüedad clara alrededor de los 67 puntos — útil para afinar criterios de admisión o consejería vocacional.

### 5. Desempeño Académico — Regresión Logística Ordinal
**Contexto:** Efecto de la beca y las inasistencias sobre el desempeño (4 niveles ordenados) · **Muestra:** 150 estudiantes

Se verificó formalmente el supuesto de odds proporcionales (Brant, p = 0.993) antes de interpretar el modelo, garantizando que la estructura ordinal es la correcta.

- **Resultado:** Pseudo R² Nagelkerke ≈ 0.29
- **Insight de negocio:** Contar con beca aumenta 390.8% los odds de mejor desempeño (OR = 4.91), mientras cada inasistencia adicional los reduce 36.5% (OR = 0.64) — dos palancas de política institucional con efectos cuantificados.

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
| Efectos Marginales | `marginaleffects`, `emmeans` |
| Reportes | Quarto / RMarkdown (`knitr`, `kableExtra`, `gtsummary`, `broom.helpers`) |

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

## 👨‍💻 Autor y Equipo

**Jose Luis Garay Ramos**
Estudiante de Estadística especializado en transformar datos complejos en análisis interpretables mediante metodologías estadísticas sólidas y programación en R/Python. En este proyecto lideré la integración y consolidación de las bases de datos, unificando los pipelines de análisis y estructurando el código del repositorio.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jose-l-garay/)
[![Correo](https://img.shields.io/badge/Correo-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:gaga4590joseluis@gmail.com)

**Equipo de Investigación (Grupo 1):** Meza Asto, Angel D. · Ormeño Sakihama, Daniel Kenyi · Ancco Guzman, Melany Alexandra · Pedraza Laboriano, Jonnathan · Fuentes Bueno, Fiorella · Sobero Aguirre, Fiorella Romina

---
