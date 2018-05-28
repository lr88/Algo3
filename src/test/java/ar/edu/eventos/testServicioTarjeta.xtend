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
import ar.edu.eventos.exceptions.BusinessException

class testServicioTarjeta {

	Usuario usuario1
	Locacion lugarDelEvento1
	EventoAbierto eventoAbierto1
	Entrada entrada1
	CCResponse EsperadoCCR0
	CCResponse EsperadoCCR1
	CCResponse EsperadoCCR2
	Tarjeta tarjeta

	@Before
	def void init() {

		tarjeta = new Tarjeta => [
			card = new CreditCardService
			datos = new CreditCard
		]
		EsperadoCCR0 = new CCResponse() => [
			statusCode = 0
			statusMessage = "Transacción exitosa"
		]
		EsperadoCCR1 = new CCResponse() => [
			statusCode = 1
			statusMessage = "Datos inválidos"
		]
		EsperadoCCR2 = new CCResponse() => [
			statusCode = 2
			statusMessage = "Pago rechazado"
		]

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
		val CCS = mock(typeof(CreditCardService))
		tarjeta.card = CCS
		
	}

	@Test
	def void compraUnaEntadaYElServidorIndicaTransacciónExitosa() {
		when(tarjeta.card.pay(tarjeta.datos, entrada1.valorDeLaEntrada)).thenReturn(EsperadoCCR0)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(900, usuario1.plataQueTengo, 0)
	}

	@Test(expected=typeof(BusinessException))
	def void compraUnaEntadaYElServidorIndicaDatosInválidos() {
		when(tarjeta.card.pay(tarjeta.datos, entrada1.valorDeLaEntrada)).thenReturn(EsperadoCCR1)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(900, usuario1.plataQueTengo, 0)
	}

	@Test(expected=typeof(BusinessException))
	def void compraUnaEntadaYElServidorIndicaPagoRechazado() {
		when(tarjeta.card.pay(tarjeta.datos, entrada1.valorDeLaEntrada)).thenReturn(EsperadoCCR2)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(900, usuario1.plataQueTengo, 0)
	}
	
}
