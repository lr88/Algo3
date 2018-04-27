package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point
import java.util.List

class testEventosCerrado {

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

	Locacion miCasa

	@Before
	def void init() {

		/*miCasa = new Locacion(new Point(10, 10), "Complejo1", 3)*/

		persona1 = new Usuario() =>{
			
		}
		persona2 = new Usuario()
		persona3 = new Usuario()
		persona4 = new Usuario()
		persona5 = new Usuario()
		/*persona6 = new Usuario("persona6", "S", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)*/

		listaDeUsuariosDelTest.add(persona1)
		listaDeUsuariosDelTest.add(persona2)
		listaDeUsuariosDelTest.add(persona3)
		listaDeUsuariosDelTest.add(persona4)
		listaDeUsuariosDelTest.add(persona5)
		listaDeUsuariosDelTest.add(persona6)

		/*Organizador1 = new Usuario("Organizador1", "W", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		Organizador2 = new Usuario("Organizador2", "W", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), true,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Amateur)
		Organizador3 = new Usuario("Organizador3", "W", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)
*/
		/*Organizador3.crearEventoCerrado("Fiesta de pedro y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))

		Organizador3.CrearEventoAbierto("Fiesta de pedro y leo", miCasa, Organizador3, 20,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))

		Organizador1.crearEventoCerrado("Fiesta de pedro y leo", miCasa, 20, Organizador1,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))
*/
		persona1.agregarAmigo(persona2)
		persona1.agregarAmigo(persona3)

		evento1 = Organizador3.eventosCerrados.get(0)
		evento2 = Organizador1.eventosCerrados.get(0)

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
		listaDeUsuariosDelTest.forEach[usuario|usuario.aceptarTodasLasInvitaciones(3)]
		Assert.assertTrue(evento1.esExitoso)
	}

	@Test
	def void fueUnFracaso() {
		listaDeUsuariosDelTest.forEach[usuario|usuario.rechazarTodasLasInvitaciones]
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
	def void capacidadMazimaEventoAbierto() {
		Assert.assertEquals(20, evento1.capacidadMaxima, 0)
	}

	@Test
	def void fechaDeConfirmacion() {
		Assert.assertEquals(LocalDateTime.of(2020, 6, 10, 5, 00), evento1.fechaMaximaDeConfirmacion)
	}

	@Test
	def void Organizador1crearUnEventoCerrado() {
		Organizador1.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador1,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 10, 5, 00),
			LocalDateTime.of(2020, 6, 10, 5, 00))
		Assert.assertEquals(1, Organizador1.eventos.size)
	}

	@Test
	def void Organizador2crearUnEventosCerrado() {
		Organizador2.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador2,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 10, 5, 00),
			LocalDateTime.of(2020, 6, 10, 5, 00))
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

	@Test
	def listaDeTodasLasInvitacionesDeUnEveto() {
		persona2.invitaciones.forEach[inv|persona2.aceptarInvitacion(inv, 2)]
		persona3.invitaciones.forEach[inv|persona3.aceptarInvitacion(inv, 2)]
		Assert.assertEquals(1, 1)
	}

}