import fixture2.*
class ContratistaCondicional {
	var precioBase
	var porcentaje
	var condicion
	constructor (_precioBase,_porcentaje,_condicion){
		precioBase = _precioBase
		porcentaje = _porcentaje
		condicion = _condicion
		}
		method costoTotal(cantAmbientes,_){
			if (condicion){return precioBase * cantAmbientes * porcentaje}
			else { return precioBase * cantAmbientes}
		}
	
}

object lito {
	var precioPorHora = 50
	var horasPorAmbiente = 16
	method costoTotal(cantAmbientes,_){
		return cantAmbientes * precioPorHora * horasPorAmbiente	
	}
}

object emanuel {
	var precioPorAmbiente = 100000
	method costoTotal(cantAmbientes,_){
		return precioPorAmbiente * cantAmbientes * casa.cantidadDePisos()
	}
}

object casa {
	var cantHabitaciones = 2
	var cantPisos = 2
	method esComplicada(){
		return cantHabitaciones > 3
	}
	method tieneMasDeDosPisos(){
		return cantPisos > 2
	}
	method cantidadDePisos(){
		return cantPisos
	}
	method cantAmbientes() {
		return cantHabitaciones
	}
	method cambiarHabitaciones(cant){
		cantHabitaciones =cant
	}
	method superficieTotal(){
		return  cocina.superficie() +habitacion.superficie()
		
	}
}


object agencia {
	var empleados = [lito,emanuel,fixture.eduardo(),fixture.roger(),fixture.marcos(),raul,carlos,venancio]
	
	method anadirEmpleado(empleado){
		empleados.add(empleado)
	}
	method costoDeEmpleado(empleado){
		return empleado.costoTotal(casa.cantAmbientes(),aldo.superficieAPintar())
	}
	
	
}
		
////////////////////////


object aldo {
	var ahorros = 6000
	var precioDeServiciosContratados = []
	var servicioMasCaro 
	var costoMasAlto = 0
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
	
	method lePuedeAbonarA(persona){
		return self.presupuesto() > agencia.costoDeEmpleado(persona)
	}
	method disminuirAhorros(perdida){
		ahorros -= perdida
	}
	method contratarA(persona){
		var costo = agencia.costoDeEmpleado(persona)
		if (self.lePuedeAbonarA(persona).negate()){
			throw new Exception("No se le puede abonar")
		}
		self.disminuirAhorros(costo)
		precioDeServiciosContratados.add(costo)
			self.servicioMasCaro(persona,costo)
		return agencia.costoDeEmpleado(persona)	
	}
	method fueUnDescuidado(){
		return self.precioMasCaro() > 5000
	}
	method precioMasCaro(){
		return precioDeServiciosContratados.max()
	}
	
	method cantidadDeServicios(){
		return precioDeServiciosContratados.size()
	}
	method servicioMasCaro(persona,costo){
		if(costo > costoMasAlto){costoMasAlto = costo 
			servicioMasCaro = persona
		}
	}
	method elMasCaro(){
		return servicioMasCaro
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
	method costoTotal(_,metros) { 
		return  self.costoManoDeObra(metros) + tipo.precioPintura(metros) 
	}
}

object carlos {
		
	method costoTotal(_,metros){
		return (500).max(500+(metros - 20)*30)
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
	method costoTotal(_,metros){
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


