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
	    casamiento.inicioDelEvento =LocalDateTime.of(2007,10,10,5,15)
	    casamiento.finDelEvento =LocalDateTime.of(2007,10,10,5,25)
	}
	
	@Test
	def void duracionDelCasamiento() {
		
		Assert.assertEquals(600,casamiento.duracion(),0)
	}
	
}