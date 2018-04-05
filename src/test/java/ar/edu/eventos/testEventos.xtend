package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point
import java.time.LocalDate

class testEventos {
	
	Point lugarGenerico = new Point(20, 2.0)
	Locacion miCasa
	Locacion complejo1
	Evento casamiento
	Usuario juan

	@Before
	def void init() {
		/*------------CREAR Organizadores-------------- */
		juan = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", lugarGenerico, true,
			LocalDate.of(2005, 10, 10),3)

		/*------------CREAR LOCACIONES-------------- */
		miCasa = new Locacion(new Point(1.0, 2.0), "Mi Casa", 800)
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 2000)

		/*------------CREAR EVENTOS-------------- */
		casamiento = new Evento("Casaminto de Flor y leo", miCasa, juan)

		/*------------INSTANCIAR OBJETOS-------------- */
		casamiento.inicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 00)
		casamiento.finDelEvento = LocalDateTime.of(2007, 10, 10, 9, 00)

	}

	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(true, casamiento.duracion()>0)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(11.11, miCasa.distancia(new Point(1.1, 2.0)), 1)
	}

}
