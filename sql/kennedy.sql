select universidades  "university"  , carreras  "career" ,fechas_de_inscripcion "inscription_date" , nombres "names" ,sexo "gender",to_date(fechas_nacimiento,'yy-mon-dd') "birth_dates"	 ,codigos_postales "postal_code"  , emails "email"
	FROM  uba_kenedy as a

WHERE
	TO_DATE(fechas_de_inscripcion, 'YY-Mon-DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND
		TO_DATE(fechas_de_inscripcion, 'YY-Mon-DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
