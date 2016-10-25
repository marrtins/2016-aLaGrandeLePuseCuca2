import fixture.*
import contratistas.*

class FechaPosteriorError inherits Exception{ 
		constructor(_mensaje) = super(_mensaje)
		}
class NoSePuedeAbonarError inherits Exception{
		constructor(_mensaje) = super(_mensaje)
	}
	
object aprendiz{
	
	method porcentajeDeSuma(){
		return 0
	}
}

object experimentado{
	
	method porcentajeDeSuma(){
		return 20
	}
}

class Maestro {
	var porcentajeDeSuma = 30
	method porcentajeDeSuma(){
		return porcentajeDeSuma
	}
}

object referente inherits Maestro{
}

object maestro inherits Maestro{
}

class Agencia {
	var empleados = []
	method agregarEmpleado(empleado){
		empleados.add(empleado)
	}
	method agregarEmpleados(_empleados){
		_empleados.forEach({unEmpleado =>self.agregarEmpleado(unEmpleado)})
	}
	method empleadosContratados(){
		return empleados
	}

	method empleadosQuePuedeContratar(persona){
		return empleados.filter({unEmpleado => persona.puedeContratarA(unEmpleado)})
	}
}

class Persona {
	var casa
	var ahorros
	var preciosDeServiciosContratados = []
	var serviciosContratados = []
	var trabajosContratados = []
	var porcentajeDispuestoAGastar = 0.2
	
	constructor(_ahorros){
		ahorros = _ahorros
	}
	method cambioEnElPorcentajeDispuestoAGastar(porcentaje){
		porcentajeDispuestoAGastar = porcentaje
	}
	method ahorrarMas(masAhorro){
		ahorros += masAhorro
	}
	method presupuesto() {
		return ahorros * porcentajeDispuestoAGastar
	}
	method puedeContratarA(persona){
		return self.presupuesto() > persona.costoTotal(casa) 
	}
	method superficieAPintar(){
		return casa.superficieTotal()
	}
	method casa(_casa){
		casa=_casa	
	}
	method reducirAhorros(monto){
		ahorros -= monto
	}
	method contratarA(contratista){
		if(self.presupuesto() < contratista.costoTotal(casa)){
			throw new NoSePuedeAbonarError("No se le puede abonar")
		}
		else {
			self.reducirAhorros(contratista.costoTotal(casa))
			preciosDeServiciosContratados.add(contratista.costoTotal(casa)) //TODO: volar
			const trabajo = new TrabajoRealizado(contratista,contratista.costoTotal(casa),casa,new Date(),casa.complejidad())
			serviciosContratados.add(contratista)
			trabajosContratados.add(trabajo)
			contratista.agregarTrabajo(trabajo)
			
		}
	}
	
	
	method fueUnDescuidado(){
		return self.precioMasCaro() > 5000
	}
	method precioMasCaro(){
		return preciosDeServiciosContratados.max()
	}
	method cantidadDeServiciosContratados(){
		return serviciosContratados.size()
	}
	method leRealizaronUnTrabajo(){ 
		return serviciosContratados.asSet()
	}
	method nombreDelServicioMasCaro(){
		return self.nombreSimpleDelServicio(self.servicioMasCaro())
	}
	method servicioMasCaro(){
		return trabajosContratados.max({unServicio => unServicio.precio()})
	}
	method nombreSimpleDelServicio(unServicio){
		return unServicio.servicio()
	}
	method trabajosContratados(){
		return trabajosContratados
	}
}

class TrabajoRealizado {
	var servicio
	var precio
	var casa
	var complejidadDeLaCasa
	var fecha
	var estaActivadoAjuste = false
	constructor(_servicio,_precio,_casa,_fecha,_complejidadDeLaCasa){
		servicio = _servicio
		precio = _precio
		casa = _casa
		fecha = _fecha
		complejidadDeLaCasa = _complejidadDeLaCasa
	}
	method servicio(){
		return servicio
	}
	method precio(){
		return precio
	}
	method fecha(){
		return fecha
	}
	method casa(){
		return casa
	}
	method complejidadDeLaCasa(){
		return complejidadDeLaCasa
	}
	method mesesAlDiaDeHoy(){
		return new Date().month() - fecha.month()
	}

	method ajustePorInflacion(){	
		if(estaActivadoAjuste){
			return self.coeficienteDeAjuste(self.mesesAlDiaDeHoy())
		}
		else{
			return 0
		}
	}
	
	method coeficienteDeAjuste(meses) {
		if (meses == 1){
			return 12.4
		}
		if (meses == 2 ){
			return 19.9
		}
		if (meses == 3 ){
			return 24.4
		}
		else return 43
	}

	method estado(_estado){
		estaActivadoAjuste = _estado
	}
}

class Damian inherits Persona {
	constructor(ahorros) = super(ahorros)
	override method fueUnDescuidado(){
		if(casa.cantidadPisos() > 3){return false}
		else{return super()}
	}
}

class Casa{
	var cantAmbientes
	var cantPisos
	var habitaciones = []
	constructor(_cantPisos){
		cantPisos = _cantPisos
	}
	method agregarHabitacion(habitacion){
		habitaciones.add(habitacion)
		cantAmbientes = habitaciones.size()
	}
	method superficieTotal(){
		return habitaciones.sum({unaHabitacion => unaHabitacion.superficie()})
	}
	method cantAmbientes(){
		return cantAmbientes
	}
	method cantidadPisos(){
		return cantPisos
	}
	method esComplicada(){
		return cantAmbientes > 3
	}
	
	
	method complejidad(){ 
		if (self.esComplicada()){
			return 2 + self.complejidadBase()
		}
		else {
			return self.complejidadBase()
		}
	}

	method complejidadBase(){
		if(cantPisos > 2){
			return 3
		}
		else {
			return 1
		}
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

class Habitacion{ 
	var largo 
	var ancho 
	var alto 
	
	constructor(_largo,_ancho,_alto){
		largo = _largo
		ancho = _ancho
		alto = _alto
	}
	method superficie(){
		return ancho * largo * alto
	}
}

class Cocina inherits Habitacion{
	constructor(largo,ancho,alto) = super(largo,ancho,alto)
	override method superficie(){
		return (ancho + largo) * 2 * alto
	}
}

class CuartoDeAldo {
	var superficie
	constructor(_superficie){
		superficie = _superficie
	}
	method superficie(){
		return superficie
	}
}

object rounder {
	method roundUp(nro){
		return -(nro.div(-1)) 
	}
	method roundDown(nro){
		return (nro.div(1)) 
	}
}


