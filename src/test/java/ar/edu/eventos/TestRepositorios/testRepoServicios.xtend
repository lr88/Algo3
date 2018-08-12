package ar.edu.eventos.TestRepositorios

import org.junit.Before
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import ar.edu.eventos.exceptions.BusinessException
import ar.edu.eventos.Repositorios.RepoServicios
import ar.edu.eventos.Eventos.Locacion
import ar.edu.eventos.Eventos.Servicio
import ar.edu.eventos.Eventos.TarifaFija
import ar.edu.eventos.Eventos.ServicioMultiple

class testRepoServicios {
	RepoServicios repoSERV
	Point lugarServ
	Locacion lugar
	Locacion lugar1
	Servicio S1
	Servicio S2
	Servicio S3
	var Point lugargenerco
	ServicioMultiple SM1

	@Before   
	def void init() {
		
		lugarServ = new Point(1.0, 2.0)
		lugargenerco= new Point(20.0, 55.0)
		
		
		
		
		lugar = new Locacion => [
			ubicacion = lugarServ
			nombreDeLaLocacion = "club"
			superficieM2 = 300
		]
		lugar1 = new Locacion => [
			ubicacion = lugargenerco
			nombreDeLaLocacion = "club"
			superficieM2 = 300
		]
		S1 = new Servicio => [
			tarifaDelServicio = new TarifaFija 
			descripcion = "Juegos"
			ubicacion = lugar
		] 
		S2 = new Servicio => [
			tarifaDelServicio = new TarifaFija
			descripcion = "Animación Mago Goma"
			ubicacion = lugar
		]
		S3 = new Servicio => [ // no cumple aproposito con la validacion
			ubicacion = lugar
			descripcion = ""
		]
		
		SM1 = new ServicioMultiple =>[
			ubicacion = lugar
			tarifaDelServicio = new TarifaFija
			descripcion = "Animación Mago Goma"
		]
		
		
		
		repoSERV = new RepoServicios
	}

	@Test
	def void SeCreaUnServicioYSeAgregaAlRepositorioCumpliendolasValidacionesCorrespondientes() {
		repoSERV.create(S1)
		Assert.assertEquals(1, repoSERV.elementos.size)
	}

	@Test
	def void SeCreaUnServicioYSeElimina() {
		repoSERV.create(S1)
		repoSERV.delete(S1)
		Assert.assertEquals(0, repoSERV.elementos.size)
	}

	@Test(expected=typeof(BusinessException))
	def void SeCreaUnServicioYSeAgregaAlRepositorioIncumpliendolasValidacionesCorrespondientes() {
		repoSERV.create(S3)
		Assert.assertEquals(0, repoSERV.elementos.size)
	}

	@Test
	def void ElServicioContieneUnID() {
		repoSERV.create(S1)
		Assert.assertEquals(1, S1.id)
	}

	@Test
	def void ElServicioS2ContieneUnIDDistinto() {
		repoSERV.create(S1)
		repoSERV.create(S2)
		Assert.assertEquals(1, S1.id)
		Assert.assertEquals(2, S2.id)
		Assert.assertEquals(2, repoSERV.elementos.size)
	}

	@Test
	def void alPedirUnServicioPorSuIDTeDevuelveLaServicioCorrespondiente() {
		repoSERV.create(S1)
		repoSERV.create(S2)
		Assert.assertEquals(S1, repoSERV.searchById(1))
		Assert.assertEquals(S2, repoSERV.searchById(2))
	}

	@Test
	def void alPedirLosDatosDeUnObjetoDelRepoEstosCorrespondenCorrectamente() {
		repoSERV.create(S1)
		var Servicio aux = repoSERV.searchById(1)
		Assert.assertEquals(lugar, aux.ubicacion)
		Assert.assertEquals("Juegos", aux.descripcion)
	}

	@Test
	def void updateServicio() {
		var Servicio Saux = S1
		repoSERV.create(S1)
		S1.descripcion = "Magia"
		S1.ubicacion = lugar1
		repoSERV.update(Saux,S1)
		Assert.assertEquals(lugar1, S1.ubicacion)
		Assert.assertEquals("Magia", S1.descripcion)
	}

}
