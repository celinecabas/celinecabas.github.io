---
layout: page
title: Centronea
description: Medición del tráfico web de una concesionaria y dashboard de métricas para el cliente
img: assets/img/projects/centronea/tarjeta_centronea.png
permalink: /projects/centronea/
lang: es
category: work
importance: 2
related_publications: false
---

{% include case_study_styles.liquid %}

<div class="cs-hero">
  <div class="cs-brand">
    <img src="{{ '/assets/img/projects/centronea/logo_centronea.jpg' | relative_url }}" alt="Centronea Automotores" style="height: 34px; border-radius: 999px">
    <span class="cs-badge">Ingeniería de datos · Analítica web</span>
  </div>
  <p class="cs-lead">
    Centronea es una concesionaria que publica sus autos en <strong>centronea.com</strong>. El servicio consistió en <strong>medir el tráfico del sitio</strong> y ponerlo a disposición del cliente en un <strong>dashboard web propio</strong>, con datos que se actualizan cada 15 minutos.
  </p>
  <div class="cs-facts">
    <div class="cs-fact"><span>Rol</span><strong>Desarrollo de punta a punta</strong></div>
    <div class="cs-fact"><span>Año</span><strong>2026</strong></div>
    <div class="cs-fact"><span>Cliente</span><strong>Centronea Automotores</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>Google Cloud · Python · Next.js</strong></div>
  </div>
</div>

## Objetivo

El panel estándar de Google Analytics muestra visitas, pero no responde las preguntas de una concesionaria: **qué autos interesan, cuáles no reciben visitas y cuántos visitantes llegan a ver el detalle de un anuncio**. El objetivo fue construir una medición a la medida del negocio, que cruce la navegación del sitio con el catálogo de autos publicados, y entregarla en un dashboard simple de consultar.

### Qué se mide

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-users"></i><strong>Visitantes</strong><p>Visitantes, sesiones, tiempo medio y usuarios nuevos frente a recurrentes.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-location-dot"></i><strong>Origen</strong><p>Ciudades y dispositivos desde los que se navega el sitio.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-car"></i><strong>Anuncios</strong><p>Visitas por auto, con marca, modelo, año y días publicado; anuncios sin visitas y eliminados.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-filter"></i><strong>Conversión</strong><p>Visitantes que pasan del catálogo al detalle de un anuncio, directo o desde el catálogo.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-images"></i><strong>Interacción</strong><p>Eventos como la navegación de fotos en el catálogo.</p></div>
</div>

## El tablero

El tablero es una aplicación web que el cliente consulta desde el navegador, en la computadora o en el celular:

<div class="mt-3">
  {% include figure.liquid path="assets/img/projects/centronea/dashboard_devices.png" class="img-fluid" alt="Tablero en una notebook, con la tabla de anuncios filtrada por Renault, y en dos celulares, con los indicadores principales y la evolución de usuarios" zoomable=true %}
</div>
<div class="caption">En la computadora, la tabla de anuncios filtrada por marca (Renault, últimos 30 días); en el celular, los indicadores principales y la evolución de usuarios nuevos y activos.</div>

## Arquitectura

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/centronea/arquitectura.png" class="img-fluid rounded" alt="Diagrama de arquitectura: GA4 y PostgreSQL alimentan BigQuery, que sirve a una API en FastAPI y un dashboard en Next.js" %}
  </div>
</div>
<div class="caption">Flujo de datos, de los eventos del sitio al dashboard del cliente.</div>

<ol class="cs-steps">
  <li>Eventos del sitio en GA4</li>
  <li>Exportación a BigQuery</li>
  <li>Catálogo de autos desde la base del sitio</li>
  <li>Job diario: consolidación de eventos</li>
  <li>Job cada 15 minutos: datos del día</li>
  <li>Tablas de hechos y dimensiones</li>
  <li>API de métricas</li>
  <li>Dashboard web</li>
</ol>

### Pipeline de datos

- **Google Analytics 4** registra la navegación del sitio y exporta los eventos crudos a **BigQuery**.
- Un **job diario** consolida los eventos en una tabla particionada por fecha con un *merge* incremental, y actualiza la dimensión de autos desde la base **PostgreSQL** del sitio, incluyendo la fecha en que cada anuncio deja de estar publicado.
- Un **job intradiario**, cada 15 minutos, reprocesa los eventos del día para que el dashboard muestre datos casi en tiempo real.
- Las consultas SQL identifican el auto de cada evento, reconstruyen sesiones y usuarios activos, y **excluyen el tráfico interno** (administración del sitio y herramientas de prueba) para no inflar las métricas.
- **Una decisión de diseño:** el job intradiario se pensó primero como disparado por eventos, pero GA4 escribe los datos del día en BigQuery sin dejar registros de auditoría, así que se reemplazó por una ejecución programada.

### Dashboard

- **API en FastAPI** que calcula todas las métricas del período en una sola consulta a BigQuery, con caché para reducir la carga y el costo de las consultas, y tests automáticos con pytest.
- **Frontend en Next.js** con React, Tailwind, shadcn/ui y Recharts: indicadores principales, evolución de visitantes, nuevos frente a recurrentes, ciudades y dispositivos, tabla de rendimiento por anuncio y eventos.
- **Selector de período** (7, 30 o 90 días, o un rango a medida), anclado a la última fecha con datos, y modo claro y oscuro.
- La primera versión fue un prototipo en **Streamlit**, que después se reemplazó por la arquitectura de API y frontend separados.

### Infraestructura y despliegue

- Todos los servicios corren en **Cloud Run** (jobs, API y frontend) y se programan con **Cloud Scheduler**.
- La infraestructura está definida con **Terraform**, con un módulo independiente por pieza.
- **GitHub Actions** construye las imágenes, las publica en Artifact Registry y despliega en cada *merge*; los cambios de infraestructura se revisan con `terraform plan` en cada pull request.
- La autenticación con Google Cloud usa **Workload Identity Federation**, sin claves de larga duración.

## Repositorios

<div class="cs-groups">
  <div class="cs-group" style="--cs-group-color: var(--cs-g2)">
    <div class="cs-group-head"><span>centronea-analytics</span><small>Python · SQL · Terraform</small></div>
    <strong>Pipeline de datos</strong>
    <p>Jobs diario e intradiario, consultas SQL de eventos, sincronización del catálogo de autos e infraestructura de los jobs.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g4)">
    <div class="cs-group-head"><span>centronea-dashboard</span><small>FastAPI · Next.js · Terraform</small></div>
    <strong>Dashboard del cliente</strong>
    <p>API de métricas con tests, frontend del dashboard e infraestructura de despliegue en Cloud Run.</p>
  </div>
</div>

## Herramientas

<div class="cs-pills">
  <span>Google Analytics 4</span><span>BigQuery</span><span>SQL</span><span>Python</span><span>pandas</span><span>PostgreSQL</span><span>FastAPI</span><span>pytest</span><span>Next.js</span><span>React</span><span>TypeScript</span><span>Tailwind</span><span>Recharts</span><span>Streamlit</span><span>Cloud Run</span><span>Cloud Scheduler</span><span>Terraform</span><span>Docker</span><span>GitHub Actions</span>
</div>

<p class="text-muted mt-4"><small>Los repositorios y el tablero son privados; las capturas son solo una vista previa.</small></p>
