package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point

class testUsuario {
	Usuario carlos
	Usuario pedro
	Usuario lucas

	Locacion casaDeCarlos

	@Before
	def void init() {
		casaDeCarlos = new Locacion(new Point(1.0, 2.0), "CasaDeCarlos")
		carlos = new Usuario("Carlos", "Perez", "carlosperez@gmail.com", casaDeCarlos, false,
			LocalDateTime.of(1990, 10, 10, 9, 00))
		pedro = new Usuario("Pedro", "Perez", "pedroPerez@gmail.com", casaDeCarlos, true,
			LocalDateTime.of(2005, 10, 10, 9, 00))
		lucas = new Usuario("Pedro", "Perez", "pedroPerez@gmail.com", casaDeCarlos, true,
			LocalDateTime.of(2005, 10, 10, 9, 00))
		pedro.agregarAmigo(carlos)
		pedro.agregarAmigo(lucas)
	}

	@Test
	def void noEsSocial() {
		Assert.assertEquals(false, carlos.estadoSocial)
	}

	@Test
	def void EsSocial() {
		Assert.assertEquals(true, pedro.estadoSocial)
	}
	
	@Test
	def void cantidadDeAmigos() {
		Assert.assertEquals(2,pedro.cantidadDeAmigos,0)
	}

	@Test
	def void contenesALucas() {
		Assert.assertEquals(true, pedro.amigos().contains(lucas))
	}

}
