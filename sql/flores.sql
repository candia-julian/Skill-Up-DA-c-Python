select universidad  "university"  , carrera  "career" ,fecha_de_inscripcion "inscription_date" , name "names" ,sexo "gender",to_date(fecha_nacimiento,'yyyy-mm-dd') "birth_dates",codigo_postal "postal_code" ,correo_electronico "email"
FROM flores_comahue
WHERE
	TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD')  >  TO_DATE('2020/09/01', 'YYYY/MM/DD')
	AND
		TO_DATE(fecha_de_inscripcion, 'YYYY/MM/DD')  <  TO_DATE('2021/02/01', 'YYYY/MM/DD')


