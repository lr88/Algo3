package ar.edu.eventos
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.updateService.UpdateService
@Accessors
class RepoLocacion extends RepoGenerico<Locacion> {

	UpdateService UpdateService
	
	override List<Locacion> search(String buscar) {
		elementos.filter[locacion|locacion.nombreDeLaLocacion == locacion.nombreDeLaLocacion.indexOf(buscar)].toList
	}
	
	def void loadLocac(Locacion object) {
		if(elementos.map(elem | elem.nombreDeLaLocacion).contains(object.nombreDeLaLocacion)){
			update(object)
		}
		else{
			create(object)
		}
	}
	
	override updateAll() {
		servJson.actualizarRepoLocacion(UpdateService.getLocationUpdates())
	}
	
	override actualizarDatos(Locacion locacionVieja, Locacion locacionNueva) {
		locacionVieja => [
			nombreDeLaLocacion = locacionNueva.nombreDeLaLocacion
			ubicacion = locacionNueva.ubicacion
		]
	}

}