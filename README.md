## Diseño de Experimentos y Análisis Inferencial Multivariado 📊

Bienvenido a esta colección de estudios de estadística multivariada aplicada. Este repositorio demuestra la implementación de diseños experimentales rigurosos (DCA, DBCA, Factoriales) y pruebas de hipótesis conjuntas utilizando **R**, evaluando cómo múltiples factores afectan simultáneamente a un vector de variables respuesta.

### 🎯 Enfoque del Repositorio
Ir más allá del análisis univariado tradicional aislando fuentes de variabilidad, comprobando supuestos estrictos (Normalidad Multivariada, Homocedasticidad, Esfericidad) y traduciendo la significancia estadística (p-valores) en impacto real mediante el cálculo del tamaño del efecto ($\eta^2$).

### 📂 Casos de Estudio Incluidos

#### 1. Calidad de Agua en Ecosistemas Andinos (Prueba Z² Multivariada)
* **Contexto:** Evaluación ambiental de cuencas hidrográficas peruanas (2017-2019).
* **Técnicas:** Prueba Z² con matriz de covarianza poblacional conocida, estimación de distancias de Mahalanobis e Intervalos de Confianza Simultáneos de Bonferroni.
* **Impacto:** Detección de desviaciones críticas en parámetros fisicoquímicos (Turbidez, pH, Conductividad) frente a métricas históricas.

#### 2. Eficacia de Rehabilitación Neuropsicológica (T² de Hotelling - Muestras Dependientes)
* **Contexto:** Evaluación pre y post tratamiento de pacientes con déficit atencional.
* **Técnicas:** Análisis de la matriz de diferencias, evaluación de normalidad de variaciones conjuntas.
* **Impacto:** Verificación clínica del cumplimiento de metas de mejora en memoria, atención y concentración.

#### 3. Perfilamiento de Variedades de Palta (T² de Hotelling - Muestras Independientes)
* **Contexto:** Comparación de atributos físico-composicionales entre las variedades Hass y Fuerte.
* **Técnicas:** Contraste de vectores de medias independientes, validación de homogeneidad de covarianzas (M de Box).

#### 4. Morfología Genética en DCA (MANOVA de una vía)
* **Contexto:** Efecto de cuatro variedades de papa sobre el desarrollo de tallos y tubérculos.
* **Técnicas:** MANOVA, descomposición de Matrices SSCP (Suma de Cuadrados y Productos Cruzados), análisis de Traza de Pillai, Lambda de Wilks y raíz de Roy.

#### 5. Optimización de Dietas Lecheras (MANOVA Factorial 2x2 en DBCA)
* **Contexto:** Evaluación del sinergismo entre forraje y suplemento nutricional en ganado, bloqueando por número de partos.
* **Técnicas:** Modelado de interacciones multivariadas, comparaciones múltiples (Tukey) post-hoc.
* **Impacto:** Identificación estadística del "efecto de dilución" (aumento masivo de volumen vs. caída de sólidos de grasa/proteína).

#### 6. Protocolos de Rehabilitación de Rodilla (MANCOVA en DBCA)
* **Contexto:** Estudio clínico bloqueado por grupo etario, incorporando covariables (Flexión basal e IMC).
* **Técnicas:** Análisis Multivariado de Covarianza (MANCOVA), ajuste de vectores de medias.
* **Impacto:** Demostración del incremento de eficiencia estadística de un diseño en bloques frente a un diseño completamente al azar.

### 🛠️ Stack Tecnológico
* **Lenguaje:** R
* **Ecosistema y Manipulación:** `tidyverse`, `dplyr`, `reshape2`
* **Inferencia y Diagnóstico:** `ICSNP`, `MVTests`, `mvnormtest`, `heplots`, `biotools`, `psych`, `car`
* **Reportes:** Quarto / RMarkdown (`knitr`, `kableExtra`)

### 💡 Flujo de Trabajo (Pipeline)
Todos los scripts aplican la siguiente metodología de validación paramétrica:
1. **Análisis Exploratorio:** Matrices de correlación, dispersión y detección de *outliers*.
2. **Diagnóstico de Supuestos:** Shapiro-Wilk Multivariado, Homogeneidad de Matrices de Covarianza (M de Box) y Prueba de Esfericidad de Bartlett.
3. **Inferencia Conjunta:** Uso sistemático de estadísticos robustos (Traza de Pillai) y evaluación del eta cuadrado multivariado ($\eta^2$).

---
#### 👨‍💻 Sobre el Autor
**Jose Luis Garay Ramos**  
Estudiante de Estadística en la Universidad Nacional Agraria La Molina (UNALM), basado en Lima, Perú. Especializado en transformar datos complejos en análisis interpretables mediante metodologías estadísticas sólidas y programación en R/Python.  

<br>

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jose-l-garay/)
[![Correo](https://img.shields.io/badge/Correo-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:gaga4590joseluis@gmail.com)
