package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosAbierto {
	Point lugarGenerico = new Point(20, 2.0)
	Locacion complejo1
	EventoAbierto show1
	EventoAbierto show2
	EventoAbierto show3
	EventoAbierto show4

	Usuario juan
	Usuario Organizador1
	Usuario Organizador2
	Usuario Organizador3
	Usuario Organizador4

	Locacion miCasa

	@Before
	def void init() {
		/*------------CREAR Organizadores-------------- */
		juan = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", lugarGenerico, true,
			LocalDateTime.of(1985, 10, 10, 0, 0), 3, new Profesional)
		Organizador1 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		Organizador2 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Amateur)
		Organizador3 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)
		Organizador4 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)

		/*------------CREAR LOCACIONES-------------- */
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 4)
		miCasa = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)

		/*------------CREAR EVENTOS-------------- */
		show1 = new EventoAbierto("show1", complejo1, Organizador3, 5, LocalDateTime.of(2018, 10, 10, 0, 0),
			LocalDateTime.of(2019, 10, 10, 0, 0), LocalDateTime.of(2020, 10, 10, 0, 0))
		show2 = new EventoAbierto("show1", complejo1, Organizador3, 5, LocalDateTime.of(2020, 10, 10, 0, 0),
			LocalDateTime.of(2020, 10, 10, 0, 0), LocalDateTime.of(2020, 10, 10, 0, 0))
		show3 = new EventoAbierto("show1", complejo1, Organizador3, 5, LocalDateTime.of(2020, 10, 10, 0, 0),
			LocalDateTime.of(2020, 10, 10, 0, 0), LocalDateTime.of(2020, 10, 10, 0, 0))
		show4 = new EventoAbierto("show1", complejo1, Organizador3, 5, LocalDateTime.of(2020, 10, 10, 0, 0),
			LocalDateTime.of(2020, 10, 10, 0, 0), LocalDateTime.of(2020, 10, 10, 0, 0))

		juan.comprarEntradaDeEventoAbierto(show1)
		Organizador1.comprarEntradaDeEventoAbierto(show1)
		Organizador2.comprarEntradaDeEventoAbierto(show1)
		Organizador3.comprarEntradaDeEventoAbierto(show1)
		Organizador4.comprarEntradaDeEventoAbierto(show1)

	/*------------INSTANCIAR OBJETOS-------------- */
	}

	@Test
	def void capacidadMaxima() {
		Assert.assertEquals(5, show1.capacidadMaxima, 1)
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

	@Test
	def void hayTiempoParaConfirmar() {
		Assert.assertEquals(true, show1.hayTiempoParaConfirmar())
	}

	@Test
	def void Organizador1IntrntacrearUnEventoAbierto() {
		Organizador1.CrearEventoAbierto("Fiesta", miCasa, Organizador1, 20, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00))
		Assert.assertEquals(0, Organizador1.eventos.size)
	}

	@Test
	def void mensajeParaOrganizador1IntrntacrearUnEventoAbierto() {
		Organizador1.CrearEventoAbierto("Fiesta", miCasa, Organizador1, 20, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00))
		Assert.assertEquals(true, Organizador1.mensajes.contains("NO PODES ORGANIZAR EVENTOS ABIERTOS"))
	}

	@Test
	def void Organizador2crearUnEventoAbierto() {
		Organizador2.CrearEventoAbierto("Fiesta", miCasa, Organizador2, 20, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00))
		Assert.assertEquals(1, Organizador2.eventosAbiertos.size)
	}

	@Test
	def void JuancrearUnEventoAbierto() {
		juan.CrearEventoAbierto("Fiesta", miCasa, juan, 20, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00))
		Assert.assertEquals(
			1,
			juan.eventosAbiertos.size
		)
	}

	@Test
	def void Organizador3crearUnEventoAbierto() {
		Organizador3.CrearEventoAbierto("Fiesta", miCasa, Organizador3, 20, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00))
		Assert.assertEquals(1, Organizador3.eventosAbiertos.size)
	}

	@Test
	def void elEventoSeCancela() {
		show1.cancelarElEvento(juan, show1)
		Assert.assertEquals(true, juan.mensajes.contains("se cancelo el evento"))
	}

	@Test
	def void elEventoSeCancelayDevuelveMontoDeLaEntrada() {
		show1.cancelarElEvento(juan, show1)
		Assert.assertEquals(100.0, juan.plataQueTengo, 0)
	}

}
