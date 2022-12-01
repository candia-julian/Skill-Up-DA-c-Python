select university  "university"  , career  "career" , TO_DATE(inscription_date, 'YY/MM/DD') "inscription_date" , substring(nombre from 1 for (POSITION(' ' IN nombre))) "first_name" 
,substring(nombre from (POSITION(' ' IN nombre))+1) "last_name" ,sexo "gender",(CURRENT_DATE - (to_date(birth_date,'YYYY/MM/DD')))/365 "age"	 , replace(upper(a.location),'-',' ') "location" ,b.codigo_postal "postal_code"  ,email "email" 
	FROM jujuy_utn as a
	inner join  localidad AS B
on  replace(upper(a.location),'-',' ')  = b.localidad 
WHERE 		
	TO_DATE(inscription_date, 'YY/MM/DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(inscription_date, 'YY/MM/DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
		AND 
		university = 'universidad nacional de jujuy'