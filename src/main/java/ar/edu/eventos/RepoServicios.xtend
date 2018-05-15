package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoServicios extends RepoGenerico<Servicio> {

	override List<Servicio> search(String buscar) {
		elementos.filter[servicio|servicio.descripcion.startsWith(buscar)].toList
	}

	override update(Servicio object) {
		object.validar()
		validarLaNoExistencia(object)
		var servicio = searchById(object.id)
		servicio.descripcion = object.descripcion
		servicio.tarifaDelServicio = object.tarifaDelServicio
		servicio.ubicacion = object.ubicacion
	}
	
	def void loadServ(Servicio object) {
		if(elementos.map(elem | elem.descripcion).contains(object.descripcion)){
			update(object)
		}
		else{
			create(object)
		}
	}
}
