import tp.*
object fixture {
	
	method eduardo(){
		return new ContratistaCondicional(100,2.0,casa.esComplicada())
	}		
	
	method marcos(){
		return new ContratistaCondicional(50000,1.2,casa.esComplicada())
	}
	
	method roger(){
		return new ContratistaCondicional(100,1.1,casa.tieneMasDeDosPisos())
	}
	
	method emanuel(){
		return new Arquitecto(100000)
	}

	method lito(){
		return new Albanil(16)
	}

	method aldo(){
		return new Persona(6000, [], null , 0, 2, [21, 20]) 
	}
	
	method noelia(){
		return new ContratistaCondicional(250, 2.0, casa.esComplicada())
	}
	
	method silvina(){
		return new ContratistaCondicional(100, 1.25,casa.tieneMasDeDosPisos())
	}
	
	method eliana(){
		return new ContratistaCondicional(12000, 1.2, casa.esComplicada())
	}
	
	method dodain(){
		return new Albanil(24)
	}
	
	method agencia(){
		return new Agencia([self.lito(),self.emanuel(),self.eduardo(),self.roger(),self.marcos(),raul,carlos,venancio])
	}
	
	method agenciaNueva(){
		return new Agencia([self.noelia(), self.silvina(), self.eliana(), self.dodain()])
	}
	
	method milena(){
		return new Persona(2000, [], null , 0, 3, [36, 12])
	}
	
	method damian(){
		return new PersonaDescuidadaPisos(250000, [], null , 0, 4, [36, 12, 18, 24])
	}
}




