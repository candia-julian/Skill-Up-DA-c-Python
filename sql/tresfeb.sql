select universidad  "university"  , careers  "career" ,fecha_de_inscripcion "inscription_date" , names "names" ,sexo "gender",to_date(birth_dates,'dd/Mon/yy')	"birth_dates" , codigo_postal "postal_code",correos_electronicos "email"
	FROM palermo_tres_de_febrero
	WHERE
	TO_DATE(fecha_de_inscripcion, 'YY/Mon/DD')  >  TO_DATE('2020-Sep-01', 'YY-Mon-DD')
	AND
		TO_DATE(fecha_de_inscripcion, 'YY/Mon/DD')  <  TO_DATE('2021-Feb-01',   'YY-Mon-DD')
