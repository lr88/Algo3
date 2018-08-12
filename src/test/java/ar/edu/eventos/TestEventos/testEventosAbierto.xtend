package ar.edu.eventos.TestEventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import java.time.Duration
import ar.edu.eventos.exceptions.BusinessException
import org.uqbar.ccService.CCResponse
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard
import static org.mockito.Mockito.*
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.Entrada
import ar.edu.eventos.Usuario.Usuario
import ar.edu.eventos.Usuario.Tarjeta
import ar.edu.eventos.Usuario.Profesional

class testEventosAbierto {
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Locacion lugarDelEvento1
	Locacion lugar1
	EventoAbierto eventoAbierto2
	EventoAbierto eventoAbierto1
	Entrada entrada1
	Entrada entrada2
	Entrada entrada3
	Entrada entrada4
	Entrada entrada5
	Entrada entrada6
	Entrada entrada7
	Entrada entrada8
	Tarjeta tarjeta1
	CCResponse EsperadoCCR0

	@Before
	def void init() {

		tarjeta1 = new Tarjeta => [
			ccService = new CreditCardService
			datos = new CreditCard
		]
		EsperadoCCR0 = new CCResponse() => [
			statusCode = 0
			statusMessage = "Transacción exitosa"
		]

		lugarDelEvento1 = new Locacion() => [
			ubicacion = new Point(1.0, 2.0)
			superficieM2 = 5
		]

		lugar1 = new Locacion() => [
			nombreDeLaLocacion = "asd"
			ubicacion = new Point(1.0, 2.0)
			validar()
		]

		usuario1 = new Usuario() => [
			direccion = lugar1
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
			tarjeta = tarjeta1
		]
		usuario2 = new Usuario() => [
			direccion = lugar1
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
			tarjeta = tarjeta1
		]
		usuario3 = new Usuario() => [
			direccion = lugar1
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
			tarjeta = tarjeta1
		]
		eventoAbierto1 = new EventoAbierto() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2050, 7, 26, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2050, 7, 30, 0, 0)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2050, 7, 12, 0, 0)
			locacion = lugarDelEvento1
			edadMinima = 18

		]

		eventoAbierto2 = new EventoAbierto() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2050, 2, 27, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2050, 2, 27, 23, 0)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2050, 2, 27, 0, 0)
			locacion = lugarDelEvento1
			edadMinima = 18
		]

		entrada1 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		entrada2 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		entrada3 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		entrada4 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		entrada5 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		entrada6 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]

		entrada7 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]

		entrada8 = new Entrada(eventoAbierto2) => [
			valorDeLaEntrada = 100
		]

		val CCS = mock(typeof(CreditCardService))
		tarjeta1.ccService = CCS
		when(tarjeta1.getCcService.pay(tarjeta1.datos, entrada1.valorDeLaEntrada)).thenReturn(EsperadoCCR0)
	}

	@Test
	def void compraUnaEntrada() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(1, usuario1.entradas.size)
	}

	@Test
	def void compraUnaEntradaYNoSeLEDescuentaElValorDeLAEntrada() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(1, usuario1.entradas.size)
		Assert.assertEquals(100, usuario1.plataQueTengo, 0)
	}

	@Test
	def void capacidadMAxima() {
		Assert.assertEquals(6, eventoAbierto1.capacidadMaxima, 1)
	}

	@Test
	def void EsExitoso() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada3)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada4)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada5)
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada6)
		Assert.assertTrue(eventoAbierto1.esExitoso)
	}

	@Test
	def void fueUnFracaso() {
		Assert.assertTrue(eventoAbierto1.esUnFracaso)
	}

	@Test
	def void fechaDeConfirmacion() {
		Assert.assertEquals(LocalDateTime.of(2050, 7, 12, 0, 0), eventoAbierto1.fechaMaximaDeConfirmacion)
	}

	@Test(expected=typeof(BusinessException))
	def void pasoLaFechaDeConfirmacion() {
		eventoAbierto1.cambiarFecha(LocalDateTime.of(2004, 10, 10, 00, 00))
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2)
	}

	@Test
	def void capacidadMaximaEventoAbierto() {
		Assert.assertEquals(6.25, eventoAbierto1.capacidadMaxima, 0)
	}

	@Test
	def void UnUsuarioCompraUnaEnradaYAlCancelarseElEventoElUsuarioRecibeLaNotificacionSeCanceloElEvento() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2)
		usuario1.cancelarEvento(eventoAbierto1)
		Assert.assertTrue(usuario2.mensajes.contains("se cancelo el evento\n"))
	}

	@Test
	def void UnUsuarioCreaUnEventoYLoPosterga() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada6)
		usuario1.postergarEvento(eventoAbierto1, LocalDateTime.of(2050, 10, 11, 0, 0))
		Assert.assertTrue(usuario2.mensajes.contains("se postergo el evento\n"))
	}

	@Test
	def void CuandoSeDevuelveLaEntradaDeUnEventoPostergadoSeReciveElValorTotalDeLaEntrada() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2)
		usuario1.postergarEvento(eventoAbierto1, LocalDateTime.of(2020, 10, 11, 0, 0))
		usuario2.devolverEntrada(entrada2, eventoAbierto1)
		Assert.assertTrue(usuario2.mensajes.contains("se postergo el evento\n"))
		Assert.assertEquals(200, usuario2.plataQueTengo, 0)
	}

	@Test
	def void CuandoSeDevuelveLaEntradaDeUnEventoSeRecibeunPorcentajedeLaEntrada() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada6)
		usuario2.devolverEntrada(entrada6, eventoAbierto1)
		Assert.assertEquals(180, usuario2.plataQueTengo, 0)
	}

	@Test //
	def void CuandoSeDevuelveLaEntradaDeUnEvento10diasantesAlEventoSeReciveunPorsentajedeLaEntrada() {
		var aux = Duration.between(LocalDateTime.of(2050, 5, 1, 0, 0), LocalDateTime.of(2050, 5, 10, 0, 2))
		eventoAbierto2.cambiarFecha(LocalDateTime.now.plus(aux))
		eventoAbierto2.fuePostergado = false
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto2, entrada8)
		usuario2.devolverEntrada(entrada8, eventoAbierto2)
		Assert.assertEquals(180, usuario2.plataQueTengo, 0.1)
	}

	@Test
	def void CuandoSeDevuelveLaEntradaDeUnEventoElDiaAnteriorAlEventoSeReciveunPorsentajedeLaEntrada() {
		var aux = Duration.between(LocalDateTime.of(2050, 5, 1, 0, 0), LocalDateTime.of(2050, 5, 2, 0, 2))
		eventoAbierto2.cambiarFecha(LocalDateTime.now.plus(aux))
		eventoAbierto2.fuePostergado = false
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto2, entrada8)
		usuario2.devolverEntrada(entrada8, eventoAbierto2)
		Assert.assertEquals(120, usuario2.plataQueTengo, 0.1)
	}

	@Test
	def void CuandoSeDevuelveLaEntradaDeUnEvento3diasantesAlEventoSeRecibeunPorcentajedeLaEntrada() {
		var aux = Duration.between(LocalDateTime.of(2050, 5, 1, 0, 0), LocalDateTime.of(2050, 5, 4, 0, 2))
		eventoAbierto2.cambiarFecha(LocalDateTime.now.plus(aux))
		eventoAbierto2.fuePostergado = false
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto2, entrada8)
		usuario2.devolverEntrada(entrada8, eventoAbierto2)
		Assert.assertEquals(140, usuario2.plataQueTengo, 0.1)
	}
}
