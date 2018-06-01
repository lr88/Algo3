package ar.edu.eventos.TestUsuario

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
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.Entrada
import ar.edu.eventos.Usuario.Usuario
import ar.edu.eventos.Usuario.Tarjeta
import ar.edu.eventos.Usuario.Profesional

class testServicioTarjeta {

	Usuario usuario1
	Locacion lugarDelEvento1
	EventoAbierto eventoAbierto1
	Entrada entrada1
	CCResponse EsperadoCCR0
	CCResponse EsperadoCCR1
	CCResponse EsperadoCCR2
	Tarjeta tarjeta1
	CreditCard creditcard1

	CCResponse ccResponse
	CreditCard creditCard
	CreditCardService creditCardService

	@Before
	def void init() {

		ccResponse = new CCResponse

		creditCard = new CreditCard => [
			name = "Adrian Lopez"
			number = "123456789"
			cvc = "123465123"
			expirationDate =  "12"

		]
		
		creditCardService = new CreditCardService

		creditcard1 = new CreditCard => [
			name = "pepe"
			number = "12345"
			cvc = "999"
			expirationDate = "16-12-2017"
		]
		
		tarjeta1 = new Tarjeta => [
			card = new CreditCardService
			datos = new CreditCard
		]
		
		tarjeta1.card = mock(typeof(CreditCardService))
		
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
			tarjeta = tarjeta1
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
	def void compraUnaEntadaYElServidorIndicaTransacciónExitosa() {
		when(tarjeta1.card.pay(tarjeta1.datos, entrada1.valorDeLaEntrada)).thenReturn(EsperadoCCR0)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(1000, usuario1.plataQueTengo, 0)
	}

	@Test(expected=typeof(BusinessException))
	def void compraUnaEntadaYElServidorIndicaDatosInválidos() {
		when(tarjeta1.card.pay(tarjeta1.datos, entrada1.valorDeLaEntrada)).thenReturn(EsperadoCCR1)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(900, usuario1.plataQueTengo, 0)
	}

	@Test(expected=typeof(BusinessException))
	def void compraUnaEntadaYElServidorIndicaPagoRechazado() {
		when(tarjeta1.card.pay(tarjeta1.datos, entrada1.valorDeLaEntrada)).thenReturn(EsperadoCCR2)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(900, usuario1.plataQueTengo, 0)
	}

	@Test
	def void seMockealaRespuestadelCreditCardNombre() {
		Assert.assertEquals("pepe", creditcard1.name)
		var creditcard1 = mock(typeof(CreditCard))
		when(creditcard1.name).thenReturn("Perdro")
		Assert.assertEquals("Perdro", creditcard1.name)
	}

	@Test
	def void seMockealaRespuestadelCreditCardNumer() {
		Assert.assertEquals("12345", creditcard1.number)
		var creditcard1 = mock(typeof(CreditCard))
		when(creditcard1.number).thenReturn("111")
		Assert.assertEquals("111", creditcard1.number)
	}

	@Test
	def void seMockealaRespuestadelCreditCardCVC() {
		Assert.assertEquals("999", creditcard1.cvc)
		var creditcard1 = mock(typeof(CreditCard))
		when(creditcard1.cvc).thenReturn("919191919")
		Assert.assertEquals("919191919", creditcard1.cvc)
	}

	@Test
	def void seMockealaRespuestadelCreditCardExpirationDate() {
		Assert.assertEquals("16-12-2017", creditcard1.expirationDate)
		var creditcard1 = mock(typeof(CreditCard))
		when(creditcard1.expirationDate).thenReturn("03-07-2017")
		Assert.assertEquals("03-07-2017", creditcard1.expirationDate)
	}
}
