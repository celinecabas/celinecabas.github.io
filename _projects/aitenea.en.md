---
layout: page
title: AiTenea
description: Automated real estate valuation with geospatial machine learning
img: assets/img/projects/aitenea/mapa_parcelas_detalle.png
permalink: /projects/aitenea/
lang: en
category: work
importance: 1
related_publications: false
---

{% include case_study_styles.liquid %}

<div class="cs-hero">
  <div class="cs-brand">
    <span class="cs-logo-dark"><img src="{{ '/assets/img/projects/aitenea/logo_aitenea.png' | relative_url }}" alt="AiTenea"></span>
    <span class="cs-by">platform built by</span>
    <a href="https://www.friwi.co/casos/aitenea" target="_blank" rel="noopener"><img class="cs-friwi" src="{{ '/assets/img/projects/aitenea/logo_friwi.png' | relative_url }}" alt="FriWi"></a>
  </div>
  <p class="cs-lead">
    A predictive analytics platform for real estate: users pick a land parcel on an interactive map and instantly get an estimate of its value. The goal is to take property appraisals <strong>from one month to real time</strong>.
  </p>
  <div class="cs-facts">
    <div class="cs-fact"><span>Role</span><strong>Data Scientist, valuation model</strong></div>
    <div class="cs-fact"><span>Year</span><strong>2025</strong></div>
    <div class="cs-fact"><span>Areas</span><strong>San Isidro, Vicente López and Buenos Aires City</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>Python · geospatial ML</strong></div>
  </div>
</div>

## My role

I was responsible for the **valuation engine**: the model that estimates the price per square meter of every parcel and feeds the platform built by [FriWi](https://www.friwi.co/casos/aitenea). I worked on the whole process, from raw data to the predictions the product consumes.

- Designed and trained the valuation models (USD/m²) for houses, land lots and apartments.
- Engineered the spatial features that explain prices: urban context, zoning, accessibility and the characteristics of nearby properties.
- Developed **prediction intervals** and a **reliability score** for each prediction, so the platform shows not only a value but also how certain it is.
- Turned the notebook work into a **modular Python pipeline** that produces predictions for every parcel in each municipality.
- Migrated the initial R prototype to the Python version used in production.

## Coverage

The project started in two municipalities in the northern Greater Buenos Aires area and was later extended to Buenos Aires City. Each area has its own configuration and models by property type.

<div class="row align-items-center">
  <div class="col-md-5 mb-3 cs-map">
    {% include figure.liquid path="assets/img/projects/aitenea/mapa_cobertura.png" class="img-fluid" alt="Map of the parcels covered in San Isidro, Vicente López and Buenos Aires City" %}
  </div>
  <div class="col-md-7">
    <div class="cs-muni">
      <span class="cs-swatch" style="background: var(--cs-si)"></span>
      <div><strong>San Isidro</strong><br><small>Houses, land lots and apartments</small></div>
      <span class="cs-count">~69,000 parcels</span>
    </div>
    <div class="cs-muni">
      <span class="cs-swatch" style="background: var(--cs-vl)"></span>
      <div><strong>Vicente López</strong><br><small>Houses, land lots and apartments</small></div>
      <span class="cs-count">~64,000 parcels</span>
    </div>
    <div class="cs-muni">
      <span class="cs-swatch" style="background: var(--cs-caba)"></span>
      <div><strong>Buenos Aires City</strong><br><small>Apartments</small></div>
      <span class="cs-count">~318,000 parcels</span>
    </div>
    <p class="cs-total">More than <strong>450,000 parcels</strong> with an estimated valuation.</p>
  </div>
</div>

## Data and features

### Data preparation

The model is trained on listings from real estate portals. Since this data is entered by people, a large part of the work went into making it reliable:

- **Consistency checks** between covered, uncovered and total surface area, and correction of misreported building ages.
- **Imputation** of missing values instead of dropping listings, to keep information in areas with few listings.
- **A consistent target:** price per m² computed with the same criteria for every listing, so listings are comparable within each property type.

### Model features

Each listing is enriched with public geographic layers through spatial joins:

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-house"></i><strong>Property</strong><p>Surface areas, age, rooms and amenities.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-map-location-dot"></i><strong>Zoning</strong><p>Land-use zoning, gated communities and private neighborhoods.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-route"></i><strong>Accessibility</strong><p>Distance to avenues, the river, schools and public transport.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-people-group"></i><strong>2022 Census</strong><p>Socioeconomic indicators by census tract.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-circle-nodes"></i><strong>Neighborhood</strong><p>Spatial lags: price and size of nearby properties.</p></div>
</div>

**Spatial lags** summarize what happens around each property using a distance-based weights matrix, and capture the "neighborhood effect" that the other features cannot explain. To avoid data leakage, they are computed using training data only.

## Modeling

### Algorithms

I compared **Random Forest**, **XGBoost** and **LightGBM**, with hyperparameter search in Optuna. For houses and land lots, Random Forest and XGBoost had similar errors, and Random Forest also allows estimating a prediction interval for each prediction. For apartments in Buenos Aires City, the final model is XGBoost.

### Iterative outlier removal

Listings with unrealistic prices distort the model. Instead of a fixed filter, I built a loop: fit the model, drop the listings with extreme deviations and retrain, until performance stabilizes. The process removes about 1% of the sample and raised the validation R² from 0.62 to 0.77.

### Uncertainty and reliability

An appraisal without a margin of error is hard to use. That is why every prediction comes with a **prediction interval**, estimated with the _jackknife-after-bootstrap_ method, and a **reliability score** that relates the width of the interval to the estimated value.

### Validation and interpretability

Performance is measured with **5-fold cross-validation**, always on data the model has not seen. To understand what the model learns, I analyzed feature importance and partial dependence plots, and reviewed residuals by property type and on the map.

## Results

Houses and land lots model for San Isidro and Vicente López:

<div class="row text-center mt-3">
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">~5,300</div><div class="cs-metric-label">training listings</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">0.77</div><div class="cs-metric-label">validation R²</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">70%</div><div class="cs-metric-label">of out-of-sample predictions within ±USD 250/m²</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">92%</div><div class="cs-metric-label">of observed prices inside the prediction interval</div></div></div>
</div>

For apartments in Buenos Aires City I trained an XGBoost model on more than 18,000 listings. It is a much more heterogeneous market, where spatial lags and neighborhood features proved key to capturing price differences across areas.

## From notebooks to production

The unit of prediction is the **parcel**: the pipeline estimates a value, with its interval, for each one.

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/aitenea/mapa_parcelas_detalle.png" class="img-fluid rounded" alt="Close-up of the San Isidro parcel map" %}
  </div>
</div>
<div class="caption">Close-up of the San Isidro parcel map: every polygon gets a valuation.</div>

Once the models were validated, I restructured them into modular scripts that process each municipality and property type automatically:

<ol class="cs-steps">
  <li>Real estate portal listings</li>
  <li>Cleaning and consistency checks</li>
  <li>Joins with spatial layers</li>
  <li>Features and spatial lags</li>
  <li>Training and validation</li>
  <li>Prediction intervals and reliability</li>
  <li>Prediction for every parcel</li>
  <li>AiTenea platform</li>
</ol>

### How a parcel is valued

Most parcels have no listing. To value them, the pipeline builds a **typical property** from the characteristics of nearby listings, adds the features of its location, and estimates its value both as a house and as a land lot. An **on-demand prediction** also lets users value a specific property with the characteristics they enter.

### Pipeline design

- Each stage is a separate script: feature engineering, training, batch prediction over parcels and on-demand prediction.
- Each municipality's settings live in YAML files, so adding a new area requires no code changes.
- An orchestration script runs the whole flow for several property types in batch.
- As a complement, I built a **spatial interpolation** flow that produces price surfaces by property type and summarizes them per parcel (minimum, maximum and mean).
- To review results with the team, I built **web map viewers** with Leaflet to explore the predictions on the map before integrating them into the platform.

## Tools

<div class="cs-pills">
  <span>Python</span><span>pandas</span><span>GeoPandas</span><span>scikit-learn</span><span>XGBoost</span><span>LightGBM</span><span>Optuna</span><span>libpysal</span><span>PyKrige</span><span>forestci</span><span>Leaflet</span><span>QGIS</span><span>R</span><span>Git</span>
</div>

<div class="mt-4">
  <a class="btn btn-sm z-depth-0" role="button" href="https://www.friwi.co/casos/aitenea" target="_blank" rel="noopener">
    <i class="fa-solid fa-arrow-up-right-from-square"></i> See the case study at FriWi
  </a>
</div>

<p class="text-muted mt-4"><small>For confidentiality reasons, the data, feature details and model parameters are not disclosed.</small></p>
