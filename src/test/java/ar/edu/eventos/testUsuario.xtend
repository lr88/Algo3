package ar.edu.eventos

import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

import java.time.LocalDateTime
import java.awt.color.ProfileDataException

class testUsuario {
	LocalDateTime fechaActual = LocalDateTime.now()
	Usuario carlos
	Usuario pedro
	Usuario lucas

	Point lugarGenerico = new Point(20, 2.0)
	Locacion miCasa
	Locacion complejo1
	Evento casamiento
	Evento casamiento1
	Evento casamiento2
	Evento casamiento3
	Usuario juan

	@Before
	def void init() {

		/*------------CREAR Usuarios-------------- */
		carlos = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		pedro = new Usuario("CPA", "Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(2005, 01, 10, 0, 0), 3, new Profesional)
		lucas = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(2005, 10, 10, 0, 0), 3, new Free)
		pedro.agregarAmigo(carlos)
		pedro.agregarAmigo(lucas)
		pedro.agregarAmigo(lucas)
		pedro.eliminarAmigos(lucas)

		juan = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", lugarGenerico, true,
			LocalDateTime.of(2005, 10, 10, 0, 0), 3, new Free)

		/*------------CREAR LOCACIONES-------------- */
		miCasa = new Locacion(new Point(1.0, 2.0), "Mi Casa", 800)
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 2000)

		/*------------CREAR EVENTOS-------------- */
				
		casamiento = new Evento("Casaminto de Flor y leo", miCasa, juan, LocalDateTime.of(2007, 10, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento1 = new Evento("Casaminto de Flor y leo", miCasa, juan, LocalDateTime.of(2007, 8, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento2 = new Evento("Casaminto de Flor y leo", miCasa, juan, LocalDateTime.of(2007, 8, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento3 = new Evento("Casaminto de Flor y leo", miCasa, juan, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		pedro.CrearEventoAbierto("Fiesta", miCasa, pedro, 20, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00))
		/*------------INSTANCIAR OBJETOS-------------- */
		juan.agregarEvento(casamiento)
		juan.agregarEvento(casamiento1)
		juan.agregarEvento(casamiento2)
		juan.agregarEvento(casamiento3)







	}

	@Test
	def void noEsSocial() {
		Assert.assertEquals(false, carlos.esAntisocial)
	}

	@Test
	def void EsSocial() {
		Assert.assertEquals(false, pedro.esAntisocial)
	}

	@Test
	def void cantidadDeAmigos() {
		Assert.assertEquals(2, pedro.cantidadDeAmigos, 0)
	}

	@Test
	def void contenesALucas() {
		Assert.assertEquals(true, pedro.amigos.contains(lucas))
	}

	@Test
	def void soyMenor() {
		Assert.assertEquals(true, pedro.soyMenorDeEdad(fechaActual))
	}

	@Test
	def void juanNoOrganizaMasDeTresEventosElMismoMes() {
		Assert.assertEquals(true, juan.puedoOrganizarUnEventoEsteMes(LocalDateTime.of(2007, 8, 10, 5, 00), 3))

	}

	@Test
	def void EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez() {
		pedro.eventos.get(0).terminarEvento
		Assert.assertEquals(true,
			pedro.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime.of(2007, 8, 10, 6, 00), 1))
	}

	@Test
	def void PedroTieneUnEventoFinalizado() {
		pedro.agregarEvento(casamiento)
		casamiento.terminarEvento
		Assert.assertEquals(1, pedro.eventos.filter[evento|evento.estadoDelEvento == false].size)
	}

	@Test
	def void PedroCambiaElTipoDeUsuario() {
		pedro.cambiarTipoDeUsuario(new Free)
		//print(pedro.eventos)
		pedro.cancelarEvento(pedro)
		Assert.assertEquals(true, pedro.mensajes.contains("NO PODES CANCELAR UN EVENTOS "))
	}
}
