package ar.edu.eventos

import org.json.JSONObject
import org.json.JSONArray
import com.eclipsesource.json.JsonArray
import java.util.List
import java.util.ArrayList
import com.eclipsesource.json.JsonObject
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

class ActualizacionRepoServicios {
	var JSONObject jsonObj
	var RepoServicios repositorio
	var ServicioExternoActualizacion SEA

	new(ServicioExternoActualizacion _SEA) {
		SEA = _SEA
	}

	def servicioExterno() {
		var String entero = SEA.Servicio()
		repositorio = RepoServicios.getinstance()
		var JSONArray arreglo = new JSONArray(entero)
		for (var i = 0; i < arreglo.length; i++) {
			jsonObj = arreglo.getJSONObject(i)
			actualizarObjeto(jsonObj)
		}
	}

	def actualizarObjeto(JSONObject obj) {
		var Servicio serv = new Servicio()
		var JSONArray jsonServicio = obj.getJSONArray("")
		for (var i = 0; i < jsonServicio.length(); i++) {
			/*serv.agregarItem(new Item(jsonServicio.getString(i),1d,1))*/
		}
	}
}

interface ServicioExternoActualizacion {
//Esta interface solo sirve para mockear 
	def String Usuario()

	def String Servicio()

	def String Locacion()

}

@Accessors
class ServicioExternoJson {
	var JsonArray array = new JsonArray
	var List<Locacion> Locaciones = new ArrayList<Locacion>
	var List<Usuario> Usuarios = new ArrayList<Usuario>
	var List<Servicio> Servicio = new ArrayList<Servicio>

	def actualizarRepoUsuarios() {
		array.forEach[x|Usuarios.add(this.parsearUsuario(x.asObject))]
		return Usuarios
	}

	def actualizarRepoLocaciones() {
		array.forEach[x|Locaciones.add(this.parsearLocacion(x.asObject))]
		return Locaciones
	}

	def actualizarRepoServicio() {
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
