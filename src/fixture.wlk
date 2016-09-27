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
		return new Persona(6000, [], null , 0, [habitacion, cocina], 2) 
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
}




