import tp.*
import fixture.*

class Contratista {
	var parametroBase
	var fechaDeInicio
	var trabajosRealizados = []
	var complejidadDelRol = 2
	var experienciaPrevia = 0
	
	
	constructor(_parametroBase){
		parametroBase = _parametroBase
	}
	
	method parametroBase(){
		return parametroBase
	}
	
	method serviciosHechosEnElMesA(persona){ /*TODO: rompe encapsulamiento */
		return (persona.trabajosContratados().filter({unTrabajo => (unTrabajo.servicio() == self) && new Date().month() == unTrabajo.fecha().month() /*rompo encapsulamiento. Delegar.*/  }))
	}
		
	method loTomoDePunto(persona){
		return self.serviciosHechosEnElMesA(persona).size() >= 2
	}
	
	method cuantoMePagoEnElMes(persona){
		return self.serviciosHechosEnElMesA(persona).sum({unServicio => unServicio.precio()})
	}
	
	method setearFechaInicio(dia,mes,ano){
		if(new Date() < new Date(dia,mes,ano)){
			throw new FechaPosteriorError("No se puede asignar una fecha posterior al dia de hoy")
			}
		fechaDeInicio = new Date(dia,mes,ano)
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
		
		
		//if(aprendiz.aplica(self)){ //TODO.
			//return aprendiz	
		//}
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


