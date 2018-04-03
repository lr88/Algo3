package ar.edu.eventos

import java.time.LocalDateTime
import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point
import java.time.LocalDate

class testUsuario {
	Usuario carlos
	Usuario pedro
	Usuario lucas 

	@Before
	def void init() {
		carlos = new Usuario("CP","Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,
			LocalDate.of(1990, 10, 10))
		pedro = new Usuario("CPA","Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), true,
			LocalDate.of(2005, 10, 10))
		lucas = new Usuario("CD","Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), true,
			LocalDate.of(2005, 10, 10))
		pedro.agregarAmigo(carlos)
		pedro.agregarAmigo(lucas)
		pedro.agregarAmigo(lucas)
		pedro.eliminarAmigos(lucas)
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
