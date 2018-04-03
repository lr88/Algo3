package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point
import java.time.LocalDate

class testEventos {
	LocalDateTime fechaActual = LocalDateTime.of(2020, 10, 10, 5, 00)
	Point lugarGenerico = new Point(20, 2.0)
	Locacion miCasa
	Locacion complejo1
	Evento casamiento
	EventoAbierto show1
	Usuario juan

	@Before
	def void init() {
		/*------------CREAR Organizadores-------------- */
		
		juan = new Usuario("CD","Pedro", "Perez", "pedroPerez@gmail.com",lugarGenerico , true,
			LocalDate.of(2005, 10, 10))
		
		/*------------CREAR LOCACIONES-------------- */
		miCasa = new Locacion(new Point(1.0, 2.0), "Mi Casa",800)
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1",2000)
		
		/*------------CREAR EVENTOS-------------- */
		
		show1 = new EventoAbierto ( "show1", complejo1,juan, 50)
		casamiento = new Evento("Casaminto de Flor y leo", miCasa,juan)
		
		/*------------INSTANCIAR OBJETOS-------------- */
		
		casamiento.inicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 00)
		casamiento.finDelEvento = LocalDateTime.of(2007, 10, 10, 9, 00)
		
	
	}
   
   
	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(4.0, casamiento.duracion(), 0.0)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(11.11, miCasa.distancia(new Point(1.1, 2.0)), 1)
	}

	@Test
	def void capacidadMaxima() {
		Assert.assertEquals(2500, show1.capacidadMaxima, 0)
	}


}