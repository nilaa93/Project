# Project
Migration trends analysis 

# Description
This project analyzes migration trends with a focus on UNHCR quota refugees and asylum seekers applications from the MENA region (Middle East and North Africa) to Sweden and Germany between 2018 and 2023. The purpose is to compare these trends and understand the impact of national policies and international crises on migration patterns over time. 

# Dataset
The data was sourced from the UNHCR refugee statistics portal and includes:

Year (2018-2023)
Country of Origin: MENA region countries.
Country of Asylum: Sweden or Germany.
Number of Asylum Seekers: Total asylum applications per year.
Quota Refugees under UNHCR's Mandate: Total number of quota refugees applications per year.

# Python Code for Data Processing and Analysis
Start by installing the necessary Python libraries:
pip install pandas pyodbc sqlalchemy matplotlib seaborn

# Database Connection and SQL Queries
The project uses SQLAlchemy and PyODBC to handle SQL database connections and execute queries.

# Data Analysis and Visualizations
Visualizations are used to analyze migration trends over time for quota refugees and asylum seekers in Sweden and Germany. Seaborn and Matplotlib are used to create plots for ''Yearly Percentage Change per Country'' and '' Visualizing Refugee Trends per Year''

# Correlation Between Quota Refugees and Asylum Seekers
This project also includes a correlation analysis to identify any relationship between the number of quota refugees and asylum seekers applications in Sweden and Germany.
