package ar.edu.eventos
import org.uqbar.updateService.UpdateService
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoServicios extends RepoGenerico<Servicio> {

	private UpdateService UpdateService
	
	override List<Servicio> search(String buscar) {
		elementos.filter[servicio|servicio.descripcion.startsWith(buscar)].toList
	}
	
	public def void loadServ(Servicio object) {
		if(elementos.map(elem | elem.descripcion).contains(object.descripcion)){
			update(object)
		}
		else{
			create(object)
		}
	}
	
	override String updateAll() {
		servJson.actualizarRepoServicio(UpdateService.getServiceUpdates())
		UpdateService.getServiceUpdates()
	}
	
	override void actualizarDatos(Servicio serViejo, Servicio serNuevo) {
		serViejo => [
		descripcion = serNuevo.descripcion
		tarifaDelServicio = serNuevo.tarifaDelServicio
		ubicacion = serNuevo.ubicacion
		]
	}
	
}