---
layout: page
title: Centronea
description: Web traffic measurement for a car dealership and a metrics dashboard for the client
img: assets/img/projects/centronea/tarjeta_centronea.png
permalink: /projects/centronea/
lang: en
category: work
importance: 2
related_publications: false
---

{% include case_study_styles.liquid %}

<div class="cs-hero">
  <div class="cs-brand">
    <img src="{{ '/assets/img/projects/centronea/logo_centronea.jpg' | relative_url }}" alt="Centronea Automotores" style="height: 34px; border-radius: 999px">
    <span class="cs-badge">Data engineering · Web analytics</span>
  </div>
  <p class="cs-lead">
    Centronea is a car dealership that lists its vehicles on <strong>centronea.com</strong>. The service consisted of <strong>measuring the site's traffic</strong> and making it available to the client through a <strong>custom web dashboard</strong>, with data refreshed every 15 minutes.
  </p>
  <div class="cs-facts">
    <div class="cs-fact"><span>Role</span><strong>End-to-end development</strong></div>
    <div class="cs-fact"><span>Year</span><strong>2026</strong></div>
    <div class="cs-fact"><span>Client</span><strong>Centronea Automotores</strong></div>
    <div class="cs-fact"><span>Stack</span><strong>Google Cloud · Python · Next.js</strong></div>
  </div>
</div>

## Goal

The standard Google Analytics report shows visits, but it doesn't answer a dealership's questions: **which cars draw interest, which ones get no visits, and how many visitors go on to open a listing's detail page**. The goal was to build measurement tailored to the business, combining site navigation with the catalog of listed cars, and to deliver it in a dashboard that is easy to consult.

### What is measured

<div class="cs-features">
  <div class="cs-feature"><i class="fa-solid fa-users"></i><strong>Visitors</strong><p>Visitors, sessions, average time, and new versus returning users.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-location-dot"></i><strong>Origin</strong><p>Cities and devices the site is browsed from.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-car"></i><strong>Listings</strong><p>Visits per car, with make, model, year and days listed; listings with no visits and removed listings.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-filter"></i><strong>Conversion</strong><p>Visitors who move from the catalog to a listing's detail page, directly or from the catalog.</p></div>
  <div class="cs-feature"><i class="fa-solid fa-images"></i><strong>Engagement</strong><p>Events such as browsing photos in the catalog.</p></div>
</div>

## The dashboard

The dashboard is a web app the client opens in the browser, on a computer or on a phone:

<div class="mt-3">
  {% include figure.liquid path="assets/img/projects/centronea/dashboard_devices.png" class="img-fluid" alt="Dashboard on a notebook, with the listings table filtered by Renault, and on two phones, with headline indicators and user trends" zoomable=true %}
</div>
<div class="caption">Dashboard preview (in Spanish). On the computer, the listings table filtered by make (Renault, last 30 days); on the phone, headline indicators and new and active users over time.</div>

## Architecture

<div class="row justify-content-center mt-3">
  <div class="col-md-10">
    {% include figure.liquid path="assets/img/projects/centronea/arquitectura_en.png" class="img-fluid rounded" alt="Architecture diagram: GA4 and PostgreSQL feed BigQuery, which serves a FastAPI API and a Next.js dashboard" %}
  </div>
</div>
<div class="caption">Data flow, from site events to the client's dashboard.</div>

<ol class="cs-steps">
  <li>Site events in GA4</li>
  <li>Export to BigQuery</li>
  <li>Car catalog from the site database</li>
  <li>Daily job: event consolidation</li>
  <li>15-minute job: same-day data</li>
  <li>Fact and dimension tables</li>
  <li>Metrics API</li>
  <li>Web dashboard</li>
</ol>

### Data pipeline

- **Google Analytics 4** records site navigation and exports raw events to **BigQuery**.
- A **daily job** consolidates events into a date-partitioned table with an incremental merge, and updates the car dimension from the site's **PostgreSQL** database, including the date each listing is taken down.
- An **intraday job**, every 15 minutes, reprocesses the current day's events so the dashboard shows near real-time data.
- The SQL queries identify the car behind each event, rebuild sessions and active users, and **exclude internal traffic** (site administration and testing tools) so metrics are not inflated.
- **A design decision:** the intraday job was first designed to be event-triggered, but GA4 writes same-day data to BigQuery without leaving audit logs, so it was replaced by a scheduled run.

### Dashboard

- **FastAPI backend** that computes all metrics for the period in a single BigQuery query, with caching to reduce query load and cost, and automated tests with pytest.
- **Next.js frontend** with React, Tailwind, shadcn/ui and Recharts: headline indicators, visitor trends, new versus returning users, cities and devices, a per-listing performance table and events.
- **Period selector** (7, 30 or 90 days, or a custom range), anchored to the latest date with data, plus light and dark modes.
- The first version was a **Streamlit** prototype, later replaced by the separate API and frontend architecture.

### Infrastructure and deployment

- All services run on **Cloud Run** (jobs, API and frontend) and are scheduled with **Cloud Scheduler**.
- Infrastructure is defined with **Terraform**, with an independent module per component.
- **GitHub Actions** builds the images, pushes them to Artifact Registry and deploys on every merge; infrastructure changes are reviewed with `terraform plan` on each pull request.
- Authentication with Google Cloud uses **Workload Identity Federation**, with no long-lived keys.

## Repositories

<div class="cs-groups">
  <div class="cs-group" style="--cs-group-color: var(--cs-g2)">
    <div class="cs-group-head"><span>centronea-analytics</span><small>Python · SQL · Terraform</small></div>
    <strong>Data pipeline</strong>
    <p>Daily and intraday jobs, event SQL queries, car catalog sync and the jobs' infrastructure.</p>
  </div>
  <div class="cs-group" style="--cs-group-color: var(--cs-g4)">
    <div class="cs-group-head"><span>centronea-dashboard</span><small>FastAPI · Next.js · Terraform</small></div>
    <strong>Client dashboard</strong>
    <p>Metrics API with tests, the dashboard frontend and the Cloud Run deployment infrastructure.</p>
  </div>
</div>

## Tools

<div class="cs-pills">
  <span>Google Analytics 4</span><span>BigQuery</span><span>SQL</span><span>Python</span><span>pandas</span><span>PostgreSQL</span><span>FastAPI</span><span>pytest</span><span>Next.js</span><span>React</span><span>TypeScript</span><span>Tailwind</span><span>Recharts</span><span>Streamlit</span><span>Cloud Run</span><span>Cloud Scheduler</span><span>Terraform</span><span>Docker</span><span>GitHub Actions</span>
</div>

<p class="text-muted mt-4"><small>The repositories and the dashboard are private; the screenshots are only a preview.</small></p>
