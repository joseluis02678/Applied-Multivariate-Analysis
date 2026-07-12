<div align="center">

## Diseño de Experimentos y Análisis Inferencial Multivariado 📊

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Quarto](https://img.shields.io/badge/Quarto-4C78B7?style=for-the-badge&logo=quarto&logoColor=white)
![Data Science](https://img.shields.io/badge/Data_Science-102A43?style=for-the-badge&logo=jupyter&logoColor=white)

*Seis diseños experimentales aplicados a problemas reales de ambiente, salud, agroindustria y producción ganadera — aislando fuentes de variabilidad y traduciendo significancia estadística en tamaño de efecto e impacto medible.*

**[📄 Ver informe completo](https://joseluis02678.github.io/Applied-Multivariate-Analysis/PC1/PC1%20-%20Grupo%201.html)** · **[💼 LinkedIn](https://www.linkedin.com/in/jose-l-garay/)**

</div>

---

## 🎯 Resumen Ejecutivo

Este repositorio reúne seis proyectos de inferencia y diseño experimental multivariado: calidad de agua en cuencas andinas, rehabilitación neuropsicológica, perfilamiento de variedades de palta, morfología genética en papa, optimización de dietas lecheras y protocolos de rehabilitación de rodilla.

**Habilidades demostradas:**
- Diseño y análisis de experimentos rigurosos: DCA, DBCA y factoriales 2x2, con bloqueo para aislar fuentes de variabilidad no controladas
- Selección de la prueba de hipótesis conjunta apropiada según el escenario (Z² con covarianza conocida, T² de Hotelling para muestras dependientes e independientes, MANOVA, MANCOVA)
- Verificación exhaustiva de supuestos: normalidad multivariada (Mardia, Henze-Zirkler, Doornik-Hansen), homogeneidad de covarianzas (M de Box), esfericidad de Bartlett
- Traducción de significancia estadística en impacto real mediante el tamaño del efecto (η²), no solo p-valores
- Análisis de seguimiento: ANOVAs univariados, comparaciones por pares y post-hoc de Tukey

---

## 📂 Casos de Estudio

### 1. Calidad de Agua en Ecosistemas Andinos — Prueba Z² Multivariada
**Contexto:** ¿Se degradó la calidad del agua en cuencas de Apurímac, Áncash, Cusco y Junín entre 2017–2019?

Se contrastaron las muestras de 2019 contra los parámetros históricos consolidados (2017–2018) usando una prueba Z² con matriz de covarianza poblacional conocida.

- **Resultado:** Z² = 284.31 frente a un crítico de 9.48 (p < 0.0001)
- **Insight de negocio:** La turbidez explica el 63.7% de la variación total detectada — es el parámetro prioritario para monitoreo y alerta temprana ambiental en estas cuencas.

### 2. Eficacia de Rehabilitación Neuropsicológica — T² de Hotelling (Muestras Dependientes)
**Contexto:** ¿El programa de 8 semanas de mindfulness, memoria de trabajo y estimulación cognitiva alcanza las metas clínicas fijadas en 35 pacientes con déficit atencional leve?

Se comparó el vector de cambios pre-post contra un vector de metas clínicas (20s, 5pts, 3pts) tras verificar normalidad multivariada y outliers.

- **Resultado:** p = 0.447 — no se rechaza H₀
- **Insight de negocio:** El programa cumple exactamente lo prometido clínicamente, sin sub ni sobre-desempeño — evidencia sólida para validar el protocolo como estándar de tratamiento.

### 3. Perfilamiento de Variedades de Palta — T² de Hotelling (Muestras Independientes)
**Contexto:** ¿Las diferencias entre las variedades Hass y Fuerte coinciden con el perfil comercial esperado (semilla, peso, aceite, firmeza)?

- **Resultado:** p = 0.6395 — compatible con el vector hipotético
- **Insight de negocio:** El perfil diferenciado entre variedades queda confirmado estadísticamente, respaldando decisiones de segmentación comercial y etiquetado de producto.

### 4. Morfología Genética en Papa — MANOVA de una vía (DCA)
**Contexto:** Efecto de cuatro variedades de papa sobre altura, tallo, diámetro y longitud de tubérculo (100 plantas, 25 por variedad).

- **Resultado:** p < 2.2e-16 en las 4 variables, η² ≈ 1.00
- **Insight de negocio:** Ninguna variedad es intercambiable con otra (C vs. D es el par más disímil, Pillai = 0.915) — información directa para selección de semilla según el atributo agronómico que se priorice.

### 5. Optimización de Dietas Lecheras — MANOVA Factorial 2x2 (DBCA)
**Contexto:** Sinergia entre tipo de forraje (Alfalfa/Ensilado) y suplementación (Con/Sin concentrado) sobre producción, grasa y proteína, bloqueando por número de partos.

- **Resultado:** Interacción altamente significativa (p < 0.0001), η² de interacción = 0.9817
- **Insight de negocio:** Alfalfa + Concentrado maximiza la producción (+13.7 L/día vs. +4.67 L/día con Ensilado), pero con un efecto de dilución (−0.82% grasa, −0.55% proteína) — un trade-off cuantificado que el área de nutrición animal puede usar para decidir según el objetivo comercial (volumen vs. calidad).

### 6. Protocolos de Rehabilitación de Rodilla — MANCOVA (DBCA)
**Contexto:** Comparación de 3 protocolos de rehabilitación controlando por ángulo basal e IMC, con bloqueo por grupo etario.

- **Resultado:** Diferencias significativas entre los 3 protocolos (p < 0.05 en todas las comparaciones), covariables altamente significativas
- **Insight de negocio:** El MANCOVA es indispensable aquí (no un MANOVA simple): sin controlar por IMC y flexión basal, la comparación entre protocolos estaría sesgada. El bloqueo por edad mejora significativamente la eficiencia del diseño.

---

## 🛠️ Stack Tecnológico

| Categoría | Herramientas |
|---|---|
| Lenguaje | R |
| Ecosistema y Manipulación | `tidyverse`, `dplyr`, `reshape2`, `readxl`, `readr` |
| Inferencia y Diagnóstico | `ICSNP`, `MVTests`, `mvnormtest`, `heplots`, `biotools`, `psych`, `car`, `MVN` |
| Modelado y Comparaciones | `emmeans`, `patchwork`, `gridExtra` |
| Visualización | `ggplot2`, `GGally`, `corrplot`, `ggthemes` |
| Reportes | Quarto / RMarkdown (`knitr`, `kableExtra`) |

---

## 📊 Métricas de Evaluación

| Técnica | Métrica Principal | Resultado Observado |
|---|---|---|
| Z² Multivariada | Estadístico Z² vs. χ² crítico | 284.31 >> 9.48 (p < 0.0001) |
| T² Hotelling (dependientes) | p-valor vs. metas clínicas | p = 0.447 (no rechaza H₀) |
| T² Hotelling (independientes) | p-valor vs. vector μ₀ | p = 0.6395 (compatible con H₀) |
| MANOVA (DCA) | η² multivariado | ≈ 1.00 (100% explicado) |
| MANOVA Factorial | η² de interacción | 0.9817 (sinergia fuerte) |
| MANCOVA | η² del modelo | > 0.85 con covariables significativas |

---

## 📁 Estructura del Repositorio

```text
Applied-Multivariate-Analysis/PC1
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

---

## 👨‍💻 Autor y Equipo

**Jose Luis Garay Ramos**
Estudiante de Estadística especializado en transformar datos complejos en análisis interpretables mediante metodologías estadísticas sólidas y programación en R/Python. En este proyecto lideré la integración y consolidación de las bases de datos, unificando los pipelines de análisis y estructurando el código del repositorio.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jose-l-garay/)
[![Correo](https://img.shields.io/badge/Correo-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:joseluisgarayramos23@gmail.com)

**Equipo de Investigación (Grupo 1):** Meza Asto, Angel D. · Ormeño Sakihama, Daniel Kenyi · Ancco Guzman, Melany Alexandra · Pedraza Laboriano, Jonnathan · Fuentes Bueno, Fiorella · Sobero Aguirre, Fiorella Romina

---
