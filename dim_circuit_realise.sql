{{ config(materialized='table', schema='core') }}
SELECT 
    date,
    heure, 
    immat, 
    rue, 
    latitude,
    longitude,
    vitesse,
    etat, 
    distance,
    num_unique_circuit,
    etape_dans_circuit
FROM 
    dwh_staging.stg_circuits_realises_combined_flt

