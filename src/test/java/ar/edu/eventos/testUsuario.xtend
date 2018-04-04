package ar.edu.eventos

import org.junit.Assert
import org.junit.Test
import org.junit.Before
import org.uqbar.geodds.Point
import java.time.LocalDate


class testUsuario {
	LocalDate fechaActual = LocalDate.now()
	Usuario carlos
	Usuario pedro
	Usuario lucas 

	@Before
	def void init() {
		carlos = new Usuario("CP","Carlos", "Perez", "carlosperez@gmail.com", new Point(1.0, 2.0), false,LocalDate.of(1990, 10, 10),3)
		pedro = new Usuario("CPA","Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,LocalDate.of(2005, 01, 10),3)
		lucas = new Usuario("CD","Pedro", "Perez", "pedroPerez@gmail.com", new Point(1.0, 2.0), false,LocalDate.of(2005, 10, 10),3)
		pedro.agregarAmigo(carlos)
		pedro.agregarAmigo(lucas)
		pedro.agregarAmigo(lucas)
		pedro.eliminarAmigos(lucas)
	}

	@Test
	def void noEsSocial() {
		Assert.assertEquals(false, carlos.esAntisocial())
	}

	@Test
	def void EsSocial() {
		Assert.assertEquals(true, pedro.esAntisocial())
	}
	
	@Test
	def void cantidadDeAmigos() {
		Assert.assertEquals(2,pedro.cantidadDeAmigos,0)
	}

	@Test
	def void contenesALucas() {
		Assert.assertEquals(true, pedro.amigos().contains(lucas))
	}

	@Test
	def void edad() {
		Assert.assertEquals(13, pedro.edad(fechaActual),0)
	}

}
