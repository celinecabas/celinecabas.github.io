---
layout: page
title: Clustering de barrios
description: Clasificación socioeconómica de los barrios de Córdoba con análisis multivariado
img: assets/img/projects/clustering/mapa_barrios_tarjeta.png
permalink: /projects/clustering/
lang: es
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
        <span class="cs-badge">Proyecto universitario · Análisis socioeconómico</span>
      </div>
      <p class="cs-lead">
        ¿Qué barrios de la ciudad de Córdoba se parecen entre sí? Este análisis agrupa los <strong>63 barrios</strong> de la base según <strong>40 indicadores socioeconómicos</strong> (educación, salud, empleo, pobreza y vivienda) para identificar perfiles de barrio a partir de los datos, sin definirlos de antemano.
      </p>
    </div>
    <div class="col-md-5 cs-map">
      {% include figure.liquid path="assets/img/projects/clustering/mapa_barrios_cordoba.png" class="img-fluid" alt="Mapa de los barrios de la ciudad de Córdoba" %}
      <div class="caption mt-0">Barrios de la ciudad de Córdoba. Fuente: Dirección General de Estadística y Censos de Córdoba (capa 2008).</div>
    </div>
  </div>
  <div class="cs-facts">
    <div class="cs-fact"><span>Contexto</span><strong>Maestría en Estadística Aplicada, UNC</strong></div>
    <div class="cs-fact"><span>Materia</span><strong>Proyecto de Análisis de Datos</strong></div>
    <div class="cs-fact"><span>Unidad de análisis</span><strong>63 barrios de la ciudad de Córdoba</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>R · Quarto</strong></div>
  </div>
</div>

## Enfoque

Es un trabajo de **análisis multivariado** aplicado: con tantas variables en juego, no alcanza con mirar los indicadores de a uno. El análisis recorre todo el proceso, desde la base de datos hasta la interpretación de los grupos:

- Comparación de dos métodos de **clustering jerárquico** (Ward y encadenamiento completo) para elegir el que menos distorsiona las distancias originales.
- **K-means** como alternativa, con evaluación de la cantidad de grupos y de la estabilidad de la solución.
- Medición de la calidad de cada agrupamiento con la **correlación cofenética**, el **criterio de Hartigan** y el **coeficiente de silueta**.
- **Caracterización** de los grupos resultantes a partir de sus indicadores promedio.
- **Validación** de la interpretación con un análisis factorial, para ver si los ejes que separan a los barrios coinciden con los grupos encontrados.

## Datos

La base tiene un registro por barrio y cada variable es una **proporción de personas u hogares** en una categoría. Al estar todas en la misma escala (0 a 1), se pueden comparar directamente con distancias euclídeas.

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-graduation-cap"></i><strong>Educación</strong><p>Máximo nivel alcanzado por el jefe o la jefa de hogar.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-book-open"></i><strong>Alfabetización</strong><p>Personas de 3 años o más que saben leer y escribir.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-notes-medical"></i><strong>Salud</strong><p>Cobertura de obra social o prepaga.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-briefcase"></i><strong>Empleo</strong><p>Ocupados, desocupados e inactivos de 14 años o más.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-hand-holding-heart"></i><strong>Pobreza</strong><p>Necesidades básicas insatisfechas (NBI) y privación material del hogar.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-house-chimney"></i><strong>Vivienda</strong><p>Tipo de vivienda y cantidad de integrantes del hogar.</p></div>
</div>

<div class="row text-center mt-3">
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">63</div><div class="cs-metric-label">barrios</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">40</div><div class="cs-metric-label">variables socioeconómicas</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">2</div><div class="cs-metric-label">familias de métodos: jerárquicos y K-means</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">4</div><div class="cs-metric-label">perfiles de barrio</div></div></div>
</div>

## Metodología

<ol class="cs-steps">
  <li>Base de 63 barrios × 40 proporciones</li>
  <li>Clustering jerárquico: Ward y completo</li>
  <li>Correlación cofenética</li>
  <li>Número de grupos: criterio de Hartigan</li>
  <li>K-means: codo y silueta</li>
  <li>Estabilidad frente a la semilla</li>
  <li>Caracterización de los grupos</li>
  <li>Contraste con análisis factorial</li>
</ol>

### Clustering jerárquico

Se compararon dos criterios para unir barrios en grupos. El **método de Ward** une en cada paso los grupos que menos aumentan la variabilidad interna. El **encadenamiento completo** (vecino más alejado) mide la distancia entre dos grupos como la mayor distancia entre sus elementos.

Para elegir entre ambos se calculó la **correlación cofenética**, que mide cuán bien el dendrograma conserva las distancias originales entre barrios. El encadenamiento completo obtuvo **0,75**, contra **0,54** de Ward, por lo que el análisis continúa con ese método.

Para decidir dónde cortar el árbol se usó el **criterio de Hartigan**, que mide cuánto se reduce la variabilidad dentro de los grupos al sumar uno más. El estadístico cae de alrededor de 43 a 6 al pasar de 3 a 4 grupos: a partir de ahí, sumar grupos aporta poco. Junto con la lectura del dendrograma, el árbol se cortó en **4 grupos**.

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/clustering/dendrograma_4_grupos.png" class="img-fluid rounded" alt="Dendrograma de los 63 barrios con encadenamiento completo, cortado en 4 grupos" %}
  </div>
</div>
<div class="caption">Dendrograma con encadenamiento completo. Cada recuadro es uno de los 4 grupos de barrios.</div>

### K-means

Como alternativa se aplicó **K-means**, un método de partición que necesita la cantidad de grupos de antemano. El gráfico de codo de la suma de cuadrados dentro de los grupos (SCDG) sugiere **3 grupos**, y el coeficiente de silueta es similar con 2 y con 3.

<div class="row">
  <div class="col-sm mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/projects/clustering/codo_scdg.png" class="img-fluid rounded" alt="Gráfico de codo de la suma de cuadrados dentro de los grupos según el número de grupos" %}
  </div>
  <div class="col-sm mt-3 mt-md-0">
    {% include figure.liquid path="assets/img/projects/clustering/silueta.png" class="img-fluid rounded" alt="Coeficiente de silueta según el número de grupos" %}
  </div>
</div>
<div class="caption">Izquierda: suma de cuadrados dentro de los grupos. Derecha: coeficiente de silueta. Ambos según el número de grupos.</div>

Como K-means arranca de centroides al azar, el algoritmo se corrió con **10 semillas distintas**: en 8 de ellas llegó a la misma solución, así que el resultado es estable. Sin embargo, la silueta por grupo quedó entre **0,39 y 0,42**, lo que según la escala de Rousseeuw (1987) indica una **estructura débil** que podría ser artificial.

### ¿Qué clasificación usar?

Por eso, la caracterización de los barrios se basa en la **clasificación jerárquica de 4 grupos**, que además permite distinguir perfiles que con 3 grupos quedaban mezclados.

## Resultados

### Cuatro perfiles de barrio

<div class="cs-groups">
  <div class="cs-group" style="--cs-group-color: var(--cs-g1)">
    <div class="cs-group-head"><span>Grupo 1</span><small>42 barrios · 67 %</small></div>
    <strong>Nivel socioeconómico medio-bajo</strong>
    <p>Zonas residenciales de clase media-baja. Jefes y jefas de hogar con primaria o secundaria; casi el 90&nbsp;% de las personas sin privación material; hogares de 2 a 4 integrantes.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g2)">
    <div class="cs-group-head"><span>Grupo 2</span><small>4 barrios · 6 %</small></div>
    <strong>Barrios céntricos universitarios</strong>
    <p>Hogares de 1 o 2 personas que viven en departamentos, jefes y jefas con universitario incompleto y la mayor proporción de inactivos, probablemente por la presencia de estudiantes.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g3)">
    <div class="cs-group-head"><span>Grupo 3</span><small>14 barrios · 22 %</small></div>
    <strong>Nivel socioeconómico bajo (vulnerables)</strong>
    <p>Los indicadores más desfavorables: educación hasta primaria, más de la mitad de las personas sin cobertura de salud, la mayor desocupación y NBI, hogares numerosos y viviendas precarias.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g4)">
    <div class="cs-group-head"><span>Grupo 4</span><small>3 barrios · 5 %</small></div>
    <strong>Nivel socioeconómico medio-alto</strong>
    <p>El mayor nivel universitario, la mejor cobertura de salud, la ocupación más alta y la mayor proporción sin privación material. Combina casas y departamentos.</p>
  </div>
</div>

### Indicadores clave

Porcentaje promedio de cada indicador en los barrios de cada grupo:

<div class="cs-table-wrap">
  <table class="cs-table">
    <thead>
      <tr>
        <th>Indicador</th>
        <th style="--cs-group-color: var(--cs-g1)"><span></span>G1</th>
        <th style="--cs-group-color: var(--cs-g2)"><span></span>G2</th>
        <th style="--cs-group-color: var(--cs-g3)"><span></span>G3</th>
        <th style="--cs-group-color: var(--cs-g4)"><span></span>G4</th>
      </tr>
    </thead>
    <tbody>
      <tr><td>Jefe/a con universitario completo</td><td>8,8</td><td>17,7</td><td>1,0</td><td class="cs-max">18,6</td></tr>
      <tr><td>Personas sin cobertura de salud</td><td>29,1</td><td>18,6</td><td class="cs-max">57,9</td><td>17,8</td></tr>
      <tr><td>Desocupados (14 años o más)</td><td>4,3</td><td>4,3</td><td class="cs-max">6,0</td><td>2,9</td></tr>
      <tr><td>Personas con NBI 1</td><td>6,1</td><td>2,2</td><td class="cs-max">19,5</td><td>2,3</td></tr>
      <tr><td>Personas sin privación material</td><td>89,9</td><td>77,3</td><td>68,7</td><td class="cs-max">90,8</td></tr>
      <tr><td>Hogares en departamento</td><td>13,9</td><td class="cs-max">81,5</td><td>6,3</td><td>52,2</td></tr>
      <tr><td>Hogares unipersonales</td><td>15,3</td><td class="cs-max">40,0</td><td>12,9</td><td>27,3</td></tr>
      <tr><td>Hogares de 5 o más integrantes</td><td>23,0</td><td>4,4</td><td class="cs-max">34,5</td><td>10,9</td></tr>
    </tbody>
  </table>
</div>
<div class="caption">Resaltado, el valor más alto de cada indicador.</div>

### Educación

El nivel educativo del jefe o la jefa de hogar es la variable que más claramente separa a los grupos: en el grupo 3 predominan la primaria y la secundaria incompleta, mientras que en los grupos 2 y 4 pesan los niveles terciario y universitario.

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/clustering/nivel_educativo.png" class="img-fluid rounded" alt="Proporción promedio de jefes y jefas de hogar según nivel educativo, por grupo de barrios" %}
  </div>
</div>
<div class="caption">Proporción promedio de jefes y jefas de hogar según nivel educativo alcanzado, por grupo de barrios.</div>

### Salud, pobreza y vivienda

El resto de las dimensiones confirma el mismo patrón. Cada pestaña muestra la proporción promedio por grupo de barrios:

{% tabs indicadores %}

{% tab indicadores Salud %}

{% include figure.liquid path="assets/img/projects/clustering/cobertura_salud.png" class="img-fluid rounded" alt="Proporción promedio de personas con y sin cobertura de salud, por grupo" %}

<div class="caption">En el grupo 3, más de la mitad de las personas no tiene obra social ni prepaga; en los grupos 2 y 4, menos de una de cada cinco.</div>

{% endtab %}

{% tab indicadores NBI %}

{% include figure.liquid path="assets/img/projects/clustering/nbi.png" class="img-fluid rounded" alt="Proporción promedio de personas por tipo de NBI, por grupo" %}

<div class="caption">El grupo 3 concentra los valores más altos de NBI 1, 3, 4 y 5. El grupo 2 sobresale en NBI 2, un resultado llamativo.</div>

{% endtab %}

{% tab indicadores Privación %}

{% include figure.liquid path="assets/img/projects/clustering/privacion_material.png" class="img-fluid rounded" alt="Proporción promedio de personas según privación material del hogar, por grupo" %}

<div class="caption">El grupo 3 tiene la mayor privación patrimonial y el grupo 2, la mayor privación de recursos. Los grupos 1 y 4 rondan el 90&nbsp;% sin privación.</div>

{% endtab %}

{% tab indicadores Vivienda %}

{% include figure.liquid path="assets/img/projects/clustering/tipo_vivienda.png" class="img-fluid rounded" alt="Proporción promedio de hogares por tipo de vivienda, por grupo" %}

<div class="caption">El grupo 2 vive mayormente en departamentos; el grupo 3, en casas y con la mayor proporción de ranchos y casillas; el grupo 4 combina ambos tipos.</div>

{% endtab %}

{% tab indicadores Hogares %}

{% include figure.liquid path="assets/img/projects/clustering/tamano_hogar.png" class="img-fluid rounded" alt="Proporción promedio de hogares según cantidad de integrantes, por grupo" %}

<div class="caption">Predominan los hogares de 1 o 2 personas en el grupo 2 y los hogares de 5 o más integrantes en el grupo 3.</div>

{% endtab %}

{% endtabs %}

## Validación con análisis factorial

Para contrastar los grupos con otra técnica, se realizó un **análisis factorial** con rotación varimax y se extrajeron 3 factores. Según las variables con mayor carga en cada uno, se interpretan así:

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-people-roof"></i><strong>Factor 1 · Hogares numerosos</strong><p>Hogares de 3 a 6 integrantes y en casas, frente a hogares de 1 o 2 personas en departamentos.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-user-graduate"></i><strong>Factor 2 · Nivel educativo bajo y desocupación</strong><p>Primaria y secundaria incompleta y desocupación, frente a nivel universitario y ocupación.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-house-crack"></i><strong>Factor 3 · Vulnerabilidad y vivienda precaria</strong><p>NBI, analfabetismo, falta de cobertura de salud, ranchos y casillas.</p></div>
</div>

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/clustering/factores_por_grupo.png" class="img-fluid rounded" alt="Nivel promedio de cada factor por grupo de barrios" %}
  </div>
</div>
<div class="caption">Nivel promedio de cada factor por grupo de barrios.</div>

Los factores respaldan la clasificación: el grupo 2 tiene el valor más bajo en hogares numerosos, coherente con barrios de hogares chicos y departamentos, y el grupo 3 es el único con valores positivos en el factor de nivel educativo bajo y el más alto en vulnerabilidad. En los demás grupos, el factor 3 es más difícil de interpretar porque reúne variables muy diversas.

## Conclusiones

- Los barrios de Córdoba se organizan en **cuatro perfiles socioeconómicos**, y uno de cada cinco barrios (el grupo 3) concentra las condiciones más vulnerables.
- Comparar métodos importa: la correlación cofenética descartó una opción que distorsionaba los datos, y la silueta advirtió que la estructura encontrada por K-means era débil.
- El análisis factorial llegó, por otro camino, a los mismos ejes que separan a los grupos: tamaño y tipo de hogar, nivel educativo y empleo, y vulnerabilidad.
- Quedan resultados para profundizar, como la proporción relativamente alta de NBI 2 y de privación de recursos en los barrios universitarios, pese a sus buenos indicadores en las demás dimensiones.

## Herramientas

<div class="cs-pills">
  <span>R</span><span>tidyverse</span><span>data.table</span><span>ggplot2</span><span>cluster</span><span>factoextra</span><span>psych</span><span>kableExtra</span><span>Quarto</span>
</div>

<div class="mt-4">
  <a class="btn btn-sm z-depth-0" role="button" href="https://celinecabas.quarto.pub/clustering/" target="_blank" rel="noopener">
    <i class="fa-solid fa-arrow-up-right-from-square"></i> Ver el notebook completo con el código
  </a>
</div>

<p class="text-muted mt-4"><small>
  Referencias: Hartigan, J. A. (1975). <em>Clustering Algorithms</em>. John Wiley &amp; Sons. ·
  Peña, D. (2002). <em>Análisis de datos multivariantes</em>. McGraw-Hill. ·
  Rousseeuw, P. J. (1987). Silhouettes: a graphical aid to the interpretation and validation of cluster analysis. <em>Journal of Computational and Applied Mathematics</em>, 20, 53-65.
</small></p>
