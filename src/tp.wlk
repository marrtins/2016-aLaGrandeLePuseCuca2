import fixture.*
class ContratistaCondicional {
	var precioBase
	var porcentaje
	var condicion
	
	constructor (_precioBase,_porcentaje,_condicion){
		precioBase = _precioBase
		porcentaje = _porcentaje
		condicion = _condicion
		}
		
		method costoTotal(metros, cliente){
			if (condicion){return precioBase * cliente.cantAmbientes() * porcentaje}
			else { return precioBase * cliente.cantAmbientes()}
		}
	
		method cambiarCondicion(condNueva){
			condicion = condNueva
			}
}

class Albanil {
	
	const precioPorHora = 50
	var horasPorAmbiente
	
	constructor (_horasPorAmbiente){
		horasPorAmbiente = _horasPorAmbiente
	}
	
	method costoTotal(metros, casa){
		return fixture.aldo().cantAmbientes() * precioPorHora * horasPorAmbiente	
	}
}	

class Arquitecto{
	var precioPorAmbiente
	
	constructor (_precioPorAmbiente){
		precioPorAmbiente = _precioPorAmbiente
	}
	
	method costoTotal(_,casa){
		return precioPorAmbiente * casa.cantAmbientes() * casa.cantidadDePisos()
	}
}

class Agencia{
	var empleados
	
	constructor(_empleados){
		empleados = _empleados
	}
	
	method empleados(){
		return empleados
	}

	method anadirEmpleado(empleado){
		empleados.add(empleado)
	}
	
	method despedirEmpleado(empleado){
		empleados.remove(empleado)
	}
	
	method costoDeEmpleado(empleado, cliente){
		return empleado.costoTotal(cliente.superficieAPintar(), cliente)
	}
}

class Persona{
	
	var ahorros
	var precioDeServiciosContratados
	var servicioMasCaro 
	var costoMasAlto
	var cantPisos
	var habitaciones
		
	constructor (_ahorros, _precioDeServiciosContratados, _servicioMasCaro, _costoMasAlto, _cantPisos, _habitaciones){
		ahorros = _ahorros
		precioDeServiciosContratados = _precioDeServiciosContratados
		servicioMasCaro = _servicioMasCaro
		costoMasAlto = _costoMasAlto
		cantPisos = _cantPisos
		habitaciones = _habitaciones
}
	
	method cantidadDePisos(){
		return cantPisos
		}
	
	method tieneMasDeDosPisos(){
		return cantPisos > 2
	}
	
	method esComplicada(){
		return habitaciones.size() > 3	
	}
	
	method cantAmbientes(){
		return habitaciones.size()
	}
	
	method ahorrarMas(masAhorro){
		ahorros += masAhorro
	}
	
	method superficieAPintar(){
		return  habitaciones.sum()
	}
	
	method presupuesto() {
		return ahorros * 0.2
	}
	
	method puedeContratarA(persona){
		return self.presupuesto() > persona.costoTotal(self.superficieAPintar(), self) 
	}
	
	method lePuedeAbonarA(persona){
		return self.presupuesto() > fixture.agencia().costoDeEmpleado(persona, self)
	}
	
	method disminuirAhorros(perdida){
		ahorros -= perdida
	}
	
	method contratarA(persona) {
	
	var costo = fixture.agencia().costoDeEmpleado(persona, self)
		if (self.lePuedeAbonarA(persona).negate()){
			throw new Exception("No se le puede abonar")
		}
		self.disminuirAhorros(costo)
		precioDeServiciosContratados.add(costo)
		self.servicioMasCaro(persona,costo)
		return fixture.agencia().costoDeEmpleado(persona, casa)	
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

class PersonaDescuidadaPisos inherits Persona {
	
	constructor (_ahorros, _precioDeServiciosContratados, _servicioMasCaro, _costoMasAlto, _cantPisos, _habitaciones) = super (_ahorros, _precioDeServiciosContratados, _servicioMasCaro, _costoMasAlto, _cantPisos, _habitaciones){
	}
	
	override method fueUnDescuidado(){
		return cantPisos < 3	
	}
}

object casa {
	var cantHabitaciones = 6
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
	method cambiarPisos(cant){
		cantPisos =cant
	}
	method superficieAPintar(){
		return  cocina.superficie() + habitacion.superficie()
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
	method costoTotal(metros,casa) { 
		return  self.costoManoDeObra(metros) + tipo.precioPintura(metros) 
	}
}

object carlos {
		
	method costoTotal(metros,casa){
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
	method costoTotal(metros, casa){
		return  self.costoManoDeObra(metros)+ tipo.precioPintura(metros)
	}	
}

object cocina{
	var largo = 2
	var ancho = 1
	var alto = 3.5
	method superficie(){
		return (ancho + largo)* 2 * alto
	}
}

object habitacion {
	var metrosTotales = 20
	method superficie(){
		return metrosTotales
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

object rounder {
	method roundUp(nro){
		return -(nro.div(-1)) 
	}
}



