## Análisis de Correspondencia y Discriminante Multivariado 🔍

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Quarto](https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white)
![Data Science](https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white)

Bienvenido a esta colección de técnicas de reducción de dimensionalidad y clasificación multivariada. Este repositorio demuestra la implementación de Análisis de Correspondencia (Simple y Múltiple) y Análisis Discriminante Lineal, explorando patrones de asociación en datos categóricos y desarrollando reglas de clasificación óptimas.

### 🎯 Enfoque del Repositorio
Transformar tablas de contingencia y datos categóricos en representaciones geométricas interpretables, identificar estructuras de asociación entre variables cualitativas, y construir funciones discriminantes que maximicen la separación entre grupos predefinidos.

---

### 📁 Estructura del Repositorio

```text
Applied-Multivariate-Analysis/PC2
│
├── 📖 README.md                     
├── 📂 notebooks/                    
│   └── 🧪 Práctica_Calificada02_Grupo01.qmd    
│
├── 📂 data/                          
│   ├── 🩺 Dataset_Hipocalcemia_4.xlsx
│   ├── 📊 Enaho01-2025-100.csv
│   └── 📋 datos.xlsx
│
├── 📂 scripts/                       
└── ⚙️ .gitignore                     
```


---

### 📂 Casos de Estudio y Arquitectura de Datos

#### 1. Análisis de Correspondencia Simple (ACS) — Posicionamiento de Marca Perú
* **Contexto:** Evaluación del posicionamiento de Cuzco como "Marca Perú" frente a potencias turísticas globales (París, Tokio, Madrid, CDMX, Nueva York), identificando qué atributos percibe el viajero internacional.
* **Dataset:** `datos.xlsx` (2,451 encuestas a viajeros reales + 558 encuestas de "Destino Ideal")
* **Variables:**
  * *Filas (Atributos):* Gastronomía, Historia, Fiesta, Seguridad, Costo, Arquitectura
  * *Columnas (Destinos):* París, Tokio, Madrid, Cuzco, CDMX, Nueva York + Destino_Ideal (suplementario)
* **Metodología:**
  * Construcción de tabla de contingencia (Atributos × Destinos)
  * Prueba Chi-cuadrado de independencia preliminar (χ² = 284.75, p < 0.001)
  * Descomposición en valores singulares (SVD) con retención de 2 dimensiones (88.79% de inercia)
  * Proyección del "Destino Ideal" como columna suplementaria
* **Hallazgo clave:** Cuzco se posiciona como "Destino Cultural-Económico" (Historia + Gastronomía), alejado del vector de Seguridad que domina Tokio. El Destino Ideal cae en el origen, revelando que el turista busca equilibrio multidimensional perfecto.

#### 2. Análisis de Correspondencia Múltiple (ACM) — Brechas de Habitabilidad en Perú
* **Contexto:** Mapeo de las brechas estructurales de habitabilidad en el Perú utilizando microdatos de la Encuesta Nacional de Hogares (ENAHO) 2025, Módulo 100.
* **Dataset:** `Enaho01-2025-100.csv` (n = 33,333 hogares)
* **Variables (5 variables × 3 categorías = 15 categorías):**
  * `Estrato`: Urb:Grande, Urb:Pequeño, Rural
  * `Paredes`: Par:Noble, Par:Mixto, Par:Precario
  * `Pisos`: Pis:Fino, Pis:Basico, Pis:Tierra
  * `Agua`: Agua:Red, Agua:Basico, Agua:Precario
  * `Baño`: Baño:Red, Baño:Basico, Baño:Precario
* **Metodología:**
  * Construcción de Matriz Disyuntiva Completa (Z: 33,333 × 15) y Tabla de Burt (B: 15 × 15)
  * Retención de 2 dimensiones (41.5% de inercia total)
  * Verificación bivariada con 10 pruebas Chi-cuadrado (todas p < 0.001)
* **Hallazgo clave:** La Dimensión 1 (27.7%) captura la brecha urbano-rural: `Urb:Grande + Par:Noble + Pis:Fino + Baño:Red` vs `Rural + Par:Mixto + Pis:Tierra + Baño:Precario`. El saneamiento (`Baño`) es la variable con mayor poder discriminante (V de Cramer = 0.44).

#### 3. Análisis Discriminante Lineal (Datos Balanceados) — Estado Nutricional Infantil
* **Contexto:** Clasificación del estado nutricional de 150 niños (5-12 años) en comunidades rurales del Perú según variables antropométricas y bioquímicas.
* **Dataset:** Datos simulados con diseño perfectamente balanceado (n = 50 por grupo)
* **Variables:**
  * *Respuesta:* `estado` (Normal, Riesgo, Desnutrición)
  * *Predictores:* `talla_z`, `peso_z`, `hemoglobi`, `albumina`, `imc`
* **Metodología:**
  * División 70/30 estratificada (105 entrenamiento, 45 prueba)
  * Verificación de supuestos: Shapiro-Wilk multivariado, Box M (homogeneidad), ANOVA univariado
  * Selección de variables: Lambda de Wilks stepwise, Boruta, Random Forest
  * Evaluación con métricas robustas: Accuracy, Kappa, ROC one-vs-one
* **Hallazgo clave:** LD1 captura el gradiente Normal → Riesgo → Desnutrición. AUC = 1.000 para Normal vs Desnutrición (discriminación perfecta). Accuracy ≈ 0.93-0.97 con Kappa > 0.80.

#### 4. Análisis Discriminante Lineal (Datos Desbalanceados) — Hipocalcemia Bovina
* **Contexto:** Detección temprana de hipocalcemia periparto en 1,000 vacas Holstein, con prevalencia del 10% (900 sanas vs 100 enfermas).
* **Dataset:** `Dataset_Hipocalcemia_4.xlsx` (desbalance 90/10)
* **Variables:**
  * *Respuesta:* `Hipocalcemia` (no / si)
  * *Predictores:* `Anios_produccion`, `Partos_promedio_anual`, `Produccion_leche_L`, `Peso_kg`, `Calcio_preparto_mg`, `Magnesio_preparto_mg`
* **Desafíos del desbalance:**
  * Accuracy engañoso (modelo trivial alcanzaría 90%)
  * Priorización de métricas robustas: Sensibilidad, F1, MCC, AUC, CSI, ETS
* **Hallazgo clave:** `Calcio_preparto_mg` es el marcador individual más fuerte (r_s = -0.784 con LD1). AUC = 0.868 (discriminación buena), pero con umbral 0.5 la sensibilidad es solo 0.267. Se recomienda reducir el umbral a ~0.25-0.30 o aplicar técnicas de balanceo (ROSE/SMOTE).

---

### 🛠️ Stack Tecnológico
* **Lenguaje:** R
* **Análisis de Correspondencia:** `FactoMineR`, `ca`, `anacor`, `factoextra`, `vegan`, `FactoClass`
* **Análisis Discriminante:** `MASS` (lda), `klaR` (greedy.wilks), `biotools` (Box M), `mvnormtest`
* **Manipulación y Visualización:** `tidyverse`, `dplyr`, `ggplot2`, `GGally`, `corrplot`, `Hmisc`
* **Validación y Métricas:** `caret`, `caTools` (colAUC), `pROC`, `psych` (Kappa), `EnvStats` (Rosner)
* **Selección de Variables:** `Boruta`, `randomForest`, `vip`
* **Reportes:** Quarto / RMarkdown (`knitr`, `kableExtra`, `gtsummary`)

---

### 💡 Flujo de Trabajo (Pipeline)

#### Para Análisis de Correspondencia:
1. **Preparación:** Construcción de tabla de contingencia / Matriz Disyuntiva Completa / Tabla de Burt
2. **Diagnóstico:** Prueba Chi-cuadrado de independencia, análisis de residuos estandarizados
3. **Descomposición:** SVD de la matriz de residuos normalizados (ACS) o diagonalización de Tabla de Burt (ACM)
4. **Interpretación:** 
   - Selección de dimensiones (regla del codo + inercia acumulada)
   - Análisis de contribuciones (CTR) y calidad de representación (cos²)
   - v.test para significancia de categorías
5. **Visualización:** Biplots con categorías activas y suplementarias, mapas factoriales coloreados por contribución

#### Para Análisis Discriminante:
1. **Exploración:** Estadísticos descriptivos por grupo, matriz de correlaciones, ggpairs
2. **Detección de Outliers:** Tukey (univariado), Mahalanobis (multivariado), Rosner (ESD)
3. **Validación de Supuestos:**
   - Normalidad multivariada (Shapiro-Wilk multivariado, Mardia, Henze-Zirkler)
   - Homogeneidad de covarianzas (M de Box)
   - Poder discriminante individual (ANOVA univariado)
4. **Modelado:**
   - Cálculo de funciones discriminantes canónicas (LD1, LD2)
   - Lambda de Wilks (individual y conjunto vía MANOVA)
   - Coeficientes estandarizados y Matriz de Estructura
5. **Clasificación y Evaluación:**
   - Matriz de confusión, Accuracy, Kappa de Cohen
   - Curvas ROC one-vs-one y AUC
   - Métricas robustas para desbalance: F1, MCC, CSI, ETS

---

### 📊 Métricas de Evaluación

| Técnica | Métrica Principal | Umbral Aceptable |
|---------|-------------------|------------------|
| **ACS/ACM** | Inercia explicada acumulada | ≥ 40% (ACM) / 80% (ACS) |
| **ACS/ACM** | Calidad de representación (cos²) | ≥ 0.80 |
| **Discriminante** | Lambda de Wilks | p < 0.05 |
| **Discriminante** | Tasa de clasificación correcta | ≥ 75% |
| **Discriminante** | Kappa de Cohen | ≥ 0.60 |
| **Discriminante (desbalance)** | AUC | ≥ 0.80 |
| **Discriminante (desbalance)** | MCC | ≥ 0.30 |

---

### 👨‍💻 Sobre el Proyecto y el Equipo

Este repositorio es el resultado de un esfuerzo analítico y colaborativo desarrollado en el curso de Técnicas Multivariadas de la **Universidad Nacional Agraria La Molina (UNALM)**.

**Jose Luis Garay Ramos**  
Estudiante de Estadística especializado en transformar datos complejos en análisis interpretables mediante metodologías estadísticas sólidas y programación en R/Python. En este proyecto, desempeñé el rol principal de **integrar y consolidar todas las bases de datos**, unificando los *pipelines* de análisis y estructurando el código de este repositorio.

**Equipo de Investigación (Grupo 1):**  
El desarrollo del marco teórico, análisis y revisión metodológica fue posible gracias al trabajo conjunto con mis compañeros:
* Meza Asto, Angel D.
* Ormeño Sakihama, Daniel Kenyi
* Ancco Guzman, Melany Alexandra
* Pedraza Laboriano, Jonnathan
* Fuentes Bueno, Fiorella
* Sobero Aguirre, Fiorella Romina

<br>

**Conecta conmigo:**  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jose-l-garay/)
[![Correo](https://img.shields.io/badge/Correo-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:gaga4590joseluis@gmail.com)

**Ver informe completo:** [PC2 - Grupo 1](https://joseluis02678.github.io/Applied-Multivariate-Analysis/PC2/Práctica_Calificada02_Grupo01.html)
