package ar.edu.eventos

import org.junit.Before
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import ar.edu.eventos.exceptions.BusinessException

class testRepoLocacion {
	var RepoLocacion repoLOCA
	var Point lugarcasa
	var Locacion casa
	var Locacion casa1
	var Locacion casa2
	var Point lugargenerco = new Point(20.0, 55.0)

	@Before
	def void init() {

		lugarcasa = new Point(1.0, 2.0)

		casa = new Locacion => [
			ubicacion = lugarcasa
			nombreDeLaLocacion = "casa de pepe"
			superficieM2 = 300
		]
		casa1 = new Locacion => [
			ubicacion = lugarcasa
			nombreDeLaLocacion = "casa de pedro"
			superficieM2 = 300
		]
		casa2 = new Locacion => [ // no cumple aproposito con la validacion
			ubicacion = lugarcasa
			superficieM2 = 300
			nombreDeLaLocacion = ""
		]
		repoLOCA = new RepoLocacion
	}

	@Test
	def void SeCreaUnaLocacionYSeAgregaAlRepositorioCumpliendolasValidacionesCorrespondientes() {
		repoLOCA.create(casa)
		Assert.assertEquals(1, repoLOCA.elementos.size)
	}

	@Test
	def void SeCreaUnaLocacionYSeElimina() {
		repoLOCA.create(casa)
		repoLOCA.delete(casa)
		Assert.assertEquals(0, repoLOCA.elementos.size)
	}

	@Test(expected=typeof(BusinessException))
	def void SeCreaUnaLocacionYSeAgregaAlRepositorioIncumpliendolasValidacionesCorrespondientes() {
		repoLOCA.create(casa2)
		Assert.assertEquals(1, repoLOCA.elementos.size)
	}

	@Test
	def void LaLocacionContieneUnID() {
		repoLOCA.create(casa)
		Assert.assertEquals(1, casa.id)
	}

	@Test
	def void LaLocacionCASA1ContieneUnIDDistinto() {
		repoLOCA.create(casa)
		repoLOCA.create(casa1)
		Assert.assertEquals(1, casa.id)
		Assert.assertEquals(2, casa1.id)
		Assert.assertEquals(2, repoLOCA.elementos.size)
	}

	@Test
	def void alPedirUnaLocacionPorSuIDTeDevuelveLaLocacionCorrespondiente() {
		repoLOCA.create(casa)
		repoLOCA.create(casa1)
		Assert.assertEquals(casa, repoLOCA.searchById(1))
		Assert.assertEquals(casa1, repoLOCA.searchById(2))
	}

	@Test
	def void alPedirLosDatosDeUnObjetoDelRepoEstosCorrespondenCorrectamente() {
		repoLOCA.create(casa)
		var Locacion aux = repoLOCA.searchById(1)
		Assert.assertEquals(lugarcasa, aux.ubicacion)
		Assert.assertEquals("casa de pepe", aux.nombreDeLaLocacion)
		Assert.assertEquals(300, aux.superficieM2, 0)
	}

	@Test
	def void updateLocacion() {
		repoLOCA.create(casa)
		var Locacion casona = new Locacion => [
			nombreDeLaLocacion = "casa de pepe"
			ubicacion = lugargenerco
			superficieM2 = 20
		]
		repoLOCA.update(casa,casona)
		Assert.assertEquals(lugargenerco, repoLOCA.elementos.get(0).ubicacion)
		Assert.assertEquals("casa de pepe", repoLOCA.elementos.get(0).nombreDeLaLocacion)
		Assert.assertEquals(20, repoLOCA.elementos.get(0).superficieM2, 0)
	}

}
