	
	select universidad  "university"  , carrerra  "career" ,TO_DATE(fechaiscripccion, 'DD/MM/YYYY') "inscription_date" , substring(nombrre from 1 for (POSITION(' ' IN nombrre)-1)) "first_name" 
,substring(nombrre from (POSITION(' ' IN nombrre))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(nacimiento,'DD/MM/YYYY')))/365 "age" ,a.codgoposstal "postal_code",b.localidad "location"  , eemail "email" 
	FROM moron_nacional_pampa as a
	inner join  localidad AS B
on cast( a.codgoposstal as Integer) = B.codigo_postal
WHERE 		
	TO_DATE(fechaiscripccion, 'DD/MM/YYYY')  >  TO_DATE('2019-jan-01', 'YY-Mon-DD')
	AND 
		TO_DATE(fechaiscripccion, 'DD/MM/YYYY')  <  TO_DATE('2020-aug-01', 'YY-Mon-DD')		
		AND 
		universidad = 'Universidad nacional de la pampa'	
		
		
		
		
		
select universidad  "university"  , carrera  "career" ,TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD') "inscription_date" , substring(nombre from 1 for (POSITION('_' IN nombre)-1)) "first_name" 
,substring(nombre from (POSITION('_' IN nombre))+1) "last_name" ,sexo "gender" , (CURRENT_DATE - (to_date(fecha_nacimiento,'DD-Mon-YY')))/365 "age", replace(upper(a.localidad),'_',' ') "location" ,b.codigo_postal "postal_code"  ,email "email" 
	FROM salvador_villa_maria as a
	inner join  localidad AS B
on  replace(upper(a.localidad),'-',' ')  = b.localidad
WHERE 		
	TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD')  >   TO_DATE('2019-jan-01', 'YY-Mon-DD')
	AND 
		TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD')  < TO_DATE('2020-aug-01', 'YY-Mon-DD')	
		AND 
		universidad = 'UNIVERSIDAD_NACIONAL_DE_VILLA_MARÍA'