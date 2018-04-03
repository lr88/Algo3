package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

class testEventos {
	LocacionEventos miCasa
	LocacionEventos complejo1
	Evento casamiento
	EventoAbierto show1

	@Before
	def void init() {
		/*------------CREAR LOCACIONES-------------- */
		miCasa = new LocacionEventos(new Point(1.0, 2.0), "Mi Casa",800)
		complejo1 = new LocacionEventos(new Point(1.0, 2.0), "Complejo1",2000)
		
		/*------------CREAR EVENTOS-------------- */
		
		show1 = new EventoAbierto ( "show1", complejo1)
		casamiento = new Evento("Casaminto de Flor y leo", miCasa)
		
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