import fixture.*
class Contratista {
	var parametroBase
	var fechaDeInicio
	var trabajosRealizados = []
	var complejidadDelRol = 2
	var experienciaPrevia = 0
	var ajuste = sinAjuste
	
	constructor(_parametroBase){
		parametroBase = _parametroBase
	}
	method parametroBase(){
		return parametroBase
	}
	method serviciosHechosEnElMesA(persona){ //TODO: rompe encapsulamiento
		return (persona.trabajosContratados().filter({unTrabajo => (unTrabajo.servicio() == self) && new Date().month() == unTrabajo.fecha().month() /*rompo encapsulamiento. Delegar.*/ */ }))
	}	
	method loTomoDePunto(persona){
		return self.serviciosHechosEnElMesA(persona).size() >= 2
	}
	method cuantoMePagoEnElMes(persona){
		return self.serviciosHechosEnElMesA(persona).sum({unServicio => unServicio.precio()})
	}
	
	
	//p4
	method setearFechaInicio(dia,mes,ano){
		if(new Date() < new Date(dia,mes,ano)){
			throw new Exception("No se puede asignar una fecha posterior al dia de hoy")
			//TODO: No tirar Exception
		}
		else{
		fechaDeInicio = new Date(dia,mes,ano)
		}
	}
	method fechaDeInicio(){
		return fechaDeInicio
	}
	method antiguedad(){
		return  new Date().year() - fechaDeInicio.year()
		}
	method porcentajePorAntiguedad(){
		if(self.antiguedad() >0){
			return rounder.roundDown(self.antiguedad() / 2.00) * 5
		}
	else return 0
	}
	method agregarTrabajo(trabajo){
		trabajosRealizados.add(trabajo)
	}
	method trabajosRealizados(){
		return trabajosRealizados
	}
	
	method complejidadAcumulada(){
		return (trabajosRealizados.map({unTrabajo => unTrabajo.complejidadDeLaCasa() * self.complejidadDelRol()}))
	}
	method experienciaGanada(){
		return experienciaPrevia + self.complejidadAcumulada().sum()
	}
	method complejidadDelRol(){
		return complejidadDelRol
	}
	method calidadDelContratista(){
		//TODO: coleccion y find
		
		
		if(aprendiz.aplica(self)){ //TODO.
			return aprendiz	
		}
		if(501 <= self.experienciaGanada() < 1000){
			return experimentado
		}
		if(1001>= self.experienciaGanada() && self.antiguedad() > 20){
			return referente
		}
		else{
			return maestro
		}
	}
	method setearExperiencia(exp){
		experienciaPrevia += exp
	}
	method costoTotal(casa){
		return 1
	}
	method pagame(casa){
		return self.calidadDelContratista().porcentajeDeSuma() *0.1* self.costoTotal(casa) + self.costoTotal(casa) * 0.1*self.porcentajePorAntiguedad()
	}
	method cobrar(){
		return ajuste.coeficienteDeAjuste() * 0.1 
	}
}

object aprendiz{
	var porcentajeDeSuma = 0
	method porcentajeDeSuma(){
		return 0
	}
}

object experimentado{
	var porcentajeDeSuma = 20
	method porcentajeDeSuma(){
		return 20
	}
}

object referente inherits Maestro{
}

object maestro inherits Maestro{
}

class Maestro {
	var porcentajeDeSuma = 30
	method porcentajeDeSuma(){
		return porcentajeDeSuma
	}
}
	
object conAjuste{
	method coeficienteDeAjuste(meses){
		if (meses == 0){
			return 0
		}
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
}
	
object sinAjuste{
	method CoeficienteDeAjuste(meses){
		return 0
	}
}

class Arquitecto inherits Contratista {
	
	constructor(precioBase) = super(precioBase){
	 	complejidadDelRol = 5
	}
	override method costoTotal(casa){
		return self.parametroBase() * casa.cantidadPisos() * casa.cantAmbientes() * (1 + self.porcentajePorAntiguedad()/100)
	}
	override method porcentajePorAntiguedad(){
		return self.antiguedad()
	}
	
}

class MaestroMayorDeObra inherits Contratista {
	constructor(precioBase) = super(precioBase){
		complejidadDelRol = 3
	}
	 override method costoTotal(casa){
		if (casa.esComplicada()){
				return self.parametroBase() * casa.cantAmbientes() * 1.2 * (1 + self.porcentajePorAntiguedad()/100)
			}
			else { 
				 return self.parametroBase() * casa.cantAmbientes() * (1 + self.porcentajePorAntiguedad()/100)
			}
		}
	override method porcentajePorAntiguedad(){
		if(self.antiguedad() < 5){
			return 0
		}
		if(  self.antiguedad() < 10){
			return 10
		}
		else {
			return 20
		}
	}
}

class Albanil inherits Contratista {
	constructor (horas) = super(horas)  {
		complejidadDelRol = 1
	}
	override method costoTotal(casa){
		return 50 * self.parametroBase() * casa.cantAmbientes()
	}
}

class Electricista inherits Contratista {
	constructor(precioBase) = super(precioBase)
	override method costoTotal(casa){
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
	
	override method costoTotal(casa){
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
			throw new Exception("No se le puede abonar") //TODO
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
	
	
	method complejidad(){ // TODO: no hacer calculos mentales
		if (cantPisos >2 && self.esComplicada()){
			return 5
		}
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

object raul inherits Contratista(25) {
	var tipo = balde
	method costoManoDeObra(metros){
		return parametroBase * metros
	}
	override method costoTotal(casa) { 
		return  self.costoManoDeObra(casa.superficieTotal()) + tipo.precioPintura(casa.superficieTotal()) 
	}
}

object carlos inherits Contratista(500){
		
	override method costoTotal(casa){
		return (parametroBase).max(parametroBase+(casa.superficieTotal() - 20)*30)
	}
		
}



object venancio inherits Contratista(220){
	
	var tipo = balde
	method cambioDeTipo(_tipo){
		tipo=_tipo
	}
	method costoManoDeObra(metros){
		return parametroBase * (rounder.roundUp(metros / 10.0 ))
	}
	override method costoTotal(casa){
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
	method roundDown(nro){
		return (nro.div(1)) 
	}
}


