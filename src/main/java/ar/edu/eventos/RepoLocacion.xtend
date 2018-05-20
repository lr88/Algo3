package ar.edu.eventos
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
@Accessors
class RepoLocacion extends RepoGenerico<Locacion> {

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
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override actualizarDatos(Locacion locacionVieja, Locacion locacionNueva) {
		locacionVieja => [
			nombreDeLaLocacion = locacionNueva.nombreDeLaLocacion
			ubicacion = locacionNueva.ubicacion
		]
	}
	

}