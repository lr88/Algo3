package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.uqbar.geodds.Point

class testEventosCerrado {
	Locacion complejo1

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
		/*------------CREAR LOCACIONES-------------- */
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)
		miCasa = new Locacion(new Point(1.0, 2.0), "Complejo1", 3)

		/*------------INSTANCIAR OBJETOS-------------- */
		fiestapepe = new EventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador0,
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00))

		

	}

	@Test
	def void Organizador1crearUnEventoCerrado() {
		Organizador1.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador1,
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00))

		Assert.assertEquals(1, Organizador1.eventos.size)
	}

	@Test
	def void Organizador2crearUnEventoCerrado() {
		Organizador2.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador2,
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00))
		Assert.assertEquals(1, Organizador2.eventos.size)
	}

	@Test
	def void Organizador3crearUnEventoCerrado() {
		Organizador3.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00))
		Organizador3.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00))
		Organizador3.crearEventoCerrado("Fiesta de Flor y leo", miCasa, 20, Organizador3,
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00))
		fiestapepe.agregarInvitacion(new Invitacion(Organizador0, 3, fiestapepe))
		print(fiestapepe.invitaciones)
		
		
		Assert.assertEquals(3, Organizador3.eventos.size)
	}

}
