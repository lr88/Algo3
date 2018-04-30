package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import java.util.List

class testEventosCerrado {
	Locacion lugarDelEvento1
	Usuario Organizador1
	Usuario Organizador2
	Usuario Organizador3
	EventoCerrado evento1
	EventoCerrado evento2
	Usuario persona1
	Usuario persona2
	Usuario persona3
	Usuario persona4
	Usuario persona5
	Usuario persona6
	List<Usuario> listaDeUsuariosDelTest = newArrayList()

	@Before
	def void init() {

		lugarDelEvento1 = new Locacion() => [
			ubicacion = new Point(1.0, 2.0)
			superficieM2 = 5
		]
		persona1 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		persona2 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		persona3 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		persona4 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		persona5 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		persona6 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]

		listaDeUsuariosDelTest.add(persona1)
		listaDeUsuariosDelTest.add(persona2)
		listaDeUsuariosDelTest.add(persona3)
		listaDeUsuariosDelTest.add(persona4)
		listaDeUsuariosDelTest.add(persona5)
		listaDeUsuariosDelTest.add(persona6)

		Organizador1 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		Organizador2 = new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Amateur
		]
		Organizador3 =new Usuario() => [
			direccion = new Point(1.0, 2.0)
			esAntisocial = false
			plataQueTengo = 100
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			radioDeCercanía = 3
			tipoDeUsuario = new Profesional
		]

		evento1 = new EventoCerrado() =>[
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 7, 26, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 7, 30, 0, 0)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2018, 7, 12, 0, 0)
			locacion = lugarDelEvento1
		]
	
		evento2 = new EventoCerrado() =>[
			fechaDeInicioDelEvento = LocalDateTime.of(2018, 7, 26, 20, 0)
			fechaDeFinDelEvento = LocalDateTime.of(2018, 7, 30, 0, 0)
			fechaMaximaDeConfirmacion = LocalDateTime.of(2018, 7, 12, 0, 0)
			locacion = lugarDelEvento1
		]
			
		persona1.agregarAmigo(persona2)
		persona1.agregarAmigo(persona3)

		Organizador3.crearEventoCerrado(evento1)
		Organizador2.crearEventoCerrado(evento2)

		Organizador3.invitarAUnUsuario(persona1, 5, evento1)
		Organizador3.invitarAUnUsuario(persona2, 5, evento1)
		Organizador3.invitarAUnUsuario(persona3, 5, evento1)
		Organizador3.invitarAUnUsuario(persona4, 5, evento1)
		Organizador3.invitarAUnUsuario(persona5, 5, evento1)
		Organizador3.invitarAUnUsuario(persona6, 5, evento1)

		Organizador1.invitarAUnUsuario(persona1, 5, evento2)

		persona1.agregarAmigo(persona2)
		persona1.agregarAmigo(persona3)

	}

	@Test
	def void  alQuererAceptarUnaInvitacionQueSuperaLaCantidadPermitidaDeAcompañantesEstaNoSepermiteAceptar() {
		persona1.aceptarInvitacion(persona1.listaDeTodosMisInvitacionesPendientes.get(0),25)
		Assert.assertEquals(0,persona1.listaDeTodosMisInvitacionesAceptadas.size,0)
	}

	@Test
	def void EsExitoso() {
		listaDeUsuariosDelTest.forEach[usuario|usuario.listaDeTodosMisInvitacionesPendientes.forEach[inv | usuario.aceptarInvitacion(inv,3)]]
		Assert.assertTrue(evento1.esExitoso)
	}

	@Test
	def void fueUnFracaso() {
		listaDeUsuariosDelTest.forEach[usuario|usuario.listaDeTodosMisInvitacionesPendientes.forEach[inv | usuario.rechazarInvitacion(inv)]]
		Assert.assertTrue(evento1.esUnFracaso)
	}

	@Test
	def void pasoLaFechaDeConfirmacion() {
		evento1.cambiarFecha(LocalDateTime.of(2004, 10, 10, 00, 00))
		Organizador1.invitarAUnUsuario(persona2, 5, evento2)
		Assert.assertEquals(2, persona2.listaDeTodosMisInvitacionesPendientes.size, 0)
		Assert.assertEquals(0, evento1.cantidadDeInvitacionesAceptadas, 0)
	}

	@Test
	def void fechaDeConfirmacion() {
		Assert.assertEquals(LocalDateTime.of(2020, 6, 10, 5, 00), evento1.fechaMaximaDeConfirmacion)
	}

	@Test
	def void Organizador1crearUnEventoCerrado() {
		Organizador1.crearEventoCerrado(evento1)
		Assert.assertEquals(1, Organizador1.eventos.size)
	}

	@Test
	def void Organizador2crearUnEventosCerrado() {
		Organizador2.crearEventoCerrado(evento2)
		Assert.assertEquals(1, Organizador2.eventos.size)
	}

	@Test
	def void Organizador3crearDosEventosCerrado() {
		Assert.assertEquals(1, Organizador3.eventos.size)
	}

	@Test
	def void listaDeTodosMisEventos() {
		Assert.assertEquals(2, Organizador3.eventos.size)
	}

	@Test
	def void cantidadDeTodasLasInvitacionesDeUnEveto() {
		Assert.assertEquals(6, evento1.invitaciones.size)
	}

	@Test
	def void listaDeTodasLasInvitacionesDeUnUsuario() {
		Assert.assertEquals(2, persona1.invitaciones.size)
	}

	@Test
	def void aceptacionMasiva() {
		persona1.aceptacionMasiva
		Assert.assertEquals(0, persona1.listaDeTodosMisInvitacionesAceptadas.size)
		Assert.assertEquals(0, persona1.listaDeTodosMisInvitacionesRechazadas.size)
		Assert.assertEquals(2, persona1.listaDeTodosMisInvitacionesPendientes.size)
	}

	@Test
	def void rechazoMasivo() {
		persona1.rechazoMasivo
		Assert.assertEquals(2, persona1.listaDeTodosMisInvitacionesAceptadas.size)
		Assert.assertEquals(0, persona1.listaDeTodosMisInvitacionesRechazadas.size)
		Assert.assertEquals(0, persona1.listaDeTodosMisInvitacionesPendientes.size)
	}
}