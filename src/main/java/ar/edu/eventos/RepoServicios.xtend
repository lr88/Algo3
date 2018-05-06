package ar.edu.eventos
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoServicios extends RepoGenerico<Servicio>{
	int proximoId = 0

	override List<Servicio> search(String buscar) {
		elementos.filter[servicio |servicio.descripcion.startsWith(buscar)].toList
	}
	
	override update(Servicio object) {
		object.soyValido()
		validarLaNoExistencia(object)
		var servicio = searchById(object.id)
		servicio.descripcion = object.descripcion
		servicio.tarifaDelServicio = object.tarifaDelServicio
		servicio.ubicacion = object.ubicacion
	}
	
	override Servicio searchById(int id) {
		elementos.findFirst[servicio|servicio.id == id]
	}
	
	override create(Servicio object) {
		object.soyValido()
		validarExistencia(object)
		elementos.add(object)
		proximoId ++
		object.setId(proximoId)
		
	}
	
}