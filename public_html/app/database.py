# -*- coding: utf-8 -*-

import os
import sys, traceback, time
import datetime

from sqlalchemy import create_engine

# configurar el motor de sqlalchemy
db_engine = create_engine("postgresql://alumnodb:alumnodb@localhost/si1", echo=False, execution_options={"autocommit":False})

def dbConnect():
    return db_engine.connect()

def dbCloseConnect(db_conn):
    db_conn.close()

def getListaCliMes(db_conn, mes, anio, iumbral, iintervalo, use_prepare, break0, niter):

    # Implementar la consulta; asignar nombre 'cc' al contador resultante
    f_inicio = "'%s-%s-%s'" % (anio, mes, '01')
    if mes == str(12):
        anio = str(int(anio)+1)
        f_final = "'%s-%s-%s'" % (anio, '01', '01')
    else:
        mes_fin = str(int(mes)+1)
        f_final = "'%s-%s-%s'" % (anio, mes_fin, '01')

    res = {}

    # Ejecutar la consulta 
    # - mediante PREPARE, EXECUTE, DEALLOCATE si use_prepare es True
    # - mediante db_conn.execute() si es False
    if use_prepare == True:
        prepare = """ PREPARE ClientesDistintosPlan (numeric) AS
                        SELECT COUNT(DISTINCT C.customerid) as NumClientes
                        FROM 
                            customers C
                            JOIN orders o ON C.customerid = o.customerid
                        WHERE
                            orderdate < {}
                            AND orderdate >= {}
                            AND totalamount > $1;""".format(f_final, f_inicio)
        db_conn.execute(prepare)

    # Array con resultados de la consulta para cada umbral
    dbr=[]

    for ii in range(niter):
        if use_prepare == True:
            res['cc'] = db_conn.execute("EXECUTE ClientesDistintosPlan ({})".format(iumbral)).first()[0]
        else:
            consulta = """SELECT COUNT(DISTINCT C.customerid) as NumClientes
                        FROM 
                            customers C
                            JOIN orders o ON C.customerid = o.customerid
                        WHERE
                            orderdate < {}
                            AND orderdate >= {}
                            AND totalamount > {};""".format(f_final, f_inicio, iumbral)
            res['cc'] = db_conn.execute(consulta).first()[0]

        # Guardar resultado de la query
        dbr.append({"umbral":iumbral,"contador":res['cc']})

        # Si break0 es True, salir si contador resultante es cero
        if break0 and res['cc'] == 0:
            break
        
        # Actualizacion de umbral
        iumbral = iumbral + iintervalo

    if use_prepare == True:
        db_conn.execute("DEALLOCATE ClientesDistintosPlan")
                
    return dbr

def getMovies(anio):
    # conexion a la base de datos
    db_conn = db_engine.connect()

    query="select movietitle from imdb_movies where year = '" + anio + "'"
    resultproxy=db_conn.execute(query)

    a = []
    for rowproxy in resultproxy:
        d={}
        # rowproxy.items() returns an array like [(key0, value0), (key1, value1)]
        for tup in rowproxy.items():
            # build up the dictionary
            d[tup[0]] = tup[1]
        a.append(d)
        
    resultproxy.close()  
    
    db_conn.close()  
    
    return a
    
def getCustomer(username, password):
    # conexion a la base de datos
    db_conn = db_engine.connect()

    query="select * from customers where username='" + username + "' and password='" + password + "'"
    res=db_conn.execute(query).first()
    
    db_conn.close()  

    if res is None:
        return None
    else:
        return {'firstname': res['firstname'], 'lastname': res['lastname']}
    
def delCustomer(customerid, bFallo, bSQL, duerme, bCommit):
    
    # Array de trazas a mostrar en la página
    dbr=[]

    # TODO: Ejecutar consultas de borrado
    # - ordenar consultas según se desee provocar un error (bFallo True) o no
    # - ejecutar commit intermedio si bCommit es True
    # - usar sentencias SQL ('BEGIN', 'COMMIT', ...) si bSQL es True
    # - suspender la ejecución 'duerme' segundos en el punto adecuado para forzar deadlock
    # - ir guardando trazas mediante dbr.append()
    
    try:
        pass
        # TODO: ejecutar consultas

    except Exception as e:
        pass
        # TODO: deshacer en caso de error

    else:
        pass
        # TODO: confirmar cambios si todo va bien

        
    return dbr

