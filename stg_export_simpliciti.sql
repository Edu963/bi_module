{{ config(materialized='table', schema='staging') }}

SELECT 
    "immat", 
    "date_levee"::date,
    "code_circuit" , 
    "code_insee" ,
    "nb_levees" 
FROM 
    ALTER TABLE dwh_raw.export_simpliciti
    ADD Primary KEY ("immat")
