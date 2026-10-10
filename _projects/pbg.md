---
layout: page
title: Producto Bruto Geográfico
description: Estimación de las cuentas económicas provinciales de Corrientes y Chaco
img: assets/img/projects/pbg/pbg_chaco_tarjeta.png
permalink: /projects/pbg/
lang: es
category: work
importance: 3
related_publications: false
---

{% include case_study_styles.liquid %}

<div class="cs-hero">
  <div class="cs-brand">
    <span class="cs-badge">Consultoría · Cuentas económicas provinciales</span>
  </div>
  <p class="cs-lead">
    El <strong>Producto Bruto Geográfico (PBG)</strong> mide el valor de todo lo que se produce en una provincia. Para los organismos provinciales de estadística de <strong>Corrientes</strong> y <strong>Chaco</strong> se desarrollaron la metodología y los procesos de cálculo que estiman el PBG por sector de actividad, con series trimestrales a precios corrientes y constantes.
  </p>
  <div class="mx-auto" style="max-width: 600px">
    {% include figure.liquid path="assets/img/projects/pbg/pbg_chaco_desestacionalizado.png" class="img-fluid rounded" alt="PBG de Chaco a precios constantes: serie original, desestacionalizada y tendencia-ciclo, 2004 a 2025" %}
  </div>
  <div class="caption mt-0 mb-3">PBG trimestral de Chaco desde 2004: serie original, desestacionalizada y tendencia-ciclo. Fuente: DiPIET Chaco, informe del 4.º trimestre de 2025.</div>
  <div class="cs-facts">
    <div class="cs-fact"><span>Rol</span><strong>Consultora en estadística económica</strong></div>
    <div class="cs-fact"><span>Período</span><strong>2022 – 2024</strong></div>
    <div class="cs-fact"><span>Cobertura</span><strong>Provincias de Corrientes y Chaco</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>R · Git</strong></div>
  </div>
</div>

## Rol

El trabajo se hizo junto a los equipos técnicos de cuentas económicas de cada organismo, y abarcó el proceso completo, desde las fuentes de información hasta las series publicables:

- **Diseño metodológico** de la estimación de cada sector, según los lineamientos de cuentas nacionales y con año base 2004.
- **Relevamiento y armonización** de más de 30 fuentes de información provinciales y nacionales.
- **Desarrollo de los procesos de cálculo** en R: un script reproducible por sector que genera las series y permite actualizarlas cada trimestre.
- **Documentación**: informe metodológico por sector y guía de actualización para los equipos de cada organismo.

## Cobertura

<div class="cs-groups">
  <div class="cs-group" style="--cs-group-color: var(--cs-g1)">
    <div class="cs-group-head"><span>Corrientes</span><small>2023 – 2024</small></div>
    <strong>Estimación completa del PBG</strong>
    <p>Los 16 sectores de actividad, con series trimestrales desde 2004 a precios corrientes y constantes, informe metodológico final y guía de actualización.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g2)">
    <div class="cs-group-head"><span>Chaco</span><small>2022</small></div>
    <strong>Revisión metodológica del PBG</strong>
    <p>Nuevo año base 2004, empalme con la serie anterior (metodología CEPAL 2008) y procesos de cálculo para industria, construcción, comercio, hotelería, transporte, administración pública, enseñanza, salud y servicios comunitarios.</p>
  </div>
</div>

<div class="row text-center mt-3">
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">2</div><div class="cs-metric-label">provincias</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">16</div><div class="cs-metric-label">sectores de actividad</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">2004</div><div class="cs-metric-label">año base y comienzo de las series</div></div></div>
  <div class="col-6 col-md-3 mb-3"><div class="cs-metric"><div class="cs-metric-value">+30</div><div class="cs-metric-label">fuentes de información</div></div></div>
</div>

### Sectores de actividad

El PBG se desagrega en las 16 letras de la Clasificación Nacional de Actividades Económicas (ClaNAE 2004), y dentro de cada una, en sus ramas de actividad:

<ul class="cs-sectors">
  <li style="--cs-group-color: var(--cs-g1)"><b>A</b>Agricultura, ganadería y silvicultura</li>
  <li style="--cs-group-color: var(--cs-g1)"><b>B</b>Pesca</li>
  <li style="--cs-group-color: var(--cs-g1)"><b>C</b>Explotación de minas y canteras</li>
  <li style="--cs-group-color: var(--cs-g2)"><b>D</b>Industria manufacturera</li>
  <li style="--cs-group-color: var(--cs-g2)"><b>E</b>Electricidad, gas y agua</li>
  <li style="--cs-group-color: var(--cs-g2)"><b>F</b>Construcción</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>G</b>Comercio mayorista y minorista</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>H</b>Hoteles y restaurantes</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>I</b>Transporte y comunicaciones</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>J</b>Intermediación financiera</li>
  <li style="--cs-group-color: var(--cs-g3)"><b>K</b>Actividades inmobiliarias y empresariales</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>L</b>Administración pública</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>M</b>Enseñanza</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>N</b>Servicios sociales y de salud</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>O</b>Servicios comunitarios y personales</li>
  <li style="--cs-group-color: var(--cs-g4)"><b>P</b>Servicio doméstico</li>
</ul>
<div class="caption">Los colores agrupan sectores primarios, productores de bienes, servicios privados y servicios públicos y sociales.</div>

## Metodología

<ol class="cs-steps">
  <li>Relevamiento de fuentes</li>
  <li>Armonización de clasificadores</li>
  <li>Año base 2004</li>
  <li>Indicadores de volumen y precio por rama</li>
  <li>Series a precios constantes y corrientes</li>
  <li>Trimestralización</li>
  <li>Desestacionalización</li>
  <li>Agregación del PBG</li>
</ol>

### Año base

Para cada rama de actividad se estiman el **Valor Bruto de Producción (VBP)**, el **Consumo Intermedio (CI)** y el **Valor Agregado Bruto (VAB)**. El punto de partida es el **Censo Nacional Económico 2004**, que publica estos agregados por provincia para 2003; los valores se llevan a 2004 con la evolución de la facturación o de las remuneraciones de cada rama. Donde el censo no alcanza se usan otras fuentes, como los censos de población o la Encuesta Nacional a Grandes Empresas.

### Extrapolación con indicadores

A partir del año base, cada rama se proyecta con indicadores que siguen su evolución: un **índice de volumen físico** para la serie a precios constantes y un **índice de valor o de precios** para la serie a precios corrientes. El indicador se elige según la información disponible en cada sector:

<div class="cs-features" style="grid-template-columns: repeat(auto-fit, minmax(240px, 1fr))">
  <div class="cs-feature"><i class="fa-solid fa-wheat-awn"></i><strong>Producción física</strong><p>Toneladas y precios de cultivos; faena, movimientos y existencias de ganado; superficie forestal implantada.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-file-invoice-dollar"></i><strong>Facturación</strong><p>Ingresos brutos declarados por rama, deflactados con índices de precios regionales.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-id-badge"></i><strong>Empleo y salarios</strong><p>Empleo registrado y masa salarial en el sector privado; planta y remuneraciones en el sector público.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-helmet-safety"></i><strong>Ingreso factorial</strong><p>Construcción: mano de obra formal e informal más el valor de los insumos.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-people-group"></i><strong>Encuestas a hogares</strong><p>Servicio doméstico y empleo informal con la EPH, expandida a la provincia con los censos.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-tower-cell"></i><strong>Indicadores de servicios</strong><p>Pasajeros, carga, accesos a telecomunicaciones, préstamos y depósitos.</p></div>
</div>

### Series trimestrales

Muchas fuentes son anuales, pero el PBG se publica por trimestre. Las series anuales se **trimestralizaron con el método de Denton-Cholette**, usando indicadores trimestrales relacionados cuando existían. En el agro, una matriz mensual de siembra y cosecha asigna a cada cultivo su estacionalidad. Sobre las series finales se aplicó **X-13ARIMA-SEATS** para obtener las series desestacionalizadas y de tendencia-ciclo.

En Chaco, además, la nueva serie se **empalmó con la serie histórica** calculada con la metodología CEPAL 2008, para mantener la comparabilidad hacia atrás.

## Fuentes de información

El cálculo combina registros administrativos provinciales con estadísticas nacionales. Ninguna fuente cubre todos los sectores, así que buena parte del trabajo consistió en armonizar clasificadores (ClaNAE, nomencladores tributarios y de empleo), períodos y unidades.

<h3 class="h6 mt-4">Provinciales</h3>
<div class="cs-pills">
  <span>Direcciones de Rentas (ingresos brutos)</span><span>Planta y remuneraciones del sector público</span><span>Ministerios de Producción (agro, forestal e industria)</span><span>Relevamientos de producción industrial</span><span>Recursos naturales</span><span>Permisos de edificación municipales</span><span>Empresas de energía y agua</span><span>Transporte urbano</span>
</div>

<h3 class="h6 mt-3">INDEC</h3>
<div class="cs-pills">
  <span>Censo Nacional Económico 2004</span><span>Censos de Población 2001, 2010 y 2022</span><span>EPH</span><span>ENGHo</span><span>Encuesta Industrial Mensual</span><span>IPC regional</span><span>IPIM</span><span>Índice del Costo de la Construcción</span><span>EMAE</span><span>Índices de volumen y precios implícitos</span>
</div>

<h3 class="h6 mt-3">Otros organismos nacionales</h3>
<div class="cs-pills">
  <span>OEDE – SIPA (Ministerio de Trabajo)</span><span>SENASA</span><span>Secretaría de Agricultura</span><span>BCRA</span><span>Superintendencia de Seguros</span><span>DNRPA</span><span>Secretaría de Energía</span><span>CAMMESA</span><span>ENACOM</span><span>ANAC</span><span>CNRT</span><span>IERIC</span><span>Asociación de Fabricantes de Cemento Portland</span><span>FAIM</span>
</div>

## Del cálculo a la producción

El objetivo no era solo estimar las series una vez, sino dejar un proceso que cada organismo pudiera **actualizar por su cuenta**:

- **Un script de R por sector**, versionado en Git, con todo el cálculo: lectura de fuentes, año base, índices y series finales.
- **Salidas estandarizadas**: VBP, CI y VAB por rama, trimestre y tipo de precio, listas para agregar al PBG total.
- **Informe metodológico** por sector, con las fuentes y los criterios de estimación a precios constantes y corrientes.
- **Guía de actualización** que ordena los pasos para incorporar cada nuevo trimestre.

## Herramientas

<div class="cs-pills">
  <span>R</span><span>data.table</span><span>tidyverse</span><span>seasonal (X-13)</span><span>tempdisagg</span><span>forecast</span><span>openxlsx</span><span>R Markdown</span><span>SQL</span><span>Git</span><span>GitLab</span>
</div>

<p class="text-muted mt-4"><small>Por confidencialidad, se omiten los resultados, los registros administrativos y el detalle de los cálculos.</small></p>
