package ar.edu.eventos

import java.time.LocalDate
import java.time.Period
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.geodds.Point
import java.time.Duration

@Accessors
class Usuario {
	LocalDate fechaActual = LocalDate.now
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

	// tipo de Usuario 
	new(String unNombreDeUsuario, String unNombre, String unApellido, String unEmail, Point unLugar,
		boolean es_Antisocial, LocalDate unaFecha, double unRadioDeCercanía) {
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

	def boolean soyMenorDeEdad(LocalDate fechaActual) {
		Period.between(fechaDeNacimiento, fechaActual).years < 18
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

}
