{{ config(materialized='table', schema='core') }}
SELECT
    immat,
    date_levee
    code_circuit,
    code_insee,
    nb_levees
FROM 
    ALTER TABLE dwh_staging.stg_export_simpliciti 
    ADD Primary KEY (immat)