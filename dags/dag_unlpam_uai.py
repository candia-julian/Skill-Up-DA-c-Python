import os
import pandas as pd
import pathlib
import logging
from airflow import DAG
from datetime import timedelta,  datetime

#postgre operator
from airflow.providers.postgres.operators.postgres import PostgresOperator
#python operator para ejectuar scripts de python
from airflow.operators.python import PythonOperator
#operator para subir archivos a s3
from airflow.providers.amazon.aws.transfers import LocalFilesystemToS3Operator


with DAG(
    'tutorial_dags',
    description='Este es un tutorial de dags',
    schedule_interval=timedelta(days = 1),
    start_date=datetime(2022,11,29)
) as dag: