# Examen Final - Técnicas Multivariadas 2026-I

## 📋 Información General

**Universidad:** Universidad Nacional Agraria La Molina  
**Facultad:** Economía y Planificación  
**Departamento:** Estadística e Informática  
**Curso:** Técnicas Multivariadas  
**Docente:** Miranda Villagomez, Clodomiro Fernando  
**Grupo:** 1  
**Periodo:** 2026-I

## 👥 Integrantes del Grupo

| Nombre | Código |
|--------|--------|
| Meza Asto, Angel D. | 20220810 |
| Ormeño Sakihama, Daniel Kenyi | 20240723 |
| Ancco Guzman, Melany Alexandra | 20230379 |
| Pedraza Laboriano, Jonnathan Jesús | 20231505 |
| Fuentes Bueno, Fiorella | 20230395 |
| Garay Ramos, Jose Luis | 20230678 |
| Sobero Aguirre, Fiorella Romina | 20091130 |

## 📚 Descripción del Proyecto

Este repositorio contiene el desarrollo del Examen Final del curso de Técnicas Multivariadas, el cual abarca cinco preguntas que aplican diferentes métodos estadísticos multivariados:

### Preguntas Desarrolladas:

1. **Regresión Logística Binaria** - Análisis de factores asociados al abandono estudiantil
2. **Regresión Log-Binomial** - Modelado de aprobación de hipotecas con estimación de Risk Ratios
3. **Regresión Poisson Robusta** - Identificación de factores determinantes de anemia infantil
4. **Regresión Logística Multinomial** - Predicción de elección de programas de especialización
5. **Regresión Logística Ordinal** - Análisis de desempeño académico con odds proporcionales

## 📁 Estructura del Repositorio

```
Final/
├── data/
│ ├── data_abandono_estudiantil.csv 
│ ├── datos_anemia_1.csv 
│ ── datos_hipotecas_final.csv 
├── Codigo_Completo_Final.R 
├── Final - Grupo 1.qmd 
├── Final - Grupo 1.html 
├── modelo_logbinomial.rds 
└── README.md # Este archivo
```


## ️ Paquetes Utilizados

- **tidyverse** - Manipulación y visualización de datos
- **MASS** - Modelos estadísticos avanzados
- **rms** - Regression Modeling Strategies
- **car** - Companion to Applied Regression
- **lmtest** - Testing linear regression models
- **brant** - Brant test for proportional odds
- **pscl** - Political Science Computational Laboratory
- **caret** - Classification and Regression Training
- **pROC** - ROC curve analysis
- **ROSE** - Handling imbalanced datasets
- **caTools** - Utilities including ROC curves
- **gtsummary** - Tablas resumen profesionales
- **sjPlot** - Visualización de modelos estadísticos
- **ggeffects** - Efectos marginales
- **randomForest** - Random Forest para importancia de variables
- **vip** - Variable Importance Plots

## 📊 Resultados Principales

### Pregunta 1: Abandono Estudiantil
- Modelo logístico con accuracy del 83.89%
- Factores significativos: promedio previo, asistencia, horas de estudio, materias reprobadas, beca y trabajo
- AUC = 0.785

### Pregunta 2: Aprobación de Hipotecas
- Modelo log-binomial con Risk Ratios interpretables
- Variables clave: empleo fijo (RR=1.63), historial crediticio excelente (RR=1.72), ingresos altos (RR=1.61)
- Accuracy = 70.2%

### Pregunta 3: Anemia Infantil
- Regresión Poisson robusta
- Suplemento de hierro: RR = 2.31 (factor protector)
- Nivel de riqueza pobre: RR = 1.75 (factor de riesgo)

### Pregunta 4: Elección de Programa
- Regresión logística multinomial
- Accuracy = 83.89%, Kappa = 0.758
- Variables predictoras: edad, ingreso, experiencia, carrera origen, puntaje cuantitativo

### Pregunta 5: Desempeño Académico
- Regresión logística ordinal con odds proporcionales
- Beca: OR = 4.91 (factor facilitador)
- Inasistencias: OR = 0.64 (factor de riesgo)
- Prueba de Brant confirma supuesto de odds proporcionales (p = 0.993)

##  Cómo Ejecutar el Código

1. **Instalar dependencias:**
```r
install.packages(c("tidyverse", "MASS", "rms", "car", "lmtest", 
                   "brant", "pscl", "caret", "pROC", "ROSE", 
                   "caTools", "gtsummary", "sjPlot", "ggeffects",
                   "randomForest", "vip"))
```

