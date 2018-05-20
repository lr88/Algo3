package ar.edu.eventos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoServicios extends RepoGenerico<Servicio> {

	override List<Servicio> search(String buscar) {
		elementos.filter[servicio|servicio.descripcion.startsWith(buscar)].toList
	}

	def void loadServ(Servicio object) {
		if(elementos.map(elem | elem.descripcion).contains(object.descripcion)){
			update(object)
		}
		else{
			create(object)
		}
	}
	
	override updateAll() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override actualizarDatos(Servicio serViejo, Servicio serNuevo) {
		serViejo => [
		descripcion = serNuevo.descripcion
		tarifaDelServicio = serNuevo.tarifaDelServicio
		ubicacion = serNuevo.ubicacion
		]
	}
	
}
