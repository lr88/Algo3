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
		Json.parse(json).asArray
	}

	def actualizarRepoUsuarios(JsonArray array) {
		array.forEach[x|Usuarios.add(this.parsearUsuario(x.asObject))]
		return Usuarios
	}

	def actualizarRepoLocaciones(JsonArray array) {
		array.forEach[x|Locaciones.add(this.parsearLocacion(x.asObject))]
		return Locaciones
	}

	def actualizarRepoServicio(JsonArray array) {
		array.forEach[x|Servicio.add(this.parsearServicio(x.asObject))]
		return Servicio
	}

	def Usuario parsearUsuario(JsonObject json) {
		var nuevoUsuario = new Usuario() => [
			nombreDeUsuario = (json.get("nombreUsuario").asString)
			nombre = (json.get("nombre").asString)
			apellido = (json.get("Apellido").asString)
			email = (json.get("email").asString)
			direccion = new Point((json.get("x").asInt), (json.get("y").asInt))
			descripcionDeLaDireccion = new Direccion => [
				calle = (json.get("calle").asString)
				numero = (json.get("numero").asInt)
				localidad = (json.get("localidad").asString)
				provincia = (json.get("provincia").asString)
			]
		]
		nuevoUsuario
	}

	def parsearLocacion(JsonObject json) {
		var nuevaLocacion = new Locacion => [
			ubicacion = new Point((json.get("x").asInt), (json.get("y").asInt))
			nombreDeLaLocacion = (json.get("nombre").asString)
		]
		nuevaLocacion
	}

	def parsearServicio(JsonObject json) {
		var nuevoServicio = new Servicio =>[
			descripcion = (json.get("descripcion").asString)
			tarifaDelServicio = queTipoDeTarifaEs(json)
			tarifaPorKilometro = (json.get("tarifaTraslado").asInt)
			ubicacion = new Locacion =>[
				ubicacion = new Point((json.get("x").asInt), (json.get("y").asInt))
			]
		]
		nuevoServicio
	}
	
	def queTipoDeTarifaEs(JsonObject json) {
			if(json.get("tarifaServicio").asString == "TF"){
			return new TarifaFija =>[
					valor = json.get("valor").asInt
				]		
			}
			if(json.get("tarifaServicio").asString == "TPP"){
			return new TarifaPorPersona =>[
					valor = json.get("valor").asInt
					porcentajeMinimo = json.get("porcentajeParaMinimo").asInt
				]		
			}
			if(json.get("tarifaServicio").asString == "TPH"){
			return new TarifaPorHora =>[
					valor = json.get("valor").asInt
					horasMinimas = json.get("minimo").asInt
				]		
			}
	}

}
