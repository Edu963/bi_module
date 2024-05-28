{{ config(materialized='table', schema='staging') }}

SELECT code_insee, nom_commune, population_totale
FROM dwh_raw.referentiel_commune
