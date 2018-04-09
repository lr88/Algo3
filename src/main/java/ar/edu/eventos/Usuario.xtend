package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import java.util.HashSet
import java.util.Set

@Accessors
class Usuario {
	Set<Evento> eventos = new HashSet ()
	LocalDateTime fechaActual = LocalDateTime.now
	String nombreDeUsuario
	String nombre
	String apellido
	String email
	Point direccion
	LocalDateTime fechaDeNacimiento
	boolean esAntisocial
	List<Usuario> amigos = newArrayList
	var double plataQueTengo = 100
	var double radioDeCercanía
	TipoDeUsuario tipoDeUsuario
	Boolean aceptacion
	int cantidadDeAcompañantes
	

	new(String unNombreDeUsuario, String unNombre, String unApellido, String unEmail, Point unLugar,
		boolean es_Antisocial, LocalDateTime unaFecha, double unRadioDeCercanía,TipoDeUsuario unTipoDeUsuario) {
		nombreDeUsuario = unNombreDeUsuario
		nombre = unNombre
		apellido = unApellido
		email = unEmail
		direccion = unLugar
		esAntisocial = es_Antisocial
		fechaDeNacimiento = unaFecha
		radioDeCercanía = unRadioDeCercanía
		tipoDeUsuario = unTipoDeUsuario
	}

	/* SOLO PARA SATISFACER EL TEST */
	def void agregarEvento(Evento unEvento) {
		eventos.add(unEvento)
	}

	/*------------------- */
	def void agregarAmigo(Usuario unAmigo) {
		amigos.add(unAmigo)
	}

	def int cantidadDeAmigos() {
		amigos.size
	}

	def eliminarAmigos(Usuario unUsuario) {
		amigos.remove(unUsuario)
	}

	def comprarEntradaDeEventoAbierto(EventoAbierto unEvento) {
		unEvento.adquirirEntrada(this)
	}

	def boolean soyMenorDeEdad(LocalDateTime fechaActual) {
		Duration.between(fechaDeNacimiento, fechaActual).toDays() / 360 < 18
	}

	def boolean queresVenir(EventoCerrado unEventoCerrado) {
		this.quieroIr(unEventoCerrado)
	}

	def int cuantosSomos(EventoCerrado unEventoCerrado) {
		amigos.filter[amigo|amigo.queresVenir(unEventoCerrado) == true].size
	}

	def puedoOrganizarUnEventoEsteMes(LocalDateTime unInicioDelEvento,int unMaximoDeEventosMensuales){
		eventos.filter[evento|evento.inicioDelEvento.getMonth == unInicioDelEvento.getMonth && evento.inicioDelEvento.getYear == unInicioDelEvento.getYear].size < unMaximoDeEventosMensuales
	}

	def EstoyOrganizandoMasDeLaCantidadPermitidaDeEventosALaVez(LocalDateTime unInicioDelEvento,int unaCantidadMaximaPermitidaDeSimultaneidadDeEventos) {
		eventos.filter[evento|evento.inicioDelEvento.getHour == unInicioDelEvento.getHour && evento.inicioDelEvento.getDayOfMonth == unInicioDelEvento.getDayOfMonth].size <= unaCantidadMaximaPermitidaDeSimultaneidadDeEventos 
	}

	
	def boolean quieroIr(EventoCerrado unEventoCerrado) {
		Duration.between(fechaActual, unEventoCerrado.fechaMaximaDeConfirmacion).toMillis > 0.0
	/*&& tipoDeUsuario.voyONO() */
	}

	def crearEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {
		
		tipoDeUsuario.organizarEventoCerrado(this,unNombre, unaLocacion, cantidadMaxima, this,
			unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}


	def CrearEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unUsuario, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {

		tipoDeUsuario.organizarEventoAbierto( unNombre,  unaLocacion, this,  unValorDeLaEntrada,
		 unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}
	
	           def devolverEntrada(Entrada unaEntrada,EventoAbierto unEvento){

                        /*Las devoluciones serán aceptadas hasta el día anterior al evento.*/
                        if(fechaActual < unEvento.inicioDelEvento)
                        unaEntrada.devolverDinero(fechaActual,unEvento)
                        unEvento.usuarioDevuelveEntrada(this)

            }
/*El organizador de un evento es quién tiene la facultad de invitar a otros usuarios. */
 	  def invitar(EventoCerrado unEvento,Invitacion unaInvitacion){
   
/*El sistema no debe permitir aceptar invitaciones una vez pasada la fecha máxima de confirmación. */
     if(fechaActual < unEvento.fechaMaximaDeConfirmacion)
     this.aceptarInvitacion(aceptacion,unaInvitacion)
     unEvento.agregarInvitacion(unaInvitacion)
}
    /*Los invitados podrán aceptar o rechazar la invitación*/
def aceptarInvitacion(Boolean _aceptacion,Invitacion unaInvitacion){
aceptacion=_aceptacion
unaInvitacion.estado = aceptacion
if(aceptacion == true)
     this.indicarCantidadDeAcompañantes(cantidadDeAcompañantes,unaInvitacion)
}
/*En caso de aceptarla deberán indicar cuantos acompañantes
 efectivamente asistirán, no pudiendo superar la cantidad definida en la invitación*/
		def indicarCantidadDeAcompañantes(int unaCantidad,Invitacion unaInvitacion){
if(unaCantidad < unaInvitacion.cantidadDeAcompañantes)
    cantidadDeAcompañantes = unaCantidad
}
}
