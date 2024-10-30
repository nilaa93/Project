-- Comparision of asylum seekers in Sweden and Germany between 2018-2023

USE Migration

SELECT
    Year,
    Country_of_origin,
    SUM(CASE WHEN Country_of_asylum = 'Sweden' THEN asylum_seekers ELSE 0 END) AS Sweden_AsylumSeekers,
    SUM(CASE WHEN Country_of_asylum = 'Germany' THEN asylum_seekers ELSE 0 END) AS Germany_AsylumSeekers
FROM (
    SELECT 
        Year,
        Country_of_origin,
        asylum_seekers,
        'Sweden' AS Country_of_asylum
    FROM 
        asylumseekerSE
    WHERE 
        Year BETWEEN 2018 AND 2023

    UNION ALL

    SELECT 
        Year,
        Country_of_origin,
        asylum_seekers,
        'Germany' AS Country_of_asylum
    FROM 
        asylumseekerGER
    WHERE 
        Year BETWEEN 2018 AND 2023
) AS Combined_AsylumSeekers
GROUP BY 
    Year, 
    Country_of_origin
ORDER BY 
    Year, 
    Country_of_origin;

-- Percentage change each year per country in Sweden and Germany (asylum seekers)
WITH AsylumChange AS (
    SELECT
        Year,
        Country_of_origin,
        Country_of_asylum,
        asylum_seekers,
        LAG(asylum_seekers) OVER (PARTITION BY Country_of_origin, Country_of_asylum ORDER BY Year) AS Previous_Year_AsylumSeekers
    FROM (
        -- Percentage change of asylum seekers in Sweden 
        SELECT 
            Year,
            Country_of_origin,
            asylum_seekers,
            'Sweden' AS Country_of_asylum
        FROM 
            asylumseekerSE
        WHERE 
            Year BETWEEN 2018 AND 2023

        UNION ALL

        -- Percentage change of asylum seekers in Germany
        SELECT 
            Year,
            Country_of_origin,
            asylum_seekers,
            'Germany' AS Country_of_asylum
        FROM 
            asylumseekerGER
        WHERE 
            Year BETWEEN 2018 AND 2023
    ) AS Combined_AsylumSeekers
)
SELECT
    Year,
    Country_of_origin,
    Country_of_asylum,
    asylum_seekers AS Current_AsylumSeekers,
    Previous_Year_AsylumSeekers,
    CASE 
        WHEN Previous_Year_AsylumSeekers = 0 THEN NULL
        ELSE ROUND(((asylum_seekers - Previous_Year_AsylumSeekers) / CAST(Previous_Year_AsylumSeekers AS FLOAT)) * 100, 2)
    END AS Percent_Change
FROM
    AsylumChange
WHERE
    Previous_Year_AsylumSeekers IS NOT NULL
ORDER BY
    Country_of_asylum, Country_of_origin, Year;
