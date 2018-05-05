package ar.edu.eventos

import org.junit.Before
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert

class testRepoLocacion {
	var RepoLocacion repoLOCA
	var Locacion casa
	var Locacion casa1

	@Before
	def void init() {
		casa = new Locacion => [
			ubicacion = new Point(1.0, 2.0)
			nombreDeLaLocacion = "casa de pepe"
			superficieM2 = 300
		]
		casa1 = new Locacion => [
			ubicacion = new Point(1.0, 2.0)
			nombreDeLaLocacion = "casa de pedro"
			superficieM2 = 300
		]
		repoLOCA = new RepoLocacion
	}

	@Test
	def void SeCreaUnaLocacionYSeAgregaAlRepositorioCumpliendolasValidacionesCorrespondientes() {
		print(1)
		repoLOCA.create(casa)
		Assert.assertEquals(1, repoLOCA.elementos.size)
	}

	@Test
	def void LaLocacionContieneUnID() {
		print(2)
		repoLOCA.create(casa)
		Assert.assertEquals(0, casa.id)
	}

	@Test
	def void LaLocacionCASA1ContieneUnIDDistinto() {
		print(3)
		repoLOCA.create(casa)
		repoLOCA.create(casa1)
		Assert.assertEquals(0, casa.id)
		Assert.assertEquals(1, casa1.id)
	}

}
