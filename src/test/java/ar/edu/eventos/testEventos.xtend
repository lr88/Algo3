package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

class testEventos {

	Point lugarGenerico = new Point(20, 2.0)
	Locacion miCasa
	Locacion complejo1
	Evento casamiento
	Evento casamiento1
	Evento casamiento2
	Evento casamiento3
	Usuario juan

	@Before
	def void init() {
		/*------------CREAR Organizadores-------------- */
		juan = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", lugarGenerico, true,
			LocalDateTime.of(2005, 10, 10, 0, 0), 3)

		/*------------CREAR LOCACIONES-------------- */
		miCasa = new Locacion(new Point(1.0, 2.0), "Mi Casa", 800)
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 2000)

		/*------------CREAR EVENTOS-------------- */
		casamiento = new Evento("Casaminto de Flor y leo", miCasa, juan,LocalDateTime.of(2007, 10, 10, 5, 00),LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento1 = new Evento("Casaminto de Flor y leo", miCasa, juan,LocalDateTime.of(2007, 8, 10, 5, 00),LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento2 = new Evento("Casaminto de Flor y leo", miCasa, juan,LocalDateTime.of(2007, 8, 10, 5, 00),LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento3 = new Evento("Casaminto de Flor y leo", miCasa, juan,LocalDateTime.of(2007, 7, 10, 5, 00),LocalDateTime.of(2007, 10, 10, 9, 00))

		/*------------INSTANCIAR OBJETOS-------------- */
		

		juan.agregarEvento(casamiento)
		juan.agregarEvento(casamiento1)
		juan.agregarEvento(casamiento2)
		juan.agregarEvento(casamiento3)

	}

	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(true, casamiento.duracion() > 0)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(11.11, miCasa.distancia(new Point(1.1, 2.0)), 1)
	}

	

}
