package ar.edu.eventos

import java.time.LocalDateTime
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
class Usuario {
	
	String nombreDeUsuario

	String nombre
	String apellido
	String email
	Point direccion
	LocalDateTime fechaDeNacimiento
	boolean social
    int cantidadMaxima
	
	/*Datos personales:  Nombre de usuario, nombre y apellido, email,
    fecha de nacimiento y dirección. De la dirección nos interesa particularmente el punto geográfico.
	*/
	new(String _nombreDeUsuario,String _nombre,String _apellido,String _email,Point _direccion,boolean _social){
		nombreDeUsuario=_nombreDeUsuario
		nombre=_nombre
		apellido=_apellido
		email=_email
		direccion=_direccion
		social=_social	
	}
	
	/*Es Antisocial: Cada usuario podrá definir si es (o no) antisocial. */
	
	def esAntisocial(){
		social
	}
	
	/*Amigos: Listado de otros usuarios que podrán ser agregados y eliminados. 
	La amistad no es necesariamente mutua.
	 */
	 def agregarAmigos(){
	 	
	 }
	 
	def eliminarAmigos(){
		
	}
	/* Radio de cercanía: Cada usuario define cuál es la 
	 * máxima distancia (en kms) que considera “cerca”.*/
	 
	 
	 /*Los usuarios de la plataforma tendrán la posibilidad de comprar entradas para los eventos abiertos.
	 El sistema solo debe permitir la compra si; quedan entradas disponibles
	   (teniendo en cuenta la capacidad máxima), 
	  aún no se ha superado la fecha máxima de confirmación, y el usuario supera la edad mínima requerida.  */
	/* def comprarEntrada(EventoAbierto unEvento){
	 	if(unEvento.entradasDisponibles()!=null && LocalDateTime.now()< unEvento.fechaMaximaParaSacarEntradas
	 		&& this.fechaDeNacimiento>18)
	 }*/
	 
	 def esInvitado(){
	 	
	 }
	 
	 def comprarEntrada(){
	 	
	 }
	 
}

class Organizador extends Usuario{
	
		new(String _nombreDeUsuario,String _nombre,String _apellido,String _email,Point _direccion,boolean _social){
		 super(_nombreDeUsuario,_nombre,_apellido,_email,_direccion,_social)
	}
	

	def cancelarEvento(Evento unEvento){
		
	}
	
	def invitar(Usuario _usuario){
		
	}
}