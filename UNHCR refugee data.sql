-- Comparision of UNHCR refugees between Sweden and Germany betwenn 2018-2023
SELECT
    Year,
    Country_of_origin,
    SUM(CASE WHEN Country_of_asylum = 'Sweden' THEN refugees_under_unhcr_s_mandate ELSE 0 END) AS Sweden_Refugees,
    SUM(CASE WHEN Country_of_asylum = 'Germany' THEN refugees_under_unhcr_s_mandate ELSE 0 END) AS Germany_Refugees
FROM (
    SELECT 
        Year,
        Country_of_origin,
        refugees_under_unhcr_s_mandate,
        'Sweden' AS Country_of_asylum
    FROM 
        kvotflyktingarSE
    WHERE 
        Year BETWEEN 2018 AND 2023

    UNION ALL

    SELECT 
        Year,
        Country_of_origin,
        refugees_under_unhcr_s_mandate,
        'Germany' AS Country_of_asylum
    FROM 
        kvotflyktingarGER
    WHERE 
        Year BETWEEN 2018 AND 2023
) AS Combined_Data
GROUP BY 
    Year, 
    Country_of_origin
ORDER BY 
    Year, 
    Country_of_origin;

-- Percentage change for each country per year in Sweden and Germany (UNHCR refugees) 
WITH RefugeeChange AS (
    SELECT
        Year,
        Country_of_origin,
        Country_of_asylum,
        refugees_under_unhcr_s_mandate,
        LAG(refugees_under_unhcr_s_mandate) OVER (PARTITION BY Country_of_origin, Country_of_asylum ORDER BY Year) AS Previous_Year_Refugees
    FROM (
        -- UNHCR refugees in Sweden
        SELECT 
            Year,
            Country_of_origin,
            refugees_under_unhcr_s_mandate,
            'Sweden' AS Country_of_asylum
        FROM 
            kvotflyktingarSE
        WHERE 
            Year BETWEEN 2018 AND 2023

        UNION ALL

        -- UNHCR refugees in Germany
        SELECT 
            Year,
            Country_of_origin,
            refugees_under_unhcr_s_mandate,
            'Germany' AS Country_of_asylum
        FROM 
            kvotflyktingarGER
        WHERE 
            Year BETWEEN 2018 AND 2023
    ) AS Combined_Refugees
)
SELECT
    Year,
    Country_of_origin,
    Country_of_asylum,
    refugees_under_unhcr_s_mandate AS Current_Refugees,
    Previous_Year_Refugees,
    CASE 
        WHEN Previous_Year_Refugees = 0 THEN NULL
        ELSE ROUND(((refugees_under_unhcr_s_mandate - Previous_Year_Refugees) / CAST(Previous_Year_Refugees AS FLOAT)) * 100, 2)
    END AS Percent_Change
FROM
    RefugeeChange
WHERE
    Previous_Year_Refugees IS NOT NULL
ORDER BY
    Country_of_asylum, Country_of_origin, Year;
;