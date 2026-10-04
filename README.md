<div align="center">
  <img src="logo.png" alt="Logo UNALM / Análisis Multivariado" width="200" />
  <h1><b>Análisis Multivariado Aplicado</b></h1>
  <h3>Universidad Nacional Agraria La Molina | 2026-I</h3>
  <p><i>Proyectos aplicados en Data Science: reducción de dimensionalidad, clasificación y modelamiento predictivo</i></p>
  
  <img src="https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white" alt="R" />
  <img src="https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white" alt="Quarto" />
  <img src="https://img.shields.io/badge/Statistics-102A43?style=for-the-badge&logo=jupyter&logoColor=white" alt="Statistics" />
  <img src="https://img.shields.io/badge/ML-FF6B6B?style=for-the-badge" alt="ML" />
</div>

---

## 📌 Sobre este portafolio

Este repositorio contiene **4 proyectos aplicados de Data Science** que resuelven problemas reales usando técnicas avanzadas de estadística multivariada. Cada proyecto demuestra:
- ✅ Identificación y cuantificación del problema
- ✅ Selección de metodología apropiada
- ✅ Implementación y validación en R/Quarto
- ✅ Insights accionables para stakeholders

**Orientado a**: Científicos de datos, Analistas, Teams de IA/ML | **Stack**: R, Estadística Multivariada, Machine Learning

---

## 🎯 Proyectos

### 1️⃣ **PC1: Inferencia Multivariada — Evaluación Comparativa de Grupos**

**Problema:**
- Necesidad de comparar múltiples grupos considerando **simultáneamente** varias variables correlacionadas (no univariados)
- Métodos tradicionales (t-tests separados) inflan error Type I y pierden información multivariada

**Solución:**
- **Hotelling T²**: Test multivariado de diferencias de medias
- **MANOVA** (Análisis Multivariante de Varianza): extensión a 3+ grupos
- **MANCOVA**: Controlando efectos de covariables
- Visualización de contrastes en espacios multidimensionales

**Resultados & Insights:**
- Identificación de grupos significativamente diferentes en combinaciones específicas de variables
- Cuantificación de efectos multivariados que univariados hubieran pasado por alto
- **Aplicación real**: Clasificación de cultivos por perfiles multivariados (agricultura)

**Skills aplicados:** Inferencia estadística, Álgebra lineal, Diseño de experimentos, Comunicación de resultados

📊 [Ver informe completo →](https://joseluis02678.github.io/Applied-Multivariate-Analysis/PC1/PC1%20-%20Grupo%201.html)

---

### 2️⃣ **Parcial: Reducción de Dimensionalidad — De 50+ variables a 5 componentes principales**

**Problema:**
- Datasets agrícolas/climáticos con **50-100+ variables correlacionadas**
- Alta multicolinealidad dificulta interpretación y aumenta ruido en modelos
- Necesidad de visualizar y comunicar patrones en espacios de alta dimensión

**Solución:**
- **PCA (Principal Component Analysis)**: Extracción de 80% varianza en ~5 componentes
- **Análisis Factorial**: Identificación de factores latentes interpretables
- Validación de dimensionalidad óptima (screeplots, varianza acumulada)

**Resultados & Insights:**
- Reducción de 50 variables → 5 componentes sin perder información crítica
- Interpretación clara de qué variables "manejan" la variabilidad del dataset
- **Aplicación real**: Compresión de datos agrarios (café, cacao, arroz) para predicción más eficiente

**Skills aplicados:** Reducción de dimensionalidad, Descomposición matricial, Interpretación de componentes

📊 [Ver informe completo →](https://joseluis02678.github.io/Applied-Multivariate-Analysis/Parcial/grupo1_EVC_completo.html)

---

### 3️⃣ **PC2: Análisis Discriminante & Correspondencia — Clasificación Supervisada**

**Problema:**
- Necesidad de clasificar nuevas observaciones en categorías conocidas
- Variables categóricas y continuas mixtas sin relación lineal simple
- Identificar qué combinaciones de variables mejor separan grupos

**Solución:**
- **Análisis Discriminante Lineal (LDA)**: Frontera óptima de decisión multivariada
- **Análisis de Correspondencia (AC)**: Relaciones entre variables categóricas
- **Análisis de Correspondencia Múltiple (ACM)**: Extensión a múltiples categorías
- Validación cruzada y matrices de confusión

**Resultados & Insights:**
- Tasa de clasificación correcta: _[a rellenar con datos reales]_
- Variables discriminantes más potentes identificadas
- Visualización de relaciones ocultas entre categorías
- **Aplicación real**: Clasificación de cultivos por calidad (bueno/regular/deficiente)

**Skills aplicados:** Clasificación, Álgebra lineal aplicada, Selección de variables, Validación de modelos

📊 [Ver informe completo →](https://joseluis02678.github.io/Applied-Multivariate-Analysis/PC2/Práctica_Calificada02_Grupo01.html)

---

### 4️⃣ **Final: Modelamiento Logístico Avanzado — Predicción Binaria, Multinomial y Ordinal**

**Problema:**
- Predicción de variables **categóricas** (sí/no, bajo/medio/alto, 1-5 escala)
- Métodos lineales tradicionales no aplican; se requiere probabilidades calibradas
- Necesidad de modelos interpretables para decisiones de negocio (seguros, crédito, predicción agraria)

**Solución:**
- **Regresión Logística Binaria**: Probabilidades de sí/no
- **Regresión Multinomial**: 3+ categorías sin orden
- **Regresión Ordinal**: 3+ categorías CON orden (e.g., deficiente→bueno→excelente)
- **Robustez**: Manejo de outliers y validación de supuestos
- Calibración de probabilidades y curvas ROC

**Resultados & Insights:**
- Modelos entrenados y persistidos (`.rds` para producción)
- Coeficientes interpretables: "Por cada unidad de X, la odds de Y aumenta 15%"
- Probabilidades predichas para nuevas observaciones
- **Aplicación real**: Predicción de resultados agrícolas, asignación de riesgos seguros

**Skills aplicados:** Modelamiento predictivo, GLM, Interpretabilidad, Métricas de rendimiento (AUC, Precisión, Recall)

📊 [Ver informe completo →](https://joseluis02678.github.io/Applied-Multivariate-Analysis/Final/Final%20-%20Grupo%201.html)

---

## 📂 Estructura del Repositorio

```
Applied-Multivariate-Analysis/
├── PC1/                              # Inferencia Multivariada
│   ├── PC1 - Grupo 1.qmd
│   ├── PC1 - Grupo 1.html            ← Informe interactivo
│   └── data/
├── Parcial/                          # Reducción de Dimensionalidad
│   ├── grupo1_EVC_completo.qmd
│   ├── grupo1_EVC_completo.html      ← Informe interactivo
│   └── data/
├── PC2/                              # Clasificación
│   ├── Práctica_Calificada02_Grupo01.qmd
│   ├── Práctica_Calificada02_Grupo01.html  ← Informe interactivo
│   └── data/
├── Final/                            # Modelamiento Predictivo
│   ├── Final - Grupo 1.qmd
│   ├── Final - Grupo 1.html          ← Informe interactivo
│   ├── modelo_logit.rds              ← Modelos guardados (producción)
│   ├── modelo_logbinomial.rds
│   └── data/
└── README.md
```

---

## 🔄 Pipeline Analítico Integrado

```mermaid
graph LR
    A["📥 Data Raw<br/>Preprocesamiento"] --> B["📊 PC1<br/>Inferencia<br/>Multivariada"]
    B --> C["📉 Parcial<br/>Reducción<br/>Dimensionalidad"]
    C --> D["🎯 PC2<br/>Clasificación<br/>Discriminante"]
    D --> E["🔮 Final<br/>Modelamiento<br/>Predictivo"]
    
    style A fill:#34495e,stroke:#ecf0f1,stroke-width:2px,color:#fff
    style B fill:#3498db,stroke:#ecf0f1,stroke-width:2px,color:#fff
    style C fill:#9b59b6,stroke:#ecf0f1,stroke-width:2px,color:#fff
    style D fill:#1abc9c,stroke:#ecf0f1,stroke-width:2px,color:#fff
    style E fill:#e74c3c,stroke:#ecf0f1,stroke-width:2px,color:#fff
```

**Flujo:**
1. Captura y limpieza de datos
2. Validación de supuestos multivariados
3. Extracción de información en espacios reducidos
4. Clasificación según perfiles
5. Modelamiento predictivo para decisiones futuras

---

## 👥 Equipo

**👨‍💻 Autor Principal:**
- **[@joseluis02678](https://github.com/joseluis02678)** — **Jose Luis Garay Ramos** 
  - *Líder de análisis predictivo y modelamiento*
  - [LinkedIn](https://www.linkedin.com/in/jose-l-garay) | [GitHub](https://github.com/joseluis02678)

**Colaboradores:**
- [@jonnathan2023](https://github.com/jonnathan2023) — Jonathan Pedraza
- [@AngelMol0810](https://github.com/AngelMol0810) — Angel Meza
- [@Orsaki](https://github.com/Orsaki) — Daniel Ormeño
- [@fiorellasob](https://github.com/fiorellasob) — Fiorella Sobero
- Melany Alexandra Ancco Guzman *(Colaboradora)*
- Fiorella Fuentes Bueno *(Colaboradora)*

---

## 🛠️ Stack Técnico

| Categoría | Tecnologías |
|-----------|------------|
| **Lenguaje** | R (base, tidyverse, ggplot2) |
| **Reportería** | Quarto (notebooks interactivos HTML) |
| **Estadística** | MASS, stats, mvnormtest |
| **Visualización** | ggplot2, plotly, factoextra |
| **Versionado** | Git + GitHub Pages |
| **Métodos** | PCA, Factor Analysis, MANOVA, LDA, Regresión Logística (binaria/multinomial/ordinal) |

---

## 📮 Contacto

- **GitHub**: [@joseluis02678](https://github.com/joseluis02678)
- **LinkedIn**: [jose-l-garay](https://www.linkedin.com/in/jose-l-garay)
- **Email**: joseluisgarayramos23@gmail.com

---

**Última actualización:** Octubre 2026 | **Estado:** Activo & Documentado
