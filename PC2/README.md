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

#### 1. Análisis de Correspondencia Simple (ACS)
* **Contexto:** Exploración de patrones de asociación entre variables categóricas mediante descomposición de inercia en tablas de contingencia.
* **Dataset:** `datos.xlsx`
* **Metodología:**
  * Construcción de tablas de contingencia
  * Cálculo de perfiles fila y columna
  * Descomposición en valores singulares (SVD)
  * Proyección en espacios de baja dimensión
* **Técnicas:**
  * Prueba de independencia Chi-cuadrado preliminar
  * Scree plot para selección de dimensiones
  * Biplot de perfiles activos y suplementarios
  * Tablas de contribución (CTR) y calidad de representación (COS)
* **Interpretación:** Identificación de categorías que más contribuyen a la inercia total y patrones de atracción/repulsión en el espacio factorial.

#### 2. Análisis de Correspondencia Múltiple (ACM)
* **Contexto:** Análisis simultáneo de múltiples variables categóricas para identificar estructuras latentes en hogares peruanos.
* **Dataset:** `Enaho01-2025-100.csv` (Encuesta Nacional de Hogares - ENAHO 2025)
* **Metodología:**
  * Codificación disyuntiva completa (indicator matrix)
  * Análisis de nube de individuos y variables
  * Extracción de componentes principales categóricos
* **Técnicas:**
  * Cálculo de inercia explicada por dimensión
  * Coordenadas principales estandarizadas
  * Gráficos de individuos y variables en espacios factoriales
* **Aplicación:** Segmentación de hogares peruanos según características socioeconómicas, identificación de patrones de vulnerabilidad y bienestar.

#### 3. Análisis Discriminante Lineal (Datos Balanceados)
* **Contexto:** Construcción de funciones discriminantes para clasificar individuos en grupos conocidos con diseño balanceado, aplicado a diagnóstico clínico de hipocalcemia.
* **Dataset:** `Dataset_Hipocalcemia_4.xlsx`
* **Variables:**
  * *Variable respuesta:* Grupo de hipocalcemia (categorías definidas)
  * *Predictores:* Variables clínicas y bioquímicas continuas
* **Metodología:**
  * Verificación de supuestos: Normalidad multivariada, homogeneidad de matrices de covarianza (M de Box)
  * Cálculo de funciones discriminantes canónicas
  * Evaluación de poder discriminante (Lambda de Wilks, Chi-cuadrado)
* **Técnicas:**
  * Coeficientes discriminantes estandarizados
  * Correlaciones canónicas
  * Matriz de clasificación (accuracy, sensibilidad, especificidad)
  * Validación cruzada (leave-one-out)
* **Impacto:** Desarrollo de reglas de diagnóstico clínico basadas en perfiles bioquímicos.

#### 4. Análisis Discriminante Lineal (Datos Desbalanceados)
* **Contexto:** Clasificación en escenarios con tamaños muestrales desiguales entre grupos.
* **Dataset:** Variante del dataset de hipocalcemia con distribución no balanceada
* **Desafíos:**
  * Sesgo hacia grupos mayoritarios
  * Estimación inestable de matrices de covarianza en grupos pequeños
* **Estrategias:**
  * Ponderación por tamaños muestrales
  * Análisis de funciones discriminantes robustas
  * Evaluación de tasas de error por grupo (no solo global)
* **Métricas:**
  * Sensibilidad y especificidad por clase
  * Curvas ROC multiclase
  * Índice Kappa de Cohen para acuerdo más allá del azar

---

### 🛠️ Stack Tecnológico
* **Lenguaje:** R
* **Análisis de Correspondencia:** `FactoMineR`, `ca`, `ggbiplot`
* **Análisis Discriminante:** `MASS` (lda), `candisc`, `heplots`
* **Manipulación y Visualización:** `tidyverse`, `dplyr`, `ggplot2`, `corrplot`
* **Validación y Métricas:** `caret`, `pROC`, `e1071`
* **Reportes:** Quarto / RMarkdown (`knitr`, `kableExtra`)

---

### 💡 Flujo de Trabajo (Pipeline)

#### Para Análisis de Correspondencia:
1. **Preparación:** Construcción de tabla de contingencia, cálculo de frecuencias esperadas
2. **Diagnóstico:** Prueba Chi-cuadrado de independencia, análisis de residuos estandarizados
3. **Descomposición:** SVD de la matriz de residuos normalizados
4. **Interpretación:** 
   - Selección de dimensiones (inercia acumulada > 80%)
   - Análisis de contribuciones (CTR > 1/k)
   - Calidad de representación (COS > 0.8)
5. **Visualización:** Biplots con etiquetas de categorías activas y suplementarias

#### Para Análisis Discriminante:
1. **Exploración:** Estadísticos descriptivos por grupo, matriz de correlaciones
2. **Validación de Supuestos:**
   - Normalidad multivariada (Shapiro-Wilk, Mardia)
   - Homogeneidad de covarianzas (M de Box)
   - Ausencia de multicolinealidad (VIF < 10)
3. **Modelado:**
   - Cálculo de funciones discriminantes canónicas
   - Evaluación de significancia (Lambda de Wilks)
   - Estructura de cargas (correlaciones intra-set)
4. **Clasificación:**
   - Asignación por distancia de Mahalanobis a centroides
   - Matriz de confusión y métricas de desempeño
   - Validación cruzada para estimar error real

---

### 📊 Métricas de Evaluación

| Técnica | Métrica Principal | Umbral Aceptable |
|---------|-------------------|------------------|
| **ACS/ACM** | Inercia explicada acumulada | ≥ 70-80% |
| **ACS/ACM** | Calidad de representación (COS) | ≥ 0.80 |
| **Discriminante** | Lambda de Wilks | p < 0.05 |
| **Discriminante** | Tasa de clasificación correcta | ≥ 75% |
| **Discriminante** | Kappa de Cohen | ≥ 0.60 |

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
