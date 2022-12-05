		select universidad  "university"  , carrerra  "career" ,fechaiscripccion "inscription_date" , nombrre "names" ,sexo "gender",to_date(nacimiento,'dd-mm-yyyy')"birth_dates" ,codgoposstal "postal_code"  , eemail "email"
	FROM moron_nacional_pampa
WHERE
	TO_DATE(fechaiscripccion, 'DD/MM/YYYY')  >  TO_DATE('2019-jan-01', 'YY-Mon-DD')
	AND
		TO_DATE(fechaiscripccion, 'DD/MM/YYYY')  <  TO_DATE('2020-aug-01', 'YY-Mon-DD')

