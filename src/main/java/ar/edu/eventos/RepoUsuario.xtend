package ar.edu.eventos
import org.uqbar.updateService.UpdateService
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{

	private UpdateService UpdateService
	
	protected override List<Usuario> search(String buscar) {
	  elementos.filter[usuario|usuario.nombre == usuario.nombre.indexOf(buscar) || usuario.apellido == usuario.apellido.indexOf(buscar)|| usuario.nombreDeUsuario.equals(buscar) ].toList 
	}

	public def void loadUser(Usuario usuario) {
		if(elementos.map(elem | elem.apellido+elem.nombre).contains(usuario.apellido+usuario.nombre)){
			var Usuario usuarioViejo = elementos.filter[elem | (elem.apellido == usuario.apellido && elem.nombre == usuario.nombre)].get(0)
			update(usuarioViejo,usuario)// si existe el nombre de la persona
		}
		else{
			create(usuario)// si no existe el nombre de la persona
		}
	}
	
	protected override String updateAll() {
		servJson.actualizarRepoUsuarios(UpdateService.getUserUpdates())
		UpdateService.getUserUpdates()
	}
	
	protected override void actualizarDatos(Usuario usuarioViejo, Usuario usuarioNuevo) {
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