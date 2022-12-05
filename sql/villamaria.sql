	select universidad  "university"  , carrera  "career" ,fecha_de_inscripcion "inscription_date" ,nombre "names" ,sexo "gender", to_date(fecha_nacimiento,'dd-mon-yy') "birth_dates" 		 ,localidad "location"  ,email "email"
	FROM salvador_villa_maria
WHERE 		
	TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND 
		TO_DATE(fecha_de_inscripcion, 'YY-Mon-DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
