import fixture.*
class ContratistaCondicional {
	var precioBase
	var porcentaje
	var condicion
	
	constructor (_precioBase,_porcentaje,_condicion){
		precioBase = _precioBase
		porcentaje = _porcentaje
		condicion = _condicion //TODO: No hay que guardarse un booleano. Puede resolverse con herencia
		}
		
		method costoTotal(metros, cliente){  //TODO: Ojo q todos los costos totales son con 1 parametro: la casa.
			if (condicion){
				return precioBase * cliente.cantAmbientes() * porcentaje
			}
			else { 
				return precioBase * cliente.cantAmbientes()
			}
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
	
	method costoTotal(metros, casa){ //TODO: ojo! No puede ser el de aldo
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

class Agencia{ //TODO: La responsabilidad de saber a quiénes puede contratar un cliente está acá.
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
	
	method costoDeEmpleado(empleado, cliente){ //TODO: Debe volar. No es RESPONSABILIDAD de la agencia
		return empleado.costoTotal(cliente.superficieAPintar(), cliente)
	}
}

class Persona{
	
	var ahorros
	var precioDeServiciosContratados
	var servicioMasCaro 
	var costoMasAlto
	var cantPisos
	var habitaciones //TODO: Dentro de la casa!!!
		
	constructor (_ahorros, _precioDeServiciosContratados, _servicioMasCaro, _costoMasAlto, _cantPisos, _habitaciones){
		ahorros = _ahorros
		precioDeServiciosContratados = _precioDeServiciosContratados
		servicioMasCaro = _servicioMasCaro
		costoMasAlto = _costoMasAlto
		cantPisos = _cantPisos
		habitaciones = _habitaciones
}
	
	method cantidadDePisos(){ //TODO: No guardar esto directamente en la persona
		return cantPisos
		}
	
	method tieneMasDeDosPisos(){ //TODO: No guardar esto directamente en la persona
		return cantPisos > 2
	}
	
	method esComplicada(){ //TODO: No guardar esto directamente en la persona
		return habitaciones.size() > 3	
	}
	
	method cantAmbientes(){ //TODO: No guardar esto directamente en la persona
		return habitaciones.size()
	}
	
	method ahorrarMas(masAhorro){
		ahorros += masAhorro
	}
	
	method superficieAPintar(){  //TODO: No guardar esto directamente en la persona
		return  habitaciones.sum()
	}
	
	method presupuesto() {
		return ahorros * 0.2
	}
	
	method puedeContratarA(contratista){
		return self.presupuesto() > contratista.costoTotal(self.superficieAPintar(), self) //TODO: Volar primer parámetro. Pasar casa por parámetro. 
	}
	
	method lePuedeAbonarA(persona){
		return self.presupuesto() > fixture.agencia().costoDeEmpleado(persona, self)
	}
	
	method disminuirAhorros(perdida){
		ahorros -= perdida
	}
	
	method contratarA(persona) { //TODO: mirar los puntos q faltan hacer. ¿cambia la responsabilidad de contratar?
	
	var costo = fixture.agencia().costoDeEmpleado(persona, self) //TODO: 2 errores. 1: el q saben, que no hay q preguntarle esto a la agencia, porque el costo no es responsabilidad de la agencia. Además, desde el código del sistema NO SE PUEDE USAR EL FIXTURE.
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
	
	method servicioMasCaro(persona,costo){ //TODO: Volar este setter
		if(costo > costoMasAlto){costoMasAlto = costo 
			servicioMasCaro = persona
		}
	}

	method elMasCaro(){ //TODO: Está mal guardarse esto. Si tienen una colección de costos, pueden calcular el más caro
		return servicioMasCaro
	}
}

class PersonaDescuidadaPisos inherits Persona {
	
	constructor (_ahorros, _precioDeServiciosContratados, _servicioMasCaro, _costoMasAlto, _cantPisos, _habitaciones) = super (_ahorros, _precioDeServiciosContratados, _servicioMasCaro, _costoMasAlto, _cantPisos, _habitaciones){
	}
	
	override method fueUnDescuidado(){
		return cantPisos < 3 // TODO: No está completa la lógica
	}
}

object casa { //TODO: Clase Casa
	var cantHabitaciones = 6 //TODO: Colección de habitaciones
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
	method superficieAPintar(){ //TODO: Cambiar
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

object cocina{ //TODO: clase Habitacion
	var largo = 2
	var ancho = 1
	var alto = 3.5
	method superficie(){
		return (ancho + largo)* 2 * alto
	}
}

object habitacion { //TODO: Nombre menos parecido arriba. cuartito
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



