
### *Reducción de dimensionalidad, modelos factoriales y análisis de correspondencia aplicados a casos reales*

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Quarto](https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white)
![Data Science](https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white)

</div>

---

## 🎯 Enfoque del Examen

Este examen parcial reúne seis técnicas de análisis multivariado de interdependencia aplicadas sobre seis conjuntos de datos distintos, reales y simulados. El hilo conductor es la reducción de dimensionalidad y la identificación de estructuras latentes bajo distintos supuestos de medida: variables continuas, mixtas, dicotómicas, ordinales y categóricas puras.

- Regresión Lineal Multivariada
- Análisis de Componentes Principales (ACP)
- Análisis Factorial Clásico (AFC)
- Análisis Factorial de Datos Mixtos (FAMD)
- Análisis Factorial Dicotómico
- Análisis Factorial Ordinal
- Análisis de Correspondencia Simple (ACS)

📄 **Ver informe completo:** [grupo1_EVC_completo.html](https://joseluis02678.github.io/Applied-Multivariate-Analysis/Parcial/grupo1_EVC_completo.html)

---

## 📁 Estructura de la Carpeta

```text
Parcial/
│
├── 📖 README.md
├── 🧪 grupo1_EVC_completo.qmd
├── 🌐 grupo1_EVC_completo.html
│
├── 📂 data/
│   ├── p1_regre_cafe.csv
│   ├── data_colegio_p3.csv
│   ├── Datos_Dicotomicos.xlsx
│   ├── Datos_Ordinales.xlsx
│   └── Data_Estres_Afrontamiento_300Trabajadores.csv
│
├── 🖼️ logo.png
└── ⚙️ .gitignore
```

---

## 📂 Casos de Estudio

### 1. Regresión Lineal Multivariada — Calidad del Café Arábica

**Contexto:** Identificación de las condiciones ambientales que explican conjuntamente la variabilidad en la calidad química (VOCs, acidez, TDS) de 199 lotes de café arábica de la selva alta peruana.

**Dataset:** `p1_regre_cafe.csv` (n = 199 lotes)

**Metodología:**
- Diagnóstico de multicolinealidad con VIF y `alias()`
- Eliminación secuencial de predictores redundantes (temperatura por VIF > 10) y no significativos (precipitación, p = 0.1052)
- Validación de supuestos: normalidad multivariada (Shapiro-Wilk), homocedasticidad (Breusch-Pagan), esfericidad de Bartlett
- Validación cruzada 80/20 con 100 repeticiones (semilla madre = 2026)

**Hallazgo clave:** El modelo final con altitud, horas de sol y materia orgánica explica entre 82% y 90% de la variabilidad (R² ajustado) con errores de predicción entre 2.2% y 6.1% (MAPE), resultados estables en validación cruzada.

---

### 2. Análisis de Componentes Principales (ACP) — Ahorro Agregado de los Hogares

**Contexto:** Reducción dimensional de cinco variables macroeconómicas (`sr`, `pop15`, `pop75`, `dpi`, `ddpi`) del dataset `LifeCycleSavings` para identificar los ejes latentes del comportamiento del ahorro en 50 países (1960–1970).

**Metodología:**
- Detección y eliminación de outliers multivariados (Libya, United States) vía distancia de Mahalanobis
- Estandarización de variables y ajuste con `dudi.pca`
- Retención de componentes: criterio de Kaiser + scree plot

**Hallazgo clave:** Dos componentes explican el 84.07% de la varianza. **CP1** (58.5%) representa la transición demográfica e ingreso (`pop15`, `pop75`, `dpi`); **CP2** (25.5%) representa el dinamismo económico (`ddpi`, `sr`). Ambos componentes son ortogonales entre sí.

---

### 3. Análisis Factorial Clásico (AFC) — Desempeño Escolar

**Contexto:** Identificación de perfiles latentes de desempeño en 200 estudiantes de secundaria del colegio Trilce (Lima), a partir de nueve variables cognitivas y conductuales.

**Metodología:**
- Verificación de supuestos: Shapiro-Wilk multivariado (rechazado), Bartlett, KMO (0.8096, "Bueno")
- Extracción por Componentes Principales (por incumplimiento de normalidad) + rotación Varimax
- Retención de 3 factores (criterio de Kaiser + análisis paralelo)

**Hallazgo clave:** Estructura simple con 83.5% de varianza explicada: **RC1 — Habilidad Verbal** (Literatura, HGE, Comunicación), **RC2 — Consistencia Académica** (Asistencia, Tareas, Desaprobados), **RC3 — Habilidad Cuantitativa** (Física, Matemática, Química). Comunalidades todas > 0.78.

---

### 4. Análisis Factorial de Datos Mixtos (FAMD) — Bienestar Laboral

**Contexto:** Identificación de dimensiones latentes de bienestar laboral en 350 empleados de una empresa tecnológica, combinando variables cuantitativas (salario, horas, estrés) y cualitativas (área, modalidad, burnout).

**Metodología:**
- Verificación de supuestos sobre la submatriz cuantitativa: Bartlett, KMO iterativo por MSAi, normalidad multivariada, outliers (Mahalanobis)
- Ajuste con `FactoMineR::FAMD()`

**Hallazgo clave:** Las tres primeras dimensiones resumen la estructura del bienestar laboral: **Dim1** — bienestar psicológico (satisfacción, estrés, productividad, burnout); **Dim2** — carga laboral y modalidad; **Dim3** — perfil socioeconómico (salario, nivel educativo).

---

### 5. Análisis Factorial Dicotómico y Ordinal

**5a. Dicotómico — Hábitos de Consumo Digital (E-commerce)**
Encuesta de 12 ítems Sí/No sobre seguridad y hábitos de compra en línea (n = 500, tras depurar 10 outliers). Correlaciones **tetracóricas** + extracción WLS + rotación Varimax. Resultado: dos factores ortogonales — **Seguridad y Prevención** y **Hábitos de Consumo Digital** — con cargas > 0.80 y fiabilidad Omega excelente.

**5b. Ordinal — Constructo Organizacional (Likert 1–5)**
Instrumento de 15 ítems (n = 250) sobre Proactividad, Liderazgo y Empatía. Correlaciones **policóricas** + extracción ULS (por incumplimiento de normalidad) + rotación Varimax + análisis paralelo. Resultado: tres factores con 83%+ de varianza explicada y Omega de McDonald > 0.90.

---

### 6. Análisis de Correspondencia Simple (ACS) — Estrés Laboral y Afrontamiento

**Contexto:** Asociación entre Nivel de Estrés (Bajo, Normal, Alto, Severo) y Estrategia de Afrontamiento (Deporte, Terapia, Meditación, Medicación, Evitación) en 300 trabajadores corporativos.

**Metodología:**
- Prueba de independencia Chi-cuadrado previa (χ² = 114.54, gl = 12, p < 0.001)
- Tabla de perfiles de fila/columna y masas marginales
- Extracción de ejes factoriales con `FactoMineR::CA()`

**Hallazgo clave:** El Eje 1 explica el 93.8% de la inercia total (98.9% acumulado con el Eje 2), revelando una estructura bipolar: perfil preventivo/activo (`Bajo`–`Deporte`–`Meditación`) frente a perfil clínico/pasivo (`Severo`–`Medicación`–`Evitación`).

---

## 🛠️ Stack Tecnológico

| Categoría | Herramientas |
|---|---|
| Lenguaje | R |
| Regresión y Diagnóstico | `car`, `lmtest`, `rms`, `performance` |
| Reducción Dimensional | `ade4`, `FactoMineR`, `factoextra` |
| Correlaciones Especiales | `psych` (tetracórica, policórica), `polycor` |
| Análisis de Correspondencia | `FactoMineR::CA`, `gmodels` |
| Valores Perdidos y Atípicos | `mice`, `naniar`, `mahalanobis` |
| Visualización | `ggplot2`, `corrplot`, `ggcorrplot`, `GGally`, `PerformanceAnalytics` |
| Reportes | Quarto (`knitr`, `kableExtra`, `DT`) |

---

## 👨‍💻 Equipo de Investigación (Grupo 1)

- **Meza Asto, Angel D.**
- **Ormeño Sakihama, Daniel Kenyi**
- **Ancco Guzman, Melany Alexandra**
- **Pedraza Laboriano, Jonnathan**
- **Fuentes Bueno, Fiorella**
- **Garay Ramos, Jose Luis**
- **Sobero Aguirre, Fiorella Romina**

---

📄 **Informe completo:** [Ver Informe](https://joseluis02678.github.io/Applied-Multivariate-Analysis/Parcial/grupo1_EVC_completo.html)
