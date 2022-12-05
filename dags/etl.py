import pandas as pd
import psycopg2
import datetime as dt
from sqlalchemy import create_engine


import os
from dotenv import load_dotenv

load_dotenv(os.path.join('config', 'conf', '.env'))


def extract(sql_first: str, university_select_first: str,sql_second, university_select_second: str) -> str:
    url_object = {
         'port':"",
        'database':"",
        'user':"",
        'password':"",
        'host':""}
    engine = create_engine('postgresql+psycopg2://{}:{}@{}:{}/{}'.format(url_object['user'],url_object['password'],url_object['host'],url_object['port'],url_object['database']))
    connection = engine.connect()
    query_first = open(sql_first, 'r')
    data_first = pd.read_sql(query_first.read(), con=connection ) #Leo consulta de la primer universidad a la base de datos.
    data_first = data_first.query('university == "{}"'.format(university_select_first)) #Creo la query con la universidad primera

    query_second = open(sql_second, 'r')
    data_second = pd.read_sql(query_second.read(), con=connection) #Leo consulta de la segunda universidad a la base de datos.
    data_second = data_second.query('university == "{}"'.format(university_select_second)) #Creo la query con la universidad segunda

    data_first = pd.concat([data_first, data_second], axis=0)

    nombre_csv = '{}'.format(sql_first.split("/")[2].split(".")[0] +'_' + sql_second.split("/")[2].split(".")[0])  #transformo el nombre del parametro SQL para luego usarlo como nombre de guardado
    data_first.to_csv("../files/{}.csv".format(nombre_csv))  # almaceno el CSV de la base de datos primaria
    connection.close() #Desconecto la base de datos
    return nombre_csv


#nombre_csv = extract('../sql/villamaria.sql','UNIVERSIDAD_NACIONAL_DE_VILLA_MARÍA','../sql/flores.sql','UNIVERSIDAD DE FLORES')
#nombre_csv = extract('../sql/comahue.sql','UNIV. NACIONAL DEL COMAHUE','../sql/salvador.sql','UNIVERSIDAD_DEL_SALVADOR')
#nombre_csv = extract('../sql/utn.sql','universidad tecnológica nacional','../sql/tresfeb.sql','universidad_nacional_de_tres_de_febrero')

#nombre_csv = extract('../sql/jujuy.sql','universidad nacional de jujuy','../sql/palermo.sql','_universidad_de_palermo')

#nombre_csv = extract('../sql/lapampa.sql','Universidad nacional de la pampa','../sql/uai.sql','-universidad-abierta-interamericana')
#nombre_csv = extract('../sql/moron.sql','Universidad de morón','../sql/riocuarto.sql','Universidad-nacional-de-río-cuarto')
#nombre_csv = extract('../sql/kennedy.sql','universidad-j.-f.-kennedy','../sql/sociales.sql','-FACULTAD-LATINOAMERICANA-DE-CIENCIAS-SOCIALES')
#nombre_csv = extract('../sql/cine.sql','UNIVERSIDAD-DEL-CINE','../sql/uba.sql','universidad-de-buenos-aires')
#nombre_csv = extract('../sql/jujuy.sql','universidad nacional de jujuy','../sql/moron.sql', 'Universidad de morón')
#nombre_csv = extract('../sql/lapampa.sql', 'Universidad nacional de la pampa','../sql/villamaria.sql','UNIVERSIDAD_NACIONAL_DE_VILLA_MARÍA')


def transform(database_path_csv:str) -> pd.DataFrame:
    universitys_query={
        'cine': 'universidad del cine',
        'uba':'universidad de buenos aires',
        'comahue':'univ. nacional del comahue',
        'salvador':'universidad del salvador',
        'jujuy':'universidad nacional de jujuy',
        'moron':'universidad de morón',
        'palermo':' universidad de palermo',
        'kennedy':'universidad j. f. kennedy',
        'sociales':' facultad latinoamericana de ciencias sociales',
        'lapampa':'universidad nacional de la pampa',
        'uai':' universidad abierta interamericana',
        'villamaria':'universidad nacional de villa maría',
        'riocuarto':'universidad nacional de río cuarto',
        'utn':'universidad tecnológica nacional',
        'tresfeb':'universidad nacional de tres de febrero',
        'flores':'universidad de flores',


    }

    DataLocationPostal_Code = open('../assets/codigos_postales.csv', 'r')  #abrir csv codigos postales y guardarlos
    data_path=open('../files/{}'.format(database_path_csv), encoding="utf8")


    data=pd.read_csv(data_path)
    dataLocation = pd.read_csv(DataLocationPostal_Code)    # leer y guardar en DataFrame los codigos postales y guardarlos en dataframe
    dataLocation = dataLocation.rename(columns={'localidad': 'location',
                                                'codigo_postal': 'postal_code'})  # Transformo los nombres de la columnas del cdv de codigos_postales
    dataLocation['location'] = dataLocation[
        'location'].str.lower()  # Transformo los valores de localidad de codigos postales
    """esta función transforma la tabla extraida como dataframe de la universidad del cine

    Args:
        data (pd.DataFrame): dataframe extraido

    Returns:
        None: no retorna nada, crea el archivo .csv listo para cargar a s3
    """

    for col in data.columns:  # convertimos todo a minusculas
        if data[col].dtype == 'object':
            data[col] = (data[col].str.lower()
                         .str.replace('-', ' ')  # reemplazamos los guiones internos por espacios para separar palabras
                         .str.replace('_', ' ')  # reemplazamos los guiones internos por espacios para separar palabras
                         .str.lstrip('-')  # sacamos guiones al inicio
                         .str.rstrip('-'))  # sacamos guiones al final

    data.names = (data.names
                  .str.split('-')  # separo por -
                  .apply(lambda x: " ".join(x))  # uno la lista con espacios
                  .str.split('\.', n=1)  # separo todas aquellas ocurrencias que contengan . como dr., ms., etc
                  .apply(
        lambda x: x[1] if len(x) >= 2 else x)  # me quedo con el segundo elemento si la lista tiene un largo mayor a 2
                  .apply(
        lambda x: "".join(x) if type(x) == list else x)  # convierto a string los elementos de tipo lista
                  .str.strip()
                  )
    data.gender = data.loc[:, ['gender']].replace('m', 'male').replace('f', 'female')

    nom_apell = (data.names
                 .str.rsplit(expand=True, n=1)
                 .rename(columns={0: 'first_name', 1: 'last_name'}))

    data = (pd.concat([data, nom_apell], axis=1)
            .drop('names', axis=1)
            )




    first_university=database_path_csv.split("/")[2].split(".")[0].split('_')[0]


    second_university=database_path_csv.split("/")[2].split(".")[0].split('_')[1]



    df_first_university=data.query('university == "{}"'.format(universitys_query[first_university]) )
    df_second_university=data.query('university == "{}"'.format(universitys_query[second_university]) )
    df_first_university = df_first_university.dropna(axis = 1, how = 'all')
    print(df_first_university.columns,df_second_university.columns)

    df_second_university= df_second_university.dropna(axis = 1, how = 'all')
    print(df_first_university.columns,df_second_university.columns)
    print(universitys_query[second_university])
    for data in [df_first_university,df_second_university]:
        data.birth_dates = pd.to_datetime(data.birth_dates , infer_datetime_format=True)
        age = data.birth_dates.apply(
        lambda x: dt.date.today().year - x.year - ((dt.date.today().month, dt.date.today().day) < (x.month, x.day)))
        data['age'] = age
        data.drop('birth_dates', axis=1, inplace=True)


    if 'location' in df_first_university.columns:  # Agrego las columnas postal_code o location

        df_first_university = df_first_university.merge(dataLocation, how='inner', on='location')
    else:
        df_first_university['postal_code'] = df_first_university['postal_code'].astype(int).replace('.0','')
        df_first_university = df_first_university.merge(dataLocation, how='inner', on='postal_code')





    if 'location' in df_second_university.columns:  # Agrego las columnas postal_code o location

        df_second_university = df_second_university.merge(dataLocation, how='inner', on='location')
    else:
        df_second_university['postal_code'] = df_second_university['postal_code'].astype(int).replace('.0','')
        df_second_university = df_second_university.merge(dataLocation, how='inner', on='postal_code')





    #guardar el txt file:

    df_first_university.to_csv(r'..\data\{}.txt'.format(first_university), header=None, index=None, sep=' ', mode='a')
    df_second_university.to_csv(r'..\data\{}.txt'.format(second_university), header=None, index=None, sep=' ', mode='a')
    return df_first_university, df_second_university


df_first_university, df_second_university = transform('../files/villamaria_flores.csv')
