package ar.edu.eventos

import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

import java.time.LocalDateTime

class testUsuario {
	LocalDateTime fechaActual = LocalDateTime.now()
	Usuario carlos
	Usuario pedro
	Usuario lucas
	Usuario juan
	Point lugarGenerico = new Point(20, 2.0)
	Locacion miCasa
	Locacion complejo1
	Evento casamiento
	Evento casamiento1
	Evento casamiento2
	Evento casamiento3

	@Before
	def void init() {

		/*------------CREAR Usuarios-------------- */
		carlos = new Usuario("CP", "Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(1990, 10, 10, 0, 0), 3, new Free)
		pedro = new Usuario("CPA", "Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(2005, 01, 10, 0, 0), 3, new Profesional)
		lucas = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,
			LocalDateTime.of(2005, 10, 10, 0, 0), 3, new Amateur)
		juan = new Usuario("CD", "Pedro", "Perez", "pedroPerez@gmail.com", lugarGenerico, true,
			LocalDateTime.of(2005, 10, 10, 0, 0), 3, new Free)

		/*------------CREAR LOCACIONES-------------- */
		miCasa = new Locacion(new Point(1.0, 2.0), "Mi Casa", 800)
		complejo1 = new Locacion(new Point(1.0, 2.0), "Complejo1", 2000)

		/*------------CREAR EVENTOS-------------- */
		casamiento = new EventoCerrado("Casaminto de Flor y leo", miCasa,3, juan,LocalDateTime.of(2007, 10, 10, 5, 00), LocalDateTime.of(2007, 10, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento1 = new EventoCerrado("Casaminto de Flor y leo", miCasa,3, juan,LocalDateTime.of(2007, 10, 10, 5, 00), LocalDateTime.of(2007, 10, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento2 = new EventoCerrado("Casaminto de Flor y leo", miCasa,3, juan,LocalDateTime.of(2007, 10, 10, 5, 00), LocalDateTime.of(2007, 10, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		casamiento3 = new EventoCerrado("Casaminto de Flor y leo", miCasa,3, juan,LocalDateTime.of(2007, 10, 10, 5, 00), LocalDateTime.of(2007, 10, 10, 5, 00),
			LocalDateTime.of(2007, 10, 10, 9, 00))
		pedro.CrearEventoAbierto("Fiesta", miCasa, pedro, 20, LocalDateTime.of(2007, 6, 10, 5, 00),
			LocalDateTime.of(2007, 6, 10, 5, 00), LocalDateTime.of(2007, 6, 10, 5, 00))
		/*------------INSTANCIAR OBJETOS-------------- */
		
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
		Assert.assertTrue( pedro.soyMenorDeEdad(fechaActual))
	}

	@Test
	def void juanNoOrganizaMasDeTresEventosElMismoMes() {
		Assert.assertTrue(juan.puedoOrganizarUnEventoEsteMes(LocalDateTime.of(2007, 8, 10, 5, 00), 3))

	}

	@Test
	def void EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez() {
		pedro.eventosAbiertos.get(0).terminoElEvento
		Assert.assertTrue(
			pedro.EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime.of(2007, 8, 10, 6, 00), 1))
	}

	@Test
	def void PedroCambiaElTipoDeUsuario() {
		pedro.cambiarTipoDeUsuario(new Free)
		pedro.cancelarEvento(casamiento)
		Assert.assertTrue(pedro.mensajes.contains("NO PODES CANCELAR UN EVENTOS "))
	}
	
	@Test
	def void TipoDeUsuarioPedro() {
		Assert.assertEquals(99, pedro.tipoDeUsuario.cantidadMaximaPermitidaDeSimultaneidadDeEventos)
		Assert.assertEquals(99, pedro.tipoDeUsuario.maximoDePersonasPorEvento)
		Assert.assertEquals(20, pedro.tipoDeUsuario.maximoDeEventosMensuales)
		Assert.assertEquals(99, pedro.tipoDeUsuario.maximoDeInvitacionesPorEvento)
	}
	
	@Test
	def void TipoDeUsuarioCarlos() {
		Assert.assertEquals(1, carlos.tipoDeUsuario.cantidadMaximaPermitidaDeSimultaneidadDeEventos)
		Assert.assertEquals(50, carlos.tipoDeUsuario.maximoDePersonasPorEvento)
		Assert.assertEquals(3, carlos.tipoDeUsuario.maximoDeEventosMensuales)
		Assert.assertEquals(99, carlos.tipoDeUsuario.maximoDeInvitacionesPorEvento)
	}
	
	@Test
	def void TipoDeUsuarioLucas() {
		Assert.assertEquals(5, lucas.tipoDeUsuario.cantidadMaximaPermitidaDeSimultaneidadDeEventos)
		Assert.assertEquals(99, lucas.tipoDeUsuario.maximoDePersonasPorEvento)
		Assert.assertEquals(99, lucas.tipoDeUsuario.maximoDeEventosMensuales)
		Assert.assertEquals(50, lucas.tipoDeUsuario.maximoDeInvitacionesPorEvento)
	}

}
