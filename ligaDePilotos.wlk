object vortex {
  var bateria = 100
  
  method anioFabricacion() = 1998

  method expRequerida() = 5

  method puedeUsarlo(piloto) = piloto.experiencia() >= self.expRequerida()

  method tieneBateria() = bateria > 10

  method conducir(piloto){
    bateria = 0.max(bateria - 30)
  }

  method expOtorgada() = 2

  method recargar(horas){
    bateria += horas * 40
  }

}

object nebula {
  var bateria = 100
  var modoConduccion = inicial
  
  method anioFabricacion() = 2009

  method expRequerida() = 3

  method puedeUsarlo(piloto) = piloto.experiencia() >= self.expRequerida()

  method tieneBateria() = bateria > 20 

  method conducir(piloto){
    bateria = 0.max(bateria - modoConduccion.consumo())
  }

  method expOtorgada() = modoConduccion.experiencia()

  method recargar(horas){
    bateria += horas * 30
  }

  method cambiarModo(modo){
    modoConduccion = modo
  }
}

object inicial{
  method experiencia() = 0
  method consumo() = 10
}

object intermedio{
  method experiencia() = 2
  method consumo() = 20
}

object avanzado{
  method experiencia() = 5
  method consumo() = 35
}
object quantum {
  
  method anioFabricacion() = 2004

  method expRequerida() = 0

  method puedeUsarlo(piloto) = true

  method tieneBateria() = true

  method conducir(piloto){

  }

  method expOtorgada() = 1

  method recargar(horas){

  }
}



object kaelVarela {
  var experiencia = 3
  var descansado = true
  const autosManejados = #{}

  method experiencia() = experiencia

  method conducir(auto){
    if(auto.puedeUsarlo(self) && auto.tieneBateria() && descansado){
      auto.conducir(self)
      experiencia += auto.expOtorgada()
      descansado = false
      autosManejados.add(auto)
    }
  }

  method dormir(){
    descansado = true
  }

  method estaFeliz() = autosManejados == formulaF.autos().asSet()

}

object novaIshari {
  var experiencia = 5
  var ultimoAuto = quantum

  method experiencia() = experiencia

  method conducir(auto){
    if(auto.puedeUsarlo(self) && auto.tieneBateria()){
      auto.conducir(self)
      experiencia += auto.expOtorgada()
      ultimoAuto = auto
    }
  }

  method estaFeliz() = ultimoAuto.anioFabricacion() < 2000
}

object axelDraven {
  var experiencia = 0
  var cantPruebas = 0

  method experiencia() = experiencia

  method conducir(auto){
    if((auto.anioFabricacion() > 2000) && cantPruebas < 5 && auto.tieneBateria()){
      auto.conducir(self)
      experiencia += auto.expOtorgada()
      cantPruebas += 1
    }
  }

  method estaFeliz()= cantPruebas > 0
}

object formulaF {
  const pilotos = [axelDraven, novaIshari, kaelVarela]
  const property autos = [vortex, nebula, quantum]
  
  method agregarPiloto(piloto){
    pilotos.add(piloto)
  }

  method agregarAuto(auto){
    autos.add(autos)
  }

  method pilotar(unAuto, unPiloto){
    unPiloto.conducir(unAuto)
  }

  method pilotarTodos(piloto){
    autos.forEach({a =>
      piloto.conducir(a)
    })
  }

  method expTotalPilotos() = pilotos.sum({p => p.experiencia()})

  method promedioExpPilotos() = self.expTotalPilotos() / pilotos.size()

  method pilotoMaxExp() = pilotos.max({unPiloto => unPiloto.experiencia()})

  method listaAniosFabricacion() = autos.map({a => a.anioFabricacion()})

  method autosNoPuedenCorrer() = autos.filter({a => !a.tieneBateria()})

  method todosEnCond() = autos.all({a => a.tieneBateria()})

  method estaRealizado(piloto) = piloto.estaFeliz()

}
