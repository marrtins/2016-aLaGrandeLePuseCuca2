object aldo {
	var ahorros = 6000
	method superficieAPintar(){
		return  cocina.superficie() +habitacion.superficie()
		
	}
	method presupuesto() {
		return ahorros *0.2
	}
	method puedeContratarA(persona){
		return self.presupuesto() > persona.pintarTotal(self.superficieAPintar())
	}
	
}

object pintura {
	
	method precioTotalPintura(tipo,metrosCuadrados){
		return tipo.precioPintura(metrosCuadrados)
	}
	
	
}

object balde {
	var latasPorMetros = 1
	var precioCada50 = 200
	method precioPintura(metrosCuadrados){
		latasPorMetros = metrosCuadrados /50
		return precioCada50 * rounder.roundUp(latasPorMetros)
	}
}
object granel {
	var costoPorLitro = 3.50
	method precioPintura(metrosCuadrados){
		return costoPorLitro * metrosCuadrados
	}
}

object raul {
	var cobrar = 0
	var tipo = balde
	method manoDeObra(metrosCuadrados){
		return 25*metrosCuadrados
	}
	method pintarTotal(metrosCuadrados) {
		cobrar=  self.manoDeObra(metrosCuadrados) + pintura.precioTotalPintura(tipo,metrosCuadrados) 
		return cobrar 
	}
	

	
}

object carlos {
	var cobrar = 0
	method pintarTotal(metros){
		if(metros <= 20){cobrar = 500}
		else{cobrar = 500 + (metros - 20)*30}
	return cobrar
	}
	
	
}

object venancio {
	var cobrar = 0
	var tipo = balde
	method manoDeObra(metrosCuadrados){
		return 200 * rounder.roundUp(metrosCuadrados)
	}
	method pintarTotal(metrosCuadrados){
		cobrar =  self.manoDeObra(metrosCuadrados)+ pintura.precioTotalPintura(tipo,metrosCuadrados)
	return cobrar
	}	
}

object cocina{
	var largo = 2
	var ancho = 1
	var alto = 3.5
	method superficie(){
		return (ancho + largo)* 2* alto
	}
}
object habitacion {
	var metrosTotales = 20
	method superficie(){
		return metrosTotales
	}
}
object rounder {
	method roundUp(nro){
		return -(nro.div(-1)) 
		// Sí, es feo, por eso queda escondido
	}
}