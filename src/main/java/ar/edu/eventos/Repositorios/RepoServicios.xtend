package ar.edu.eventos.Repositorios

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Eventos.Servicio

@Accessors
class RepoServicios extends RepoGenerico<Servicio> {

	
	override List<Servicio> search(String buscar) {
		elementos.filter[servicio|servicio.descripcion.startsWith(buscar)].toList
	}
	
	public def void loadServ(Servicio object) {
		if(elementos.map(elem | elem.descripcion).contains(object.descripcion)){
			var Servicio servicioViejo = elementos.filter[elem | (elem.descripcion == object.descripcion)].get(0)
			update(servicioViejo,object)
		}
		else{
			create(object)
		}
	}
	
	def getServis() {
		update.getServiceUpdates()
	}
	
	override void updateAll() {
		servJson.actualizarRepoServicio(update.getServiceUpdates())
	}
	
	override void actualizarDatos(Servicio serViejo, Servicio serNuevo) {
		serViejo => [
		descripcion = serNuevo.descripcion
		tarifaDelServicio = serNuevo.tarifaDelServicio
		ubicacion = serNuevo.ubicacion
		]
	}
	
}