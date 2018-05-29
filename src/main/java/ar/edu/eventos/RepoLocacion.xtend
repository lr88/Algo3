package ar.edu.eventos
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.updateService.UpdateService
import org.eclipse.xtend.lib.annotations.AccessorsProcessor.Util

@Accessors
class RepoLocacion extends RepoGenerico<Locacion> {

	UpdateService UpdateService
	
	override List<Locacion> search(String buscar) {
		elementos.filter[locacion|locacion.nombreDeLaLocacion == locacion.nombreDeLaLocacion.indexOf(buscar)].toList
	}
	 
	public def void loadLocac(Locacion object) {
		if(elementos.map(elem | elem.nombreDeLaLocacion).contains(object.nombreDeLaLocacion)){
			var Locacion locacionVieja = elementos.filter[elem | (elem.nombreDeLaLocacion == object.nombreDeLaLocacion)].get(0)
			update(locacionVieja,object)
		}
		else{
			create(object)
		}
	}
	
	
	override void updateAll() {
		servJson.actualizarRepoLocacion(UpdateService.getLocationUpdates())
	}
	
	override void actualizarDatos(Locacion locacionVieja, Locacion locacionNueva) {
			locacionVieja.nombreDeLaLocacion = locacionNueva.nombreDeLaLocacion
			locacionVieja.ubicacion = locacionNueva.ubicacion
			locacionVieja.superficieM2 = locacionNueva.superficieM2
		
	}

}