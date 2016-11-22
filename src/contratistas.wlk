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
	
	
	method loTomoDePunto(persona){
		return persona.trabajosQueMeHizoEnElMes(self).size() >= 2
	}
	
	//method cuantoMePagoEnElMes(persona){
		//return persona.trabajosQueMeHizoEnElMes(self).sum({unServicio => unServicio.precio()})
	//}
	
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
		//var calidades  = [aprendiz,experimentado,referente,maestro]
		//return calidades.filter({unaCalidad => unaCalidad.aplica(self)})
		if(aprendiz.aplica(self)){
			return aprendiz
		}
		else if(experimentado.aplica(self)){
			return experimentado
		}
		else if(referente.aplica(self)){
			return referente
		}
		else return maestro
		
	}
	
	method setearExperiencia(exp){
		experienciaPrevia += exp
	}
	method costoTotal(casa){
		return (1+self.calidadDelContratista().porcentajeDeSuma() + self.porcentajePorAntiguedad()) * self.costoSinAdicionales(casa)
	}
	method costoSinAdicionales(casa)
	
	
	
	
	
}
class Calidad{
	method nombreSimple(){
		return self
	}
}
object aprendiz inherits Calidad{
	method aplica(contratista){
		return contratista.experienciaGanada() < 500
	}
	method porcentajeDeSuma(){
		return 0
	}
}

object experimentado inherits Calidad{
	method aplica(contratista){
		return contratista.experienciaGanada() < 1000 && contratista.experienciaGanada() > 501
	}
	method porcentajeDeSuma(){
		return 0.2
	}
}

class Maestro inherits Calidad{
	var porcentajeDeSuma = 0.3
	method aplica(contratista){
		return contratista.experienciaGanada() > 1000
	}
	method porcentajeDeSuma(){
		return porcentajeDeSuma
	}
}

object referente inherits Maestro{
	override method aplica(contratista){
		return contratista.antiguedad() > 20 && super(contratista)
		
	}
}

object maestro inherits Maestro{
	
}

class Arquitecto inherits Contratista {
	
	constructor(precioBase) = super(precioBase){
	 	complejidadDelRol = 5
	}
	override method costoSinAdicionales(casa){
		return self.parametroBase() * casa.cantidadPisos() * casa.cantAmbientes() 
	}
	override method porcentajePorAntiguedad(){
		return self.antiguedad() * 0.01
	}
	
}

class MaestroMayorDeObra inherits Contratista {
	
	constructor(precioBase) = super(precioBase){
		complejidadDelRol = 3
	}
	override method costoSinAdicionales(casa){
		if(casa.esComplicada()){
			return self.parametroBase() * casa.cantAmbientes() * 1.2
		
		}
		else {
			return self.parametroBase()*casa.cantAmbientes()
		}
	}
	
	override method porcentajePorAntiguedad(){
		if(self.antiguedad() < 5){
			return 0
		}
		if(  self.antiguedad() < 10){
			return 0.1
		}
		else {
			return 0.2
		}
	}
}

class Albanil inherits Contratista {
	constructor (horas) = super(horas)  {
		complejidadDelRol = 1
	}
	override method costoSinAdicionales(casa){
		return 50 * self.parametroBase() * casa.cantAmbientes() 
	}
}

class Electricista inherits Contratista {
	constructor(precioBase) = super(precioBase)
	 override method costoSinAdicionales(casa){
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
	
	 override method costoSinAdicionales(casa){
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
	 override method costoSinAdicionales(casa) { 
		return  self.costoManoDeObra(casa.superficieTotal()) + tipo.precioPintura(casa.superficieTotal()) 
	}
}

object carlos inherits Contratista(500){
		
	 override method costoSinAdicionales(casa){
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
	 override method costoSinAdicionales(casa){
		return  self.costoManoDeObra(casa.superficieTotal())+ tipo.precioPintura(casa.superficieTotal())
	}	
}


