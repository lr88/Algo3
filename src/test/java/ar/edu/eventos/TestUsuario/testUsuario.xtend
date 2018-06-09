package ar.edu.eventos.TestUsuario

import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.EventoCerrado
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Usuario.Amateur
import ar.edu.eventos.Usuario.Free
import ar.edu.eventos.Usuario.Profesional
import ar.edu.eventos.Usuario.Usuario
import ar.edu.eventos.exceptions.BusinessException
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testUsuario {
	Usuario carlos
	Usuario pedro
	Usuario lucas
	Usuario juan
	Locacion lugar1
	Locacion miCasa
	Locacion complejo1
	EventoCerrado casamiento
	EventoCerrado casamiento1
	EventoCerrado casamiento2
	EventoAbierto casamiento3

	@Before
	def void init() {

		lugar1 = new Locacion() => [
			nombreDeLaLocacion = "asd"
			ubicacion = new Point(4.0, 2.0)
			validar()
		]

		carlos = new Usuario() => [
			nombreDeUsuario = "cp"
			email = "carlos@carlos.com"
			nombre = "carlos"
			apellido = "perez"
			direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		pedro = new Usuario() => [
			nombre= "pedro"
			direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 01, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
		]
		lucas = new Usuario() => [
			direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Amateur
		]
		juan = new Usuario() => [
			nombre="juan"
			direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
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
			nombre = "juanylore"
			locacion = miCasa
			cantidadMaximaDeInvitados = 3
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 9, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 10, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 8, 5, 00)
		]
		casamiento1 = new EventoCerrado() => [
			nombre = "pepeymoni"
			locacion = miCasa
			cantidadMaximaDeInvitados = 3
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 9, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 10, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 8, 5, 00)
		]
		casamiento2 = new EventoCerrado() => [
			nombre = "leoyflor"
			locacion = miCasa
			cantidadMaximaDeInvitados = 3
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 9, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 10, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 8, 5, 00)
		]
		casamiento3 = new EventoAbierto() => [
			nombre = "asdasd"
			locacion = miCasa
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 9, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 10, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 8, 5, 00)
		]

		juan.crearEventoCerrado(casamiento)
		juan.crearEventoCerrado(casamiento1)
		juan.crearEventoCerrado(casamiento2)

		pedro.crearEventoAbierto(casamiento3)
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
		Assert.assertEquals(3, juan.eventos.size)
	}

	@Test(expected=typeof(BusinessException))
	def void PedroCambiaElTipoDeUsuario() {
		pedro.cambiarTipoDeUsuario(new Free)
		pedro.cancelarEvento(casamiento)
		Assert.assertTrue(pedro.mensajes.contains("NO PODES CANCELAR UN EVENTOS "))
	}

	@Test(expected=typeof(BusinessException))
	def void TipoDeUsuarioCarlosPostergarEvento() {
		carlos.postergarEvento(casamiento3,LocalDateTime.of(2007, 10, 10, 10, 00))
		Assert.assertTrue(casamiento3.fuePostergado)
	}

	@Test(expected=typeof(BusinessException))
	def void TipoDeUsuarioCarlosCancelarElEvento() {
		carlos.cancelarEvento(casamiento3)
		Assert.assertTrue(casamiento3.fueCancelado)
	}

	@Test
	def void TipoDeUsuarioPedro() {
		pedro.postergarEvento(casamiento3,LocalDateTime.of(2007, 10, 10, 10, 00))
		Assert.assertTrue(casamiento3.fuePostergado)
		pedro.cancelarEvento(casamiento3)
		Assert.assertTrue(casamiento3.fueCancelado)
	}

	@Test
	def void TipoDeUsuarioLucas() {
		lucas.postergarEvento(casamiento3,LocalDateTime.of(2007, 10, 10, 10, 00))
		Assert.assertTrue(casamiento3.fuePostergado)
		lucas.cancelarEvento(casamiento3)
		Assert.assertTrue(casamiento3.fueCancelado)
		}
		
	
	
}
