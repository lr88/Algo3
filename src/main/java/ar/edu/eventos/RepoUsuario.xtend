package ar.edu.eventos
import org.uqbar.updateService.UpdateService
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{

	UpdateService UpdateService
	
	override List<Usuario> search(String buscar) {
	  elementos.filter[usuario|usuario.nombre == usuario.nombre.indexOf(buscar) || usuario.apellido == usuario.apellido.indexOf(buscar)|| usuario.nombreDeUsuario.equals(buscar) ].toList 
	}

	def void loadUser(Usuario usuario) {
		if(elementos.map(elem | elem.apellido+elem.nombre).contains(usuario.apellido+usuario.nombre)){
			update(usuario)
		}
		else{
			create(usuario)
		}
	}
	
	override updateAll() {
		servJson.actualizarRepoUsuarios(UpdateService.getUserUpdates())
	}
	
	override actualizarDatos(Usuario usuarioViejo, Usuario usuarioNuevo) {
		usuarioViejo=>[
		usuarioViejo.nombreDeUsuario = usuarioNuevo.nombreDeUsuario
		usuarioViejo.nombre = usuarioNuevo.nombre
		usuarioViejo.apellido = usuarioNuevo.apellido
		usuarioViejo.fechaDeNacimiento = usuarioNuevo.fechaDeNacimiento
		usuarioViejo.email = usuarioNuevo.email
		usuarioViejo.direccion = usuarioNuevo.direccion
   ]
	}
	
}