package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonArray
import com.eclipsesource.json.JsonObject
import org.uqbar.geodds.Point

@Accessors
class ServicioExternoJson {
	var JsonArray array = new JsonArray
	var List <Locacion> Locaciones = newArrayList
	var List <Usuario> Usuarios = newArrayList
	var List <Servicio> Servicio = newArrayList

	def JsonArray getValueArrayFromJsonResponse(String json) {
		return Json.parse(json).asArray
	}

	def actualizarRepoUsuarios(JsonArray array) {
		array.forEach[arrays|Usuarios.add(this.parsearUsuario(arrays.asObject))]
		
	}

	def actualizarRepoLocaciones(JsonArray array) {
		array.forEach[arrays|Locaciones.add(this.parsearLocacion(arrays.asObject))]
		
	}

	def actualizarRepoServicio(JsonArray array) {
		array.forEach[arrays|Servicio.add(this.parsearServicio(arrays.asObject))]
		
	}

	def Usuario parsearUsuario(JsonObject json) {
		var Usuario nuevoUsuario = new Usuario() => [
			nombreDeUsuario = (json.get("nombreUsuario").asString)
			nombre = (json.get("nombre").asString)
			apellido = (json.get("Apellido").asString)
			email = (json.get("email").asString)
			direccion = new Point((json.get("x").asDouble), (json.get("y").asDouble))
			descripcionDeLaDireccion = new Direccion => [
			calle = (json.get("calle").asString)
			numero = (json.get("numero").asInt)
			localidad = (json.get("localidad").asString)
			provincia = (json.get("provincia").asString)
			]]
		return nuevoUsuario
	}

	def parsearLocacion(JsonObject json) {
		var Locacion nuevaLocacion = new Locacion => [
			ubicacion = new Point((json.get("x").asDouble), (json.get("y").asDouble))
			nombreDeLaLocacion = (json.get("nombre").asString)
		]
		return nuevaLocacion
	}

	def parsearServicio(JsonObject json) {
		var Servicio nuevoServicio = new Servicio =>[
			descripcion = (json.get("descripcion").asString)
			tarifaDelServicio = queTipoDeTarifaEs(json)
			tarifaPorKilometro = (json.get("tarifaTraslado").asDouble)
			ubicacion = new Locacion =>[
				ubicacion = new Point((json.get("x").asDouble), (json.get("y").asDouble))
			]
		]
		return nuevoServicio
	}
	
	def queTipoDeTarifaEs(JsonObject json) {
			if(json.get("tipo").asString == "TF"){
			return new TarifaFija =>[
					valor = json.get("valor").asDouble
				]		
			}
			if(json.get("tipo").asString == "TPP"){
			return new TarifaPorPersona =>[
					valor = json.get("valor").asDouble
					porcentajeMinimo = json.get("porcentajeParaMinimo").asInt
				]		
			}
			if(json.get("tipo").asString == "TPH"){
			return new TarifaPorHora =>[
					valor = json.get("valor").asDouble
					horasMinimas = json.get("minimo").asInt
				]		
			}
	}

}
