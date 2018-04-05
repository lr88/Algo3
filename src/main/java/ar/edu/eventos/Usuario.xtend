package ar.edu.eventos

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import java.time.Duration
import java.time.LocalDateTime

@Accessors
class Usuario {
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

	def cuantosSomos(EventoCerrado unEventoCerrado) {
		amigos.filter[amigos|amigos.queresVenir(unEventoCerrado) == true].size
	}

	def boolean quieroIr(EventoCerrado unEventoCerrado) {
		Duration.between(fechaActual, unEventoCerrado.fechaMaximaDeConfirmacion).toMillis > 0.0
	/*&& tipoDeUsuario.voyONO() */
	}

	def organizarEventoCerrado(String unNombre, Locacion unaLocacion, int cantidadMaxima, Usuario unOrganizador,
		LocalDateTime unaFechaMaximaDeConfirmacion) {
		tipoDeUsuario.organizarEventoCerrado(unNombre, unaLocacion, cantidadMaxima, unOrganizador,
			unaFechaMaximaDeConfirmacion)
	}

	def organizarEventoAbierto(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion) {

		tipoDeUsuario.organizarEventoAbierto(unNombre, unaLocacion, unOrganizador, unValorDeLaEntrada,
			unaFechaMaximaDeConfirmacion)
	}

// faltan el cancelar evento lo deriva al tipo de persona
// falta el postergar evento lo deriva al tipo de persona
}
