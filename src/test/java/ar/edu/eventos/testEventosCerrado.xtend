package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosCerrado {
	Locacion complejo1
	Usuario carlos
	Usuario pedro
	Usuario lucas
	Usuario juan
	Usuario Organizador0
	Usuario Organizador1
	Usuario Organizador2
	Usuario Organizador3
	Locacion miCasa
	EventoCerrado fiestapepe

	@Before
	def void init() {
		/*------------CREAR Organizadores-------------- */
		Organizador1 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		Organizador2 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Amateur)
		Organizador3 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)
		carlos = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		pedro = new Usuario("CPA", "Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(2005, 01, 10, 0, 0), 3, new Profesional)
		lucas = new Usuario("CD", "lucas", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(2005, 10, 10, 0, 0), 3, new Free)
		juan = new Usuario("CD", "juan", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), true,
			LocalDateTime.of(2005, 10, 10, 0, 0), 3, new Free)

		/*------------CREAR LOCACIONES-------------- */
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)
		miCasa = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)

		/*------------INSTANCIAR OBJETOS-------------- */
		fiestapepe = new EventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador0,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 10, 5, 00),
			LocalDateTime.of(2020, 6, 10, 5, 00))
		pedro.agregarAmigo(carlos)
		pedro.agregarAmigo(lucas)
		pedro.agregarAmigo(lucas)
		pedro.eliminarAmigos(lucas)

	}

	@Test
	def void Organizador1crearUnEventoCerrado() {
		Organizador1.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador1,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 10, 5, 00),
			LocalDateTime.of(2020, 6, 10, 5, 00))

		Assert.assertEquals(1, Organizador1.eventosCerrados.size)
	}

	@Test
	def void Organizador2crearUnEventoCerrado() {
		Organizador2.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador2,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 10, 5, 00),
			LocalDateTime.of(2020, 6, 10, 5, 00))
		Assert.assertEquals(1, Organizador2.eventosCerrados.size)
	}

	@Test
	def void Organizador3crearUnEventoCerrado() {
		Organizador3.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))
		Assert.assertEquals(1, Organizador3.eventosCerrados.size)
	}

	@Test
	def void LosprimerosAmigosAceptanLasInvitaciones() {
		var int cantidad
		Organizador3.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))
		Organizador3.eventosCerrados.filter(evento|evento.nombre == "Fiesta de Flor y leo").get(0).
			invitarAUnUsuario(pedro, 3)

		var EventoCerrado eve1 = Organizador3.eventosCerrados.filter(evento|evento.nombre == "Fiesta de Flor y leo").
			get(0)
		var Invitacion inv1 = eve1.invitaciones.get(0)
		inv1.cuantosSomos()
		cantidad = inv1.cantidadConfirmada
		Assert.assertEquals(3, cantidad)

	}

	@Test
	def void TodosLosAmigosAceptanLasInvitaciones() {
		Organizador3.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))
		Organizador3.eventosCerrados.filter(evento|evento.nombre == "Fiesta de Flor y leo").get(0).
			invitarAUnUsuario(pedro, 3)
		Organizador3.eventosCerrados.filter(evento|evento.nombre == "Fiesta de Flor y leo").get(0).
			invitarAUnUsuario(carlos, 3)
		var EventoCerrado eve1 = Organizador3.eventosCerrados.filter(evento|evento.nombre == "Fiesta de Flor y leo").
			get(0)

		Assert.assertEquals(4, eve1.cuantosAvamos)
	}
}
