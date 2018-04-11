package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosAbierto {
	

	@Before
	def void init() {
		/*------------CREAR Organizadores-------------- */
		

		/*------------CREAR LOCACIONES-------------- */
		

		/*------------CREAR EVENTOS-------------- */
		


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

	@Test
	def void postergarEvento() {
		print(show1.inicioDelEvento)
		show1.postergarElEvento(juan, show1, LocalDateTime.of(2019, 11, 10, 5, 00))
		Assert.assertEquals(LocalDateTime.of(2019, 11, 10, 5, 00), show1.inicioDelEvento)
	}

	@Test
	def void choloDevuelveLaEntradaYrecibeUnPorcentaje() {
		cholo4.comprarEntradaDeEventoAbierto(show5)
		cholo4.devolverEntrada(show5.entradas.get(0), show5)
		Assert.assertEquals(80.0, cholo4.plataQueTengo, 0)
	}

}
