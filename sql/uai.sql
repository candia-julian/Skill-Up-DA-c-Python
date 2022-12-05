	select univiersities  "university"  , carrera  "career" ,inscription_dates "inscription_date" , names "names" ,sexo "gender", to_date(fechas_nacimiento,'yy-mon-dd') "birth_dates"	 , localidad "location"  , email "email"
	FROM rio_cuarto_interamericana

WHERE
	TO_DATE(inscription_dates, 'YY/Mon/DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND
		TO_DATE(inscription_dates, 'YY/Mon/DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
