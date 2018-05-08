package ar.edu.eventos

import org.junit.Assert
import org.junit.Before
import org.junit.Test

class testRepoGenerico {
	
	ServicioExternoJson ServicioExternoJson
	RepoUsuario RepoUsuario
	RepoServicios RepoServicios
	RepoLocacion RepoLocacion
	String JSonUsuarios
	String JSonLocaciones
	String JSonServicios

	@Before
	def void init() {
	
		ServicioExternoJson = new ServicioExternoJson
		RepoUsuario = new RepoUsuario
		RepoServicios = new RepoServicios
		RepoLocacion = new RepoLocacion

		JSonUsuarios = "[{
		\"nombreUsuario\":\"lucas_capo\",
		\"nombre\":\"Lucas\",
		\"Apellido\":\"Lopez\",
		\"email\":\"lucas_93@hotmail.com\",
		\"fechaNacimiento\":\"15/01/1993\",
		\"direccion\":{
		\"calle\":\"25 de Mayo\",
		\"numero\":3918,
		\"localidad\":\"San Martín\",
		\"provincia\":\"Buenos Aires\",
		\"x\":-34.572224,
		\"y\":58.535651
		}},
   		{  
		\"nombreUsuario\":\"martin1990\",
		\"nombre\":\"Martín\",
		\"Apellido\":\"Varela\",
		\"email\":\"martinvarela90@yahoo.com\",
		\"fechaNacimiento\":\"18/11/1990\",
		\"direccion\":{
		\"calle\":\"Av. Triunvirato\",
		\"numero\":4065,
		\"localidad\":\"CABA\",
		\"provincia\":\"\",
		\"x\":-33.582360,
		\"y\":60.516598
		}}]"

		JSonLocaciones = "[{
		\"x\":-34.603759,
		\"y\":-58.381586,
		\"nombre\":\"Salón El Abierto\"
		},
		{
		\"x\":-34.572224,
		\"y\":-58.535651,
		\"nombre\":\"Estadio Obras\"
		}]"

		JSonServicios = "[{
		\"descripcion\":\"Catering Food Party\",
		\"tarifaServicio\":{ 
		\"tipo\":\"TF\",
		\"valor\":5000.00
		},
		\"tarifaTraslado\":30.00,
		\"ubicacion\":{
		\"x\":-34.572224,
		\"y\":58.535651
		}
		}]"

	}

	@Test
	def testearParserJson(){
		var valueArray = ServicioExternoJson.getValueArrayFromJsonResponse(JSonUsuarios)
		var listaDeUsuarios = ServicioExternoJson.actualizarRepoUsuarios(valueArray)
		Assert.assertTrue(listaDeUsuarios.get(0).equals("lucas_capo"))
	}


	
}
