---
layout: page
title: AiTenea
description: Valuación automática de inmuebles con machine learning geoespacial
img: assets/img/projects/aitenea/mapa_parcelas_detalle.png
permalink: /projects/aitenea/
lang: es
category: work
importance: 1
related_publications: false
---

{% include case_study_styles.liquid %}

<div class="cs-hero">
  <div class="cs-brand">
    <span class="cs-logo-dark"><img src="{{ '/assets/img/projects/aitenea/logo_aitenea.png' | relative_url }}" alt="AiTenea"></span>
    <span class="cs-by">plataforma desarrollada por</span>
    <a href="https://www.friwi.co/casos/aitenea" target="_blank" rel="noopener"><img class="cs-friwi" src="{{ '/assets/img/projects/aitenea/logo_friwi.png' | relative_url }}" alt="FriWi"></a>
  </div>
  <p class="cs-lead">
    Plataforma de análisis predictivo para el sector inmobiliario: el usuario elige una parcela en un mapa interactivo y obtiene al instante una estimación de su valor. El objetivo es llevar las tasaciones <strong>de un mes a tiempo real</strong>.
  </p>
  <div class="cs-facts">
    <div class="cs-fact"><span>Rol</span><strong>Data Scientist del modelo de valuación</strong></div>
    <div class="cs-fact"><span>Año</span><strong>2025</strong></div>
    <div class="cs-fact"><span>Zonas</span><strong>San Isidro, Vicente López y CABA</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>Python · ML geoespacial</strong></div>
  </div>
</div>

## Mi rol

Estuve a cargo del **motor de valuación**: el modelo que estima el precio por metro cuadrado de cada parcela y que alimenta la plataforma desarrollada por [FriWi](https://www.friwi.co/casos/aitenea). Trabajé el proceso completo, desde los datos crudos hasta las predicciones que consume el producto.

- Diseñé y entrené los modelos de valuación (USD/m²) para casas, terrenos y departamentos.
- Construí las variables espaciales que explican el precio: entorno urbano, normativa, accesibilidad y características de los vecinos cercanos.
- Desarrollé **intervalos de confianza** y un **índice de fiabilidad** por predicción, para que la plataforma muestre no solo un valor sino también cuán seguro es.
- Llevé el trabajo de los notebooks a un **pipeline modular en Python** que genera predicciones para todas las parcelas de cada municipio.
- Migré el prototipo inicial, desarrollado en R, a la versión en Python que se usa en producción.

## Cobertura

El proyecto empezó en dos municipios de la zona norte del Gran Buenos Aires y luego se extendió a la Ciudad de Buenos Aires. Cada zona tiene su propia configuración y modelos según el tipo de inmueble.

<div class="row align-items-center">
  <div class="col-md-5 mb-3 cs-map">
    {% include figure.liquid path="assets/img/projects/aitenea/mapa_cobertura.png" class="img-fluid" alt="Mapa de parcelas cubiertas en San Isidro, Vicente López y CABA" %}
  </div>
  <div class="col-md-7">
    <div class="cs-muni">
      <span class="cs-swatch" style="background: var(--cs-si)"></span>
      <div><strong>San Isidro</strong><br><small>Casas, terrenos y departamentos</small></div>
      <span class="cs-count">~69.000 parcelas</span>
    </div>
    <div class="cs-muni">
      <span class="cs-swatch" style="background: var(--cs-vl)"></span>
      <div><strong>Vicente López</strong><br><small>Casas, terrenos y departamentos</small></div>
      <span class="cs-count">~64.000 parcelas</span>
    </div>
    <div class="cs-muni">
      <span class="cs-swatch" style="background: var(--cs-caba)"></span>
      <div><strong>CABA</strong><br><small>Departamentos</small></div>
      <span class="cs-count">~318.000 parcelas</span>
    </div>
    <p class="cs-total">Más de <strong>450.000 parcelas</strong> con valuación estimada.</p>
  </div>
</div>

## Datos y variables

### Preparación de los datos

El modelo se entrena con avisos publicados en portales inmobiliarios. Como son datos cargados por personas, buena parte del trabajo estuvo en hacerlos confiables:

- **Controles de consistencia** entre superficie cubierta, descubierta y total, y corrección de antigüedades mal cargadas.
- **Imputación** de valores faltantes en lugar de descartar avisos, para no perder información en zonas con poca oferta.
- **Variable objetivo homogénea:** precio por m² calculado con el mismo criterio para todos los avisos, para que sean comparables dentro de cada tipo de inmueble.

### Variables del modelo

Cada aviso se enriquece con capas geográficas públicas mediante cruces espaciales:

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-house"></i><strong>Inmueble</strong><p>Superficies, antigüedad, ambientes y amenities.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-map-location-dot"></i><strong>Normativa</strong><p>Zonificación, barrios cerrados y urbanizaciones.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-route"></i><strong>Accesibilidad</strong><p>Distancia a avenidas, al río, a escuelas y a transporte.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-people-group"></i><strong>Censo 2022</strong><p>Indicadores socioeconómicos por radio censal.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-circle-nodes"></i><strong>Vecindario</strong><p>Rezagos espaciales: precio y superficie de los inmuebles cercanos.</p></div>
</div>

Los **rezagos espaciales** resumen lo que pasa alrededor de cada inmueble a partir de una matriz de pesos por distancia, y capturan el efecto "barrio" que las demás variables no alcanzan a explicar. Para evitar fuga de información, se calculan solo con los datos de entrenamiento.

## Modelado

### Algoritmos

Comparé **Random Forest**, **XGBoost** y **LightGBM**, con búsqueda de hiperparámetros en Optuna. En casas y terrenos, Random Forest y XGBoost tuvieron errores similares, y Random Forest permite además estimar un intervalo de confianza para cada predicción. En departamentos de CABA, el modelo final es XGBoost.

### Limpieza iterativa de outliers

Los avisos con precios irreales distorsionan el modelo. En lugar de un filtro fijo, armé un ciclo: se ajusta el modelo, se descartan los avisos con desvíos extremos y se vuelve a entrenar, hasta que el desempeño se estabiliza. El proceso elimina alrededor del 1&nbsp;% de la muestra y llevó el R² de validación de 0,62 a 0,77.

### Incertidumbre y fiabilidad

Una tasación sin margen de error es difícil de usar. Por eso cada predicción incluye un **intervalo de confianza**, estimado con el método _jackknife-after-bootstrap_, y un **índice de fiabilidad** que relaciona el ancho del intervalo con el valor estimado.

### Validación e interpretabilidad

El desempeño se mide con **validación cruzada** de 5 particiones, siempre sobre datos que el modelo no vio. Para entender qué aprende el modelo, analicé la importancia de variables y gráficos de dependencia parcial, y revisé los residuos por tipo de inmueble y sobre el mapa.

## Resultados

Modelo de casas y terrenos en San Isidro y Vicente López:

<div class="row text-center mt-3">
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">~5.300</div><div class="cs-metric-label">avisos para entrenar</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">0,77</div><div class="cs-metric-label">R² de validación</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">70 %</div><div class="cs-metric-label">de las predicciones fuera de muestra a menos de ±USD 250/m²</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">92 %</div><div class="cs-metric-label">de los precios observados dentro del intervalo</div></div></div>
</div>

Para departamentos en CABA entrené un modelo XGBoost con más de 18.000 avisos. Es un mercado mucho más heterogéneo, donde los rezagos espaciales y las variables de entorno resultaron clave para capturar las diferencias entre barrios.

## De notebooks a producción

La unidad de predicción es la **parcela**: el pipeline estima un valor, con su intervalo, para cada una.

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/aitenea/mapa_parcelas_detalle.png" class="img-fluid rounded" alt="Detalle del parcelario de San Isidro" %}
  </div>
</div>
<div class="caption">Detalle del parcelario de San Isidro: cada polígono recibe una valuación.</div>

Una vez validados los modelos, los reorganicé en scripts modulares que procesan cada municipio y tipo de inmueble de forma automática:

<ol class="cs-steps">
  <li>Avisos de portales inmobiliarios</li>
  <li>Limpieza y controles de consistencia</li>
  <li>Cruces con capas espaciales</li>
  <li>Variables y rezagos espaciales</li>
  <li>Entrenamiento y validación</li>
  <li>Intervalos de confianza y fiabilidad</li>
  <li>Predicción para cada parcela</li>
  <li>Plataforma AiTenea</li>
</ol>

### Cómo se valúa una parcela

La mayoría de las parcelas no tiene un aviso publicado. Para valuarlas, el pipeline construye un **inmueble típico** a partir de las características de los avisos cercanos, le suma las variables de su ubicación y estima su valor como casa y como terreno. Además, una **predicción a medida** permite valuar un inmueble puntual con las características que indique el usuario.

### Diseño del pipeline

- Cada etapa es un script independiente: construcción de variables, entrenamiento, predicción masiva sobre parcelas y predicción a medida.
- La configuración de cada municipio vive en archivos YAML, así que sumar una nueva zona no requiere tocar el código.
- Un script de orquestación corre todo el flujo para varios tipos de inmueble en lote.
- Como complemento, desarrollé un flujo de **interpolación espacial** que genera superficies de precio por tipo de inmueble y las resume por parcela (mínimo, máximo y promedio).
- Para revisar los resultados con el equipo armé **visores web** con Leaflet, que permiten recorrer las predicciones en el mapa antes de integrarlas a la plataforma.

## Herramientas

<div class="cs-pills">
  <span>Python</span><span>pandas</span><span>GeoPandas</span><span>scikit-learn</span><span>XGBoost</span><span>LightGBM</span><span>Optuna</span><span>libpysal</span><span>PyKrige</span><span>forestci</span><span>Leaflet</span><span>QGIS</span><span>R</span><span>Git</span>
</div>

<div class="mt-4">
  <a class="btn btn-sm z-depth-0" role="button" href="https://www.friwi.co/casos/aitenea" target="_blank" rel="noopener">
    <i class="fa-solid fa-arrow-up-right-from-square"></i> Ver el caso en FriWi
  </a>
</div>

<p class="text-muted mt-4"><small>Por confidencialidad, se omiten los datos, el detalle de las variables y los parámetros de los modelos.</small></p>
