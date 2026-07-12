<div align="center">
  <img src="logo.png" alt="Logo UNALM / Análisis Multivariado" width="200" />
  <h1><b>Análisis Multivariado Aplicado</b></h1>
  <h3>Universidad Nacional Agraria La Molina | Semestre 2026-I</h3>
  <p><i>Implementación de métodos estadísticos, extracción de características y reducción de dimensionalidad</i></p>
  
  <img src="https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white" alt="R" />
  <img src="https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white" alt="Quarto" />
  <img src="https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white" alt="Data Science" />
</div>

---

## 🎯 ¿Qué es este repositorio?

Este repositorio contiene la implementación de **proyectos aplicados de estadística multivariada** desarrollados durante el curso de Técnicas Multivariadas (UNALM, 2026-I). Cada proyecto resuelve problemas reales de negocio e investigación utilizando métodos avanzados para:

- 📊 **Comparar grupos** evaluando múltiples variables simultáneamente (MANOVA, Hotelling T²).
- 📉 **Reducir dimensionalidad** de datasets complejos (PCA, Análisis Factorial).
- ️ **Clasificar individuos** en categorías conocidas (Análisis Discriminante).
-  **Modelar variables categóricas** y de conteo (Regresión Logística Binaria, Multinomial, Ordinal y Poisson Robusta).

---

## 📑 Informes Interactivos

Accede directamente a los informes renderizados en GitHub Pages:

| Evaluación | Tema Principal | Informe HTML |
|------------|----------------|--------------|
| **PC1** | Inferencia Multivariada (Z², Hotelling T², MANOVA, MANCOVA) | [Ver Informe](https://joseluis02678.github.io/Applied-Multivariate-Analysis/PC1/PC1%20-%20Grupo%201.html) |
| **Parcial** | Reducción de Dimensionalidad (PCA, Análisis Factorial) | [Ver Informe](https://joseluis02678.github.io/Applied-Multivariate-Analysis/Parcial/grupo1_EVC_completo.html) |
| **PC2** | Análisis de Correspondencia y Discriminante (ACS, ACM, ADL) | [Ver Informe](https://joseluis02678.github.io/Applied-Multivariate-Analysis/PC2/Práctica_Calificada02_Grupo01.html) |
| **Final** | Modelamiento Logístico Avanzado (Regresión Logística Binaria, Multinomial, Ordinal) | [Ver Informe](https://joseluis02678.github.io/Applied-Multivariate-Analysis/Final/Final%20-%20Grupo%201.html) |

---

##  Integrantes del Equipo

*   **[@jonnathan2023](https://github.com/jonnathan2023)** — Jonathan Pedraza
*   **[@AngelMol0810](https://github.com/AngelMol0810)** — Angel Meza
*   **[@Orsaki](https://github.com/Orsaki)** — Daniel Ormeño
*   **[@joseluis02678](https://github.com/joseluis02678)** — Jose Luis Garay Ramos
*   **[@fiorellasob](https://github.com/fiorellasob)** — Fiorella Sobero
*   **Melany Alexandra Ancco Guzman** *(Colaboradora)*
*   **Fiorella Fuentes Bueno** *(Colaboradora)*

---

## 📂 Estructura del Repositorio

```
Applied-Multivariate-Analysis/
├── PC1/
│   ├── PC1 - Grupo 1.qmd
│   ├── PC1 - Grupo 1.html
│   ├── README.md
│   └── data/
├── Parcial/
│   ├── grupo1_EVC_completo.qmd
│   ├── grupo1_EVC_completo.html
│   └── data/
├── PC2/
│   ├── Práctica_Calificada02_Grupo01.qmd
│   ├── Práctica_Calificada02_Grupo01.html
│   └── data/
├── Final/
│   ├── Final - Grupo 1.qmd
│   ├── Final - Grupo 1.html
│   ├── Codigo_Completo_Final.R
│   ├── modelo_logit.rds
│   ├── modelo_logbinomial.rds
│   └── data/
├── .gitignore
├── README.md
└── logo.png
```

---

### 🔄 Arquitectura del Proyecto y Flujo de Evaluaciones

El siguiente esquema representa el pipeline analítico desarrollado a lo largo del ciclo, abarcando desde la inferencia inicial hasta el modelamiento predictivo avanzado.

```mermaid
graph TD
    A[Data Raw & Preprocesamiento] --> B(PC1: Inferencia Multivariada)
    B --> C(Parcial: Reducción de Dimensionalidad)
    C --> D(PC2: Clasificación Categórica)
    D --> E(Final: Modelamiento Logístico Avanzado)
    
    style A fill:#2d3436,stroke:#dfe6e9,stroke-width:2px,color:#fff
    style B fill:#0984e3,stroke:#74b9ff,stroke-width:2px,color:#fff
    style C fill:#6c5ce7,stroke:#a29bfe,stroke-width:2px,color:#fff
    style D fill:#00b894,stroke:#55efc4,stroke-width:2px,color:#fff
    style E fill:#d63031,stroke:#ff7675,stroke-width:2px,color:#fff
```
