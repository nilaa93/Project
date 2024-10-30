-- Summary of UNHCR refugees and asylum seekers in Sweden
USE Migration

SELECT 
    kvotflyktingarSE.Year,
    SUM(CASE WHEN kvotflyktingarSE.Country_of_asylum = 'Sweden' THEN kvotflyktingarSE.Refugees_under_UNHCR_s_mandate ELSE 0 END) AS Total_Quota_Refugees,
    SUM(CASE WHEN asylumseekerSE.Country_of_asylum = 'Sweden' THEN asylumseekerSE.Asylum_seekers ELSE 0 END) AS Total_Asylum_Seekers
FROM 
    kvotflyktingarSE
    JOIN asylumseekerSE ON kvotflyktingarSE.Year = asylumseekerSE.Year
GROUP BY 
    kvotflyktingarSE.Year
ORDER BY 
    kvotflyktingarSE.Year;

-- Summary of UNHCR refugees and asylum seekers in Germany
SELECT 
    kvotflyktingarGER.Year,
    SUM(CASE WHEN kvotflyktingarGER.Country_of_asylum = 'Germany' THEN kvotflyktingarGER.Refugees_under_UNHCR_s_mandate ELSE 0 END) AS Total_Quota_Refugees,
    SUM(CASE WHEN asylumseekerGER.Country_of_asylum = 'Germany' THEN asylumseekerGER.Asylum_seekers ELSE 0 END) AS Total_Asylum_Seekers
FROM 
    kvotflyktingarGER
    JOIN asylumseekerGER ON kvotflyktingarGER.Year = asylumseekerGER.Year
GROUP BY 
    kvotflyktingarGER.Year
ORDER BY 
    kvotflyktingarGER.Year;