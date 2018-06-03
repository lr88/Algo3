package ar.edu.eventos.TestUsuario
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point
import java.time.LocalDateTime
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Eventos.EventoCerrado
import ar.edu.eventos.Eventos.EventoAbierto
import ar.edu.eventos.Usuario.Usuario
import ar.edu.eventos.Usuario.Free
import ar.edu.eventos.Usuario.Profesional
import ar.edu.eventos.Usuario.Amateur
import ar.edu.eventos.Observer.AmigoDelCreador
import ar.edu.eventos.Observer.SuperAmigo
import org.uqbar.mailService.Mail
import static org.mockito.Mockito.*
import ar.edu.eventos.Observer.ViveCerca
import org.uqbar.mailService.MailService

class testAmigo {
	
var mockedMail = mock(typeof(Mail))
var mockedMailService = mock(typeof(MailService))

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
     }
   
   @Test
	def void amigoCreaUnEventoYesNotificado() {
		juan.agregarAmigo(pedro)
		juan.agregarAccion(new AmigoDelCreador("Amigo del creador del evento"))
		juan.crearEventoCerrado(casamiento)
		Assert.assertEquals("el usuario juan ha creado el evento juanylore", pedro.mailsRecibidos.head.mensaje)
	}
	
	@Test
	def void NoEsAmigoCreaUnEventoYnoEsNotificado() {
		juan.agregarAccion(new AmigoDelCreador("Amigo del creador del evento"))
		juan.crearEventoCerrado(casamiento)
		Assert.assertTrue(pedro.mailsRecibidos.head === null)
	}
	
	@Test
	def void amigosMutuosCreaEventoYseNotifica() {
		juan.agregarAmigo(pedro)
		pedro.agregarAmigo(juan)
		juan.agregarAccion(new SuperAmigo("Amigo del creador del evento"))
		juan.crearEventoCerrado(casamiento2)
		Assert.assertEquals("el usuario juan ha creado el evento leoyflor", pedro.mailsRecibidos.head.mensaje)
	}
	
	@Test
	def void vivenCercaDelEventoYseNotifica() {
		juan.agregarAmigo(pedro)
		juan.agregarAccion(new ViveCerca("Viven cerca del evento",mockedMailService))
		juan.crearEventoCerrado(casamiento2)
		Assert.assertEquals("el usuario juan ha creado el evento leoyflor", pedro.mailsRecibidos.head.mensaje)
	}
	
 }