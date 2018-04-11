package ar.edu.eventos

/* mosjim@gmail.com */
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.Duration
import java.time.LocalDateTime
import java.util.Set
import java.util.HashSet

@Accessors
class EventoAbierto extends Evento {

	int ValorDeLaEntrada
	Set<Entrada> entradas = new HashSet()

	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValorDeLaEntrada,
		LocalDateTime unaFechaMaximaDeConfirmacion, LocalDateTime unInicioDelEvento, LocalDateTime unFinDelEvento) {
		super(unNombre, unaLocacion, unOrganizador, unInicioDelEvento, unFinDelEvento)

		ValorDeLaEntrada = unValorDeLaEntrada
		fechaMaximaDeConfirmacion = unaFechaMaximaDeConfirmacion

	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}
    
    def cantidadTotalDeEntradasParaVender(){
    	  capacidadMaxima
    }
	def boolean esExitoso() {
		seVendioMasDelNoventaPorCientoDeLasEntradas && !fuePostergado && !fueCancelado
	}

	def boolean seVendioMasDelNoventaPorCientoDeLasEntradas() {
		cantidadTotalDeEntradasParaVender * 0.9 < cantidadDeEntradasVendidas
	}

	def boolean esUnFracaso() {
		cantidadDeEntradasVendidas > cantidadTotalDeEntradasParaVender * 0.5
	}

	def boolean hayTiempoParaConfirmar() {
		(Duration.between(fechaActual,fechaMaximaDeConfirmacion).toHours()) > 0
	}

	def void adquirirEntrada(Usuario unUsuario) {
		if (entradasDisponibles > 0 && !unUsuario.soyMenorDeEdad(fechaActual) &&
			hayTiempoParaConfirmar) 
		agregarEntradas(new Entrada(unUsuario, ValorDeLaEntrada))
	}
	
	def agregarEntradas(Entrada unaEntrada){
		entradas.add(unaEntrada)
	}
	
	def entradasDisponibles(){
		cantidadTotalDeEntradasParaVender - cantidadDeEntradasVendidas
	}

	override cancelarElEvento(Evento unEvento) {
        fueCancelado = true
    	entradas.forEach[entrada | entrada.usuario.mensajes.add("se cancelo el evento")]
		entradas.forEach[entrada|entrada.devolverEltotal()]
		entradas.clear
	}

	override postergarElEvento(Evento unEvento, LocalDateTime NuevaFechaDeInicioDelEvento) {
		fuePostergado = true
		entradas.forEach[entrada | entrada.usuario.mensajes.add("se postergo el evento")]
 		organizador.indicarNuevaFechaDeEvento(this,NuevaFechaDeInicioDelEvento) 
	}

	def int cantidadDeEntradasVendidas() {
		entradas.size
	}

	def usuarioDevuelveEntrada(Entrada unaEntrada) {
		entradas.remove(unaEntrada)
	}

	override void cambiarFecha(LocalDateTime nuevaFecha) {

		var aux = Duration.between(inicioDelEvento, nuevaFecha)
		print(aux)
		inicioDelEvento = inicioDelEvento.plus(aux)
		finDelEvento = finDelEvento.plus(aux)
		fechaMaximaDeConfirmacion = fechaMaximaDeConfirmacion.plus(aux)
	}
}
