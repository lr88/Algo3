package ar.edu.eventos
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
@Accessors
class RepoLocacion extends RepoGenerico<Locacion> {
	int proximoId = 0
	var ServicioExternoJson servJson = new ServicioExternoJson()
	
	override List<Locacion> search(String buscar) {
		elementos.filter[locacion|locacion.nombreDeLaLocacion == locacion.nombreDeLaLocacion.indexOf(buscar)].toList
	}
	
	override update(Locacion object) {
		object.soyValido()
		validarLaNoExistencia(object)
		var locacion = searchById(object.id)
		locacion.nombreDeLaLocacion = object.nombreDeLaLocacion
		locacion.ubicacion = object.ubicacion
	}
	
	override Locacion searchById(int id) {
		elementos.findFirst[locacion|locacion.id == id]
	}
	
	override create(Locacion object) {
		object.soyValido()
		validarExistencia(object)
		elementos.add(object)
		proximoId +=1
		object.setId(proximoId)
		
		
	}
}