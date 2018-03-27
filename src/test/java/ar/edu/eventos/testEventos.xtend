package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

class testEventos {
	Locacion miCasa
	Evento casamiento

	@Before
	def void init() {
		miCasa = new Locacion(new Point(1.0, 2.0), "Mi Casa")
		casamiento = new Evento("Casaminto de Flor y leo", miCasa)
		casamiento.inicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 15)
		casamiento.finDelEvento = LocalDateTime.of(2007, 10, 10, 5, 25)

	}

	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(600, casamiento.duracion(), 0)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(11.11, miCasa.distancia(new Point(1.1, 2.0)), 1)
	}

}
