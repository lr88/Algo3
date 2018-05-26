package ar.edu.eventos

import com.eclipsesource.json.Json
import com.eclipsesource.json.JsonObject
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class EntityJsonParser {

	private var RepoUsuario repositorioUsuarios
	private var RepoLocacion repositorioLocacion
	private var RepoServicios repositorioServicios

	public def void actualizarRepoUsuarios(String json) {
		Json.parse(json).asArray.forEach[arrays|parsearUsuario(arrays.asObject)]
	}

	public def void actualizarRepoLocacion(String json) {
		Json.parse(json).asArray.forEach[arrays|parsearLocacion(arrays.asObject)]
	}

	public def void actualizarRepoServicio(String json) {
		Json.parse(json).asArray.forEach[arrays|parsearServicio(arrays.asObject)]
	}

	private def Usuario parsearUsuario(JsonObject json) {

		val formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
		val LocalDate date = LocalDate.parse(json.get("fechaNacimiento").asString, formatter)
		val LocalDateTime time = date.atTime(0, 0)

		var Usuario nuevoUsuario = new Usuario() => [
			nombreDeUsuario = (json.get("nombreUsuario").asString)
			nombre = (json.get("nombre").asString)
			apellido = (json.get("apellido").asString)
			email = (json.get("email").asString)
			fechaDeNacimiento = time
			direccion = new Locacion => [
				ubicacion = new Point((json.get("direccion").asObject.get("coordenadas").asObject.get("x").asDouble),
					(json.get("direccion").asObject.get("coordenadas").asObject.get("y").asDouble))
				calle = (json.get("direccion").asObject.get("calle").asString)
				numero = (json.get("direccion").asObject.get("numero").asInt)
				localidad = (json.get("direccion").asObject.get("localidad").asString)
				provincia = (json.get("direccion").asObject.get("provincia").asString)
				nombreDeLaLocacion = calle + (json.get("direccion").asObject.get("numero").asInt).toString + localidad +
					provincia
			]
		]
		repositorioUsuarios.loadUser(nuevoUsuario)
		return nuevoUsuario
	}

	private def Locacion parsearLocacion(JsonObject json) {
		var Locacion nuevaLocacion = new Locacion => [
			ubicacion = new Point((json.get("x").asDouble), (json.get("y").asDouble))
			nombreDeLaLocacion = (json.get("nombre").asString)
		]
		repositorioLocacion.loadLocac(nuevaLocacion)
		return nuevaLocacion
	}

	private def Servicio parsearServicio(JsonObject json) {
		var Servicio nuevoServicio = new Servicio => [
			descripcion = (json.get("descripcion").asString)
			tarifaDelServicio = getTipoDeTarifa(json)
			tarifaPorKilometro = (json.get("tarifaTraslado").asDouble)
			ubicacion = new Locacion => [
				ubicacion = new Point((json.get("ubicacion").asObject.get("x").asDouble),
					(json.get("ubicacion").asObject.get("y").asDouble))
			]
		]
		repositorioServicios.loadServ(nuevoServicio)
		return nuevoServicio
	}

	private def getTipoDeTarifa(JsonObject json) {
		if (json.get("tarifaServicio").asObject.get("tipo").asString == "TF") {
			return new TarifaFija => [
				valor = json.get("tarifaServicio").asObject.get("valor").asDouble
			]
		}
		if (json.get("tarifaServicio").asObject.get("tipo").asString == "TPP") {
			return new TarifaPorPersona => [
				valor = json.get("tarifaServicio").asObject.get("valor").asDouble
				porcentajeMinimo = json.get("tarifaServicio").asObject.get("porcentajeParaMinimo").asDouble
			]
		}
		if (json.get("tarifaServicio").asObject.get("tipo").asString == "TPH") {
			return new TarifaPorHora => [
				valor = json.get("tarifaServicio").asObject.get("valor").asDouble
				costoMínimoFijo = json.get("tarifaServicio").asObject.get("minimo").asDouble
			]
		}
	}

}
