-- Simple example script to use snowpark and python to calculate the average of every numeric column in arbor_bi_connector_production

import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import avg, col
import pandas as pd

def main(session: snowpark.Session):
    database = 'ARBOR_BI_CONNECTOR_PRODUCTION'
    schema = 'ARBOR_MIS_ENGLAND_MODELLED'

    # Retrieve the list of tables from the database
    tables = session.sql(f"SELECT table_name FROM {database}.information_schema.tables WHERE TABLE_SCHEMA = '{schema}' ORDER BY TABLE_NAME").collect()
    tables_list, columns_list, avgs_list = [], [], []
    data = []
    queries_list = []
    for table in tables[0:20]:
        table_name = table['TABLE_NAME']
        
        # Retrieve the list of columns for the current table
        columns = session.sql(f"SELECT column_name FROM {database}.information_schema.columns WHERE TABLE_SCHEMA = '{schema}' AND TABLE_NAME = '{table_name}' AND DATA_TYPE IN ('NUMBER', 'FLOAT', 'DECIMAL') ORDER BY COLUMN_NAME").collect()

        for column in columns:
            column_name = column['COLUMN_NAME']
            tables_list.append(table_name)
            columns_list.append(column_name)

            # Create and execute a query to calculate average
            full_table_name = f"{database}.{schema}.{table_name}"
            
            try:
                try:
                    avg_query = f"SELECT AVG(CAST({column_name} AS FLOAT)) AS average_value FROM {full_table_name}"
                    query_result = session.sql(avg_query).collect()
                except:
                    avg_query = f"SELECT AVG(CAST({column_name} AS FLOAT)) AS average_value FROM {full_table_name}"
                    query_result = session.sql(avg_query).collect()
                try:
                    avg_value = query_result[0]['average_value']
                except:
                    avg_value = -1
                queries_list.append(avg_query)
                avgs_list.append(avg_query)
                data.append((table_name, column_name, query_result[0][0]))
            except:
                data.append((table_name, column_name, -1))

    dataframe = session.create_dataframe(data, schema=['Table', 'Column', 'Avg'])

    return dataframe

            
