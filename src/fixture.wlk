import tp.*
object fixture{
	method crearCasaDeAldo(){
		
		
	}
	method casaDeAldo(casa,persona){
		const cocina = new Cocina(2,1,3.5)
		const cuartoDeAldo = new CuartoDeAldo(20)
		casa.agregarHabitacion(cocina)
		casa.agregarHabitacion(cuartoDeAldo)
		persona.casa(casa)
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
	method casaDePrueba(casa,metros){
		const cuarto = new CuartoDeAldo(metros)
		casa.agregarHabitacion(cuarto)
	}
	
	method casaDeMilena(casa,persona){
		const hab1 = new Habitacion(4,3,3)
		const hab2 = new Habitacion(3,2,2)
		casa.agregarHabitacion(hab1)
		casa.agregarHabitacion(hab2)
		persona.casa(casa)
	}
	method casaDeDamian(casa,persona){
		const hab1 = new Habitacion(4,3,3) 
		const hab2 = new Habitacion(3,2,2)
		const hab3= new Habitacion(3,2,3)
		const hab4 = new Habitacion(3,4,2)
		casa.agregarHabitacion(hab1)
		casa.agregarHabitacion(hab2)
		casa.agregarHabitacion(hab3)
		casa.agregarHabitacion(hab4)
		persona.casa(casa)
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
	
	
	
}

