package Prueba

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Label
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel

class Menu extends MainWindow<MenuApp> {
	
	
	new() {
		super(new MenuApp)
	}

	override createContents(Panel mainPanel) {
		
		
		this.title = "Menu Principal"
		this.minHeight = 10000
		this.minWidth = 10000
		
		new Label(mainPanel).text = "TE AMO AMORCHUUUUUUU"+"\n"+"asdasd"
		new TextBox(mainPanel).value
		new ErrorsPanel(mainPanel, "Listo para convertir")
	}

	def static main(String[] args) {
		new Menu().startApplication
	}

}

@Accessors
@Observable
class MenuApp {
}
