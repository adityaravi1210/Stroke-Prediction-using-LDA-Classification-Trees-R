# Stroke Prediction using LDA & Classification Trees in R

This project aims to predict the occurrence of a stroke in a patient based on their health metrics.

## Dataset Description

The dataset comprises details of 5110 patients. Each patient is described by the following attributes:

- **ID**: Unique identifier.
- **Gender**: Male, female, or other.
- **Age**: Age of the patient.
- **Hypertension**: Absence (0) or presence (1) of hypertension.
- **Heart Disease**: Absence (0) or presence (1) of heart disease.
- **Marital Status**: Whether the patient has ever been married (Yes/No).
- **Work Type**: Type of employment (children, never_worked, self_employed, private, govt_job).
- **Residency**: Urban or rural.
- **Average Glucose Level**: Average glucose level in the blood.
- **BMI**: Body mass index.
- **Smoking Status**: Current smoking status (formerly smoked, never smoked, smokes, unknown).
- **Stroke**: Absence (0) or presence (1) of stroke.

These attributes are utilized to train and test prediction models using LDA and Random Forest techniques.

## Methods Employed

- **Linear Discriminant Analysis (LDA)**
- **Random Forest Classification**

## R Libraries Utilized

- `funModeling`
- `tidyverse`
- `Hmisc`
- `MASS`
- `stats`
- `pscl`
- `rms`
- `plyr`
- `caTools`
- `partykit`
