# walmart-sales-analysis-basic

#  Walmart Sales Data Analysis

This project analyzes Walmart sales data using Python, SQL (MySQL & PostgreSQL), and Jupyter Notebook.  
It covers data acquisition, cleaning, feature engineering, and SQL-based business problem solving.  
The goal is to derive actionable insights into sales performance, customer behavior, and profitability.

---

##  Project Steps

### **1. Set Up the Environment**
- **Tools Used:** Visual Studio Code (VS Code), Python, SQL (MySQL & PostgreSQL)
- **Goal:** Create a structured workspace in VS Code and organize project folders for smooth development and data handling.

---

### **2. Set Up Kaggle API**
- **API Setup:** Obtain your Kaggle API token from your Kaggle profile settings (download JSON file).
- **Configuration:**
  - Place `kaggle.json` in your local `.kaggle` folder.
  - Use:
    ```bash
    kaggle datasets download -d <dataset-path>
    ```
    to pull datasets directly into your project.

---
**3. Download Walmart Sales Data using Kaggle API**
- **Data Source:** Kaggle’s Walmart Sales Dataset.
- **Dataset Link:** [Walmart Sales Dataset](https://www.kaggle.com/)
- **Method:** Used Kaggle API to download the dataset directly into the `data/` folder.
- **Command:**
  ```bash
  kaggle datasets download -d <dataset-path> -p data/ --unzip
---

### **4. Install Required Libraries and Load Data**
- **Install:**
  ```bash
  pip install pandas numpy sqlalchemy mysql-connector-python psycopg2


### 5. Install Kaggle API

To interact with Kaggle datasets directly from your environment, install the Kaggle API:

```bash
pip install kaggle
```

### 6. Configure Kaggle API Credentials
Go to your Kaggle account settings: https://www.kaggle.com/account

Scroll to the API section and click Create New API Token.

This will download a file named kaggle.json.

Place kaggle.json in the following location:
```bash
Windows: C:\Users\<YourUsername>\.kaggle\
```
### 7. Download Dataset from Kaggle
Use the Kaggle API command to download a dataset.
```bash
!kaggle datasets download -d najir0123/walmart-10k-sales-datasets
```
### 6. Data Cleaning
Remove Duplicates: Identify and remove duplicate entries to avoid skewed results.
Handle Missing Values: Drop rows or columns with missing values if they are insignificant; fill values where essential.
Fix Data Types: Ensure all columns have consistent data types (e.g., dates as datetime, prices as float).
Currency Formatting: Use .replace() to handle and format currency values for analysis.
Validation: Check for any remaining inconsistencies and verify the cleaned data.

### 7. Feature Engineering
Create New Columns: Calculate the Total Amount for each transaction by multiplying unit_price by quantity and adding this as a new column.
Enhance Dataset: Adding this calculated field will streamline further SQL analysis and aggregation tasks.

### 8. Load Data into MySQL and PostgreSQL
Set Up Connections: Connect to MySQL and PostgreSQL using sqlalchemy and load the cleaned data into each database.
Table Creation: Set up tables in both MySQL and PostgreSQL using Python SQLAlchemy to automate table creation and data insertion.
Verification: Run initial SQL queries to confirm that the data has been loaded accurately.

### 9. SQL Analysis: Complex Queries and Business Problem Solving
Business Problem-Solving: Write and execute complex SQL queries to answer critical business questions, such as:
1. TOP 5 Performing Branch by Total Sales
2.  Lowest Performing Branch by Average Profit Margin
3.  City Sales Leader
4.  Category Trend Analysis — total sales / month, 3-month moving avg, trend last 6 months
5.  High-Value Transaction Detection (top 5% by sales amount) and compare avg profit margin

License
This project is licensed under the MIT License.

Acknowledgments
Data Source: Kaggle’s Walmart Sales Dataset
Inspiration: Walmart’s business case studies on sales and supply chain optimization.

