---
layout: page
title: Neighborhood clustering
description: Socioeconomic classification of Córdoba's neighborhoods with multivariate analysis
img: assets/img/projects/clustering/mapa_barrios_tarjeta.png
permalink: /projects/clustering/
lang: en
category: work
importance: 4
related_publications: false
tabs: true
---

{% include case_study_styles.liquid %}

<div class="cs-hero">
  <div class="row align-items-center">
    <div class="col-md-7">
      <div class="cs-brand">
        <span class="cs-badge">University project · Socioeconomic analysis</span>
      </div>
      <p class="cs-lead">
        Which neighborhoods of the city of Córdoba, Argentina, are alike? This analysis groups the dataset's <strong>63 neighborhoods</strong> by <strong>40 socioeconomic indicators</strong> (education, health, employment, poverty and housing) to let neighborhood profiles emerge from the data instead of defining them in advance.
      </p>
    </div>
    <div class="col-md-5 cs-map">
      {% include figure.liquid path="assets/img/projects/clustering/mapa_barrios_cordoba.png" class="img-fluid" alt="Map of the neighborhoods of the city of Córdoba" %}
      <div class="caption mt-0">Neighborhoods of the city of Córdoba. Source: Córdoba Provincial Statistics and Census Office (2008 layer).</div>
    </div>
  </div>
  <div class="cs-facts">
    <div class="cs-fact"><span>Context</span><strong>Master's in Applied Statistics, UNC</strong></div>
    <div class="cs-fact"><span>Course</span><strong>Data Analysis Project</strong></div>
    <div class="cs-fact"><span>Unit of analysis</span><strong>63 neighborhoods of Córdoba</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>R · Quarto</strong></div>
  </div>
</div>

## Approach

This is an applied **multivariate analysis** project: with this many variables, looking at indicators one at a time is not enough. The analysis covers the whole process, from the dataset to the interpretation of the groups:

- Comparison of two **hierarchical clustering** methods (Ward and complete linkage) to keep the one that least distorts the original distances.
- **K-means** as an alternative, assessing the number of groups and the stability of the solution.
- Quality assessment of each clustering with the **cophenetic correlation**, **Hartigan's rule** and the **silhouette coefficient**.
- **Profiling** of the resulting groups based on their average indicators.
- **Validation** of the interpretation with a factor analysis, to see whether the dimensions that separate neighborhoods match the groups found.

## Data

The dataset has one row per neighborhood, and each variable is the **share of people or households** in a category. Since all variables are on the same scale (0 to 1), they can be compared directly with Euclidean distances.

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-graduation-cap"></i><strong>Education</strong><p>Highest level attained by the head of household.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-book-open"></i><strong>Literacy</strong><p>People aged 3 or older who can read and write.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-notes-medical"></i><strong>Health</strong><p>Health insurance coverage.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-briefcase"></i><strong>Employment</strong><p>Employed, unemployed and inactive people aged 14 or older.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-hand-holding-heart"></i><strong>Poverty</strong><p>Unmet basic needs (NBI) and household material deprivation.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-house-chimney"></i><strong>Housing</strong><p>Dwelling type and household size.</p></div>
</div>

<div class="row text-center mt-3">
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">63</div><div class="cs-metric-label">neighborhoods</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">40</div><div class="cs-metric-label">socioeconomic variables</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">2</div><div class="cs-metric-label">method families: hierarchical and K-means</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">4</div><div class="cs-metric-label">neighborhood profiles</div></div></div>
</div>

## Methodology

<ol class="cs-steps">
  <li>Dataset: 63 neighborhoods × 40 shares</li>
  <li>Hierarchical clustering: Ward and complete</li>
  <li>Cophenetic correlation</li>
  <li>Number of groups: Hartigan's rule</li>
  <li>K-means: elbow and silhouette</li>
  <li>Stability across random seeds</li>
  <li>Group profiling</li>
  <li>Comparison with factor analysis</li>
</ol>

### Hierarchical clustering

Two criteria for merging neighborhoods into groups were compared. **Ward's method** merges, at each step, the groups that least increase within-group variability. **Complete linkage** (farthest neighbor) defines the distance between two groups as the largest distance between their members.

To choose between them, the **cophenetic correlation** was computed; it measures how well the dendrogram preserves the original distances between neighborhoods. Complete linkage scored **0.75**, against **0.54** for Ward, so the analysis continues with that method.

The cut point of the tree was chosen with **Hartigan's rule**, which measures how much within-group variability drops when one more group is added. The statistic falls from about 43 to 6 when going from 3 to 4 groups: beyond that point, adding groups adds little. Together with a reading of the dendrogram, the tree was cut into **4 groups**.

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/clustering/dendrograma_4_grupos.png" class="img-fluid rounded" alt="Complete-linkage dendrogram of the 63 neighborhoods, cut into 4 groups" %}
  </div>
</div>
<div class="caption">Complete-linkage dendrogram. Each box is one of the 4 neighborhood groups.</div>

### K-means

As an alternative, **K-means** was applied: a partitioning method that needs the number of groups up front. The elbow plot of the within-group sum of squares suggests **3 groups**, and the silhouette coefficient is similar for 2 and 3.

<div class="row">
  <div class="col-sm mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/projects/clustering/codo_scdg.png" class="img-fluid rounded" alt="Elbow plot of the within-group sum of squares by number of groups" %}
  </div>
  <div class="col-sm mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/projects/clustering/silueta.png" class="img-fluid rounded" alt="Silhouette coefficient by number of groups" %}
  </div>
</div>
<div class="caption">Left: within-group sum of squares (SCDG). Right: silhouette coefficient. Both by number of groups.</div>

Since K-means starts from random centroids, it was run with **10 different seeds**: 8 of them reached the same solution, so the result is stable. However, the per-group silhouette was between **0.39 and 0.42**, which on Rousseeuw's (1987) scale indicates a **weak structure** that could be artificial.

### Which clustering to use?

For that reason, the neighborhood profiles are based on the **4-group hierarchical clustering**, which also separates profiles that were blended together with 3 groups.

## Results

### Four neighborhood profiles

<div class="cs-groups">
  <div class="cs-group" style="--cs-group-color: var(--cs-g1)">
    <div class="cs-group-head"><span>Group 1</span><small>42 neighborhoods · 67%</small></div>
    <strong>Lower-middle socioeconomic level</strong>
    <p>Lower-middle-class residential areas. Heads of household with primary or secondary education; almost 90% of people without material deprivation; households of 2 to 4 members.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g2)">
    <div class="cs-group-head"><span>Group 2</span><small>4 neighborhoods · 6%</small></div>
    <strong>Central university neighborhoods</strong>
    <p>One- or two-person households living in apartments, heads of household with some university education and the highest share of inactive people, likely due to students.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g3)">
    <div class="cs-group-head"><span>Group 3</span><small>14 neighborhoods · 22%</small></div>
    <strong>Low socioeconomic level (vulnerable)</strong>
    <p>The least favorable indicators: education up to primary school, over half of people without health insurance, the highest unemployment and NBI, large households and precarious housing.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g4)">
    <div class="cs-group-head"><span>Group 4</span><small>3 neighborhoods · 5%</small></div>
    <strong>Upper-middle socioeconomic level</strong>
    <p>The highest university attainment, the best health coverage, the highest employment and the largest share without material deprivation. A mix of houses and apartments.</p>
  </div>
</div>

### Key indicators

Average percentage of each indicator across the neighborhoods in each group:

<div class="cs-table-wrap">
  <table class="cs-table">
    <thead>
      <tr>
        <th>Indicator</th>
        <th style="--cs-group-color: var(--cs-g1)"><span></span>G1</th>
        <th style="--cs-group-color: var(--cs-g2)"><span></span>G2</th>
        <th style="--cs-group-color: var(--cs-g3)"><span></span>G3</th>
        <th style="--cs-group-color: var(--cs-g4)"><span></span>G4</th>
      </tr>
    </thead>
    <tbody>
      <tr><td>Head of household with a university degree</td><td>8.8</td><td>17.7</td><td>1.0</td><td class="cs-max">18.6</td></tr>
      <tr><td>People without health insurance</td><td>29.1</td><td>18.6</td><td class="cs-max">57.9</td><td>17.8</td></tr>
      <tr><td>Unemployed (aged 14 or older)</td><td>4.3</td><td>4.3</td><td class="cs-max">6.0</td><td>2.9</td></tr>
      <tr><td>People with NBI 1</td><td>6.1</td><td>2.2</td><td class="cs-max">19.5</td><td>2.3</td></tr>
      <tr><td>People without material deprivation</td><td>89.9</td><td>77.3</td><td>68.7</td><td class="cs-max">90.8</td></tr>
      <tr><td>Households in apartments</td><td>13.9</td><td class="cs-max">81.5</td><td>6.3</td><td>52.2</td></tr>
      <tr><td>Single-person households</td><td>15.3</td><td class="cs-max">40.0</td><td>12.9</td><td>27.3</td></tr>
      <tr><td>Households with 5 or more members</td><td>23.0</td><td>4.4</td><td class="cs-max">34.5</td><td>10.9</td></tr>
    </tbody>
  </table>
</div>
<div class="caption">Highlighted: the highest value of each indicator.</div>

### Education

The education level of the head of household is the variable that most clearly separates the groups: group 3 is dominated by primary and incomplete secondary education, while groups 2 and 4 lean toward tertiary and university levels.

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/clustering/nivel_educativo.png" class="img-fluid rounded" alt="Average share of heads of household by education level, per neighborhood group" %}
  </div>
</div>
<div class="caption">Average share of heads of household by highest education level attained, per neighborhood group (labels in Spanish).</div>

### Health, poverty and housing

The remaining dimensions confirm the same pattern. Each tab shows the average share per neighborhood group (chart labels in Spanish):

{% tabs indicators %}

{% tab indicators Health %}

{% include figure.liquid path="assets/img/projects/clustering/cobertura_salud.png" class="img-fluid rounded" alt="Average share of people with and without health insurance, per group" %}

<div class="caption">In group 3, more than half of people have no health insurance; in groups 2 and 4, fewer than one in five.</div>

{% endtab %}

{% tab indicators NBI %}

{% include figure.liquid path="assets/img/projects/clustering/nbi.png" class="img-fluid rounded" alt="Average share of people by type of unmet basic need, per group" %}

<div class="caption">Group 3 has the highest values of NBI 1, 3, 4 and 5. Group 2 stands out in NBI 2, a striking result.</div>

{% endtab %}

{% tab indicators Deprivation %}

{% include figure.liquid path="assets/img/projects/clustering/privacion_material.png" class="img-fluid rounded" alt="Average share of people by household material deprivation, per group" %}

<div class="caption">Group 3 has the highest asset deprivation and group 2 the highest resource deprivation. Groups 1 and 4 are around 90% without deprivation.</div>

{% endtab %}

{% tab indicators Housing %}

{% include figure.liquid path="assets/img/projects/clustering/tipo_vivienda.png" class="img-fluid rounded" alt="Average share of households by dwelling type, per group" %}

<div class="caption">Group 2 lives mostly in apartments; group 3 in houses, with the highest share of shacks and makeshift dwellings; group 4 mixes both.</div>

{% endtab %}

{% tab indicators Households %}

{% include figure.liquid path="assets/img/projects/clustering/tamano_hogar.png" class="img-fluid rounded" alt="Average share of households by number of members, per group" %}

<div class="caption">One- and two-person households dominate in group 2, and households of 5 or more members in group 3.</div>

{% endtab %}

{% endtabs %}

## Validation with factor analysis

To check the groups with a different technique, a **factor analysis** with varimax rotation was run and 3 factors were extracted. Based on the variables with the highest loadings on each one, they are interpreted as follows:

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-people-roof"></i><strong>Factor 1 · Large households</strong><p>Households of 3 to 6 members living in houses, versus one- or two-person households in apartments.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-user-graduate"></i><strong>Factor 2 · Low education and unemployment</strong><p>Incomplete primary and secondary education and unemployment, versus university education and employment.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-house-crack"></i><strong>Factor 3 · Vulnerability and precarious housing</strong><p>NBI, illiteracy, lack of health insurance, shacks and makeshift dwellings.</p></div>
</div>

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/clustering/factores_por_grupo.png" class="img-fluid rounded" alt="Average level of each factor per neighborhood group" %}
  </div>
</div>
<div class="caption">Average level of each factor per neighborhood group.</div>

The factors support the clustering: group 2 has the lowest score on large households, consistent with neighborhoods of small households and apartments, and group 3 is the only one with positive scores on the low-education factor and the highest on vulnerability. In the other groups, factor 3 is harder to interpret because it combines very diverse variables.

## Conclusions

- Córdoba's neighborhoods fall into **four socioeconomic profiles**, and one in five neighborhoods (group 3) concentrates the most vulnerable conditions.
- Comparing methods matters: the cophenetic correlation ruled out an option that distorted the data, and the silhouette flagged that the K-means structure was weak.
- Factor analysis reached, by a different route, the same dimensions that separate the groups: household size and type, education and employment, and vulnerability.
- Some results deserve a closer look, such as the relatively high share of NBI 2 and resource deprivation in the university neighborhoods, despite their good indicators elsewhere.

## Tools

<div class="cs-pills">
  <span>R</span><span>tidyverse</span><span>data.table</span><span>ggplot2</span><span>cluster</span><span>factoextra</span><span>psych</span><span>kableExtra</span><span>Quarto</span>
</div>

<div class="mt-4">
  <a class="btn btn-sm z-depth-0" role="button" href="https://celinecabas.quarto.pub/clustering/" target="_blank" rel="noopener">
    <i class="fa-solid fa-arrow-up-right-from-square"></i> See the full notebook with code (in Spanish)
  </a>
</div>

<p class="text-muted mt-4"><small>
  References: Hartigan, J. A. (1975). <em>Clustering Algorithms</em>. John Wiley &amp; Sons. ·
  Peña, D. (2002). <em>Análisis de datos multivariantes</em>. McGraw-Hill. ·
  Rousseeuw, P. J. (1987). Silhouettes: a graphical aid to the interpretation and validation of cluster analysis. <em>Journal of Computational and Applied Mathematics</em>, 20, 53-65.
</small></p>
