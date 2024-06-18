// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:clicker_slayer/Objetos/Item.dart';
import 'package:clicker_slayer/Pages/Inicio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inventario extends StatefulWidget {
  @override
  Content createState() => Content();
}

// Funciones de salto de Page
mostrarMenu(BuildContext context) {
  seleccionado = Item("", 0, 0, AssetImage("url"), 0);
  Navigator.of(context).pushNamed("/menu");
}

int calcularEspada() {
  int state = 0;

  if (player.lvlEspada < 5) {
    state = 0;
  } else if (player.lvlEspada > 4 && player.lvlEspada < 10) {
    state = 1;
  } else if (player.lvlEspada >= 10 && player.lvlEspada < 15) {
    state = 2;
  } else if (player.lvlEspada >= 15 && player.lvlEspada < 20) {
    state = 3;
  } else if (player.lvlEspada >= 20 && player.lvlEspada < 25) {
    state = 4;
  } else if (player.lvlEspada >= 25) {
    state = 5;
  }

  return state;
}

// Variables
Item seleccionado = Item("", 0, 0, AssetImage("url"), 0);
AssetImage espada = AssetImage("");
List<AssetImage> espadas = [
  AssetImage("assets/Miscelaneo/espada1.png"),
  AssetImage("assets/Miscelaneo/espada2.png"),
  AssetImage("assets/Miscelaneo/espada3.png"),
  AssetImage("assets/Miscelaneo/espada4.png"),
  AssetImage("assets/Miscelaneo/espada5.png"),
  AssetImage("assets/Miscelaneo/espada6.png"),
];
List<Item> listaObjetos = [
  Item("Garra Curva", 0, 0.0, AssetImage("assets/Objetos/garra.png"), 100),
  Item("Cuerno Hueco", 0.25, 0.0, AssetImage("assets/Objetos/cuerno.png"), 120),
  Item(
      "Mineral Hierro", 0.5, 0.0, AssetImage("assets/Objetos/mineral.png"), 75),
  Item(
      "Semilla Aurea ", 0, 0.1, AssetImage("assets/Objetos/semilla.png"), 1000),
  Item("Flor Tóxica", 0.25, 0.1, AssetImage("assets/Objetos/flor.png"), 1115),
  Item("Planta Rodadora", 0.5, 0.1, AssetImage("assets/Objetos/rodadora.png"),
      10525),
  Item("Panal de larva", 0, 0.2, AssetImage("assets/Objetos/larva.png"), 11000),
  Item("Cola cortada", 0.25, 0.2, AssetImage("assets/Objetos/cola.png"), 9750),
  Item("Slime marino", 0.5, 0.2, AssetImage("assets/Objetos/slime.png"), 95750),
  Item("Coral cristalizado", 0, 0.3, AssetImage("assets/Objetos/coral.png"),
      10500),
  Item("Pluma Alada", 0.25, 0.3, AssetImage("assets/Objetos/pluma.png"),
      1000000),
  Item("Pluma Celestial", 0.5, 0.3,
      AssetImage("assets/Objetos/pluma_celeste.png"), 1075000),
  Item("Fragmento de Estrella", 0, 0.4,
      AssetImage("assets/Objetos/estrella.png"), 1100000000),
  Item("Mal Karma", 0.25, 0.4, AssetImage("assets/Objetos/karma.png"),
      1100000000),
  Item("Nucleo Diabólico", 0.5, 0.4, AssetImage("assets/Objetos/nucleo.png"),
      1100000000),
];
List<bool> hoverStates = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

// Funcion de ayuda (muestra un showdialog con ayuda al usuario)
ayuda(BuildContext context) {
  // Muestra un AlertDialog con las estadisticas del equipo
  Color color = Color.fromARGB(255, 226, 174, 95);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.7),
              title: Text(
                "Ayuda - Inventario",
                textAlign: TextAlign.center,
                style: TextStyle(color: color, fontSize: 28),
              ),
              content: Stack(
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(color: color),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "\nTe encuentras en la pantalla de inventario. Aqui podras comprobar existencias de objetos, vender aquellos objetos que te sobren a cambio de dinero o comprobar el estado de tu espada.\n\nPara empezar a vender selecciona un objeto y presiona el botón de la bolsa.",
                      style: TextStyle(
                        fontSize: 16,
                        color: color,
                      ),
                    ),
                  ),
                ],
              )),
        );
      });
}

class Content extends State<Inventario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Fondo / Marco
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Marcos/inventario.png"),
                fit: BoxFit.fill),
          ),
        ),
        // Espada
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.65,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.175,
              top: MediaQuery.of(context).size.height * 0.05),
          decoration: BoxDecoration(
              image: DecorationImage(image: espadas[calcularEspada()])),
        ),
        // Panel con los items
        Container(
            height: MediaQuery.of(context).size.height * 0.555,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.175,
                left: MediaQuery.of(context).size.width * 0.1),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                border:
                    Border.all(color: Colors.black.withOpacity(0.5), width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                for (int x = 0; x < listaObjetos.length; x++)
                  Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.23,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height *
                            (listaObjetos[x].posicionY + 0.0155),
                        left: MediaQuery.of(context).size.width *
                            listaObjetos[x].posicionX,
                      ),
                      decoration: BoxDecoration(
                          color: hoverStates[x]
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                          image: DecorationImage(image: listaObjetos[x].imagen),
                          borderRadius: BorderRadius.circular(50)),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            seleccionado = listaObjetos[x];
                          });
                        },
                        onHover: (val) {
                          setState(() {
                            hoverStates[x] = val;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2,
                              top: MediaQuery.of(context).size.width * 0.15),
                          child: Text(
                            listaObjetos[x].cantidad.toString(),
                            style: GoogleFonts.pressStart2p(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ))
              ],
            )),
        // Boton vender
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.25,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.75,
              left: MediaQuery.of(context).size.width * 0.1),
          decoration: BoxDecoration(
              color: hoverStates[15]
                  ? Colors.orange.withOpacity(0.65)
                  : Colors.black.withOpacity(0.3),
              border:
                  Border.all(color: Colors.black.withOpacity(0.5), width: 3),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: AssetImage("assets/Miscelaneo/bolsaVender.png"))),
          child: InkWell(
              onTap: () {
                setState(() {
                  if (seleccionado.cantidad > 0) {
                    player.oro += seleccionado.precio;
                    seleccionado.cantidad--;
                  }
                });
              },
              onHover: (value) => setState(() {
                    hoverStates[15] = value;
                  })),
        ),
        // Nombre
        Container(
          height: MediaQuery.of(context).size.height * 0.045,
          width: MediaQuery.of(context).size.width * 0.53,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.75,
            left: MediaQuery.of(context).size.width * 0.37,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border.all(color: Colors.black.withOpacity(0.5), width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              seleccionado.nombre,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Precio
        Container(
          height: MediaQuery.of(context).size.height * 0.045,
          width: MediaQuery.of(context).size.width * 0.53,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.805,
            left: MediaQuery.of(context).size.width * 0.37,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border.all(color: Colors.black.withOpacity(0.5), width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  seleccionado.precio.toString(),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.06,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.44),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Miscelaneo/moneda.png"))),
              ),
            ],
          ),
        ),
        // Boton de regreso
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.2,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.87,
              left: MediaQuery.of(context).size.width * 0.25),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Miscelaneo/volver.png"))),
          child: InkWell(
            onTap: () => mostrarMenu(context),
          ),
        ),
        // Boton de información
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.2,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.87,
              left: MediaQuery.of(context).size.width * 0.52),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Miscelaneo/ayuda.png"))),
          child: InkWell(
            onTap: () => ayuda(context),
          ),
        )
      ],
    ));
  }
}
