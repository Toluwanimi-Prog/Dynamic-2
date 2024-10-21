

I chose the dataset "Federal, State, and Local Government
Transportation-Related Revenues and Expenditures, Fiscal Year" provides
financial data on transportation-related revenues and expenditures
across federal, state, and local governments in the United States,
measured in millions of current dollars. It includes detailed
information on government revenues from user charges and taxes
specifically allocated for transportation programs, as well as
expenditures in this sector over multiple fiscal years. The dataset
excludes general fund revenues and borrowing proceeds, focusing on
own-source revenues.

The data is sourced from the U.S. Department of Transportation's Bureau
of Transportation Statistics (BTS) and is published under the National
Transportation Statistics Table 3-29, available on the BTS website. This
dataset is instrumental for analyzing transportation funding and
government spending trends at various governmental levels.

**Dataset Exploration**

::::::::::: cell
``` {.r .cell-code}
# Load necessary libraries
library(readxl)  # To read Excel files
library(dplyr)   # For data manipulation
```

::: {.cell-output .cell-output-stderr}

    Attaching package: 'dplyr'
:::

::: {.cell-output .cell-output-stderr}
    The following objects are masked from 'package:stats':

        filter, lag
:::

::: {.cell-output .cell-output-stderr}
    The following objects are masked from 'package:base':

        intersect, setdiff, setequal, union
:::

``` {.r .cell-code}
library(ggplot2) # For visualization
```

::: {.cell-output .cell-output-stderr}
    Warning: package 'ggplot2' was built under R version 4.3.2
:::

``` {.r .cell-code}
# Task 1: Load the dataset
file_path <-  "C:/Users/toluf/OneDrive/Desktop/Dynamic 2/Archive 2/table_03_29_061324.xlsx"


dataset <- read_excel(file_path, sheet = 2)
```

::: {.cell-output .cell-output-stderr}
    New names:
    • `` -> `...2`
    • `` -> `...3`
    • `` -> `...4`
    • `` -> `...5`
    • `` -> `...6`
    • `` -> `...7`
    • `` -> `...8`
    • `` -> `...9`
    • `` -> `...10`
    • `` -> `...11`
    • `` -> `...12`
    • `` -> `...13`
    • `` -> `...14`
    • `` -> `...15`
    • `` -> `...16`
:::

``` {.r .cell-code}
# Explore the structure of the dataset
str(dataset)
```

::: {.cell-output .cell-output-stdout}
    tibble [17 × 16] (S3: tbl_df/tbl/data.frame)
     $ Table 3-29:  Federal, State, and Local Government Transportation-Related Revenues and Expenditures, Fiscal Year (millions of current dollars): chr [1:17] NA "Total government revenues" "Federal" "State and local" ...
     $ ...2                                                                                                                                         : num [1:17] 2007 163884 53967 109917 268843 ...
     $ ...3                                                                                                                                         : num [1:17] 2008 163222 52102 111120 284343 ...
     $ ...4                                                                                                                                         : num [1:17] 2009 157684 47287 110397 300267 ...
     $ ...5                                                                                                                                         : num [1:17] 2010 160472 47244 113227 303516 ...
     $ ...6                                                                                                                                         : num [1:17] 2011 171324 50310 121014 303784 ...
     $ ...7                                                                                                                                         : num [1:17] 2012 179173 54473 124699 314024 ...
     $ ...8                                                                                                                                         : num [1:17] 2013 174527 50686 123841 309276 ...
     $ ...9                                                                                                                                         : num [1:17] 2014 183537 54161 129376 324000 ...
     $ ...10                                                                                                                                        : num [1:17] 2015 194195 56714 137481 329551 ...
     $ ...11                                                                                                                                        : num [1:17] 2016 194420 57279 137141 339439 ...
     $ ...12                                                                                                                                        : num [1:17] 2017 203528 57628 145900 355374 ...
     $ ...13                                                                                                                                        : num [1:17] 2018 213373 60035 153338 370884 ...
     $ ...14                                                                                                                                        : num [1:17] 2019 228293 62142 166150 384211 ...
     $ ...15                                                                                                                                        : num [1:17] 2020 200560 53719 146842 404177 ...
     $ ...16                                                                                                                                        : num [1:17] 2021 196163 53503 142660 398764 ...
:::

``` {.r .cell-code}
# Check for missing values
summary(dataset)
```

::: {.cell-output .cell-output-stdout}
     Table 3-29:  Federal, State, and Local Government Transportation-Related Revenues and Expenditures, Fiscal Year (millions of current dollars)
     Length:17                                                                                                                                    
     Class :character                                                                                                                             
     Mode  :character                                                                                                                             
                                                                                                                                                  
                                                                                                                                                  
                                                                                                                                                  
                                                                                                                                                  
          ...2             ...3             ...4             ...5       
     Min.   :  2007   Min.   :  2008   Min.   :  2009   Min.   :  2010  
     1st Qu.: 42052   1st Qu.: 45088   1st Qu.: 42913   1st Qu.: 43445  
     Median : 81942   Median : 81611   Median : 82167   Median : 85120  
     Mean   :114380   Mean   :118497   Mean   :121481   Mean   :123375  
     3rd Qu.:183756   3rd Qu.:186542   3rd Qu.:185882   3rd Qu.:188221  
     Max.   :268843   Max.   :284343   Max.   :300267   Max.   :303516  
     NA's   :9        NA's   :9        NA's   :9        NA's   :9       
          ...6             ...7             ...8             ...9       
     Min.   :  2011   Min.   :  2012   Min.   :  2013   Min.   :  2014  
     1st Qu.: 46028   1st Qu.: 49049   1st Qu.: 46068   1st Qu.: 48811  
     Median : 87711   Median : 91481   Median : 90561   Median : 94066  
     Mean   :125829   Mean   :130834   Mean   :128363   Mean   :134480  
     3rd Qu.:196144   3rd Qu.:204692   3rd Qu.:200162   3rd Qu.:210463  
     Max.   :303784   Max.   :314024   Max.   :309276   Max.   :324000  
     NA's   :9        NA's   :9        NA's   :9        NA's   :9       
         ...10            ...11            ...12            ...13       
     Min.   :  2015   Min.   :  2016   Min.   :  2017   Min.   :  2018  
     1st Qu.: 50609   1st Qu.: 51743   1st Qu.: 52507   1st Qu.: 53460  
     Median : 97294   Median : 98386   Median :101765   Median :107654  
     Mean   :138327   Mean   :141171   Mean   :147181   Mean   :154063  
     3rd Qu.:219960   3rd Qu.:221892   3rd Qu.:232204   3rd Qu.:244318  
     Max.   :329551   Max.   :339439   Max.   :355374   Max.   :370884  
     NA's   :9        NA's   :9        NA's   :9        NA's   :9       
         ...14            ...15            ...16       
     Min.   :  2019   Min.   :  2020   Min.   :  2021  
     1st Qu.: 55380   1st Qu.: 50734   1st Qu.: 50281  
     Median :115440   Median :113377   Median :113880  
     Mean   :161470   Mean   :161426   Mean   :159622  
     3rd Qu.:258499   3rd Qu.:241019   3rd Qu.:236660  
     Max.   :384211   Max.   :404177   Max.   :398764  
     NA's   :9        NA's   :9        NA's   :9       
:::

``` {.r .cell-code}
# Check for duplicates
duplicated_rows <- dataset[duplicated(dataset), ]

# Rename columns for easier access
colnames(dataset) <- c("Description", "2007", "2008", "2009", "2010", "2011", 
                       "2012", "2013", "2014", "2015", "2016", "2017", "2018", 
                       "2019", "2020", "2021")

# Get an overview of the data
head(dataset)
```

::: {.cell-output .cell-output-stdout}
    # A tibble: 6 × 16
      Description     `2007` `2008` `2009` `2010` `2011` `2012` `2013` `2014` `2015`
      <chr>            <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
    1 <NA>            2.01e3 2.01e3 2.01e3 2.01e3 2.01e3 2.01e3 2.01e3 2.01e3 2.02e3
    2 Total governme… 1.64e5 1.63e5 1.58e5 1.60e5 1.71e5 1.79e5 1.75e5 1.84e5 1.94e5
    3 Federal         5.40e4 5.21e4 4.73e4 4.72e4 5.03e4 5.45e4 5.07e4 5.42e4 5.67e4
    4 State and local 1.10e5 1.11e5 1.10e5 1.13e5 1.21e5 1.25e5 1.24e5 1.29e5 1.37e5
    5 Total governme… 2.69e5 2.84e5 3.00e5 3.04e5 3.04e5 3.14e5 3.09e5 3.24e5 3.30e5
    6 State and loca… 2.43e5 2.57e5 2.70e5 2.71e5 2.71e5 2.81e5 2.77e5 2.91e5 2.97e5
    # ℹ 6 more variables: `2016` <dbl>, `2017` <dbl>, `2018` <dbl>, `2019` <dbl>,
    #   `2020` <dbl>, `2021` <dbl>
:::
:::::::::::

**Data Cleaning**

::::: cell
``` {.r .cell-code}
# Task 2: Data Cleaning

# Remove duplicates (if any)
dataset <- dataset %>% distinct()

# Handle missing values (remove rows with missing values or impute with mean/median if necessary)
# Option 1: Remove rows with missing values
cleaned_dataset <- na.omit(dataset)

# Option 2: Impute missing values with median (can also use mean if more appropriate)
cleaned_dataset <- dataset %>% 
  mutate(across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .)))

# Check for inconsistencies or outliers using boxplots (visual inspection)
boxplot(cleaned_dataset[, sapply(cleaned_dataset, is.numeric)], main = "Boxplots for Numeric Variables")
```

::: cell-output-display
![](week7_baruga_r_files/figure-markdown/unnamed-chunk-2-1.png)
:::

``` {.r .cell-code}
# Remove rows where the Description column is NA
cleaned_dataset <- dataset %>% filter(!is.na(Description))

# Convert year columns to numeric
cleaned_dataset[, -1] <- lapply(cleaned_dataset[, -1], as.numeric)

# Check if the conversion was successful
str(cleaned_dataset)
```

::: {.cell-output .cell-output-stdout}
    tibble [14 × 16] (S3: tbl_df/tbl/data.frame)
     $ Description: chr [1:14] "Total government revenues" "Federal" "State and local" "Total government expenditures" ...
     $ 2007       : num [1:14] 163884 53967 109917 268843 243373 ...
     $ 2008       : num [1:14] 163222 52102 111120 284343 256501 ...
     $ 2009       : num [1:14] 157684 47287 110397 300267 270478 ...
     $ 2010       : num [1:14] 160472 47244 113227 303516 271470 ...
     $ 2011       : num [1:14] 171324 50310 121014 303784 270602 ...
     $ 2012       : num [1:14] 179173 54473 124699 314024 281248 ...
     $ 2013       : num [1:14] 174527 50686 123841 309276 277065 ...
     $ 2014       : num [1:14] 183537 54161 129376 324000 291241 ...
     $ 2015       : num [1:14] 194195 56714 137481 329551 297255 ...
     $ 2016       : num [1:14] 194420 57279 137141 339439 304305 ...
     $ 2017       : num [1:14] 203528 57628 145900 355374 318231 ...
     $ 2018       : num [1:14] 213373 60035 153338 370884 337150 ...
     $ 2019       : num [1:14] 228293 62142 166150 384211 349118 ...
     $ 2020       : num [1:14] 200560 53719 146842 404177 362396 ...
     $ 2021       : num [1:14] 196163 53503 142660 398764 358148 ...
:::
:::::

**Descriptive Statistics**

:::::::: cell
``` {.r .cell-code}
# Calculate summary statistics for numeric columns
descriptive_stats <- cleaned_dataset %>%
  summarise(across(where(is.numeric), list(
    mean = ~ mean(., na.rm = TRUE),
    median = ~ median(., na.rm = TRUE),
    std_dev = ~ sd(., na.rm = TRUE)
  )))

# View the descriptive statistics
print(descriptive_stats)
```

::: {.cell-output .cell-output-stdout}
    # A tibble: 1 × 45
      `2007_mean` `2007_median` `2007_std_dev` `2008_mean` `2008_median`
            <dbl>         <dbl>          <dbl>       <dbl>         <dbl>
    1     130433.       109917.         97623.     135138.       111120.
    # ℹ 40 more variables: `2008_std_dev` <dbl>, `2009_mean` <dbl>,
    #   `2009_median` <dbl>, `2009_std_dev` <dbl>, `2010_mean` <dbl>,
    #   `2010_median` <dbl>, `2010_std_dev` <dbl>, `2011_mean` <dbl>,
    #   `2011_median` <dbl>, `2011_std_dev` <dbl>, `2012_mean` <dbl>,
    #   `2012_median` <dbl>, `2012_std_dev` <dbl>, `2013_mean` <dbl>,
    #   `2013_median` <dbl>, `2013_std_dev` <dbl>, `2014_mean` <dbl>,
    #   `2014_median` <dbl>, `2014_std_dev` <dbl>, `2015_mean` <dbl>, …
:::

``` {.r .cell-code}
# Plot the distribution for one of the years, e.g., 2021
hist(cleaned_dataset$`2021`, 
     main = "Distribution of Transportation-Related Revenues/Expenditures for 2021", 
     xlab = "Revenue/Expenditure (Millions)", 
     breaks = 20)
```

::: cell-output-display
![](week7_baruga_r_files/figure-markdown/unnamed-chunk-3-1.png)
:::

``` {.r .cell-code}
# Example: Create a correlation matrix to identify relationships between variables
cor_matrix <- cor(cleaned_dataset %>% select(where(is.numeric)), use = "complete.obs")
print(cor_matrix)
```

::: {.cell-output .cell-output-stdout}
              2007      2008      2009      2010      2011      2012      2013
    2007 1.0000000 0.9992200 0.9957372 0.9955944 0.9982996 0.9987699 0.9982597
    2008 0.9992200 1.0000000 0.9985997 0.9984952 0.9995968 0.9998451 0.9995891
    2009 0.9957372 0.9985997 1.0000000 0.9999387 0.9988945 0.9988467 0.9989537
    2010 0.9955944 0.9984952 0.9999387 1.0000000 0.9990215 0.9989126 0.9990930
    2011 0.9982996 0.9995968 0.9988945 0.9990215 1.0000000 0.9999100 0.9999483
    2012 0.9987699 0.9998451 0.9988467 0.9989126 0.9999100 1.0000000 0.9999287
    2013 0.9982597 0.9995891 0.9989537 0.9990930 0.9999483 0.9999287 1.0000000
    2014 0.9985962 0.9997517 0.9988848 0.9989586 0.9999355 0.9999718 0.9999746
    2015 0.9993482 0.9993916 0.9970608 0.9971437 0.9994229 0.9995078 0.9994220
    2016 0.9988899 0.9997125 0.9983948 0.9984766 0.9999131 0.9999101 0.9998824
    2017 0.9986660 0.9992946 0.9977322 0.9978360 0.9997184 0.9995628 0.9995986
    2018 0.9989272 0.9994124 0.9977061 0.9977523 0.9995666 0.9995920 0.9996157
    2019 0.9987879 0.9985028 0.9957926 0.9959504 0.9987484 0.9987679 0.9988146
    2020 0.9911542 0.9955344 0.9990016 0.9991752 0.9966571 0.9963679 0.9968956
    2021 0.9894631 0.9942597 0.9982861 0.9984816 0.9953152 0.9951339 0.9956841
              2014      2015      2016      2017      2018      2019      2020
    2007 0.9985962 0.9993482 0.9988899 0.9986660 0.9989272 0.9987879 0.9911542
    2008 0.9997517 0.9993916 0.9997125 0.9992946 0.9994124 0.9985028 0.9955344
    2009 0.9988848 0.9970608 0.9983948 0.9977322 0.9977061 0.9957926 0.9990016
    2010 0.9989586 0.9971437 0.9984766 0.9978360 0.9977523 0.9959504 0.9991752
    2011 0.9999355 0.9994229 0.9999131 0.9997184 0.9995666 0.9987484 0.9966571
    2012 0.9999718 0.9995078 0.9999101 0.9995628 0.9995920 0.9987679 0.9963679
    2013 0.9999746 0.9994220 0.9998824 0.9995986 0.9996157 0.9988146 0.9968956
    2014 1.0000000 0.9995464 0.9999361 0.9996537 0.9997081 0.9989196 0.9965499
    2015 0.9995464 1.0000000 0.9997745 0.9997836 0.9998933 0.9997817 0.9937224
    2016 0.9999361 0.9997745 1.0000000 0.9998653 0.9998327 0.9992473 0.9956970
    2017 0.9996537 0.9997836 0.9998653 1.0000000 0.9998272 0.9994682 0.9948384
    2018 0.9997081 0.9998933 0.9998327 0.9998272 1.0000000 0.9996941 0.9948117
    2019 0.9989196 0.9997817 0.9992473 0.9994682 0.9996941 1.0000000 0.9924318
    2020 0.9965499 0.9937224 0.9956970 0.9948384 0.9948117 0.9924318 1.0000000
    2021 0.9952895 0.9920435 0.9942353 0.9930950 0.9932298 0.9905877 0.9998203
              2021
    2007 0.9894631
    2008 0.9942597
    2009 0.9982861
    2010 0.9984816
    2011 0.9953152
    2012 0.9951339
    2013 0.9956841
    2014 0.9952895
    2015 0.9920435
    2016 0.9942353
    2017 0.9930950
    2018 0.9932298
    2019 0.9905877
    2020 0.9998203
    2021 1.0000000
:::

``` {.r .cell-code}
# Visualize correlations (optional)
library(corrplot)
```

::: {.cell-output .cell-output-stderr}
    corrplot 0.92 loaded
:::

``` {.r .cell-code}
corrplot(cor_matrix, method = "circle")
```

::: cell-output-display
![](week7_baruga_r_files/figure-markdown/unnamed-chunk-3-2.png)
:::
::::::::
