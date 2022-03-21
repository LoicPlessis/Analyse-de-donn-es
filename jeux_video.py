import pandas as pd
import numpy as np
import mysql.connector as mysqlpyth

df = pd.read_csv('vgsales.csv')
df=df.drop(['NA_Sales','EU_Sales','JP_Sales','Other_Sales'], axis=1)
print(df.head(5))
#df.to_csv('ventes_jeux.csv')



class Connexion :
    
    __USER = 'root'
    __PWD = 'root'
    __HOST = 'localhost'
    __PORT = '8081'
    __DB = 'jeuxvideo'
    __cursor = None

    @classmethod
    def ouvrir_connexion(cls) :
        if cls.__cursor == None :
            cls.__bdd = mysqlpyth.connect(user = cls.__USER, password = cls.__PWD, host = cls.__HOST, port = cls.__PORT, database = cls.__DB, allow_local_infile = True)
            cls.__cursor = cls.__bdd.cursor()
    
    @classmethod
    def charger_bdd(cls):
        query1 =  "LOAD DATA LOCAL INFILE './Jeux.csv' INTO TABLE jeux FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\n' IGNORE 1 ROWS;"
        query2 = "LOAD DATA LOCAL INFILE './Genre.csv' INTO TABLE genre FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\n' IGNORE 1 ROWS;"
        query3 ="LOAD DATA LOCAL INFILE './Editeur.csv' INTO TABLE editeur FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\n' IGNORE 1 ROWS;"
        query4 = "LOAD DATA LOCAL INFILE 'Console.csv' INTO TABLE console FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\\n' IGNORE 1 ROWS;"
        cls.__cursor.execute(query1)
        cls.__cursor.execute(query2)
        cls.__cursor.execute(query3)
        cls.__cursor.execute(query4)
        cls.__bdd.commit()

    @classmethod
    def fermer_connexion(cls):
        cls.__cursor.close()
        cls.__bdd.close()
        cls.__cursor = None

tab_1=df[['Name','Year','Global_Sales']]
df_publish=df['Publisher'].unique()
df_publish=pd.DataFrame(df_publish)
tab_2=df_publish
df_plat=df['Platform'].unique()
df_plat=pd.DataFrame(df_plat)
tab_3=df_plat
df_genre=df['Genre'].unique()
df_genre=pd.DataFrame(df_genre)
tab_4=df_genre

tab_1.index += 1
tab_2.index += 1
tab_3.index += 1
tab_4.index += 1

tab_1.to_csv('Jeux.csv')
tab_2.to_csv('Editeur.csv')
tab_3.to_csv('Console.csv')
tab_4.to_csv('Genre.csv')

Connexion.ouvrir_connexion()
Connexion.charger_bdd()
Connexion.fermer_connexion()
