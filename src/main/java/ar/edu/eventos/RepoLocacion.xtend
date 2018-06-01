package ar.edu.eventos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepoLocacion extends RepoGenerico<Locacion> {

	override List<Locacion> search(String buscar) {
		elementos.filter[locacion|locacion.nombreDeLaLocacion == locacion.nombreDeLaLocacion.indexOf(buscar)].toList
	}

	public def void loadLocac(Locacion object) {
		if (elementos.map(elem|elem.nombreDeLaLocacion).contains(object.nombreDeLaLocacion)) {
			var Locacion locacionVieja = elementos.filter[elem|(elem.nombreDeLaLocacion == object.nombreDeLaLocacion)].
				get(0)
			update(locacionVieja, object)
		} else {
			create(object)
		}
	}

	def getLocations() {
		update.getLocationUpdates()
	}

	override updateAll() {
		servJson.actualizarRepoLocacion(getLocations)
	}

	override void actualizarDatos(Locacion locacionVieja, Locacion locacionNueva) {
		locacionVieja.nombreDeLaLocacion = locacionNueva.nombreDeLaLocacion
		locacionVieja.ubicacion = locacionNueva.ubicacion
		locacionVieja.superficieM2 = locacionNueva.superficieM2

	}

}
