package ar.edu.eventos

import java.time.LocalDate
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosAbierto {
	Point lugarGenerico = new Point(20, 2.0)
	Locacion complejo1
	EventoAbierto show1
	Usuario juan

	@Before
	def void init() {
		/*------------CREAR Organizadores-------------- */
		juan = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", lugarGenerico, true,
			LocalDate.of(2005, 10, 10),3)

		/*------------CREAR LOCACIONES-------------- */
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)

		/*------------CREAR EVENTOS-------------- */
		show1 = new EventoAbierto("show1", complejo1, juan, 5)

		juan.comprarEntradaDeEventoAbierto(show1)
		juan.comprarEntradaDeEventoAbierto(show1)
		juan.comprarEntradaDeEventoAbierto(show1)
		juan.comprarEntradaDeEventoAbierto(show1)
		juan.comprarEntradaDeEventoAbierto(show1)

	/*------------INSTANCIAR OBJETOS-------------- */
	}

	@Test
	def void capacidadMaxima() {
		Assert.assertEquals(3, show1.capacidadMaxima, 1)
	}

	@Test
	def void capacidadesSonExitosas() {
		Assert.assertEquals(true, show1.lasCapacidadesSonExitosas)
	}

	@Test
	def void eventoExitoso() {
		Assert.assertEquals(true, show1.esExitoso)
	}

	@Test
	def void eventoesUnFracaso() {
		Assert.assertEquals(false, show1.esUnFracaso)
	}

}
