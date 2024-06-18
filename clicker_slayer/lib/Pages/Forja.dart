// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:async';
import 'package:clicker_slayer/Pages/Inicio.dart';
import 'package:flutter/material.dart';

class Forja extends StatefulWidget {
  @override
  Content createState() => Content();
}

// Variables
bool flame = false;
int precio = 0;
double height = 100;
double width = 100;
double sizeFlame = 70;
AssetImage fondo = AssetImage("assets/Marcos/forja.png");
AssetImage mana = AssetImage("assets/Miscelaneo/anillo.png");
AssetImage armadura = AssetImage("assets/Miscelaneo/armadura.png");
AssetImage espada = AssetImage("assets/Miscelaneo/espada.png");
AssetImage imagenLlamaDrag = AssetImage("assets/Animaciones/llama.gif");
AssetImage imagenLlamaOrigen = AssetImage("assets/Animaciones/llama.gif");

class Content extends State<Forja> {
  // Temporizadores
  Timer milisegundos = Timer(Duration(), () {});
  @override
  void initState() {
    super.initState();

    milisegundos = Timer.periodic(Duration(milliseconds: 10), (Timer t) {
      setState(() {
        if (flame) {
          if (height <= 400 || width <= 400) {
            height += 1.5;
            width += 1.5;
          } else {
            imagenLlamaDrag = AssetImage("assets/Animaciones/llama.gif");
            imagenLlamaOrigen = AssetImage("");
            sizeFlame = 110;
          }
        } else {
          if (height >= 100 || width >= 100) {
            height -= 1;
            width -= 1;
          } else {
            imagenLlamaDrag = AssetImage("");
            imagenLlamaOrigen = AssetImage("assets/Animaciones/llama.gif");
            sizeFlame = 70;
          }
        }
      });
    });
  }

  // Funciones de salto de Page
  mostrarMenu(BuildContext context) {
    flame = false;
    height = 100;
    width = 100;
    Navigator.of(context).pushNamed("/menu");
    milisegundos.cancel();
  }

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
                  "Ayuda - Forja",
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
                        "\nAcabas de abrir la forja. La forja esta destinada a mejorar tu equipamiento para que puedas hacer frente a enemigos de mayor nivel, para mejorar tu equipo necesitaras oro y objetos especiales, al seleccionar una pieza de tu equipo apareceran sus requisitos de mejora.\n\nPara empezar a mejorar tu equipación pulsa la llama para avivarla y arrastrala hasta la pieza de equipo que quieras mejorar.",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        // Energia
        Center(
          child: Container(
            height: height,
            width: width,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2625),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10000),
                color: const Color.fromARGB(255, 33, 243, 191)),
          ),
        ),
        // Fondo
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(image: fondo, fit: BoxFit.fill)),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.8,
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.125,
            top: MediaQuery.of(context).size.height * 0.045,
          ),
          child: Row(
            children: [
              // Magia
              DragTarget<int>(
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.125,
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.165),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 33, 243, 191),
                                width: 2),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(image: mana)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              double tmp = 100;
                              for (int x = 0; x < player.lvlMana; x++) {
                                tmp *= 1.1;
                              }

                              precio = tmp.round();
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
                onAccept: (data) {
                  setState(() {
                    if (flame && precio > 0 && player.oro >= precio) {
                      flame = false;
                      sizeFlame = 70;
                      height = 100;
                      width = 100;

                      player.oro -= precio;

                      player.lvlMana += 1;
                      double tmp = 100;
                      for (int x = 0; x < player.lvlMana; x++) {
                        tmp *= 1.1;
                      }

                      precio = tmp.round();
                      mana.evict();
                      mana = AssetImage("assets/Animaciones/anillo.gif");
                    }
                  });
                },
              ),
              // Espada
              DragTarget<int>(
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.125,
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.125),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 33, 243, 191),
                                width: 2),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(image: espada)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              double tmp = 20;
                              for (int x = 0; x < player.lvlEspada; x++) {
                                tmp *= 1.1;
                              }

                              precio = tmp.round();
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
                onAccept: (data) {
                  setState(() {
                    if (flame && precio > 0 && player.oro >= precio) {
                      flame = false;
                      sizeFlame = 70;
                      height = 100;
                      width = 100;

                      player.oro -= precio;

                      player.lvlEspada += 1;
                      double tmp = 20;
                      for (int x = 0; x < player.lvlEspada; x++) {
                        tmp *= 1.1;
                      }

                      precio = tmp.round();
                      espada.evict();
                      espada = AssetImage("assets/Animaciones/espada.gif");
                    }
                  });
                },
              ),
              // Armadura
              DragTarget<int>(
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.125,
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.165),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 33, 243, 191),
                                width: 2),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(image: armadura)),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              double tmp = 50;
                              for (int x = 0; x < player.lvlArmadura; x++) {
                                tmp *= 1.1;
                              }

                              precio = tmp.round();
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
                onAccept: (data) {
                  setState(() {
                    if (flame && precio > 0 && player.oro >= precio) {
                      flame = false;
                      sizeFlame = 70;
                      height = 100;
                      width = 100;

                      player.oro -= precio;

                      player.lvlArmadura += 1;
                      double tmp = 50;
                      for (int x = 0; x < player.lvlArmadura; x++) {
                        tmp *= 1.1;
                      }

                      precio = tmp.round();
                      armadura.evict();
                      armadura = AssetImage("assets/Animaciones/armadura.gif");
                    }
                  });
                },
              ),
            ],
          ),
        ),
        // Tu oro
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.055,
            width: MediaQuery.of(context).size.width * 0.6,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.5525,
                left: MediaQuery.of(context).size.width * 0.2),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                border:
                    Border.all(color: Colors.black.withOpacity(0.7), width: 3),
                borderRadius: BorderRadius.circular(5)),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    player.oro.toString(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 139, 7),
                        fontSize: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.01),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Miscelaneo/moneda.png"))),
                  ),
                )
              ],
            ),
          ),
        ),
        // Objetos mejora
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.085,
            width: MediaQuery.of(context).size.width * 0.6,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.105,
                left: MediaQuery.of(context).size.width * 0.2),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                border:
                    Border.all(color: Colors.black.withOpacity(0.7), width: 3),
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        // Oro mejora
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.055,
            width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.04,
                left: MediaQuery.of(context).size.width * 0.25),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                border:
                    Border.all(color: Colors.black.withOpacity(0.7), width: 3),
                borderRadius: BorderRadius.circular(5)),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    precio.toString(),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 255, 139, 7),
                        fontSize: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.01),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Miscelaneo/moneda.png"))),
                  ),
                )
              ],
            ),
          ),
        ),
        // Llama
        Draggable(
          data: precio,
          feedback: Container(
            height: sizeFlame,
            width: sizeFlame,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.57,
                left: MediaQuery.of(context).size.width * 0.375),
            decoration:
                BoxDecoration(image: DecorationImage(image: imagenLlamaDrag)),
          ),
          childWhenDragging: Container(
              height: sizeFlame,
              width: sizeFlame,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.57,
                  left: MediaQuery.of(context).size.width * 0.375),
              decoration: BoxDecoration(
                image: DecorationImage(image: imagenLlamaOrigen),
              )),
          child: Align(
            alignment: Alignment.center,
            child: Container(
                height: sizeFlame,
                width: sizeFlame,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Animaciones/llama.gif"))),
                child: InkWell(
                  onTap: () => setState(() {
                    flame = !flame;
                  }),
                )),
          ),
        ),
        // Regresar al menu
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.15,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.06,
                  left: MediaQuery.of(context).size.width * 0.025,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Miscelaneo/volver.png")),
                ),
                child: InkWell(
                  onTap: () => mostrarMenu(context),
                ))),
        // Informacion
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.15,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.06,
                  right: MediaQuery.of(context).size.width * 0.025,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Miscelaneo/ayuda.png")),
                ),
                child: InkWell(
                  onTap: () => ayuda(context),
                )))
      ]),
    );
  }
}
