package ar.edu.eventos

import org.junit.Before
import org.junit.Assert
import org.junit.Test
import java.time.LocalDateTime
import org.uqbar.geodds.Point
import static org.mockito.Mockito.*
import org.uqbar.ccService.CCResponse
import org.uqbar.ccService.CreditCardService
import org.uqbar.ccService.CreditCard

class testServicioTarjeta {

	Usuario usuario1
	Locacion lugarDelEvento1
	EventoAbierto eventoAbierto1
	Entrada entrada1
	Entrada entrada2
	Entrada entrada3
	Entrada entrada4
	CCResponse asd
	CreditCardService CCS
	Tarjeta tarjeta1
	
	@Before
	def void init() {

		
		CCS = mock(typeof(CreditCardService))
		tarjeta1 = new Tarjeta =>[
			TCCS = CCS
		]
		
		
		asd = new CCResponse()=> [
			statusCode = 0
			statusMessage = "Transacción exitosa"
		]
		
		
		usuario1 = new Usuario() => [
			esAntisocial = false
			plataQueTengo = 1000
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			moneda = tarjeta1
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
		entrada2 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		entrada3 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		entrada4 = new Entrada(eventoAbierto1) => [
			valorDeLaEntrada = 100
		]
		
	}

//	@Test
//	def void compraUnaEntrada() {
//		var tarjeta1 = mock(typeof(Tarjeta))
//		when(tarjeta1.codigosDeLaTarjeta()).thenReturn(asd)
//		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
//		Assert.assertEquals(1, usuario1.plataQueTengo,0)
//	}
	@Test
	def void compraUnaEntasdasdrada() {
		when(CCS.pay(tarjeta1.TCC,0)).thenReturn(asd)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1)
		Assert.assertEquals(1, usuario1.plataQueTengo,0)
	}
	
//	@Test
//	def void compraDosEntradas() {
//		
//		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1, tarjeta)
//		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2, tarjeta)
//		Assert.assertEquals(2, usuario1.entradas.size)
//	}
	
//	@Test
//	def void cocoestafeliz() {
//		var rerer = mock(typeof(Asd))
//		when(rerer.hola()).thenReturn(coco)
//		print(rerer.hola())
//		Assert.assertEquals(0,0,0)
//	}
	
	
	
//	@Test
//	def void compraDosEntradasYSeLEDescuentaLaPlataCorrespondiente() {
//		
//		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1, tarjeta)
//		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2, tarjeta)
//		Assert.assertEquals(2, usuario1.plataQueTengo,0)
//	}




}
