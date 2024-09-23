## Markdown title

Markdown Lists:

- Item 1
- Item 2
- Item 3

Enumarated list

1. Hola
2. Hi
3. Namaste

We can do **bold**, or *italic*


```python
# Importing Numpy with nickname np
import numpy as np
np.absolute(-1)
arr = np.array([1, 2, 3, 4, 5])
print(arr)
```

    [1 2 3 4 5]
    


```python
# Lists are native to python
my_list = [1, 2, 3, 4, 5]
print(my_list)
```

    [1, 2, 3, 4, 5]
    


```python
# Dataframes, so we need pandas library
import pandas as pd
data = {'Ozone': [41, 36, 12], 'Temp': [67, 72, 74]}
df = pd.DataFrame(data)
print(df)
```

       Ozone  Temp
    0     41    67
    1     36    72
    2     12    74
    

## 4. Loading csv files

To load .csv files into a 'DataFrame', we use pandas function read_csv


```python
df = pd.read_csv('/Users/derrickmarkbavaudbaruga/Documents/fall 2024/CSC 477/Week 2/airquality_datasets.csv')
# Summary of the dataset
print(df.info())
print(df.describe())
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 153 entries, 0 to 152
    Data columns (total 6 columns):
     #   Column   Non-Null Count  Dtype  
    ---  ------   --------------  -----  
     0   Ozone    116 non-null    float64
     1   Solar.R  146 non-null    float64
     2   Wind     153 non-null    float64
     3   Temp     153 non-null    int64  
     4   Month    153 non-null    int64  
     5   Day      153 non-null    int64  
    dtypes: float64(3), int64(3)
    memory usage: 7.3 KB
    None
                Ozone     Solar.R        Wind        Temp       Month         Day
    count  116.000000  146.000000  153.000000  153.000000  153.000000  153.000000
    mean    42.129310  185.931507    9.957516   77.882353    6.993464   15.803922
    std     32.987885   90.058422    3.523001    9.465270    1.416522    8.864520
    min      1.000000    7.000000    1.700000   56.000000    5.000000    1.000000
    25%     18.000000  115.750000    7.400000   72.000000    6.000000    8.000000
    50%     31.500000  205.000000    9.700000   79.000000    7.000000   16.000000
    75%     63.250000  258.750000   11.500000   85.000000    8.000000   23.000000
    max    168.000000  334.000000   20.700000   97.000000    9.000000   31.000000
    


```python
import matplotlib.pyplot as plt

# Ozone Histogram
plt.figure(figsize=(8, 6))
plt.hist(df['Ozone'].dropna(), bins=20, color='blue', edgecolor='black')
plt.title('Distribution of Ozone Levels')
plt.xlabel('Ozone (ppb)')
plt.ylabel('Frequency')
plt.show()
```


    
![png](week4_baruga_python_files/week4_baruga_python_6_0.png)
    



```python
# Temp Histogram
plt.figure(figsize=(8, 6))
plt.hist(df['Temp'].dropna(), bins=20, color='orange', edgecolor='black')
plt.title('Distribution of Temperature')
plt.xlabel('Temperature (°F)')
plt.ylabel('Frequency')
plt.show()
```


    
![png](week4_baruga_python_files/week4_baruga_python_7_0.png)
    



```python
# Boxplot for Ozone
plt.figure(figsize=(8, 6))
plt.boxplot(df['Ozone'].dropna())
plt.title('Boxplot of Ozone Levels')
plt.ylabel('Ozone (ppb)')
plt.show()
```


    
![png](week4_baruga_python_files/week4_baruga_python_8_0.png)
    



```python
# Boxplot for Temp
plt.figure(figsize=(8, 6))
plt.boxplot(df['Temp'].dropna())
plt.title('Boxplot of Temperature')
plt.ylabel('Temperature (°F)')
plt.show()
```


    
![png](week4_baruga_python_files/week4_baruga_python_9_0.png)
    

