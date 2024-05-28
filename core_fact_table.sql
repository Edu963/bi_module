{{ config(materialized='table', schema='core') }}

select *
from
(select coalesce(immat,immat_circuit) as immat_bigT, CODE_CIRCUIT, coalesce(date_circuit,date_levee) as date_bigT, sum_distance, total_levees, nombre_vidages
from 
(select  immat as immat_circuit , "date" as date_circuit, sum(distance) as SUM_distance, COUNT(DISTINCT CASE WHEN etat = 'VIDAGE' THEN date || '-' || heure END) AS nombre_vidages
from dwh_staging.stg_circuits_realises_combined_flt
group by immat , "date" ) as T1
full outer join
(SELECT  immat , CODE_CIRCUIT, date_levee, sum(nb_levees) as total_levees
FROM dwh_staging.stg_export_simpliciti
GROUP BY immat , CODE_CIRCUIT, date_levee) as T2
on T1.immat_circuit = T2.immat and T1.date_circuit = T2.date_levee) as bigT
full outer join
( SELECT pes_date_entree, SUM(pes_poids_net::integer) as sum_poids, pes_tra_id, count(pes_tra_id) as count_pes
FROM dwh_staging.stg_export_Athanor_2023
GROUP BY pes_date_entree , pes_tra_id ) as T3
on bigT.date_bigT = T3.pes_date_entree and bigT.code_circuit = pes_tra_id
