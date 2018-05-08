package ar.edu.eventos

import org.junit.Test
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import org.junit.Assert

class testRepoGenerico {
	ServicioExternoJson ServicioExternoJson = new ServicioExternoJson
	RepoUsuario RepoUsuario
	RepoServicios RepoServicios
	RepoLocacion RepoLocacion

	var String JSonUsuarios = "[{
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

	var String JSonLocaciones = "[{
		\"x\":-34.603759,
		\"y\":-58.381586,
		\"nombre\":\"Salón El Abierto\"
		},
		{
		\"x\":-34.572224,
		\"y\":-58.535651,
		\"nombre\":\"Estadio Obras\"
		}]"

	var String JSonServicios = "[{
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

	@Test
	def void JSonUsuarios() {
		var JsonArray array = new JsonArray
		array.add(JsonObject.readFrom(JSonUsuarios))
		ServicioExternoJson.array = array
		RepoUsuario.servJson = ServicioExternoJson
		ServicioExternoJson.actualizarRepoLocaciones()
	}

	@Test
	def void JSonLocaciones() {
		var JsonArray array = new JsonArray
		array.add(JsonObject.readFrom(JSonLocaciones))
		ServicioExternoJson.array = array
		RepoLocacion.servJson = ServicioExternoJson
		ServicioExternoJson.actualizarRepoLocaciones()

	}

	@Test
	def void JSonServicios() {
		var JsonArray array = new JsonArray
		array.add(JsonObject.readFrom(JSonServicios))
		ServicioExternoJson.array = array
		RepoServicios.servJson = ServicioExternoJson 
		ServicioExternoJson.actualizarRepoLocaciones()

	}

}
