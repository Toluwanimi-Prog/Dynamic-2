

Here’s a structured tutorial to showcase the power of **scikit-learn** using the Iris dataset, incorporating statistical summaries, visualizations, simple linear regression, correlation plots, and multiple linear regression.


**1. Statistical Summary** with Pandas
Start by loading the Iris dataset and generating summary statistics using **Pandas**.

```{python}
import pandas as pd
from sklearn import datasets

# Load the Iris dataset
iris = datasets.load_iris()

# Convert it into a Pandas DataFrame
iris_df = pd.DataFrame(data=iris.data, columns=iris.feature_names)

# Describe the statistics
iris_df.describe()
```

The .describe() function gives you important statistics, such as count, mean, standard deviation, min, max, and quartiles for each feature

2. **Visualizations** Using Matplotlib and Seaborn

Now, visualize the data to understand relationships between features. Seaborn is great for quick visualizations.

```{python}
import seaborn as sns
import matplotlib.pyplot as plt

# Pairplot to visualize relationships between features
sns.pairplot(iris_df)
plt.show()

# Add the target (species) to the DataFrame for visualization
iris_df['species'] = iris.target

# Visualize the distribution of each feature using a boxplot
plt.figure(figsize=(12,6))
sns.boxplot(data=iris_df.drop(columns='species'))
plt.title('Feature Distribution')
plt.show()
```

- **Pairplot** helps identify relationships between features.
- **Boxplots** help visualize the distribution and potential outliers in each feature.

**3. Simple Linear Regression**
We can now build a simple linear regression model. For example, predicting sepal length based on sepal width

```{python}
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

# Selecting only Sepal Length and Sepal Width for simple linear regression
X = iris_df[['sepal width (cm)']]  # Predictor
y = iris_df['sepal length (cm)']    # Response

# Split the data into training and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Train the linear regression model
lin_reg = LinearRegression()
lin_reg.fit(X_train, y_train)

# Predict on the test set
y_pred = lin_reg.predict(X_test)

# Visualize the linear regression fit
plt.scatter(X_test, y_test, color='blue', label='Actual')
plt.plot(X_test, y_pred, color='red', label='Predicted')
plt.title('Simple Linear Regression: Sepal Width vs. Sepal Length')
plt.xlabel('Sepal Width (cm)')
plt.ylabel('Sepal Length (cm)')
plt.legend()
plt.show()
```

Here we’ve modeled **sepal length** based on sepal width, split the data into training and test sets, and plotted the predicted vs actual values.

**4. Correlation Plot**
Next, explore the correlation between features using a heatmap to see how strongly they are related.

```{python}
# Correlation matrix
corr_matrix = iris_df.drop(columns='species').corr()

# Visualize the correlation matrix with a heatmap
plt.figure(figsize=(8,6))
sns.heatmap(corr_matrix, annot=True, cmap='coolwarm', linewidths=0.5)
plt.title('Correlation Matrix of Iris Features')
plt.show()
```

This heatmap will help you understand which features are highly correlated, which can be helpful for model building.

**5. Multiple Linear Regression**
Finally, let’s perform a multiple linear regression using all the features to predict a response variable (e.g., sepal length).

```{python}
# All features (excluding target/species) as predictors
X = iris_df.drop(columns=['species', 'sepal length (cm)'])
y = iris_df['sepal length (cm)']

# Split the data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Train the multiple linear regression model
mlr = LinearRegression()
mlr.fit(X_train, y_train)

# Predict on the test set
y_pred = mlr.predict(X_test)

# Calculate performance metrics (optional)
from sklearn.metrics import mean_squared_error, r2_score
print(f"Mean Squared Error: {mean_squared_error(y_test, y_pred)}")
print(f"R-squared: {r2_score(y_test, y_pred)}")

# Visualize actual vs predicted
plt.scatter(y_test, y_pred)
plt.title('Multiple Linear Regression: Actual vs Predicted Sepal Length')
plt.xlabel('Actual Sepal Length (cm)')
plt.ylabel('Predicted Sepal Length (cm)')
plt.show()

# Print the equation of the multiple linear regression model
intercept = mlr.intercept_
coefficients = mlr.coef_

# Feature names (excluding the response variable and species)
features = iris_df.columns.drop(['species', 'sepal length (cm)'])

# Construct the regression equation as a string
equation = f"Sepal Length = {intercept:.2f}"
for feature, coef in zip(features, coefficients):
    equation += f" + ({coef:.2f} * {feature})"

# Print the regression equation
print("The equation for multiple linear regression:")
print(equation)
```

**Conclusion**
This tutorial has shown how to:
1. Get a statistical summary of the Iris dataset.
2. Visualize relationships between features using pairplots and boxplots.
3. Perform simple linear regression.
4. Generate a correlation heatmap.
5. Conduct multiple linear regression.

These steps give a comprehensive introduction to using scikit-learn along with Pandas, Seaborn, and Matplotlib for exploratory data analysis and modeling.


