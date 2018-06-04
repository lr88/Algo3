package ar.edu.eventos.Repositorios
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.eventos.Usuario.Usuario

@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{

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
	
	def getUsers() {
		update.getUserUpdates()
	}
	
	override updateAll() {
		servJson.actualizarRepoUsuarios(update.getUserUpdates())
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