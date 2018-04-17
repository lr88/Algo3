package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosAbierto {

	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Locacion casaUsuario1
	EventoAbierto eventoAbierto1

	@Before
	def void init() {

		casaUsuario1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 5)

		usuario1 = new Usuario("usuario1", "usuario1", "usuario1", "usuario1@usuario1.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)
		usuario2 = new Usuario("usuario2", "usuario2", "usuario2", "usuario2@usuario2.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)
		usuario3 = new Usuario("usuario2", "usuario2", "usuario2", "usuario2@usuario2.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)

		eventoAbierto1 = new EventoAbierto("Mi cumple", casaUsuario1, usuario1, 100,
			LocalDateTime.of(2019, 10, 10, 0, 0), LocalDateTime.of(2020, 10, 11, 0, 0),
			LocalDateTime.of(2020, 10, 12, 0, 0))

	}

	@Test
	def void EsExitoso() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario3.comprarEntradaDeEventoAbierto(eventoAbierto1)
		Assert.assertTrue(eventoAbierto1.esExitoso)
	}

	@Test
	def void fueUnFracaso() {
		print(eventoAbierto1.cantidadDeEntradasVendidas)
		Assert.assertTrue(eventoAbierto1.esUnFracaso)
	}

	@Test
	def void fechaDeConfirmacion() {
		Assert.assertEquals(LocalDateTime.of(2019, 10, 10, 00, 00), eventoAbierto1.fechaMaximaDeConfirmacion)
	}

	@Test
	def void pasoLaFechaDeConfirmacion() {
		eventoAbierto1.cambiarFecha(LocalDateTime.of(2004, 10, 10, 00, 00))
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1)
		Assert.assertTrue(usuario2.mensajes.contains("Paso el tiempo de compra de entradas\n"))
		Assert.assertEquals(0, usuario2.listaDeEntradas.size, 0)
		Assert.assertEquals(0, eventoAbierto1.cantidadDeEntradasVendidas, 0)
	}

	@Test
	def void capacidadMazimaEventoAbierto() {
		Assert.assertEquals(6.25, eventoAbierto1.capacidadMaxima, 0)
	}

	@Test
	def void UnUsuarioCompraUnaEnradaYAlCancelarseElEventoRecibeLaNotificacionSeCanceloElEvento() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1)
		usuario1.cancelarEvento(eventoAbierto1)
		Assert.assertTrue(usuario2.mensajes.contains("se cancelo el evento\n"))
	}

	@Test
	def void UnUsuarioCompraUnaEnradaYElEventoRecibeLaNotificacionSeCanceloElEvento() {

		usuario1.CrearEventoAbierto("Mi cumple", casaUsuario1, usuario1, 100, LocalDateTime.of(2020, 10, 10, 0, 0),
			LocalDateTime.of(2020, 10, 11, 0, 0), LocalDateTime.of(2020, 10, 12, 0, 0))
		usuario2.comprarEntradaDeEventoAbierto(usuario1.eventosAbiertos.get(0))
		usuario1.cancelarEvento(usuario1.eventosAbiertos.get(0))
		Assert.assertTrue(usuario2.mensajes.contains("se cancelo el evento\n"))
	}

	@Test
	def void UnUsuarioCreaUnEventoYLoPosterga() {

		usuario1.CrearEventoAbierto("Mi cumple", casaUsuario1, usuario1, 100, LocalDateTime.of(2020, 10, 10, 0, 0),
			LocalDateTime.of(2020, 10, 11, 0, 0), LocalDateTime.of(2020, 10, 12, 0, 0))
		usuario2.comprarEntradaDeEventoAbierto(usuario1.eventosAbiertos.get(0))
		usuario1.postergarEvento(usuario1.eventosAbiertos.get(0), LocalDateTime.of(2020, 10, 11, 0, 0))
		Assert.assertTrue(usuario2.mensajes.contains("se postergo el evento\n"))
	}

	def void UnUsuarioCreaUnEventoYLoPostergaYelEventocambialafecha() {

		usuario1.CrearEventoAbierto("Mi cumple", casaUsuario1, usuario1, 100, LocalDateTime.of(2020, 10, 10, 0, 0),
			LocalDateTime.of(2020, 10, 11, 0, 0), LocalDateTime.of(2020, 10, 12, 0, 0))
		usuario2.comprarEntradaDeEventoAbierto(usuario1.eventosAbiertos.get(0))
		usuario1.postergarEvento(usuario1.eventosAbiertos.get(0), LocalDateTime.of(2020, 10, 11, 0, 0))
		Assert.assertEquals(LocalDateTime.of(2020, 10, 11, 0, 0),
			usuario1.eventosAbiertos.get(0).fechaDeInicioDelEvento)
	}

}
