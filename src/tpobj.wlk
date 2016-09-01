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
		return self.presupuesto() > persona.pintarTotal() //persona.costoTotal(self.superficieAPintar())
	}
	
}

object pintura { // pasamanos, innecesario.
	
	method precioTotalPintura(tipo){
		return tipo.precioPintura()
	}
}

object balde {
	var precioCada50 = 200
	method nuevoPrecio(nuevoPrecio){
		precioCada50 = nuevoPrecio
	}
	method latasNecesarias(){
		return rounder.roundUp(metrosCuadrados.metrosC() * 0.02)
	}
	//method latasNecesarias(metros){
	//	return rounder.roundUp(metros * 0.02)
	//}
	method precioPintura(){
		return  self.latasNecesarias() * precioCada50 
	}
	
}
object granel {
	var costoPorLitro = 3.50
	method precioPintura(){
		return costoPorLitro * metrosCuadrados.metrosC()
	}
}

object raul {
	var cobrar = 0
	var tipo = balde
	//method costoManoDeObra(metros){
	//	return 25 * metros
	//}
	method manoDeObra(){
		return metrosCuadrados.metrosC() * 25
	}
	
	method pintarTotal() { //cambiar
		cobrar=  self.manoDeObra() + /*granel? balde? no. tipo*/pintura.precioTotalPintura(tipo) 
		return cobrar 
	}
	

	
}

object carlos {
	var cobrar = 0
	method pintarTotal(){
		if(metrosCuadrados.metrosC() <= 20){cobrar = 500}
		else{cobrar = 500 + (metrosCuadrados.metrosC() - 20)*30}
	return cobrar
	
	// if (metros < self.limite()) return 500
	// return metros - self.limite() * 30
	
	// cuanto cobra: el máximo entre 500 y 30 * metros
	}
	
	
}

object venancio {
	var cobrar = 0
	var tipo = balde
	method cambioDeTipo(_tipo){
		tipo=_tipo
	}
	method manoDeObra(){
		return 220 * (rounder.roundUp(metrosCuadrados.metrosC() / 10.0 ))
	}
	method pintarTotal(){
		cobrar =  self.manoDeObra()+ pintura.precioTotalPintura(tipo)
	return cobrar
	}	
}

object cocina{
	//inicializar
	var largo = 0
	var ancho = 0
	var alto = 0
	method largoAnchoAltoTest(l,a,a2){
		largo = l
		ancho = a
		alto = a2
	}
	
	method superficie(){
		return (ancho + largo)* 2* alto
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

object habitacion {
	var metrosTotales = 0
	method metrosTotalesTest(m){
		metrosTotales = m
	}
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