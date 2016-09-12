object aldo {
	var ahorros = 6000
	method ahorrarMas(masAhorro){
		ahorros += masAhorro
	}
	method superficieAPintar(){
		return  cocina.superficie() +habitacion.superficie()
		
	}
	method presupuesto() {
		return ahorros *0.2
	}
	method puedeContratarA(persona){
		return self.presupuesto() > persona.costoTotal(self.superficieAPintar()) 
	}
	
}



object balde {
	var precioCada50 = 200
	method nuevoPrecio(nuevoPrecio){
		precioCada50 = nuevoPrecio
	}
	method latasNecesarias(metros){
		return rounder.roundUp(metros * 0.02)
	}
	
	method precioPintura(metros){
		return  self.latasNecesarias(metros) * precioCada50 
	}
	
}
object granel {
	var costoPorLitro = 3.50
	method precioPintura(metros){
		return costoPorLitro * metros
	}
}

object raul {
	var tipo = balde
	method costoManoDeObra(metros){
		return 25 * metros
	}
	method costoTotal(metros) { 
		return  self.costoManoDeObra(metros) + tipo.precioPintura(metros) 
	}
}

object carlos {
		
	method costoTotal(metros){
		return (500).max(500+(metros - 20)*30)
	}
		
}

object metrosCuadrados {
	var metros = 0
	method metrosCTest(m){
		metros = m
	}
	method metrosC(){
		return metros
	}
}

object venancio {
	
	var tipo = balde
	method cambioDeTipo(_tipo){
		tipo=_tipo
	}
	method costoManoDeObra(metros){
		return 220 * (rounder.roundUp(metros / 10.0 ))
	}
	method costoTotal(metros){
		return  self.costoManoDeObra(metros)+ tipo.precioPintura(metros)
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
		// S�, es feo, por eso queda escondido
	}
}
//asd


