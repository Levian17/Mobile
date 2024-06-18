// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:math';
import 'package:clicker_slayer/Pages/Selector.dart';
import 'package:flutter/material.dart';

import 'Expedicion.dart';
import 'Inventario.dart';

// IMPORTANTE REINICIAR EL AREA SELECCIONADA AL ACABAR !!!

class Regreso extends StatefulWidget {
  @override
  Content createState() => Content();
}

// Variables
bool isHoverYellow = false;
bool isHoverBlue = false;
bool dropsGenerados = false;
int posicion = 0;
int numObjetos = 0;
double margen = 0;

// Funciones
int randomInt(int min, int max) {
  // Genera un entero aleatorio entre dos parametros numericos
  Random tmp = Random();
  int random = min + tmp.nextInt(max - min);
  return random;
}

Container imagenesObjetos(
    String areaSeleccionada, List<int> objetos, BuildContext context) {
  Container imagenes;

  switch (areaSeleccionada) {
    case "tutorial":
      posicion = 0;
      break;
    case "bosque":
      posicion = 3;
      break;
    case "desierto":
      posicion = 5;
      break;
    case "oceano":
      posicion = 8;
      break;
    case "cielo":
      posicion = 10;
      break;
    case "abismo":
      posicion = 12;
      break;
  }

  if (areaSeleccionada == "tutorial" ||
      areaSeleccionada == "desierto" ||
      areaSeleccionada == "abismo") {
    imagenes = Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.12),
      child: Row(
        children: [
          for (int x = 0; x < 3; x++)
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.2,
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.075,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: listaObjetos[posicion + x].imagen)),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      objetos[x].toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
        ],
      ),
    );
  } else {
    imagenes = Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
      child: Row(
        children: [
          for (int x = 0; x < 2; x++)
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.2,
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.075,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: listaObjetos[posicion + x].imagen)),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      objetos[x].toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
        ],
      ),
    );
  }

  return imagenes;
}

void sumarObjetos() {
  int posicion = 0;
  switch (areaSeleccionada) {
    case "tutorial":
      posicion = 0;
      break;
    case "bosque":
      posicion = 3;
      break;
    case "desierto":
      posicion = 5;
      break;
    case "oceano":
      posicion = 8;
      break;
    case "cielo":
      posicion = 10;
      break;
    case "abismo":
      posicion = 12;
      break;
  }

  if (areaSeleccionada == "tutorial" ||
      areaSeleccionada == "desierto" ||
      areaSeleccionada == "abismo") {
    listaObjetos[posicion].cantidad += objetos[0];
    listaObjetos[posicion + 1].cantidad += objetos[1];
    listaObjetos[posicion + 2].cantidad += objetos[2];
  } else {
    listaObjetos[posicion].cantidad += objetos[0];
    listaObjetos[posicion + 1].cantidad += objetos[1];
  }
}

class Content extends State<Regreso> {
  @override
  Widget build(BuildContext context) {
    // Funciones de salto de Page
    mostrarMenu(BuildContext context) {
      sumarObjetos();
      enemigoDerrotados = 0;
      objetos = [0, 0, 0];
      areaSeleccionada = "";
      posicion = 0;
      numObjetos = 0;
      Navigator.of(context).pushNamed("/menu", arguments: "");
    }

    mostrarSelector(BuildContext context) {
      sumarObjetos();
      enemigoDerrotados = 0;
      objetos = [0, 0, 0];
      areaSeleccionada = "";
      posicion = 0;
      numObjetos = 0;
      Navigator.of(context).pushNamed("/selector", arguments: "");
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Marcos/regreso.png"),
                  fit: BoxFit.fill),
            ),
          ),

          // Imagen objetos
          imagenesObjetos(areaSeleccionada, objetos, context),
          // Repetir expedicion
          Container(
            alignment: Alignment.center,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
            child: InkWell(
              onHover: (val) {
                setState(() {
                  isHoverYellow = val;
                });
              },
              onTap: () => {mostrarSelector(context)},
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: isHoverYellow
                        ? Colors.orange.withOpacity(0.7)
                        : Colors.orange.withOpacity(0.25),
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  "Repetir expedicion",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            ),
          ),
          // Regresar al menu
          Container(
            alignment: Alignment.center,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.65),
            child: InkWell(
              onHover: (val) {
                setState(() {
                  isHoverBlue = val;
                });
              },
              onTap: () {
                mostrarMenu(context);
              },
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: isHoverBlue
                        ? Colors.blue.shade800.withOpacity(0.7)
                        : Colors.blue.shade800.withOpacity(0.3),
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  "Regresar al menu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
