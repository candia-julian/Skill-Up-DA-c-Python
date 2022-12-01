import os
import pandas as pd
import pathlib
import logging
from airflow import DAG
from datetime import timedelta,  datetime
#
from airflow.operators import task
#postgre operator
from airflow.providers.postgres.operators.postgres import PostgresOperator
#python operator para ejectuar scripts de python
from airflow.operators.python import PythonOperator
#operator para subir archivos a s3
from airflow.providers.amazon.aws.transfers import LocalFilesystemToS3Operator

with DAG(
    'dag universidad latam y jfk',
    description='ETL',
    schedule_interval="@hourly",
    catchup=False,
    default_args={
        "retries": 5, # If a task fails, it will retry 2 times.
    },
    tags=['example'],
    start_date=datetime(2022,11,29)
) as dag:

