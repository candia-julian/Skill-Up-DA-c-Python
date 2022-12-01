import pandas as pd
import psycopg2
import sqlalchemy
import json
import datetime as dt
from credentials import *

def extract(sql:str)->pd.DataFrame:
    
    engine = psycopg2.connect(
    database=database,
    user=user,
    password=password,
    host=host,
    port=port
    )
    query = open('cine2.sql', 'r')

    data = pd.read_sql(query.read(),con=engine)
    return data

def transform_cine(data:pd.DataFrame) -> None:
    """esta función transforma la tabla extraida como dataframe de la universidad del cine

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        None: no retorna nada, crea el archivo .csv listo para cargar a s3
    """
    for col in data.columns:  #convertimos todo a minusculas
        if data[col].dtype == 'object':
            data[col] = data[col].str.lower()

    data.universities = (data.universities
                                .str.lstrip('-') #sacamos guiones al inicio
                                .str.rstrip('-')  #
                                .str.replace('-', ' '))

    data = data.query('universities == "universidad del cine"')

    data.careers = (data.careers
                                .str.lstrip('-') #sacamos guiones al inicio
                                .str.rstrip('-')  #sacamos guiones al final
                                .str.replace('-', ' ') #reemplazamos los guiones internos por espacios para separar palabras
                                )

    data.names = (data.names
                    .str.split('-') #separo por -
                    .apply(lambda x:" ".join(x)) #uno la lista con espacios
                    .str.split('\.', n=1) #separo todas aquellas ocurrencias que contengan . como dr., ms., etc
                    .apply(lambda x:x[1] if len(x) >= 2 else x) #me quedo con el segundo elemento si la lista tiene un largo mayor a 2
                    .apply(lambda x:"".join(x) if type(x) == list else x) #convierto a string los elementos de tipo lista
                    .str.strip()
                    )

    data.locations = (data.locations
                        .str.replace('-',' ')
                        .str.strip())

    nom_apell = (data.names
                    .str.rsplit(expand=True,n=1)
                    .rename(columns={0:'nombre',1:'apellido'}))

    data = (pd.concat([data , nom_apell], axis=1)
                            .drop('names', axis=1)
                            )

    data.birth_dates = pd.to_datetime(data.birth_dates,
                                    infer_datetime_format=True
                                    )
    age = data.birth_dates.apply(lambda x: dt.date.today().year - x.year - ((dt.date.today().month, dt.date.today().day) < (x.month, x.day)))

    data['edad'] = age
    data.drop('birth_dates', axis=1, inplace=True)
    data.to_csv('cine.csv')

def transform_jfk(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed

def transform_uflo(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed


def transform_umor(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed

def transform_usal(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed


def transform_up(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed

def transform_unj(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed

def transform_unj(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed

def transform_unco(data:pd.DataFrame) -> pd.DataFrame:
    """esta función transforma la tabla extraida como dataframe de la universidad abierta latam

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        pd.DataFrame: retorna el df transformado listo para cargar
    """
    df_transformed = None
    return df_transformed