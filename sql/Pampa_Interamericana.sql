	select universidad  "university"  , carrerra  "career" ,TO_DATE(fechaiscripccion, 'DD/MM/YYYY') "inscription_date" , substring(nombrre from 1 for (POSITION(' ' IN nombrre)-1)) "first_name" 
,substring(nombrre from (POSITION(' ' IN nombrre))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(nacimiento,'DD/MM/YYYY')))/365 "age" ,a.codgoposstal "postal_code" ,b.localidad "location" , eemail "email" 
	FROM moron_nacional_pampa as A
	inner join  localidad AS B
on cast( A.codgoposstal as Integer) = B.codigo_postal
WHERE 		
	TO_DATE(fechaiscripccion, 'DD/MM/YYYY')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(fechaiscripccion, 'DD/MM/YYYY')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
		AND 
		universidad = 'Universidad nacional de la pampa'	
		

		
		

		
	select univiersities  "university"  , carrera  "career" ,TO_DATE(inscription_dates, 'YY/Mon/DD') "inscription_date" , substring(names from 1 for (POSITION('-' IN names)-1)) "first_name" 
,substring(names from (POSITION('-' IN names))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(fechas_nacimiento,'YY/Mon/DD')))/365 "age" , replace(upper(a.localidad), '-',' ') "location" ,b.codigo_postal "postal_code"  , email "email" 
	FROM rio_cuarto_interamericana as a
	inner join  localidad AS B
on  replace(upper(a.localidad),'-',' ')  = b.localidad
WHERE 		
	TO_DATE(inscription_dates, 'YY/Mon/DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(inscription_dates, 'YY/Mon/DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
		AND 
		univiersities = '-universidad-abierta-interamericana'	