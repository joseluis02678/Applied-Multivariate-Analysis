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
🚀 Applied-Multivariate-Analysis
│
├── 📖 README.md             
├── 📂 notebooks/            
│   └── 🧪 PC1_MANOVA.qmd     
│
├── 📂 data/                  
│   ├── 💧 Calidad_Agua.xlsx
│   ├── 🧠 Neuropsicologia.xlsx
│   ├── 🥑 Palta_data.csv
│   ├── 🥔 Papa_manova.csv
│   └── 🐄 Vacas_PC1.csv
│
├── 📂 scripts/               
└── ⚙️ .gitignore             
```

### 📂 Casos de Estudio y Arquitectura de Datos

#### 1. Calidad de Agua en Ecosistemas Andinos (Prueba Z² Multivariada)
* **Contexto:** Evaluación ambiental de cuencas hidrográficas peruanas (2017-2019) contrastando muestras recientes con parámetros históricos.
* **Dataset:** `Dataset_CalidadAgua_Andina_2017_2019.xlsx`
* **Diccionario de Variables:** 
  * `pH` (Acidez/Alcalinidad)
  * `Turbidez_NTU` (Claridad del agua)
  * `Oxigeno_Disuelto_mgL` (Viabilidad acuática)
  * `Conductividad_uScm` (Sales disueltas)
* **Técnicas:** Prueba Z² con matriz de covarianza poblacional conocida, estimación de distancias de Mahalanobis e Intervalos de Confianza Simultáneos de Bonferroni.

#### 2. Eficacia de Rehabilitación Neuropsicológica (T² de Hotelling - Muestras Dependientes)
* **Contexto:** Evaluación clínica pre y post tratamiento de pacientes con déficit atencional leve tras 8 semanas de intervención.
* **Dataset:** `datos_neuropsico.xlsx` (Hoja 2)
* **Diccionario de Variables:**
  * `sostenida` (Tiempo de concentración en segundos)
  * `memoria` (Puntaje de memoria de trabajo)
  * `atencion` (Puntaje de atención selectiva)
  * `momento` (Factor temporal: Antes / Después)
* **Técnicas:** Análisis de la matriz de diferencias, evaluación de normalidad de variaciones conjuntas.

#### 3. Perfilamiento de Variedades de Palta (T² de Hotelling - Muestras Independientes)
* **Contexto:** Comparación de atributos físico-composicionales entre las variedades comerciales Hass y Fuerte.
* **Dataset:** `base_de_datos_palta.csv`
* **Diccionario de Variables:**
  * `Especie` (Factor: Hass / Fuerte)
  * *Vector respuesta:* `DiametroSemilla` (mm), `PesoFruto` (g), `ContenidoAceite` (%), `Firmeza` (N)
* **Técnicas:** Contraste de vectores de medias independientes, validación de homogeneidad de covarianzas (M de Box).

#### 4. Morfología Genética en DCA (MANOVA de una vía)
* **Contexto:** Efecto de cuatro variedades de papa (*Solanum tuberosum*) sobre el desarrollo estructural de la planta bajo un Diseño Completamente Aleatorizado.
* **Dataset:** `datos_manova_papa.csv`
* **Diccionario de Variables:**
  * `Variedad` (Factor: A, B, C, D)
  * *Vector respuesta:* `Y1` (Altura), `Y2` (Longitud tallo), `Y3` (Diámetro tubérculo), `Y4` (Longitud tubérculo) - *expresadas en cm*.
* **Técnicas:** MANOVA, descomposición de Matrices SSCP (Suma de Cuadrados y Productos Cruzados), análisis de Traza de Pillai.

#### 5. Optimización de Dietas Lecheras (MANOVA Factorial 2x2 en DBCA)
* **Contexto:** Evaluación del sinergismo entre forraje y suplemento nutricional en ganado, aislando la madurez del animal.
* **Dataset:** `Data_Final_Vacas_PC1.csv`
* **Diccionario de Variables:**
  * *Factores:* `Forraje` (Alfalfa/Ensilado), `Suplemento` (Con/Sin)
  * *Bloque:* `Bloque` (Número de partos)
  * *Vector respuesta:* `Produccion` (L/día), `Grasa` (%), `Proteina` (%)
* **Técnicas:** Modelado de interacciones multivariadas, comparaciones múltiples (Tukey) post-hoc.
* **Impacto:** Cuantificación estadística del "efecto de dilución" (aumento de volumen vs. caída de densidad de sólidos).

#### 6. Protocolos de Rehabilitación de Rodilla (MANCOVA en DBCA)
* **Contexto:** Estudio clínico evaluando terapias de recuperación física, controlando factores externos críticos.
* **Dataset:** *Generado mediante simulación estocástica controlada en el script principal.*
* **Diccionario de Variables:**
  * `Protocolo` (Factor de tratamiento: A, B, C)
  * `GrupoEtario` (Factor de Bloqueo)
  * *Covariables:* `FLEX_BASAL` (Ángulo inicial), `IMC` (Índice de Masa Corporal)
  * *Vector respuesta:* `FLEX_RODILLA` (Ángulo al alta), `FUERZA_CUAD` (kg/f al alta)
* **Técnicas:** Análisis Multivariado de Covarianza (MANCOVA), ajuste de vectores de medias.

---

### 🛠️ Stack Tecnológico
* **Lenguaje:** R
* **Ecosistema y Manipulación:** `tidyverse`, `dplyr`, `reshape2`
* **Inferencia y Diagnóstico:** `ICSNP`, `MVTests`, `mvnormtest`, `heplots`, `biotools`, `psych`, `car`
* **Reportes y Compilación:** Quarto / RMarkdown (`knitr`, `kableExtra`)

### 💡 Flujo de Trabajo (Pipeline)
Todos los scripts aplican la siguiente metodología de validación paramétrica antes de la inferencia:
1. **Análisis Exploratorio:** Matrices de correlación, dispersión y detección de *outliers* multivariados (Distancia de Mahalanobis).
2. **Diagnóstico de Supuestos:** Shapiro-Wilk Multivariado, Homogeneidad de Matrices de Covarianza (M de Box) y Prueba de Esfericidad de Bartlett.
3. **Inferencia Conjunta:** Uso sistemático de estadísticos robustos (Traza de Pillai) y evaluación del tamaño del efecto global ($\eta^2$).

---

#### 👨‍💻 Sobre el Proyecto y el Equipo

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
