## Diseño de Experimentos y Análisis Inferencial Multivariado 📊

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Quarto](https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white)
![Data Science](https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white)

Bienvenido a esta colección de estudios de estadística multivariada aplicada. Este repositorio demuestra la implementación de diseños experimentales rigurosos (DCA, DBCA, Factoriales) y pruebas de hipótesis conjuntas, evaluando cómo múltiples factores afectan simultáneamente a un vector de variables respuesta.

### 🎯 Enfoque del Repositorio
Ir más allá del análisis univariado tradicional aislando fuentes de variabilidad, comprobando supuestos estrictos (Normalidad Multivariada, Homocedasticidad, Esfericidad) y traduciendo la significancia estadística (p-valores) en impacto real y toma de decisiones mediante el cálculo del tamaño del efecto ($\eta^2$).

---

### 📁 Estructura del Repositorio

```text
🚀 Applied-Multivariate-Analysis/PC1
│
├── 📖 README.md             
├── 📂 notebooks/            
│   └── 🧪 PC1 - Grupo 1.qmd    
│
├── 📂 data/                  
│   ├── 💧 Dataset_CalidadAgua_Andina_2017_2019.xlsx
│   ├── 🧠 datos_neuropsico.xlsx
│   ├── 🥑 base_de_datos_palta.csv
│   ├── 🥔 datos_manova_papa.csv
│   └── 🐄 Data_Final_Vacas_PC1.csv
│
├── 📂 scripts/               
└── ⚙️ .gitignore             
```

### 📂 Casos de Estudio y Arquitectura de Datos

#### 1. Calidad de Agua en Ecosistemas Andinos (Prueba Z² Multivariada)
* **Contexto:** Evaluación ambiental de cuencas hidrográficas peruanas (Apurímac, Áncash, Cusco y Junín) durante el periodo 2017-2019, contrastando muestras de 2019 con parámetros históricos consolidados (2017-2018).
* **Dataset:** `Dataset_CalidadAgua_Andina_2017_2019.xlsx`
* **Diccionario de Variables:** 
  * `pH` (Acidez/Alcalinidad)
  * `Turbidez_NTU` (Claridad del agua)
  * `Oxigeno_Disuelto_mgL` (Viabilidad acuática)
  * `Conductividad_uScm` (Sales disueltas)
* **Técnicas:** Prueba Z² con matriz de covarianza poblacional conocida, estimación de distancias de Mahalanobis e Intervalos de Confianza Simultáneos de Bonferroni.
* **Hallazgo clave:** La **Turbidez** es el factor crítico de degradación, responsable del **63.7%** de la variación total detectada. El Z² calculado (284.31) supera ampliamente al crítico (9.48), rechazando contundentemente H₀ (p < 0.0001).

#### 2. Eficacia de Rehabilitación Neuropsicológica (T² de Hotelling - Muestras Dependientes)
* **Contexto:** Evaluación clínica pre y post tratamiento de 35 pacientes con déficit atencional leve tras un programa de 8 semanas combinando mindfulness, entrenamiento de memoria de trabajo y estimulación cognitiva computarizada.
* **Dataset:** `datos_neuropsico.xlsx` (Hoja 2)
* **Diccionario de Variables:**
  * `sostenida` (Tiempo de concentración en segundos)
  * `memoria` (Puntaje de memoria de trabajo)
  * `atencion` (Puntaje de atención selectiva)
  * `momento` (Factor temporal: Antes / Después)
* **Vector de metas clínicas:** (20 s, 5 pts, 3 pts)
* **Técnicas:** Análisis de la matriz de diferencias, pruebas de normalidad multivariada (Mardia, Henze-Zirkler, Doornik-Hansen), detección de outliers multivariados.
* **Hallazgo clave:** La prueba T² de Hotelling **no rechaza H₀** (p = 0.447), confirmando que el programa produce cambios que se ajustan perfectamente a las metas clínicas establecidas.

#### 3. Perfilamiento de Variedades de Palta (T² de Hotelling - Muestras Independientes)
* **Contexto:** Comparación de atributos físico-composicionales entre las variedades comerciales Hass y Fuerte, evaluando si las diferencias observadas coinciden con el vector esperado.
* **Dataset:** `base_de_datos_palta.csv`
* **Diccionario de Variables:**
  * `Especie` (Factor: Hass / Fuerte)
  * *Vector respuesta:* `DiametroSemilla` (mm), `PesoFruto` (g), `ContenidoAceite` (%), `Firmeza` (N)
* **Vector hipotético (μ₀):** (-3, -20, -4, 5)ᵀ → Hass tiene semilla 3mm más pequeña, pesa 20g menos, 4% menos aceite y 5N más firme.
* **Técnicas:** Contraste de vectores de medias independientes, validación de homogeneidad de covarianzas (M de Box), intervalos de confianza simultáneos.
* **Hallazgo clave:** Con p = 0.6395, no se rechaza H₀. Los datos son **totalmente compatibles** con el vector especificado, confirmando el perfil diferenciado entre variedades.

#### 4. Morfología Genética en DCA (MANOVA de una vía)
* **Contexto:** Efecto de cuatro variedades de papa (*Solanum tuberosum*: A, B, C, D) sobre el desarrollo estructural bajo un Diseño Completamente Aleatorizado con 100 plantas (25 por variedad).
* **Dataset:** `datos_manova_papa.csv`
* **Diccionario de Variables:**
  * `Variedad` (Factor: A, B, C, D)
  * *Vector respuesta:* `Y1` (Altura), `Y2` (Longitud tallo), `Y3` (Diámetro tubérculo), `Y4` (Longitud tubérculo) - *en cm*.
* **Técnicas:** MANOVA con 4 criterios (Pillai, Wilks, Hotelling-Lawley, Roy), descomposición de Matrices SSCP, ANOVAs univariados de seguimiento, comparaciones por pares con Traza de Pillai.
* **Hallazgo clave:** Todas las variedades difieren significativamente en las 4 variables (p < 2.2e-16), con **η² ≈ 1** (casi el 100% de variabilidad explicada). **Ningún par de variedades es equivalente**: los más disímiles son C vs D (Pillai = 0.915).

#### 5. Optimización de Dietas Lecheras (MANOVA Factorial 2x2 en DBCA)
* **Contexto:** Evaluación del sinergismo entre forraje (Alfalfa/Ensilado) y suplemento (Con/Sin Concentrado) en ganado, aislando la variabilidad por número de partos mediante 5 bloques.
* **Dataset:** `Data_Final_Vacas_PC1.csv`
* **Diccionario de Variables:**
  * *Factores:* `Forraje` (Alfalfa/Ensilado), `Suplemento` (Con/Sin)
  * *Bloque:* Número de partos (5 niveles)
  * *Vector respuesta:* `Produccion` (L/día), `Grasa` (%), `Proteina` (%)
* **Técnicas:** Modelado de interacciones multivariadas, análisis de efectos simples condicionados, comparaciones múltiples de Tukey post-hoc, cálculo de η² multivariado.
* **Hallazgo clave:** Interacción altamente significativa (p < 0.0001). **Alfalfa + Concentrado maximiza producción** (+13.7 L/día vs +4.67 L/día con Ensilado), pero con **efecto de dilución**: caída de -0.82% en grasa y -0.55% en proteína. η² de interacción = 0.9817.

#### 6. Protocolos de Rehabilitación de Rodilla (MANCOVA en DBCA)
* **Contexto:** Estudio clínico evaluando 3 protocolos de rehabilitación física (A, B, C) con 10 bloques etarios, controlando factores externos críticos mediante covariables.
* **Dataset:** Generado mediante simulación estocástica controlada (set.seed = 2025).
* **Diccionario de Variables:**
  * `Protocolo` (Factor de tratamiento: A, B, C)
  * `GrupoEtario` (Factor de Bloqueo, 10 niveles)
  * *Covariables:* `FLEX_BASAL` (Ángulo inicial), `IMC` (Índice de Masa Corporal)
  * *Vector respuesta:* `FLEX_RODILLA` (Ángulo al alta), `FUERZA_CUAD` (kg/f al alta)
* **Técnicas:** Análisis Multivariado de Covarianza (MANCOVA), ajuste de vectores de medias, comparación de eficiencia DCA vs DBCA mediante razón de determinantes.
* **Hallazgo clave:** Los 3 protocolos producen perfiles de recuperación distintos (p < 0.05 en todas las comparaciones por pares). Ambas covariables son altamente significativas, justificando el MANCOVA sobre MANOVA. El bloqueo mejora la eficiencia en un porcentaje significativo.

---

### 🛠️ Stack Tecnológico
* **Lenguaje:** R
* **Ecosistema y Manipulación:** `tidyverse`, `dplyr`, `reshape2`, `readxl`, `readr`
* **Inferencia y Diagnóstico:** `ICSNP`, `MVTests`, `mvnormtest`, `heplots`, `biotools`, `psych`, `car`, `MVN`
* **Modelado y Comparaciones:** `emmeans`, `patchwork`, `gridExtra`
* **Visualización:** `ggplot2`, `GGally`, `corrplot`, `ggthemes`
* **Reportes y Compilación:** Quarto / RMarkdown (`knitr`, `kableExtra`)

### 💡 Flujo de Trabajo (Pipeline)
Todos los análisis aplican la siguiente metodología de validación paramétrica antes de la inferencia:

1. **Análisis Exploratorio:** Matrices de correlación, dispersión (ggpairs), boxplots comparativos y detección de *outliers* multivariados (Distancia de Mahalanobis).
2. **Diagnóstico de Supuestos:**
   - Normalidad Multivariada: Shapiro-Wilk multivariado, Mardia, Henze-Zirkler, Doornik-Hansen
   - Homogeneidad de Matrices de Covarianza: Prueba M de Box
   - Correlación entre variables: Prueba de Esfericidad de Bartlett
3. **Inferencia Conjunta:** Uso sistemático de los 4 criterios multivariados (Pillai, Wilks, Hotelling-Lawley, Roy) priorizando Traza de Pillai por su robustez, y evaluación del tamaño del efecto global ($\eta^2$).
4. **Análisis de Seguimiento:** ANOVAs univariados, comparaciones por pares y pruebas post-hoc de Tukey cuando corresponde.

---

### 📊 Métricas de Evaluación

| Técnica | Métrica Principal | Resultado Observado |
|---------|-------------------|---------------------|
| **Z² Multivariada** | Estadístico Z² vs χ² crítico | 284.31 >> 9.48 (p < 0.0001) |
| **T² Hotelling (dep)** | p-valor vs metas clínicas | p = 0.447 (no rechaza H₀) |
| **T² Hotelling (ind)** | p-valor vs vector μ₀ | p = 0.6395 (compatible con H₀) |
| **MANOVA DCA** | η² multivariado | ≈ 1.00 (100% explicado) |
| **MANOVA Factorial** | η² de interacción | 0.9817 (sinergia fuerte) |
| **MANCOVA** | η² del modelo | > 0.85 con covariables sig. |

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

**Ver informe completo:** [PC1 - Grupo 1](https://joseluis02678.github.io/Applied-Multivariate-Analysis/PC1/PC1%20-%20Grupo%201.html)
