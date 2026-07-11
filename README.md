<div align="center">
  <h1><b>Análisis Multivariado Aplicado</b></h1>
  <h3>Universidad Nacional Agraria La Molina | Semestre 2026-I</h3>
  <p><i>Implementación de métodos estadísticos, extracción de características y reducción de dimensionalidad</i></p>

  <img src="https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white" alt="R" />
  <img src="https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white" alt="Quarto" />
  <img src="https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white" alt="Data Science" />
</div>

---

Bienvenido a esta colección de estudios de estadística multivariada aplicada. Este repositorio demuestra la implementación de diseños experimentales rigurosos (DCA, DBCA, Factoriales) y pruebas de hipótesis conjuntas, evaluando cómo múltiples factores afectan simultáneamente a un vector de variables respuesta.

### Arquitectura del Proyecto y Flujo de Evaluaciones

El siguiente esquema representa el pipeline analítico desarrollado a lo largo del ciclo, abarcando desde la inferencia inicial hasta el modelamiento predictivo avanzado.

```mermaid
graph TD
    A[Data Raw & Preprocesamiento] --> B(PC1: Inferencia Multivariada)
    B --> C(EC1: Reducción de Dimensionalidad)
    C --> D(PC2: Clasificación Categórica)
    D --> E(EF: Modelamiento Logístico Avanzado)
    
    style A fill:#2d3436,stroke:#dfe6e9,stroke-width:2px,color:#fff
    style B fill:#0984e3,stroke:#74b9ff,stroke-width:2px,color:#fff
    style C fill:#6c5ce7,stroke:#a29bfe,stroke-width:2px,color:#fff

    style D fill:#00b894,stroke:#55efc4,stroke-width:2px,color:#fff
    style E fill:#d63031,stroke:#ff7675,stroke-width:2px,color:#fff
```
