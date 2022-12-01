		
select universidad  "university"  , carrera  "career" ,TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD') "inscription_date" , substring(nombre from 1 for (POSITION('_' IN nombre)-1)) "first_name" 
,substring(nombre from (POSITION('_' IN nombre))+1) "last_name" ,sexo "gender", (CURRENT_DATE - (to_date(fecha_nacimiento,'DD-Mon-YY')))/365 "age" 		 ,replace(upper(a.localidad),'_',' ') "location" ,b.codigo_postal "postal_code" ,email "email" 
	FROM salvador_villa_maria as a 
inner join  localidad AS B
on  A.localidad = b.localidad 
WHERE 		
	TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
		AND 
		universidad = 'UNIVERSIDAD_NACIONAL_DE_VILLA_MARÍA'