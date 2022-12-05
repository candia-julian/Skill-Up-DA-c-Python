select university  "university"  , career  "career" , inscription_date "inscription_date" , nombre  "names" ,sexo "gender",to_date(birth_date,'yyyy-mm-dd') "birth_dates"	 , location  "location"  ,email "email"
	FROM jujuy_utn
WHERE 		
	TO_DATE(inscription_date, 'YY/MM/DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(inscription_date, 'YY/MM/DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
