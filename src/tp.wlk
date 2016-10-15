import fixture.*
class Contratista {
	var parametroBase
	constructor(_parametroBase){
		parametroBase = _parametroBase
	}
	method parametroBase(){
		return parametroBase
	}
	method serviciosHechosEnElMesA(persona){
		return (persona.trabajosContratados().filter({unTrabajo => (unTrabajo.servicio() == self) && new Date().month() == unTrabajo.fecha().month() }))
	}	
	method loTomoDePunto(persona){
		return self.serviciosHechosEnElMesA(persona).size() >= 2
	}
	method cuantoMePagoEnElMes(persona){
		return self.serviciosHechosEnElMesA(persona).sum({unServicio => unServicio.precio()})
	}
	
}

class Arquitecto inherits Contratista {
	constructor(precioBase) = super(precioBase)
	method costoTotal(casa){
		return self.parametroBase() * casa.cantidadPisos() * casa.cantAmbientes()
	}
}

class MaestroMayorDeObra inherits Contratista {
	constructor(precioBase) = super(precioBase)
	 method costoTotal(casa){
		if (casa.esComplicada()){
				return self.parametroBase() * casa.cantAmbientes() * 1.2
			}
			else { 
				 return self.parametroBase() * casa.cantAmbientes()
			}
		}
}

class Albanil inherits Contratista {
	constructor (horas) = super(horas)   
	method costoTotal(casa){
		return 50 * self.parametroBase() * casa.cantAmbientes()
	}
}

class Electricista inherits Contratista {
	constructor(precioBase) = super(precioBase)
	method costoTotal(casa){
		if (casa.esComplicada()){
				return self.parametroBase() *2 * casa.cantAmbientes() 	
				}
			else { 
				return self.parametroBase() * casa.cantAmbientes()
			}
	
		}
	}
class Plomero inherits Contratista {
	constructor(porcentajeRecargo) = super(porcentajeRecargo)
	
	method costoTotal(casa){
		if (casa.cantidadPisos() > 2){
				return 100 * self.parametroBase() * casa.cantAmbientes() 	
				}
			else { 
				return 100 * casa.cantAmbientes()
			}
		}
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
			throw new Exception("No se le puede abonar")
		}
		else {
			self.reducirAhorros(contratista.costoTotal(casa))
			preciosDeServiciosContratados.add(contratista.costoTotal(casa))
			const trabajo = new TrabajoRealizado(contratista,contratista.costoTotal(casa))
			serviciosContratados.add(contratista)
			trabajosContratados.add(trabajo)
			
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
	var fechaDelServicio = new Date()
	constructor(_servicio,_precio){
		servicio = _servicio
		precio = _precio
	}
	method servicio(){
		return servicio
	}
	method precio(){
		return precio
	}
	method fecha(){
		return fechaDelServicio
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
	method costoTotal(casa) { 
		return  self.costoManoDeObra(casa.superficieTotal()) + tipo.precioPintura(casa.superficieTotal()) 
	}
}

object carlos {
		
	method costoTotal(casa){
		return (500).max(500+(casa.superficieTotal() - 20)*30)
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
	method costoTotal(casa){
		return  self.costoManoDeObra(casa.superficieTotal())+ tipo.precioPintura(casa.superficieTotal())
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
}



