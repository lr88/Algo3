package ar.edu.eventos

import org.junit.Assert
import ar.edu.eventos.exceptions.BusinessException

import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

import java.time.LocalDateTime

class testUsuario {
	Usuario carlos
	Usuario pedro
	Usuario lucas
	Usuario juan
	Point lugarGenerico = new Point(20, 2.0)
	Locacion miCasa
	Locacion complejo1
	Evento casamiento
	Evento casamiento1
	Evento casamiento2
	Evento casamiento3

	@Before
	def void init() {
         
		carlos = new Usuario() => [
			nombreDeUsuario= "cp"
			email="carlos@carlos.com"
			nombre= "carlos"
			apellido = "perez"
			direccion = new Point(1.0, 2.0)
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		pedro = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			fechaDeNacimiento = LocalDateTime.of(2005, 01, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
		]
		lucas = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			fechaDeNacimiento = LocalDateTime.of(2005, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Amateur
		]
		juan = new Usuario() => [
			direccion = lugarGenerico
			fechaDeNacimiento = LocalDateTime.of(2005, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]

		miCasa = new Locacion() => [
			nombreDeLaLocacion = "miCasa"
			ubicacion = new Point(10, 10)
			superficieM2 = 800
		]
		complejo1 = new Locacion() => [
			nombreDeLaLocacion = "complejo1"
			ubicacion = new Point(10, 10)
			superficieM2 = 2000
		]

		casamiento = new EventoCerrado() => [
			locacion = miCasa
			organizador = juan
			cantidadMaximaDeInvitados = 3
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 9, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 10, 5, 00)
		]
		casamiento1 = new EventoCerrado() => [
			locacion = miCasa
			organizador = juan
			cantidadMaximaDeInvitados = 3
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 9, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 10, 5, 00)
		]
		casamiento2 = new EventoCerrado() => [
			locacion = miCasa
			organizador = juan
			cantidadMaximaDeInvitados = 3
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 9, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 10, 5, 00)
		]
		casamiento3 = new EventoAbierto() => [
			locacion = miCasa
			organizador = juan
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 10, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 9, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 10, 5, 00)
		]
		pedro.CrearEventoAbierto(new EventoAbierto())
		pedro.agregarAmigo(carlos)
		pedro.agregarAmigo(lucas)
		pedro.agregarAmigo(juan)
		pedro.eliminarAmigos(juan)
	}

	@Test
	def void noEsSocial() {
	
		Assert.assertFalse(carlos.esAntisocial)
	}

	@Test
	def void EsSocial() {
		Assert.assertFalse(pedro.esAntisocial)
	}

	@Test
	def void cantidadDeAmigos() {
		Assert.assertEquals(2, pedro.cantidadDeAmigos, 0)
	}

	@Test
	def void contenesALucas() {
		Assert.assertTrue(pedro.amigos.contains(lucas))
	}

	@Test
	def void soyMenor() {
		Assert.assertEquals(13, pedro.edad())
	}

	@Test
	def void juanNoOrganizaMasDeTresEventosElMismoMes() {
		Assert.assertEquals(1,juan.cantidadDeEventosEnEsteMes(casamiento))

	}

	@Test
	def void EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez() {
		pedro.eventosAbiertos.get(0).terminoElEvento
		Assert.assertTrue(pedro.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime.of(2007, 8, 10, 6, 00), 1))
	}

	@Test
	def void PedroCambiaElTipoDeUsuario() {
		pedro.cambiarTipoDeUsuario(new Free)
		pedro.cancelarEvento(casamiento)
		Assert.assertTrue(pedro.mensajes.contains("NO PODES CANCELAR UN EVENTOS "))
	}

	
/*
	@Test
	def void TipoDeUsuarioCarlos() {
		Assert.assertEquals(1, carlos.tipoDeUsuario.cantidadMaximaPermitidaDeSimultaneidadDeEventos)
		Assert.assertEquals(50, carlos.tipoDeUsuario.maximoDePersonasPorEvento)
		Assert.assertEquals(3, carlos.tipoDeUsuario.cantidadDeEventosEnEsteMes)
	}

	@Test
	def void TipoDeUsuarioLucas() {
		Assert.assertEquals(5, lucas.tipoDeUsuario.cantidadMaximaPermitidaDeSimultaneidadDeEventos)
		Assert.assertEquals(50, lucas.tipoDeUsuario.maximoDeInvitacionesPorEvento)
	}
 */
}
