	select universities  "university"  , careers  "career" ,inscription_dates "inscription_date" ,names "names" ,sexo "gender"	,to_date(birth_dates,'dd-mm-yyyy') "birth_dates"	 , locations "location"    , emails "email"
	FROM lat_sociales_cine
WHERE 		
	TO_DATE(inscription_dates, 'DD-MM-YYYY')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(inscription_dates, 'DD-MM-YYYY')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
