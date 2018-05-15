package ar.edu.eventos
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
@Accessors
class RepoLocacion extends RepoGenerico<Locacion> {

	override List<Locacion> search(String buscar) {
		elementos.filter[locacion|locacion.nombreDeLaLocacion == locacion.nombreDeLaLocacion.indexOf(buscar)].toList
	}
	
	override update(Locacion object) {
		object.validar()
		validarLaNoExistencia(object)
		var locacion = searchById(object.id)
		locacion.nombreDeLaLocacion = object.nombreDeLaLocacion
		locacion.ubicacion = object.ubicacion
	}
	
	def void loadLocac(Locacion object) {
		if(elementos.map(elem | elem.nombreDeLaLocacion).contains(object.nombreDeLaLocacion)){
			update(object)
		}
		else{
			create(object)
		}
	}

}