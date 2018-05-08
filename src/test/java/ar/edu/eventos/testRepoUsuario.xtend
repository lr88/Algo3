package ar.edu.eventos

import org.junit.Before
import org.uqbar.geodds.Point
import org.junit.Test
import org.junit.Assert
import ar.edu.eventos.exceptions.BusinessException
import java.time.LocalDateTime

class testRepoUsuario {
	RepoUsuario repoUser
	Point lugarUsuario = new Point(1.0, 2.0)
	Usuario Us1
	Usuario Us2
	Usuario Us3
	var Point lugargenerco = new Point(20.0, 55.0)

	@Before
	def void init() {
	
		Us1 = new Usuario => [
			nombreDeUsuario = "pepito"
			nombre = "pepe"
			apellido = "Pin"
			email = "pepepin@gmail.com"
			fechaDeNacimiento = LocalDateTime.of(2000,08,07,22,00)
			direccion = lugarUsuario
			]
		Us2 = new Usuario => [
			nombreDeUsuario = "pepito"
			nombre = "pepe"
			apellido = "Pin"
			email = "pepepin@gmail.com"
			fechaDeNacimiento = LocalDateTime.of(2000,08,07,22,00)
			direccion = lugarUsuario
			]
		Us3 = new Usuario => [ // no cumple aproposito con la validacion
			nombreDeUsuario = "pepito"
			apellido = "Pin"
			email = "pepepin@gmail.com"
			fechaDeNacimiento = LocalDateTime.of(2000,08,07,22,00)
			direccion = lugarUsuario
			]
		repoUser = new RepoUsuario
	}

	@Test
	def void SeCreaUnUsuarioYSeAgregaAlRepositorioCumpliendolasValidacionesCorrespondientes() {
		repoUser.create(Us1)
		Assert.assertEquals(1, repoUser.elementos.size)
	}

	@Test
	def void SeCreaUnUsuarioYSeElimina() {
		repoUser.create(Us1)
		repoUser.delete(Us1)
		Assert.assertEquals(0, repoUser.elementos.size)
	}

	@Test(expected=typeof(BusinessException))
	def void SeCreaUnUsuarioYSeAgregaAlRepositorioIncumpliendolasValidacionesCorrespondientes() {
		repoUser.create(Us3)
		Assert.assertEquals(0, repoUser.elementos.size)
	}

	@Test
	def void ElUsuarioContieneUnID() {
		repoUser.create(Us1)
		Assert.assertEquals(1, Us1.id)
	}

	@Test
	def void ElUsuarioUs2ContieneUnIDDistinto() {
		repoUser.create(Us1)
		repoUser.create(Us2)
		Assert.assertEquals(1, Us1.id)
		Assert.assertEquals(2, Us2.id)
		Assert.assertEquals(2, repoUser.elementos.size)
	}

	@Test
	def void alPedirUnUsuarioPorSuIDTeDevuelveElUsuarioCorrespondiente() {
		repoUser.create(Us1)
		repoUser.create(Us2)
		Assert.assertEquals(Us1, repoUser.searchById(1))
		Assert.assertEquals(Us2, repoUser.searchById(2))
	}

	@Test
	def void alPedirLosDatosDeUnUsuarioDelRepoEstosCorrespondenCorrectamente() {
		repoUser.create(Us1)
		var Usuario aux = repoUser.searchById(1)
		Assert.assertEquals(lugarUsuario, aux.direccion)
		Assert.assertEquals("pepito", aux.nombreDeUsuario)
	}

	@Test
	def void updateUsuario() {
		repoUser.create(Us1)
		Us1.nombreDeUsuario = "coco"
		Us1.direccion = lugargenerco
		repoUser.update(Us1)
		Assert.assertEquals(lugargenerco, Us1.direccion)
		Assert.assertEquals("coco", Us1.nombreDeUsuario)
	}

}
