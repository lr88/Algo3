package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

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

	Locacion miCasa

	@Before
	def void init() {

		persona1 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), true,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		persona2 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		persona3 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		persona4 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		persona5 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		persona6 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)

		Organizador1 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		Organizador2 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), true,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Amateur)
		Organizador3 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)

		Organizador3.crearEventoCerrado("Fiesta de pedro y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))
		Organizador3.CrearEventoAbierto("Fiesta de pedro y leo", miCasa, Organizador3, 20,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))

		Organizador1.crearEventoCerrado("Fiesta de pedro y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))

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
		
		Organizador1.invitarAUnUsuario(persona1, 5, evento1)
		
		persona1.agregarAmigo(persona2)
		persona1.agregarAmigo(persona3)
		
		
		
		miCasa = new Locacion(new Point(10, 10), "Complejo1", 3)

	}

	@Test
	def void Organizador1crearUnEventoCerrado() {
		Organizador1.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador1,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 10, 5, 00),
			LocalDateTime.of(2020, 6, 10, 5, 00))
		Assert.assertEquals(1, Organizador1.eventosCerrados.size)
	}

	@Test
	def void Organizador2crearUnEventosCerrado() {
		Organizador2.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador2,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 10, 5, 00),
			LocalDateTime.of(2020, 6, 10, 5, 00))
		Assert.assertEquals(1, Organizador2.eventosCerrados.size)
	}

	@Test
	def void Organizador3crearDosEventosCerrado() {
		Assert.assertEquals(1, Organizador3.eventosCerrados.size)
	}

	@Test
	def void listaDeTodosMisEventos() {
		Assert.assertEquals(2, Organizador3.listaDeTodosMisEventos().size)
	}

	@Test
	def void cantidadDeTodasLasInvitacionesDeUnEveto() {
		Assert.assertEquals(7, evento1.invitaciones.size)
	}

	@Test
	def void listaDeTodasLasInvitacionesDeUnUsuario() {
		Assert.assertEquals(2, persona1.miListaDeInvitaciones.size)
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
		persona2.miListaDeInvitaciones.forEach[inv | persona2.aceptarInvitacion(inv,2)]
		persona3.miListaDeInvitaciones.forEach[inv | persona3.aceptarInvitacion(inv,2)]
		Assert.assertEquals(1,1)
	}
	
}
