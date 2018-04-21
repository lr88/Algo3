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
		miCasa = new Locacion ()=>[
			ubicacion = new Point(1.0, 2.0)
		]

	casamiento = new EventoAbierto()=>[
		fechaDeInicioDelEvento = LocalDateTime.of(2018, 10, 10, 20, 0)
		fechaDeFinDelEvento = LocalDateTime.of(2018, 10, 11, 0, 0)
	 ]
	}

	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(4, casamiento.duracion(), 0)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(11.11, miCasa.distancia(new Point(1.1, 2.0)), 1)
	}

}
