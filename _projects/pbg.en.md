---
layout: page
title: Gross Geographic Product
description: Estimating the provincial economic accounts of Corrientes and Chaco
img: assets/img/projects/pbg/pbg_chaco_tarjeta.png
permalink: /projects/pbg/
lang: en
category: work
importance: 3
related_publications: false
---

{% include case_study_styles.liquid %}

<div class="cs-hero">
  <div class="cs-brand">
    <span class="cs-badge">Consulting · Provincial economic accounts</span>
  </div>
  <p class="cs-lead">
    The <strong>Gross Geographic Product (PBG)</strong> measures the value of everything produced in an Argentine province, the provincial equivalent of GDP. For the provincial statistics offices of <strong>Corrientes</strong> and <strong>Chaco</strong>, the project developed the methodology and the calculation processes that estimate the PBG by economic sector, with quarterly series at current and constant prices.
  </p>
  <div class="mx-auto" style="max-width: 600px">
    {% include figure.liquid path="assets/img/projects/pbg/pbg_chaco_desestacionalizado_en.png" class="img-fluid rounded" alt="Chaco PBG at constant prices: original, seasonally adjusted and trend-cycle series, 2004 to 2025" %}
  </div>
  <div class="caption mt-0 mb-3">Quarterly Chaco PBG since 2004: original, seasonally adjusted and trend-cycle series. Source: DiPIET Chaco, Q4 2025 report.</div>
  <div class="cs-facts">
    <div class="cs-fact"><span>Role</span><strong>Economic statistics consultant</strong></div>
    <div class="cs-fact"><span>Period</span><strong>2022 – 2024</strong></div>
    <div class="cs-fact"><span>Coverage</span><strong>Corrientes and Chaco provinces</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>R · Git</strong></div>
  </div>
</div>

## Role

The work was carried out with each office's economic accounts team and covered the full process, from the data sources to publishable series:

- **Methodological design** of the estimation for each sector, following national accounts guidelines with 2004 as the base year.
- **Collection and harmonization** of more than 30 provincial and national data sources.
- **Calculation processes** in R: one reproducible script per sector that produces the series and allows quarterly updates.
- **Documentation**: a methodological report per sector and an update guide for each office's team.

## Coverage

<div class="cs-groups">
  <div class="cs-group" style="--cs-group-color: var(--cs-g1)">
    <div class="cs-group-head"><span>Corrientes</span><small>2023 – 2024</small></div>
    <strong>Full PBG estimation</strong>
    <p>All 16 economic sectors, with quarterly series from 2004 at current and constant prices, a final methodological report and an update guide.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g2)">
    <div class="cs-group-head"><span>Chaco</span><small>2022</small></div>
    <strong>Methodological revision of the PBG</strong>
    <p>A new 2004 base year, splicing with the previous series (ECLAC 2008 methodology) and calculation processes for manufacturing, construction, trade, hotels, transport, public administration, education, health and community services.</p>
  </div>
</div>

<div class="row text-center mt-3">
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">2</div><div class="cs-metric-label">provinces</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">16</div><div class="cs-metric-label">economic sectors</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">2004</div><div class="cs-metric-label">base year and start of the series</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">30+</div><div class="cs-metric-label">data sources</div></div></div>
</div>

### Economic sectors

The PBG is broken down into the 16 sections (letters) of Argentina's National Classification of Economic Activities (ClaNAE 2004), and each section into its branches:

<ul class="cs-sectors">
  <li style="--cs-group-color: var(--cs-g1)"><b>A</b>Agriculture, livestock and forestry</li>
  <li style="--cs-group-color: var(--cs-g1)"><b>B</b>Fishing</li>
  <li style="--cs-group-color: var(--cs-g1)"><b>C</b>Mining and quarrying</li>
  <li style="--cs-group-color: var(--cs-g2)"><b>D</b>Manufacturing</li>
  <li style="--cs-group-color: var(--cs-g2)"><b>E</b>Electricity, gas and water</li>
  <li style="--cs-group-color: var(--cs-g2)"><b>F</b>Construction</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>G</b>Wholesale and retail trade</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>H</b>Hotels and restaurants</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>I</b>Transport and communications</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>J</b>Financial intermediation</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>K</b>Real estate and business activities</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>L</b>Public administration</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>M</b>Education</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>N</b>Health and social services</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>O</b>Community and personal services</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>P</b>Domestic services</li>
</ul>
<div class="caption">Colors group primary sectors, goods-producing sectors, private services, and public and social services.</div>

## Methodology

<ol class="cs-steps">
  <li>Data source collection</li>
  <li>Classification harmonization</li>
  <li>2004 base year</li>
  <li>Volume and price indicators per branch</li>
  <li>Constant- and current-price series</li>
  <li>Temporal disaggregation</li>
  <li>Seasonal adjustment</li>
  <li>PBG aggregation</li>
</ol>

### Base year

For each branch, the **Gross Value of Production (VBP)**, **Intermediate Consumption (CI)** and **Gross Value Added (VAB)** are estimated. The starting point is the **2004 National Economic Census**, which publishes these aggregates by province for 2003; values are carried forward to 2004 with the change in each branch's turnover or wages. Where the census falls short, other sources are used, such as the population censuses or the National Survey of Large Companies.

### Extrapolation with indicators

From the base year, each branch is projected with indicators that track its evolution: a **volume index** for the constant-price series and a **value or price index** for the current-price series. The indicator depends on the information available for each sector:

<div class="cs-features" style="grid-template-columns: repeat(auto-fit, minmax(240px, 1fr))">
  <div class="cs-feature"><i class="fa-solid fa-wheat-awn"></i><strong>Physical output</strong><p>Crop tonnage and prices; livestock slaughter, movements and stocks; planted forest area.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-file-invoice-dollar"></i><strong>Turnover</strong><p>Gross receipts declared by branch, deflated with regional price indices.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-id-badge"></i><strong>Employment and wages</strong><p>Registered employment and wage bill in the private sector; headcount and pay in the public sector.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-helmet-safety"></i><strong>Factor income</strong><p>Construction: formal and informal labor plus the value of materials.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-people-group"></i><strong>Household surveys</strong><p>Domestic services and informal work from the EPH survey, expanded to the province with census data.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-tower-cell"></i><strong>Service indicators</strong><p>Passengers, freight, telecom subscriptions, loans and deposits.</p></div>
</div>

### Quarterly series

Many sources are annual, but the PBG is published quarterly. Annual series were **disaggregated to quarters with the Denton-Cholette method**, using related quarterly indicators where available. In agriculture, a monthly planting and harvest matrix assigns each crop its seasonal pattern. **X-13ARIMA-SEATS** was applied to the final series to obtain seasonally adjusted and trend-cycle series.

In Chaco, the new series was also **spliced with the historical series** computed under the ECLAC 2008 methodology, to keep it comparable over time.

## Data sources

The calculation combines provincial administrative records with national statistics. No single source covers every sector, so a large part of the work was harmonizing classifications (ClaNAE, tax and employment codes), periods and units.

<h3 class="h6 mt-4">Provincial</h3>
<div class="cs-pills">
  <span>Revenue offices (gross receipts tax)</span><span>Public sector headcount and payroll</span><span>Ministries of Production (agriculture, forestry, industry)</span><span>Industrial production surveys</span><span>Natural resources</span><span>Municipal building permits</span><span>Energy and water utilities</span><span>Urban transport</span>
</div>

<h3 class="h6 mt-3">INDEC (national statistics office)</h3>
<div class="cs-pills">
  <span>2004 National Economic Census</span><span>Population Censuses 2001, 2010 and 2022</span><span>EPH household survey</span><span>ENGHo expenditure survey</span><span>Monthly Industrial Survey</span><span>Regional CPI</span><span>Wholesale price index</span><span>Construction cost index</span><span>EMAE activity estimator</span><span>Volume and implicit price indices</span>
</div>

<h3 class="h6 mt-3">Other national agencies</h3>
<div class="cs-pills">
  <span>OEDE – SIPA (Ministry of Labor)</span><span>SENASA</span><span>Secretariat of Agriculture</span><span>Central Bank (BCRA)</span><span>Insurance Superintendency</span><span>Vehicle registry (DNRPA)</span><span>Secretariat of Energy</span><span>CAMMESA</span><span>ENACOM</span><span>ANAC</span><span>CNRT</span><span>IERIC</span><span>Portland Cement Producers Association</span><span>FAIM</span>
</div>

## From calculation to production

The goal was not just to estimate the series once, but to leave a process each office could **update on its own**:

- **One R script per sector**, version-controlled in Git, with the whole calculation: reading sources, base year, indices and final series.
- **Standardized outputs**: VBP, CI and VAB by branch, quarter and price type, ready to aggregate into the total PBG.
- **Methodological report** per sector, with the sources and estimation criteria at constant and current prices.
- **Update guide** setting out the steps to add each new quarter.

## Tools

<div class="cs-pills">
  <span>R</span><span>data.table</span><span>tidyverse</span><span>seasonal (X-13)</span><span>tempdisagg</span><span>forecast</span><span>openxlsx</span><span>R Markdown</span><span>SQL</span><span>Git</span><span>GitLab</span>
</div>

<p class="text-muted mt-4"><small>For confidentiality reasons, results, administrative records and calculation details are omitted.</small></p>
