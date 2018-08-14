package ar.edu.eventos.Repositorios

import ar.edu.eventos.Usuario.Amateur
import ar.edu.eventos.Usuario.Free
import ar.edu.eventos.Usuario.Profesional
import ar.edu.eventos.Usuario.Usuario
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepoUsuario extends RepoGenerico<Usuario>{
	
	def List<Usuario> getUsuarios(){
		val carlos = new Usuario() => [
			nombreDeUsuario = "cp"
			email = "carlos@carlos.com"
			nombre = "carlos"
			apellido = "perez"
			//direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(1990, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Free
		]
		val pedro = new Usuario() => [
			nombreDeUsuario = "pedro"
			email = "pedro@gmail.com"
			nombre = "Pedro"
			apellido = "Picapiedra"
			//direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 01, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 11
			tipoDeUsuario = new Profesional
		]
		val lucas = new Usuario() => [
			nombreDeUsuario = "lucas18"
			email = "lucas18@yahoo.com"
			nombre = "Lucas"
			apellido = "Pato"
			//direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 3
			tipoDeUsuario = new Amateur
		]
		val juan = new Usuario() => [
			nombreDeUsuario = "juancho"
			email = "juancho@apple.com.uy"
			nombre = "Juancho"
			apellido = "Tacorta"
			//direccion = lugar1
			fechaDeNacimiento = LocalDateTime.of(2005, 10, 10, 0, 0)
			esAntisocial = false
			radioDeCercanía = 12
			tipoDeUsuario = new Profesional
		]
		this.elementos => [
			add(carlos)
			add(pedro)
			add(lucas)
			add(juan)
		]
		this.elementos
	}

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