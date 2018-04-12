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

	Usuario persona = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
		LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)

	Usuario persona1 = persona
	Usuario persona2 = persona
	Usuario persona3 = persona
	Usuario persona4 = persona
	Usuario persona5 = persona
	Usuario persona6 = persona

	var EventoCerrado evento1 = Organizador3.eventosCerrados.get(0)

	Locacion miCasa

	@Before
	def void init() {
		Organizador1 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		Organizador2 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Amateur)
		Organizador3 = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Profesional)

		Organizador3.invitarAUnUsuario(persona1, 5, evento1)
		Organizador3.invitarAUnUsuario(persona2, 5, evento1)
		Organizador3.invitarAUnUsuario(persona3, 5, evento1)
		Organizador3.invitarAUnUsuario(persona4, 5, evento1)
		Organizador3.invitarAUnUsuario(persona5, 5, evento1)
		Organizador3.invitarAUnUsuario(persona6, 5, evento1)

		miCasa = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)

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
		Organizador3.crearEventoCerrado("Fiesta de pedro y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))
		Assert.assertEquals(1, Organizador3.eventosCerrados.size)
	}

	@Test
	def void Organizador1crearDosEventosCerrado() {
		Organizador3.crearEventoCerrado("Fiesta de pedro y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2020, 6, 10, 5, 00), LocalDateTime.of(2020, 6, 11, 5, 00),
			LocalDateTime.of(2020, 6, 11, 6, 00))

		Assert.assertEquals(1, Organizador3.eventosCerrados.size)
	}

}
