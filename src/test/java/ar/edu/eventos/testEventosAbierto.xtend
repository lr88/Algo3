package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import java.time.Duration
import ar.edu.eventos.exceptions.BusinessException

class testEventosAbierto {
	Efectivo efectivo
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

	@Before
	def void init() {

		efectivo = new Efectivo

		lugarDelEvento1 = new Locacion() => [
			ubicacion = new Point(1.0, 2.0)
			superficieM2 = 5
		]

		lugar1 = new Locacion() => [
			nombreDeLaLocacion ="asd"
			ubicacion = new Point(1.0, 2.0)
			validar()
		]

		usuario1 = new Usuario() => [
			direccion = lugar1
			esAntisocial = false
			plataQueTengo = 10000
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
		]
		usuario2 = new Usuario() => [
			direccion = lugar1
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
		]
		usuario3 = new Usuario() => [
			direccion = lugar1
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
		]
		eventoAbierto1 = new EventoAbierto() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 7, 26, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 7, 30, 0, 0)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2018, 7, 12, 0, 0)
			locacion = lugarDelEvento1
			edadMinima = 18
		]

		eventoAbierto2 = new EventoAbierto() => [
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 2, 27, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 2, 27, 23, 0)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2018, 2, 27, 0, 0)
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

	}

	@Test
	def void compraUnaEntrada() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1,efectivo)
		Assert.assertEquals(1, usuario1.entradas.size)
	}

	@Test
	def void capacidadMAxima() {
		Assert.assertEquals(6, eventoAbierto1.capacidadMaxima, 1)
	}

	@Test
	def void EsExitoso() {
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada1,efectivo)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2,efectivo)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada3,efectivo)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada4,efectivo)
		usuario1.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada5,efectivo)
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada6,efectivo)
		Assert.assertTrue(eventoAbierto1.esExitoso)
	}

	@Test
	def void fueUnFracaso() {
		Assert.assertTrue(eventoAbierto1.esUnFracaso)
	}

	@Test
	def void fechaDeConfirmacion() {
		Assert.assertEquals(LocalDateTime.of(2018, 7, 12, 0, 0), eventoAbierto1.fechaMaximaDeConfirmacion)
	}

	@Test(expected = typeof(BusinessException))
	def void pasoLaFechaDeConfirmacion(){
		eventoAbierto1.cambiarFecha(LocalDateTime.of(2004, 10, 10, 00, 00))
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2,efectivo)
	}

	@Test
	def void capacidadMaximaEventoAbierto() {
		Assert.assertEquals(6.25, eventoAbierto1.capacidadMaxima, 0)
	}

	@Test
	def void UnUsuarioCompraUnaEnradaYAlCancelarseElEventoElUsuarioRecibeLaNotificacionSeCanceloElEvento() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2,efectivo)
		usuario1.cancelarEvento(eventoAbierto1)
		Assert.assertTrue(usuario2.mensajes.contains("se cancelo el evento\n"))
	}

	@Test
	def void UnUsuarioCreaUnEventoYLoPosterga() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada6,efectivo)
		usuario1.postergarEvento(eventoAbierto1, LocalDateTime.of(2018, 10, 11, 0, 0))
		Assert.assertTrue(usuario2.mensajes.contains("se postergo el evento\n"))
	}

	@Test
	def void CuandoSeDevuelveLaEntradaDeUnEventoPostergadoSeReciveElValorTotalDeLaEntrada() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada2,efectivo)
		usuario1.postergarEvento(eventoAbierto1, LocalDateTime.of(2020, 10, 11, 0, 0))
		usuario2.devolverEntrada(entrada2, eventoAbierto1)
		Assert.assertTrue(usuario2.mensajes.contains("se postergo el evento\n"))
		Assert.assertEquals(100, usuario2.plataQueTengo, 0)
	}

	@Test
	def void CuandoSeDevuelveLaEntradaDeUnEventoSeRecibeunPorcentajedeLaEntrada() {
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto1, entrada6,efectivo)
		usuario2.devolverEntrada(entrada6, eventoAbierto1)
		Assert.assertEquals(80, usuario2.plataQueTengo, 0)
	}

	@Test //
	def void CuandoSeDevuelveLaEntradaDeUnEvento10diasantesAlEventoSeReciveunPorsentajedeLaEntrada() {
		var aux = Duration.between(LocalDateTime.of(2018, 5, 1, 0, 0), LocalDateTime.of(2018, 5, 10, 0, 2))
		eventoAbierto2.cambiarFecha(LocalDateTime.now.plus(aux))
		eventoAbierto2.fuePostergado = false
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto2, entrada8,efectivo)
		usuario2.devolverEntrada(entrada8, eventoAbierto2)
		Assert.assertEquals(80, usuario2.plataQueTengo,0.1)
	}

//----------------------------
	@Test 
	def void CuandoSeDevuelveLaEntradaDeUnEventoElDiaAnteriorAlEventoSeReciveunPorsentajedeLaEntrada() {
		var aux = Duration.between(LocalDateTime.of(2018, 5, 1, 0, 0),  LocalDateTime.of(2018, 5, 2, 0, 2))
		eventoAbierto2.cambiarFecha(LocalDateTime.now.plus(aux))
		eventoAbierto2.fuePostergado = false
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto2, entrada8,efectivo)
		usuario2.devolverEntrada(entrada8, eventoAbierto2)
		Assert.assertEquals(20, usuario2.plataQueTengo,0.1)
	}

	@Test
	def void CuandoSeDevuelveLaEntradaDeUnEvento3diasantesAlEventoSeRecibeunPorcentajedeLaEntrada() {
		var aux = Duration.between(LocalDateTime.of(2018, 5, 1, 0, 0), LocalDateTime.of(2018, 5, 4, 0, 2))
		eventoAbierto2.cambiarFecha(LocalDateTime.now.plus(aux))
		eventoAbierto2.fuePostergado = false
		usuario2.comprarEntradaDeEventoAbierto(eventoAbierto2, entrada8,efectivo)
		usuario2.devolverEntrada(entrada8, eventoAbierto2)
		Assert.assertEquals(40, usuario2.plataQueTengo,0.1)
	}
}
