package ar.edu.eventos

import java.time.Duration
import java.time.LocalDateTime
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point

@Accessors
class Usuario {
	List<Evento> eventos = newArrayList
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
	

	new(String unNombreDeUsuario, String unNombre, String unApellido, String unEmail, Point unLugar,
		boolean es_Antisocial, LocalDateTime unaFecha, double unRadioDeCercanía) {
		nombreDeUsuario = unNombreDeUsuario
		nombre = unNombre
		apellido = unApellido
		email = unEmail
		direccion = unLugar
		esAntisocial = es_Antisocial
		fechaDeNacimiento = unaFecha
		radioDeCercanía = unRadioDeCercanía
		
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

	def organizarEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {
		tipoDeUsuario.organizarEventoCerrado(this,unNombre, unaLocacion, cantidadMaxima, unOrganizador,
			unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}

	def organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion,LocalDateTime unInicioDelEvento,LocalDateTime unFinDelEvento) {

		tipoDeUsuario.organizarEventoAbierto(this,unNombre, unaLocacion, unOrganizador, unValorDeLaEntrada,
			unaFechaMaximaDeConfirmacion, unInicioDelEvento, unFinDelEvento)
	}
	
	

}
