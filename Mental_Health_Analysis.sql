-- MENTAL HEALTH ANALYSIS
-- WHICH COUNTRIES AND REGION HAVE THE HIGHEST AND LOWEST PREVALENCE OF DIFFERENT MENTAL HEALTH ILLNESS OVER TIME?
-- ARE RATES INCREASING OR DESCREASING?
-- WHICH DISORDERS ARE NOT COMMON?

-- AVERAGE PREVALENCE by COUNTRY

SELECT DISTINCT Entity, AVG(Schizophrenia_disorders) AS avg_schizophrenia_disorders,
               AVG(Depressive_disorders) AS avg_depressive_disorders,
			   AVG(Anxiety_disorders) AS avg_anxiety_disorders,
			   AVG(Bipolar_disorders) AS avg_bipolar_disorders,
			   AVG(Eating_disorders) AS avg_eating_disorders,
	CASE
	    WHEN AVG(Schizophrenia_disorders) > 
		     AVG(Depressive_disorders) AND AVG(Schizophrenia_disorders) >
			 AVG(Anxiety_disorders) AND AVG(Schizophrenia_disorders) >
			 AVG(Bipolar_disorders) AND AVG(Schizophrenia_disorders) >
			 AVG(Eating_disorders) 
			   THEN 'Schizophrenia' 
			WHEN AVG(Depressive_disorders) > AVG(Schizophrenia_disorders)
			AND AVG(Depressive_disorders) > AVG(Anxiety_disorders)
			AND AVG(Depressive_disorders) > AVG(Bipolar_disorders)
			AND AVG(Depressive_disorders) > AVG(Eating_disorders)
			THEN 'DepressiveDisorders'
			WHEN AVG(Anxiety_disorders) > AVG(Schizophrenia_disorders)
			AND AVG(Anxiety_disorders) > AVG(Depressive_disorders)
			AND AVG(Anxiety_disorders) > AVG(Bipolar_disorders) 
			AND AVG(Anxiety_disorders) > AVG(Eating_disorders)
			THEN 'AnxietyDisorders'
			WHEN AVG(Bipolar_disorders) > AVG(Schizophrenia_disorders)
			AND AVG(Bipolar_disorders) > AVG(Depressive_disorders)
			AND AVG(Bipolar_disorders) > AVG(Anxiety_disorders)
			AND AVG(Bipolar_disorders) > AVG(Eating_disorders)
			THEN 'BipolarDisorders'
			ELSE 'EatingDisorders'
			END AS MostCommonDisorder
FROM "Mental Illness Prevalence"
WHERE Year BETWEEN 1990 AND 2021
GROUP BY Entity
ORDER BY avg_depressive_disorders DESC;

-- TREND ANALYSIS 
SELECT DISTINCT Entity, AVG(CASE WHEN Year <= 2000 THEN Depressive_disorders ELSE 0 END) AS EarlyDespressive,
               AVG(CASE WHEN Year > 2010 THEN Depressive_disorders ELSE 0 END) AS LateDespressive,
			   CASE
			       WHEN AVG(CASE WHEN Year > 2010 THEN Depressive_disorders ELSE 0 END) >
				   AVG(CASE WHEN Year <= 2000 THEN Depressive_disorders ELSE 0 END) 
				   THEN 'Increasing'
				   ELSE 'Decreasing or Stable'
				   END AS DespressiveTrend
FROM "Mental Illness Prevalence"
WHERE Year BETWEEN 1990 AND 2021
GROUP BY Entity
ORDER BY LateDespressive DESC;


-- HOW DOES THE BURDEN DISEASE (DALYs) COMPARE TO THE PREVALENCE OF MENTAL ILLNESS ACROSS COUNTRIES?
-- DO SOME ILLNESS CAUSE DISPROPORTIONATE HEALTH LOSS?
-- ARE THERE REGIONS WITH HIGH BURDEN BUT LOW PREVALENCE REPORTING?

SELECT DISTINCT p.Entity, AVG(p.Depressive_disorders) AS avg_prevalence_depressive,
                 AVG(d.DALYs_Depressive_disorders) AS avg_DALYs_depressive,
				 AVG(p.Depressive_disorders) / COALESCE (AVG(d.DALYs_Depressive_disorders), 0) AS depressive_burden_ratio,
				CASE   
				    WHEN AVG(d.DALYs_Depressive_disorders) > 1000 
					AND AVG(p.Depressive_disorders) < 3
					THEN 'High Burden, Low Prevalence'
					ELSE 'Other'
					END AS BurdenPrevalenceMismatch
FROM "Mental Illness Prevalence" p
JOIN "Burden of Disease Mental Illness" d ON p.Entity = d.Entity AND p.Year = d.Year
GROUP BY p.Entity
ORDER BY avg_DALYs_depressive DESC;


-- WHERE IS THE TREATMENT GAP FOR ANXIETY DISORDERS THE LARGEST?
-- WHICH COUNTRIES HAVE THE HIGHEST PERCENTAGE OF UNTREATED INDIVIDUALS?
-- HOW DO POTENTIALLY ADEQUATE TREATMENT RATES COMPARE ACROSS COUNTRIES?

SELECT  DISTINCT Entity, Year,
       Untreated AS UntreatedPercentage,
	   Potentially_adequate_treatment AS AdequateTreatmentPercentage
FROM "Anxiety Disorders Treatment Gaps"
WHERE Year = (SELECT MAX(Year) FROM "Anxiety Disorders Treatment Gaps")
ORDER BY Untreated DESC;

-- WHAT PERCENTAGE OF THE GLOBAL ADULT POPULATION IS COVERED IN PRIMARY DATA COLLECTION FOR DIFFERENT MENTAL ILLNESS?
-- ARE SOME DISORDERS UNDERREPRESENTED?
-- ARE SOME REGIONS MORE FREQUENTLY STUDIED?
SELECT *
FROM "Number of Countries with Primary Data"

SELECT DISTINCT
    'Major_depression' AS Disorder,
    Year,
    AVG(COALESCE(Major_depression, 0)) AS AvgCoverage,
    COUNT(DISTINCT Entity) AS NumCountries
FROM "Primary Data Coverage for Major Depression"
WHERE Year = 2008
GROUP BY Year
UNION
SELECT 
    'Major_depression' AS Disorder,
    Year,
    AVG(COALESCE(Major_depression, 0)) AS AvgCoverage,
    COUNT(DISTINCT Entity) AS NumCountries
FROM "Primary Data for Mental Illnesses"
WHERE Year = 2008
GROUP BY Year
UNION
SELECT 
    'Bipolar_disorder' AS Disorder,
    Year,
    AVG(COALESCE(Bipolar_disorder, 0)) AS AvgCoverage,
    COUNT(DISTINCT Entity) AS NumCountries
FROM "Primary Data for Mental Illnesses"
WHERE Year = 2008
GROUP BY Year
UNION
SELECT 
    'Eating_disorders' AS Disorder,
    Year,
    AVG(COALESCE(Eating_disorders, 0)) AS AvgCoverage,
    COUNT(DISTINCT Entity) AS NumCountries
FROM "Primary Data for Mental Illnesses"
WHERE Year = 2008
GROUP BY Year
UNION
SELECT 
    'Dysthymia' AS Disorder,
    Year,
    AVG(COALESCE(Dysthymia, 0)) AS AvgCoverage,
    COUNT(DISTINCT Entity) AS NumCountries
FROM "Primary Data for Mental Illnesses"
WHERE Year = 2008
GROUP BY Year
UNION
SELECT 
    'Schizophrenia' AS Disorder,
    Year,
    AVG(COALESCE(Schizophrenia, 0)) AS AvgCoverage,
    COUNT(DISTINCT Entity) AS NumCountries
FROM "Primary Data for Mental Illnesses"
WHERE Year = 2008 
GROUP BY Year
UNION
SELECT 
    'Anxiety_disorders' AS Disorder,
    Year,
    AVG(COALESCE(Anxiety_disorders, 0)) AS AvgCoverage,
    COUNT(DISTINCT Entity) AS NumCountries
FROM "Primary Data for Mental Illnesses"
WHERE Year = 2008
GROUP BY Year
UNION
SELECT 
    Entity AS Disorder,
    Year,
    0 AS AvgCoverage,
    Number_of_countries
FROM "Number of Countries with Primary Data"
WHERE Year = 2008
ORDER BY Disorder, Year DESC;

-- WHICH DEPRESSIVE SYMPTOMS ARE MOST COMMONLY REPORTED IN THE US, AND WHICH ONE ARE LEAST PREVALENT?
-- HOW DO SYMPTOMS PATTERNS SHIFT BY FREQUENCY?

SELECT TOP 1 Entity, Year, AVG(Nearly_every_day) AS AvgNearlyEveryday,
             AVG(More_than_half_the_days) AS AvgMoreThanHalfDays,
			 AVG(Several_days) AS AvgSeveralDays,
			 AVG(Not_at_all) AS AvgNotAtAll,
		CASE
		     WHEN AVG(Nearly_every_day) > AVG(More_than_half_the_days)
			 AND AVG(Nearly_every_day) > AVG(Several_days)
			 AND AVG(Nearly_every_day) > AVG(Not_at_all)
			 THEN 'NearlyEveryday'
			 WHEN AVG(More_than_half_the_days) > AVG(Nearly_every_day)
			 AND AVG(More_than_half_the_days) > AVG(Several_days)
			 AND AVG(More_than_half_the_days) > AVG(Not_at_all)
			 THEN 'MoreThanHalfDays'
			 WHEN AVG(Several_days) > AVG(Nearly_every_day)
			 AND AVG(Several_days) > AVG(More_than_half_the_days)
			 AND AVG(Several_days) > AVG(Not_at_all)
			 THEN 'SeveralDays'
			 ELSE 'NotAtAll'
			 END AS MostCommonSymptom
FROM "Depressive Symptoms in the US"
GROUP BY Entity, Year
ORDER BY AvgSeveralDays DESC;


-- ARE THERE MISMATCHES BETWEEN (DALYs) AND TREATMENT COVERAGE FOR DEPRESSION AND ANXIETY?
-- CAN YOU SPOT REGIONS WHERE THE NEED IS HIGH BUT TREATMENT REMAINS LOW?

SELECT DISTINCT b.Entity, b.Year, AVG(b.DALYs_Depressive_disorders) AS AvgDALYsDepressive,
                         AVG(t.Potentially_adequate_treatment) AS AvgAnxietyTreatment,
						 AVG(p.Major_depression) AS AvgDepressionTreatment,
						 CASE
						      WHEN AVG(b.DALYs_Depressive_disorders) > 1000 AND AVG(P.Major_depression) < 0.3
							  THEN 'High Depression Burden, Low Treatment'
							  WHEN AVG(b.DALYs_Depressive_disorders) > 1000 AND AVG(t.Potentially_adequate_treatment) < 0.3
							  THEN 'High Anxiety Burden, Low Treatment'
							  ELSE 'Other'
							  END AS MisMatchStatus
FROM "Burden of Disease Mental Illness" b
LEFT JOIN "Anxiety Disorders Treatment Gaps" t ON b.Entity = t.Entity AND b.Year = t.Year
LEFT JOIN "Primary Data Coverage for Major Depression" p ON b.Entity = p.Entity AND b.Year = p.Year
GROUP BY b.Entity, b.Year
ORDER BY AvgDALYsDepressive DESC;


-- WHICH DISORDERS ARE WELL REPRESENTED ACROSS MULTIPLE DATA AND WHICH MIGHT BE UNDERREPORTED?
SELECT Major_depression AS Disorder, COUNT(DISTINCT Entity) AS Number_of_countries,
                                    AVG(Major_depression) AS AvgMajorDepression
FROM "Primary Data for Mental Illnesses"
WHERE Major_depression IS NOT NULL
GROUP BY ()
UNION
SELECT Bipolar_disorder, COUNT(DISTINCT Entity), AVG(Bipolar_disorder)
FROM "Primary Data for Mental Illnesses"
WHERE Bipolar_disorder IS NOT NULL
GROUP BY ()
UNION
SELECT Eating_disorders, COUNT(DISTINCT Entity), AVG(Eating_disorders)
FROM "Primary Data for Mental Illnesses"
WHERE Eating_disorders IS NOT NULL
GROUP BY ()
UNION
SELECT Dysthymia, COUNT(DISTINCT Entity), AVG(Dysthymia)
FROM "Primary Data for Mental Illnesses"
WHERE Dysthymia IS NOT NULL
GROUP BY ()
UNION
SELECT Schizophrenia, COUNT(DISTINCT Entity), AVG(Schizophrenia)
FROM "Primary Data for Mental Illnesses"
WHERE Schizophrenia IS NOT NULL
GROUP BY ()
UNION
SELECT Anxiety_disorders, COUNT(DISTINCT Entity), AVG(Anxiety_disorders)
FROM "Primary Data for Mental Illnesses"
WHERE Anxiety_disorders IS NOT NULL 
GROUP BY ()
ORDER BY NumCountries DESC;

SELECT *
FROM "Primary Data for Mental Illnesses"

SELECT 
    'Major_depression' AS Disorder,
    COUNT(DISTINCT p1.Entity) AS NumCountries,
    AVG(COALESCE(p1.Major_depression, 0)) AS AvgCoverage,
    MAX(CASE WHEN c.Entity = 'Major_depression' THEN c.Number_of_countries ELSE 0 END) AS NumCountriesPrimaryData,
    CASE 
        WHEN AVG(COALESCE(p1.Major_depression, 0)) < 0.5 OR COUNT(DISTINCT p1.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END AS RepresentationStatus
FROM "Primary Data Coverage for Major Depression" p1
LEFT JOIN "Number of Countries with Primary Data" c
    ON p1.Year = c.Year
WHERE p1.Year = 2008 AND p1.Major_depression IS NOT NULL
UNION
SELECT 
    'Major_depression',
    COUNT(DISTINCT p2.Entity),
    AVG(COALESCE(p2.Major_depression, 0)),
    MAX(CASE WHEN c.Entity = 'Major_depression' THEN c.Number_of_countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p2.Major_depression, 0)) < 0.5 OR COUNT(DISTINCT p2.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Primary Data for Mental Illnesses" p2
LEFT JOIN "Number of Countries with Primary Data" c
    ON p2.Year = c.Year
WHERE p2.Year = 2008 AND p2.Major_depression IS NOT NULL
UNION
SELECT 
    'Bipolar_disorder',
    COUNT(DISTINCT p2.Entity),
    AVG(COALESCE(p2.Bipolar_disorder, 0)),
    MAX(CASE WHEN c.Entity = 'Bipolar_disorder' THEN c.Number_of_Countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p2.Bipolar_disorder, 0)) < 0.5 OR COUNT(DISTINCT p2.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Primary Data for Mental Illnesses" p2
LEFT JOIN "Number of Countries with Primary Data" c
    ON p2.Year = c.Year
WHERE p2.Year = 2008 AND p2.Bipolar_disorder IS NOT NULL
UNION
SELECT 
    'Eating_disorders',
    COUNT(DISTINCT p2.Entity),
    AVG(COALESCE(p2.Eating_disorders, 0)),
    MAX(CASE WHEN c.Entity = 'Eating_disorders' THEN c.Number_of_Countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p2.Eating_disorders, 0)) < 0.5 OR COUNT(DISTINCT p2.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Primary Data for Mental Illnesses" p2
LEFT JOIN "Number of Countries with Primary Data" c
    ON p2.Year = c.Year
WHERE p2.Year = 2008 AND p2.Eating_disorders IS NOT NULL
UNION
SELECT 
    'Dysthymia',
    COUNT(DISTINCT p2.Entity),
    AVG(COALESCE(p2.Dysthymia, 0)),
    MAX(CASE WHEN c.Entity = 'Dysthymia' THEN c.Number_of_Countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p2.Dysthymia, 0)) < 0.5 OR COUNT(DISTINCT p2.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Primary Data for Mental Illnesses" p2
LEFT JOIN "Number of Countries with Primary Data" c
    ON p2.Year = c.Year
WHERE p2.Year = 2008 AND p2.Dysthymia IS NOT NULL
UNION
SELECT 
    'Schizophrenia',
    COUNT(DISTINCT p2.Entity),
    AVG(COALESCE(p2.Schizophrenia, 0)),
    MAX(CASE WHEN c.Entity = 'Schizophrenia' THEN c.Number_of_Countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p2.Schizophrenia, 0)) < 0.5 OR COUNT(DISTINCT p2.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Primary Data for Mental Illnesses" p2
LEFT JOIN "Number of Countries with Primary Data" c
    ON p2.Year = c.Year
WHERE p2.Year = 2008 AND p2.Schizophrenia IS NOT NULL
UNION
SELECT 
    'Anxiety_disorders',
    COUNT(DISTINCT p2.Entity),
    AVG(COALESCE(p2.Anxiety_disorders, 0)),
    MAX(CASE WHEN c.Entity = 'Anxiety_disorders' THEN c.Number_of_Countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p2.Anxiety_disorders, 0)) < 0.5 OR COUNT(DISTINCT p2.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Primary Data for Mental Illnesses" p2
LEFT JOIN "Number of Countries with Primary Data" c
    ON p2.Year = c.Year
WHERE p2.Year = 2008 AND p2.Anxiety_disorders IS NOT NULL
UNION
SELECT 
    'Depressive_disorders',
    COUNT(DISTINCT p3.Entity),
    AVG(COALESCE(p3.Depressive_disorders, 0)),
    MAX(CASE WHEN c.Entity = 'Depressive_disorders' THEN c.Number_of_countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p3.Depressive_disorders, 0)) < 0.5 OR COUNT(DISTINCT p3.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Mental Illness Prevalence" p3
LEFT JOIN "Number of Countries with Primary Data" c
    ON p3.Year = c.Year
WHERE p3.Year = 2008 AND p3.Depressive_disorders IS NOT NULL
UNION
SELECT 
    'Anxiety_disorders',
    COUNT(DISTINCT p3.Entity),
    AVG(COALESCE(p3.Anxiety_disorders, 0)),
    MAX(CASE WHEN c.Entity = 'Anxiety_disorders' THEN c.Number_of_countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p3.Anxiety_disorders, 0)) < 0.5 OR COUNT(DISTINCT p3.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Mental Illness Prevalence" p3
LEFT JOIN "Number of Countries with Primary Data" c
    ON p3.Year = c.Year
WHERE p3.Year = 2008 AND p3.Anxiety_disorders IS NOT NULL
UNION
SELECT 
    'Bipolar_disorder',
    COUNT(DISTINCT p3.Entity),
    AVG(COALESCE(p3.Bipolar_disorder, 0)),
    MAX(CASE WHEN c.Entity = 'Bipolar_disorder' THEN c.Number_of_countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p3.Bipolar_disorder, 0)) < 0.5 OR COUNT(DISTINCT p3.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Primary Data for Mental Illnesses" p3
LEFT JOIN "Number of Countries with Primary Data" c
    ON p3.Year = c.Year
WHERE p3.Year = 2008 AND p3.Bipolar_disorder IS NOT NULL
UNION
SELECT 
    'Eating_disorders',
    COUNT(DISTINCT p3.Entity),
    AVG(COALESCE(p3.Eating_disorders, 0)),
    MAX(CASE WHEN c.Entity = 'Eating_disorders' THEN c.Number_of_countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p3.Eating_disorders, 0)) < 0.5 OR COUNT(DISTINCT p3.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Mental Illness Prevalence" p3
LEFT JOIN "Number of Countries with Primary Data" c
    ON p3.Year = c.Year
WHERE p3.Year = 2008 AND p3.Eating_disorders IS NOT NULL
UNION
SELECT 
    'Schizophrenia_disorders',
    COUNT(DISTINCT p3.Entity),
    AVG(COALESCE(p3.Schizophrenia_disorders, 0)),
    MAX(CASE WHEN c.Entity = 'Schizophrenia_disorders' THEN c.Number_of_countries ELSE 0 END),
    CASE 
        WHEN AVG(COALESCE(p3.Schizophrenia_disorders, 0)) < 0.5 OR COUNT(DISTINCT p3.Entity) < 30 
        THEN 'Underreported' 
        ELSE 'WellRepresented' 
    END
FROM "Mental Illness Prevalence" p3
LEFT JOIN "Number of Countries with Primary Data" c
    ON p3.Year = c.Year
WHERE p3.Year = 2008 AND p3.Schizophrenia_disorders IS NOT NULL
GROUP BY Number_of_countries
ORDER BY Disorder DESC, NumCountries DESC, AvgCoverage DESC, NumCountriesPrimaryData DESC, RepresentationStatus DESC;

