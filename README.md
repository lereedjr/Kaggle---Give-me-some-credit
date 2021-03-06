
# Can I Borrow Some Money?

### Overview

The Kaggle competition requires participants to improve on the state of the art in credit scoring, by predicting the probability that somebody will experience financial distress in the next two years.

Banks play a crucial role in market economies. They decide who can get finance and on what terms and can make or break investment decisions. For markets and society to function, individuals and companies need access to credit. 
Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted. 

### Motivation

The goal of this dataset is to participate in a Kaggle competition is to build a model that borrowers can use to help make the best financial decisions.Credit scoring algorithms, which make a guess at the probability of default, are the method banks use to determine whether or not a loan should be granted.

### Data
The dataset contains 150,000 rows and 11 columns. Go to kaggle https://www.kaggle.com/c/GiveMeSomeCredit/data for dataset. 

#### Variable Names:
SeriousDlqin2yrs: Person experienced 90 days past due delinquency or worse 

RevolvingUtilizationOfUnsecuredLines: Total balance on credit cards and personal lines of credit except real estate and no installment debt like car loans divided by the sum of credit limits.

age:Age of borrower in years

NumberOfTime30-59DaysPastDueNotWorse: Number of times borrower has been 30-59 days past due but no worse in the last 2 years.

DebtRatio : Monthly debt payments, alimony,living costs divided by monthy gross income

MonthlyIncome: Monthly debt payments, alimony,living costs divided by monthy gross income

NumberOfOpenCreditLinesAndLoans: Number of Open loans (installment like car loan or mortgage) and Lines of credit (e.g. credit cards)

NumberOfTimes90DaysLate: Number of times borrower has been 90 days or more past due.

NumberRealEstateLoansOrLines:Number of mortgage and real estate loans including home equity lines of credit.

NumberOfTime60-89DaysPastDueNotWorse: Number of times borrower has been 60-89 days past due but no worse in the last 2 years.

NumberOfDependents: Number of dependents in family excluding themselves (spouse, children etc.)

### Visualizations:

The model building process involves setting up ways of collecting data, understanding and paying attention to what is important in the data to answer if individuals will experience financial distress in the next two years. Here's the layout of the process:

<a href="http://tinypic.com?ref=2w2gghv" target="_blank"><img src="http://i64.tinypic.com/2w2gghv.png" border="0" alt="Image and video hosting by TinyPic"></a>

In the Number of Open Credit Lines And Loans boxplot, there are serveral outliers in the upper whisker and the data looks slightly skewed to the right. 

#### Histogram of Number of Open Credit Lines  
<a href="http://tinypic.com?ref=314fbqd" target="_blank"><img src="http://i65.tinypic.com/314fbqd.png" border="0" alt="Image and video hosting by TinyPic"></a>

In the histogram to be sure they are outliers and data is slighltly skewed to the right. The outliers in the boxplot could have caused it to not take the shape of a normal distribution, so lets remove them.

#### Boxplot of Number of Open Credit Lines 
<a href="http://tinypic.com?ref=bg8o44" target="_blank"><img src="http://i65.tinypic.com/bg8o44.png" border="0" alt="Image and video hosting by TinyPic"></a>

### Analysis:
#### Data Preparation 
Read in the dataset to look at the structure of the data to view data types of the variables and their five-number summary.
- Look at the data types (integer, number, factor) to decide if they need to be categorical or continuous. 
- Check the five-number summary to measure the range and distribution of the variables. 
    - Minimum
    - Maximum
    - Mean
    - Median
    - Quartiles (First and Third)

#### Data Cleaning
Transform variables (if needed) to make sure they have the correct value ranges that makes sense. 
-  Remove outliers/anomalies
    - Replace missing or extensive ranges with NA
-  Remove all the NA’s

#### Exploratory Data Analysis
Look at the patterns or trends in the data using histograms and barplots. 
- Check the distribution of all continuous variables
    - Make sure they are normally distributed
- Bivariate bar plot visualizations of target variable and each predictor
    - Measure the count between the two groups in the target variable 
- T-test for equal variance among between the two groups 

#### Modeling
The target variable of the data is categorical, so classification machine learning algorithms will be used. 
- Perform classification techniques using cross-validation with Logistic Regression, Decision Tree, K-NN, and Ensemble Methods.
    - Confusion Matrix
    - ROC
    - Predict using test set
    
### Conclusion
Chose the best model from the four different classification techniques with a very high accuracy and kappa statistic. 



