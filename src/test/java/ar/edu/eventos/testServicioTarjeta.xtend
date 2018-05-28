package ar.edu.eventos

import org.junit.Before
import org.junit.Assert
import org.junit.Test
import java.time.LocalDateTime
import org.uqbar.geodds.Point
import org.uqbar.ccService.CCResponse
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard
import static org.mockito.Mockito.*

class testServicioTarjeta {

	Usuario usuario1
	Locacion lugarDelEvento1
	EventoAbierto eventoAbierto1
	Entrada entrada1
	CCResponse EsperadoCCR
	Tarjeta tjta
	Tarjeta tarjeta

	@Before
	def void init() {

		EsperadoCCR = new CCResponse() => [
			statusCode = 0
			statusMessage = "Transacción exitosa"
		]
		
		tarjeta = mock(typeof(Tarjeta))
		when(tarjeta.code()).thenReturn(EsperadoCCR)
		
		usuario1 = new Usuario() => [
			esAntisocial = false
			plataQueTengo = 1000
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			moneda = tarjeta
		]

		lugarDelEvento1 = new Locacion() => [
			ubicacion = new Point(1.0, 2.0)
			superficieM2 = 5
		]

		eventoAbierto1 = new EventoAbierto() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 7, 26, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 7, 30, 0, 0)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2018, 7, 12, 0, 0)
			locacion = lugarDelEvento1
			edadMinima = 18
		]

		entrada1 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]

	}

	@Test
	def void compraUnaEntasdasdrada() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(1, usuario1.plataQueTengo, 0)
	}
}
