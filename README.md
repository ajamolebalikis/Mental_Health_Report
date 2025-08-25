# Mental_Health_Report

## Introduction
Mental health remains a critical global health challenge, with rising prevalence and significant treatment gaps affecting millions worldwide. This project leverages comprehensive datasets downloaded from Kaggle to analyze patterns in prevalence, disease burden, and treatment disparities across countries and years. The analysis aims to empower public health organizations with actionable insights to address the most pressing mental health needs. This project outlines the project’s structure, findings, and recommendations to guide resource allocation and policy development.

## Contents
- [Introduction](#introduction)
- [Problem Statement](#problem-statement)
- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Datasets](#datasets)
- [Tools Used](#tools-used)
- [Analysis Results](#analysis-results)
- [Recommendations](#recommendations)
- [Conclusions](#conclusions)

## Problem Statement
Mental health disorders, including depression, anxiety, and schizophrenia, impose a substantial global burden, yet many regions, particularly lower -and middle-income countries (LMICs), face significant treatment gaps and underreported data. Current public health strategies lack sufficient data-driven insights to prioritize resources effectively, especially where prevalence and burden are high but treatment access is limited. This necessitates a comprehensive study to identify disparities and inform evidence-based interventions.

## Project Overview
This project conducts a detailed analysis of global mental health data, starting with datasets downloaded from Kaggle. Data cleaning was performed in Excel to ensure quality and consistency, followed by analysis using SQL Server. The study integrates seven datasets from the Institute for Health Metrics and Evaluation (IHME) Global Burden of Disease (GBD) study, focusing on prevalence rates, disease burden (DALYs), treatment gaps, and data coverage across countries and years (1990–2019). The analysis includes data importation into SQL Server, querying to answer key business questions, and generating recommendations for public health stakeholders.

## Objectives
- *Prevalence Analysis*: Identify countries and regions with the highest and lowest prevalence of mental illnesses and assess trends over time.
- *Burden Comparison*: Compare disease burden (DALYs) with prevalence to detect disproportionate health losses and underreported regions.
- *Treatment Gap Assessment*: Determine the largest treatment gaps for anxiety disorders and compare treatment rates across countries.
- *Data Coverage Evaluation*: Quantify the percentage of the global adult population covered in primary data collection and identify underrepresented disorders or regions.
- *Symptom Patterns*: Analyze the frequency of depressive symptoms in the U.S. population.
- *Mismatch Identification*: Spot regions with high disease burden but low treatment coverage.
- *Representation Check*: Assess which disorders are well-represented or underreported across datasets.

## Datasets
The project utilizes the following datasets, downloaded from Kathleen:
1. *Mental Illness Prevalence*: Includes columns such as Entity, Year, Schizophrenia, Depressive_disorders, Anxiety_disorders, Bipolar_disorders, and Eating_disorders (age-standardized share of population).
2. *Burden of Disease from Mental Illness*: Contains Entity, Year, and DALYs rates for Depressive_disorders, Schizophrenia, Bipolar_disorders, Eating_disorders, and Anxiety_disorders.
3. *Adult Population Covered (Major Depression)*: Includes Entity, Year, and Major_depression. 
4. *Adult Population Covered (Mental Illnesses)*: Features Entity, Year, Major_depression, Bipolar_disorder, Eating_disorders, Dysthymia, Schizophrenia, and Anxiety_disorder coverage.
5. *Anxiety Disorders Treatment Gap*: Contains Entity, Year, Potentially_adequate_treatment, Other_treatments, and Untreated percentages.
6. *Depressive Symptoms (US Population)*: Includes Entity, Year, and frequency categories (NearlyEveryDay, MoreThanHalfDays, SeveralDays, NotAtAll).
7. *Number of Countries with Primary Data*: Features Entity, Year, and NumberOfCountriesWithPrimaryData on prevalence.

## Tools Used
- *Excel*: Used for initial data cleaning, including handling missing values, removing duplicates, and standardizing column names.
- *SQL Server Management Studio (SSMS)*: Employed for data importation, storage, and advanced querying to analyze prevalence, disorders and treatment gaps, utilized for executing SQL queries and visualizing analysis results.
- *GitHub*:For project documentation.

## Analysis Results
The analysis conducted revealed the following insights:
- *Prevalence*: Uganda recorded the highest depressive disorder rate (5.7%), while Brunei had the lowest (2.5%). Anxiety is the most common disorder globally (4%), with stable or slightly increasing trends, depression from 3.4% in 1990 to 3.8% in 2019.
- *Burden*: Depression accounts for 46% of mental DALYs, with sub-Saharan Africa showing high schizophrenia DALYs despite low reported prevalence (possible underreporting).
- *Treatment Gaps*: Lebanon (92% untreated anxiety), Iraq (89%), Nigeria (88.6%) and lower-middle-income-countries exhibit the largest gaps; the USA leads with 29% potentially adequate treatment.
- *Data Coverage*: Global adult coverage is 55% for major depression and 50% for anxiety; dysthymia (25%) and eating disorders (30%) are underrepresented, with high-income regions North America better studied than sub-Saharan Africa (20–30%).
- *Depressive Symptoms (US)*: “Several days” (30%) is most common; “nearly every day” (5%) is least prevalent.
- *Mismatches*: Sub-Saharan Africa and the Middle East show high DALYs but low treatment coverage like 85% untreated anxiety.
- *Representation*: Depression and anxiety are well-represented; dysthymia and eating disorders are underreported.

## Recommendations
Based on the analysis, the following recommendations are proposed for public health decision-makers:
- *Prioritize Uganda and LMICs*: Expand mental health services in Uganda (highest prevalence at 5.7%), Lebanon, Iraq, Nigeria, LMIC and sub-Saharan Africa through telehealth and provider training.
- *Improve Data Collection*: Increase primary data surveys in Africa and Asia, focusing on underrepresented disorders like dysthymia and eating disorders.
- *Address Disorders*: Enhance schizophrenia diagnostics and reporting in high-DALY regions like sub-Saharan Africa.
- *Target Vulnerable Groups*: Focus on women and youth (rising prevalence) with gender-specific interventions, especially in the U.S. for frequent symptoms.
- *Integrate Care*: Link mental health to non-communicable disease programs in high-need, low-treatment regions like sub-Saharan Africa.
- *Monitor Trends*: Use annual GBD updates and digital tools for real-time data tracking.
- *Policy Focus*: Advocate for increased funding to close treatment gaps in LMICs, aiming for at least 20% adequate treatment coverage.

## Conclusions
This project underscores the significant and growing burden of mental illnesses globally, with Uganda emerging as a key focus due to its highest prevalence rate of 5.7%.The analysis highlights disparities in prevalence, treatment, and data coverage, particularly in LMICs. By addressing these gaps through targeted interventions, improved data collection, and integrated health strategies, public health organizations can optimize resource allocation and enhance mental health outcomes. Future efforts should expand dataset coverage and incorporate real-time data to refine these insights further.
