# walmart-sales-analysis-basic

# 🛒 Walmart Sales Data Analysis

This project analyzes Walmart sales data using Python, SQL (MySQL & PostgreSQL), and Jupyter Notebook.  
It covers data acquisition, cleaning, feature engineering, and SQL-based business problem solving.  
The goal is to derive actionable insights into sales performance, customer behavior, and profitability.

---

## 📌 Project Steps

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


### **5. Install Kaggle API

To interact with Kaggle datasets directly from your environment, install the Kaggle API:

```bash
pip install kaggle
