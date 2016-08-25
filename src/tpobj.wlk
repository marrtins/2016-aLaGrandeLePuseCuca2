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
		return self.presupuesto() > persona.pintarTotal()
	}
	
}

object pintura {
	
	method precioTotalPintura(tipo){
		return tipo.precioPintura()
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
object balde {
	var precioCada50 = 200
	method nuevoPrecio(nuevoPrecio){
		precioCada50 = nuevoPrecio
	}
	method latasNecesarias(){
		return rounder.roundUp(metrosCuadrados.metrosC() * 0.02)
	}
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
	method manoDeObra(){
		return 25*metrosCuadrados.metrosC()
	}
	method pintarTotal() {
		cobrar=  self.manoDeObra() + pintura.precioTotalPintura(tipo) 
		return cobrar 
	}
	

	
}

object carlos {
	var cobrar = 0
	method pintarTotal(){
		if(metrosCuadrados.metrosC() <= 20){cobrar = 500}
		else{cobrar = 500 + (metrosCuadrados.metrosC() - 20)*30}
	return cobrar
	}
	
	
}

object venancio {
	var cobrar = 0
	var tipo = balde
	method cambioDeTipo(_tipo){
		tipo=_tipo
	}
	method manoDeObra(){
		return 220 * (rounder.roundUp(metrosCuadrados.metrosC() * 0.1))
	}
	method pintarTotal(){
		cobrar =  self.manoDeObra()+ pintura.precioTotalPintura(tipo)
	return cobrar
	}	
}

object cocina{
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
		// Sí, es feo, por eso queda escondido
	}
}