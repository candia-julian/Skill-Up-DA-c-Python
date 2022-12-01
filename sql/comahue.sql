select universidad  "university"  , carrera  "career" ,TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD') "inscription_date" , substring(name from 1 for (POSITION(' ' IN name))) "first_name" 
,substring(name from (POSITION(' ' IN name))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(fecha_nacimiento,'YYYY-MM-DD')))/365 "age" 		, a.codigo_postal "postal_code",b.localidad "location"  ,correo_electronico "email" 
FROM flores_comahue AS A
inner join  localidad AS B
on cast( A.codigo_postal as Integer) = B.codigo_postal
WHERE 		
	TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD')  >  TO_DATE('2020/09/01', 'YYYY/MM/DD')
	AND 
		TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD')  <  TO_DATE('2021/02/01', 'YYYY/MM/DD')
		AND 
		universidad = 'UNIV. NACIONAL DEL COMAHUE'
		