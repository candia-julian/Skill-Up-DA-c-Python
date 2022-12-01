		select university  "university"  , career  "career" , TO_DATE(inscription_date, 'YY/MM/DD') "inscription_date" , substring(nombre from 1 for (POSITION(' ' IN nombre))) "first_name" 
,substring(nombre from (POSITION(' ' IN nombre))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(birth_date,'YYYY/MM/DD')))/365 "age"	 , replace(upper(a.location),'_',' ') "location" ,b.codigo_postal "postal_code"  ,email "email" 
	FROM jujuy_utn as a
	inner join  localidad AS B
on  replace(upper(a.location),'-',' ')  = b.localidad
WHERE 		
	TO_DATE(inscription_date, 'YY/MM/DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(inscription_date, 'YY/MM/DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
		AND 
		university = 'universidad tecnológica nacional'		
		

		
		
	select universidad  "university"  , careers  "career" ,TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD') "inscription_date" , substring(names from 1 for (POSITION('_' IN names)-1)) "first_name" 
,substring(names from (POSITION('_' IN names))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(birth_dates,'DD/Mon/YY')))/365 "age"		 ,a.codigo_postal "postal_code" ,b.localidad "location"  ,correos_electronicos "email" 
	FROM palermo_tres_de_febrero as A 
	inner join  localidad AS B
on cast( A.codigo_postal as Integer) = B.codigo_postal
WHERE 		
	TO_DATE(fecha_de_inscripcion, 'YY/Mon/DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(fecha_de_inscripcion, 'YY/Mon/DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
		AND 
		universidad = 'universidad_nacional_de_tres_de_febrero'	

        