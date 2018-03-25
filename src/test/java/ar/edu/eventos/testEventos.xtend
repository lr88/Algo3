package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before

class testEventos {

	Evento casamiento
	@Before
	def void init() {
		casamiento = new Evento("Flor y leo")
		casamiento.inicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 15)
		casamiento.finDelEvento = LocalDateTime.of(2007, 10, 10, 5, 25)
		casamiento.ubicacion(50,1)
		casamiento.elNombreDeLaLocacion("Club 1")
			
	}
	@Test
	def void duracionDelCasamiento() {
		Assert.assertEquals(600, casamiento.duracion(), 0)
	}
	@Test
	def void ubicacionDelCasamientoX() {
		Assert.assertEquals(50, casamiento.locacionX, 0)
	}
	@Test
	def void ubicacionDelCasamientoY() {
		Assert.assertEquals(1, casamiento.locacionY, 0)
	}
	@Test
	def void nombreDeLaUbicacionDelCasamiento() {
		Assert.assertTrue("Club 1" == casamiento.nombreDeLaLocacion)
	}

	@Test
	def void distancia() {
		Assert.assertEquals(47,casamiento.distancia(3,3),1)
		
	}


}
