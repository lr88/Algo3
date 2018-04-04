package ar.edu.eventos

import java.time.LocalDate
import java.time.Period
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Usuario {
	
	String nombreDeUsuario
	String nombre
	String apellido
	String email
	Point direccion
	LocalDate fechaDeNacimiento
	boolean esAntisocial
	List<Usuario> amigos = newArrayList
	var double plataQueTengo = 100
	var double radioDeCercanía
	

	new(String unNombreDeUsuario, String unNombre, String unApellido, String unEmail, Point unLugar, boolean es_Antisocial,
		LocalDate unaFecha,double unRadioDeCercanía) {
		nombreDeUsuario = unNombreDeUsuario
		nombre = unNombre
		apellido = unApellido
		email = unEmail
		direccion = unLugar
		esAntisocial = es_Antisocial
		fechaDeNacimiento = unaFecha
		radioDeCercanía = unRadioDeCercanía
	}

	def esAntisocial() {
		esAntisocial
	}

	/*Amigos: Listado de otros usuarios que podrán ser agregados y eliminados. 
	 * La amistad no es necesariamente mutua.
	 */
	def void agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}

	def amigos() {
		amigos
	}

	def int cantidadDeAmigos() {
		amigos.size
	}

	def eliminarAmigos(Usuario unUsuario) {
		amigos.remove(unUsuario)
	}

	/* Radio de cercanía: Cada usuario define cuál es la 
	 * máxima distancia (en kms) que considera “cerca”.*/
	/*Los usuarios de la plataforma tendrán la posibilidad de comprar entradas para los eventos abiertos.
	 * El sistema solo debe permitir la compra si; quedan entradas disponibles
	 *   (teniendo en cuenta la capacidad máxima), 
	 aún no se ha superado la fecha máxima de confirmación, y el usuario supera la edad mínima requerida.  */
	/* def comprarEntrada(EventoAbierto unEvento){
	 *  	if(unEvento.entradasDisponibles()!=null && LocalDateTime.now()< unEvento.fechaMaximaParaSacarEntradas
	 *  		&& this.fechaDeNacimiento>18)
	 }*/
	def esInvitado() {
	}

	def comprarEntradaDeEventoAbierto(EventoAbierto unEvento) {
		unEvento.adquirirEntrada(this)
	}

	def edad(LocalDate fechaActual){
		Period.between(fechaDeNacimiento,fechaActual ).years
	}
}
