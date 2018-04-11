package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosAbierto {
	
	Usuario usuario1
	Locacion casaUsuario1
	EventoAbierto eventoAbierto1
	LocalDateTime fechaActual = LocalDateTime.now()

	@Before
	def void init() {
		
	casaUsuario1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)	
	
	usuario1 = new Usuario ("usuario1","usuario1","usuario1","usuario1@usuario1.com",
		new Point(1.0, 2.0),false,LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)
	
	eventoAbierto1 = new EventoAbierto("Mi cumple",casaUsuario1,usuario1,100,LocalDateTime.of(2020, 10, 10, 0, 0),LocalDateTime.of(2020, 10, 11, 0, 0),LocalDateTime.of(2020, 10, 12, 0, 0))

	}


	@Test
	def void a() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario1.cancelarEvento(eventoAbierto1)
		Assert.assertEquals(true,usuario1.mensajes.contains("se cancelo el evento"))
	}

}
