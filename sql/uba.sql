select universidades  "university"  , carreras  "career" ,TO_DATE(fechas_de_inscripcion, 'YY-Mon-DD') "inscription_date" , substring(nombres from 1 for (POSITION('-' IN nombres)-1)) "first_name" 
,substring(nombres from (POSITION('-' IN nombres))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(fechas_nacimiento,'yy-mon-dd')))/365 "age"	 , a.codigos_postales "postal_code" ,b.localidad "location"  , emails "email" 
	FROM  uba_kenedy as a
	inner join  localidad AS B
on cast( a.codigos_postales as Integer) = B.codigo_postal	
WHERE 		
	TO_DATE(fechas_de_inscripcion, 'YY-Mon-DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(fechas_de_inscripcion, 'YY-Mon-DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
		AND 
		universidades = 'universidad-de-buenos-aires'