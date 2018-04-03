package ar.edu.eventos

/* mosjim@gmail.com */
import java.time.LocalDateTime
import java.time.Duration
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

//import java.util.stream.DoubleStream.Builder
/*Los eventos abiertos son aquellos a los cuales puede asistir cualquier persona. 
 * Para asistir se debe sacar una entrada, a través de esta misma aplicación. 
 * Si bien existen eventos abiertos gratuitos, 
 a fines prácticos consideraremos que son eventos cuya entrada vale $0.*/
@Accessors
class EventoAbierto extends Evento {

	LocalDateTime fechaMaximaParaSacarEntradas
	List<Entrada> entradas = newArrayList
	var int valorDeLAEntrada

	new(String unNombre, Locacion unaLocacion, Usuario unOrganizador, int unValor) {
		super(unNombre, unaLocacion, unOrganizador)
		valorDeLAEntrada = unValor
	}

	def double capacidadMaxima() {
		locacion.capacidadMaxima()
	}

	def double cantidadDeEntradasVendidas() {
		entradas.size()
	}

	def adquirirEntrada(Usuario unUsuario) {
		if (this.capacidadMaxima() - this.cantidadDeEntradasVendidas > 0) {
			entradas.add(new Entrada(unUsuario))

		}
	}

	/*Fecha máxima confirmación: En el caso de eventos abiertos, es hasta cuando se puede sacar entradas.  */
	def fechaMaximaDeConfirmacion() {
		this.fechaMaximaParaSacarEntradas
	}

	/*Los eventos abiertos son un éxito si se venden al menos el 90% de las entradas disponibles 
	 y no fueron cancelados o postergados.  */
	def esExitoso() {
	}

	/*Edad Mínima: (Aplicable solo a eventos abiertos). No podrán asistir 
	 al evento usuarios menores a esa edad.  */
	/* En el caso de eventos abiertos, si se venden menos del 50% de las entradas.  */
	def esUnFracaso() {
	}
}
