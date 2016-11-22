import tp.*
import contratistas.*


object fixture{
	//1
	method casaDeAldo(persona){
		const casa = new Casa(2)
		const cocina = new Cocina(2,1,3.5)
		const cuartoDeAldo = new CuartoDeAldo(20)
		casa.agregarHabitacion(cocina)
		casa.agregarHabitacion(cuartoDeAldo)
		persona.casa(casa)
		return casa
	}
	
	method casaComplicada(casa,persona){
		const cocina = new Cocina(2,1,3.5)
		const cuartoDeAldo = new CuartoDeAldo(20)
		const cuarto2 = new CuartoDeAldo(20)
		const cuarto3 = new CuartoDeAldo(20)
		const cuarto4 = new CuartoDeAldo(20)
		const cuarto5 = new CuartoDeAldo(20)
		casa.agregarHabitacion(cocina)
		casa.agregarHabitacion(cuartoDeAldo)
		casa.agregarHabitacion(cuarto2)
		casa.agregarHabitacion(cuarto3)
		casa.agregarHabitacion(cuarto4)
		casa.agregarHabitacion(cuarto5)
		persona.casa(casa)
	}
	method casaComplicadaDe2Ambientes(casa,persona){
		const c1 = new CuartoDeAldo(20)
		const c2 = new CuartoDeAldo(20)
		casa.agregarHabitacion(c1)
		casa.agregarHabitacion(c2)
		persona.casa(casa)
		
	}
	
	method casaComplicadaDe4Ambientes(casa,persona){
		const cuarto2 = new CuartoDeAldo(20)
		const cuarto3 = new CuartoDeAldo(20)
		const cuarto4 = new CuartoDeAldo(20)
		const cuarto5 = new CuartoDeAldo(20)
		casa.agregarHabitacion(cuarto2)
		casa.agregarHabitacion(cuarto3)
		casa.agregarHabitacion(cuarto4)
		casa.agregarHabitacion(cuarto5)
		persona.casa(casa)
	}
	
	method casaDe4pisosY7Ambientes(casa,persona){
		const cuarto2 = new CuartoDeAldo(20)
		const cuarto3 = new CuartoDeAldo(20)
		const cuarto4 = new CuartoDeAldo(20)
		const cuarto5 = new CuartoDeAldo(20)
		const cuarto6 = new CuartoDeAldo(20)
		const cuarto7 = new CuartoDeAldo(20)
		const cuarto8 = new CuartoDeAldo(20)
		casa.agregarHabitacion(cuarto2)
		casa.agregarHabitacion(cuarto3)
		casa.agregarHabitacion(cuarto4)
		casa.agregarHabitacion(cuarto5)
		casa.agregarHabitacion(cuarto6)
		casa.agregarHabitacion(cuarto7)
		casa.agregarHabitacion(cuarto8)
		persona.casa(casa)
	}
	
	method casaDePrueba(metros){
		const cuarto = new CuartoDeAldo(metros)
		const casa = new Casa(2)
		casa.agregarHabitacion(cuarto)
		return casa
	}
	
	method casaDeMilena(persona){
		const casa = new Casa(3) 
		const hab1 = new Habitacion(4,3,3)
		const hab2 = new Habitacion(3,2,2)
		casa.agregarHabitacion(hab1)
		casa.agregarHabitacion(hab2)
		persona.casa(casa)
		return casa 
		
	}
	
	method casaDeDamian(persona){
		const casa = new Casa(4)
		const hab1 = new Habitacion(4,3,3) 
		const hab2 = new Habitacion(3,2,2)
		const hab3= new Habitacion(3,2,3)
		const hab4 = new Habitacion(3,4,2)
		casa.agregarHabitacion(hab1)
		casa.agregarHabitacion(hab2)
		casa.agregarHabitacion(hab3)
		casa.agregarHabitacion(hab4)
		persona.casa(casa)
		return casa
	}
	
	method crearAgenciaNueva(){
		const noelia = new Electricista(250)
		const eliana = new MaestroMayorDeObra(12000)
		const dodain = new Albanil(24)
		const silvina = new Plomero(1.25)
		const agencia = new Agencia()
		agencia.agregarEmpleado(noelia)
		agencia.agregarEmpleado(eliana)
		agencia.agregarEmpleado(dodain)
		agencia.agregarEmpleado(silvina)
		return agencia
	}
	
	method venancio(){
		venancio.setearFechaInicio(18,07,2000)
		return venancio
	}
	
	method eliana(){
		const contratista = new MaestroMayorDeObra(12000)
		contratista.setearFechaInicio(08,12,2007)
		return contratista
	}
	
	method marcos(){
		const contratista = new MaestroMayorDeObra(50000)
		contratista.setearFechaInicio(18,07,2010)
		return contratista
	}
	
	method emanuel(){
		const contratista = new Arquitecto(100000)
		contratista.setearFechaInicio(05,06,2009)
		return contratista
	}
	
	method carlos(){
		carlos.setearFechaInicio(07,07,2016)
		return carlos
	}
	
	method raul(){
		raul.setearFechaInicio(01,01,2016)
		return raul
	}
	
	method lito(){
		const contratista = new Albanil(16)
		contratista.setearFechaInicio(01,01,2016)
		return contratista
	}
	
	method eduardo(){
		const contratista = new Electricista(100)
		contratista.setearFechaInicio(01,01,2016)
		return contratista
	}
	
	method roger(){
		const contratista = new Plomero(1.1)
		contratista.setearFechaInicio(01,01,2016)
		return contratista
	}
	
	method noelia(){
		const contratista = new Electricista(250)
		contratista.setearFechaInicio(01,01,2016)
		return contratista
	}
	
	method dodain(){
		const contratista = new Albanil(24)
		contratista.setearFechaInicio(01,01,2016)
		return contratista
	}
	
	method silvina(){
		const contratista = new Plomero(1.25)
		contratista.setearFechaInicio(01,01,2016)
		contratista.setearExperiencia(396)
		return contratista
	}
	
	method aldo(){
		return new Persona(6000)
	}
	
	method milena(){
		return new Persona(2000)
	}
	
	method damian(){
		return new Damian(250000)
	}
	
	method servicioDeDodainEl1532016deMilPesos(){
		const dodain = self.dodain()
		const casa = new Casa(1)
		const hab1 = new Habitacion(4,3,3)
		casa.agregarHabitacion(hab1)
		const fecha = new Date(15,03,2016)
		return new TrabajoRealizado(dodain,1000,casa,fecha,casa.complejidad())
	}
	
	method servicioDeDodainEl442016deMilPesos(){
		const dodain = self.dodain()
		const casa = new Casa(3)
		const hab1 = new Habitacion(4,3,3)
		casa.agregarHabitacion(hab1)
		const fecha = new Date(04,04,2016)
		return new TrabajoRealizado(dodain,1000,casa,fecha,casa.complejidad())	
	}


}
