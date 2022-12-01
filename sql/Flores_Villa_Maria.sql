select universidad  "university"  , carrera  "career" ,TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD') "inscription_date" , substring(name from 1 for (POSITION(' ' IN name))) "first_name" 
,substring(name from (POSITION(' ' IN name))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(fecha_nacimiento,'YYYY-MM-DD')))/365 "age"  , a.codigo_postal "postal_code",b.localidad "location"  ,correo_electronico "email" 
FROM flores_comahue AS A
inner join  localidad AS B
on cast( A.codigo_postal as Integer) = B.codigo_postal
WHERE 		
	TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD')  >  TO_DATE('2020/09/01', 'YYYY/MM/DD')
	AND 
		TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD')  <  TO_DATE('2021/02/01', 'YYYY/MM/DD')
		AND 
		universidad = 'UNIVERSIDAD DE FLORES'


		
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
		