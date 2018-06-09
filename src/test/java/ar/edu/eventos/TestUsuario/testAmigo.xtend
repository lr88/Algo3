package ar.edu.eventos.TestUsuario

import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Eventos.EventoCerrado
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Observer.AmigoDelCreador
import ar.edu.eventos.Observer.FanDeUnArtista
import ar.edu.eventos.Observer.SuperAmigo
import ar.edu.eventos.Observer.ViveCerca
import ar.edu.eventos.Observer.ViveCercaEventoAbierto
import ar.edu.eventos.Repositorios.RepoUsuario
import ar.edu.eventos.Usuario.Amateur
import ar.edu.eventos.Usuario.Free
import ar.edu.eventos.Usuario.Profesional
import ar.edu.eventos.Usuario.Usuario
import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import org.uqbar.mailService.Mail
import org.uqbar.mailService.MailService

import static org.mockito.Mockito.*

class testAmigo {

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
	RepoUsuario repoUsuario1

	AmigoDelCreador amigoDelCreador
	SuperAmigo superAmigo
	ViveCerca viveCerca
	ViveCercaEventoAbierto viveCercaEventoAbierto
	FanDeUnArtista fanDeUnArtista

	MailService mailService
	Mail mail

	@Before
	def void init() {

		mailService = mock(typeof(MailService))
		mail = mock(typeof(Mail))

		lugar1 = new Locacion() => [
			nombreDeLaLocacion = "asd"
			ubicacion = new Point(10.0, 9.9)
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
			nombre = "pedro"
			direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 01, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 11
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
			nombre = "juan"
			direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 12
			tipoDeUsuario = new Profesional
		]

		repoUsuario1 = new RepoUsuario => [
			elementos.add(carlos)
			elementos.add(pedro)
			elementos.add(lucas)
			elementos.add(juan)
		]

		amigoDelCreador = new AmigoDelCreador(mailService, mail) => [
			repoUsuario = repoUsuario1
		]
		superAmigo = new SuperAmigo(mailService, mail) => [
			repoUsuario = repoUsuario1
		]
		viveCerca = new ViveCerca(mailService, mail) => [
			repoUsuario = repoUsuario1
		]
		viveCercaEventoAbierto = new ViveCercaEventoAbierto(mailService, mail) => [
			repoUsuario = repoUsuario1
		]
		fanDeUnArtista = new FanDeUnArtista(mailService, mail) => [
			repoUsuario = repoUsuario1
		]

		when(amigoDelCreador.returnMailServis).thenReturn("")
		when(superAmigo.returnMailServis).thenReturn("")
		when(viveCerca.returnMailServis).thenReturn("")
		when(viveCercaEventoAbierto.returnMailServis).thenReturn("")
		when(fanDeUnArtista.returnMailServis).thenReturn("")



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
			nombre = "horacioycoca"
			locacion = miCasa
			fechaDeInicioDelEvento = LocalDateTime.of(2007, 10, 9, 5, 00)
			fechaDeFinDelEvento = LocalDateTime.of(2007, 10, 10, 10, 00)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2007, 10, 8, 5, 00)
		]
	}

	@Test
	def void amigoCreaUnEventoYesNotificado() {
		juan.agregarAmigo(pedro)
		juan.agregarAccion(amigoDelCreador)
		juan.crearEventoCerrado(casamiento)
		Assert.assertEquals(1, pedro.mensajes.size)
	}

	@Test
	def void NoEsAmigoCreaUnEventoYnoEsNotificado() {
		juan.agregarAccion(amigoDelCreador)
		juan.crearEventoCerrado(casamiento)
		Assert.assertEquals(0, pedro.mensajes.size)
	}

	@Test
	def void amigosMutuosCreaEventoYseNotifica() {
		juan.agregarAmigo(pedro)
		pedro.agregarAmigo(juan)
		juan.agregarAccion(superAmigo)
		juan.crearEventoCerrado(casamiento2)
		Assert.assertEquals(1, pedro.mensajes.size)
	}

	@Test
	def void vivenCercaDelEventoYseNotifica() {
		juan.agregarAmigo(pedro)
		juan.agregarAccion(viveCerca)
		juan.crearEventoCerrado(casamiento2)
		Assert.assertEquals(1, pedro.mensajes.size)
	}

	@Test
	def void vivenCercaDelEventoAbiertoYseNotifica() {
		juan.agregarAccion(viveCercaEventoAbierto)
		juan.crearEventoAbierto(casamiento3)
		Assert.assertEquals(1, pedro.mensajes.size)
	}
}
