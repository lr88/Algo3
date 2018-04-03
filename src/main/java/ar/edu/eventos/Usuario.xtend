package ar.edu.eventos

import java.time.LocalDateTime
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors
class Usuario {

	String nombre
	String apellido
	String email
	Locacion direccion
	LocalDateTime fechaDeNacimiento
	boolean estadoSocial
	List <Usuario> amigos  = newArrayList
	

	new(String unNombre, String unApellido, String unEmail, Locacion unaDireccion, boolean unEstadoSocial,LocalDateTime unaFecha) {
		nombre = unNombre
		apellido = unApellido
		email = unEmail
		direccion = unaDireccion
		estadoSocial = unEstadoSocial
		fechaDeNacimiento = unaFecha
		}

	def esAntisocial() {
		estadoSocial
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
	
	def eliminarAmigos() {
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

	def comprarEntrada() {
	}

}
