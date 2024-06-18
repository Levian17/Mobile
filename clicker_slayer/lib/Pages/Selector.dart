// ignore_for_file: prefer_const_constructors

import 'package:clicker_slayer/Pages/Expedicion.dart';
import 'package:clicker_slayer/Pages/Inicio.dart';
import 'package:flutter/material.dart';

List<int> zonasBloqueadas = [2, 1, 0, 0, 0, 0];
String areaSeleccionada = "";

// Funcion de salto de Page
mostrarExpedicion(BuildContext context) {
  iniciando = true;
  vidaMax = player.calcularVida();
  vida = vidaMax;
  damageCorte = player.calcularDamageCorte();
  damageHabilidad = player.calcularDamageHabilidad();
  Navigator.of(context).pushNamed("/expedicion", arguments: areaSeleccionada);
}

class Selector extends StatefulWidget {
  @override
  Content createState() => Content();
}

class Content extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    crearIcon(int state) {
      switch (state) {
        case 0:
          return Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Miscelaneo/bolaGris.png"))));

        case 1:
          return Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Miscelaneo/bolaAzul.png"))));

        case 2:
          return Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Miscelaneo/bolaNaranja.png"))));
      }
    }

    crearPositioned(double x, double y, String seleccion, int zona) {
      return Positioned(
        left: MediaQuery.of(context).size.width * x,
        top: MediaQuery.of(context).size.height * y,
        child: InkWell(
          onTap: () {
            if (zonasBloqueadas[zona] > 0) {
              areaSeleccionada = seleccion;
              mostrarExpedicion(context);
            }
          },
          child: crearIcon(zonasBloqueadas[zona]),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage("assets/Marcos/mapa.jpg"),
            fit: BoxFit.fill,
          ))),
          Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: BackButton(
                color: Colors.amber,
              )),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Selecciona un area del mapa.",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 196, 175, 115),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
          Stack(
            children: [
              crearPositioned(0.835, 0.2875, "tutorial", 0),
              crearPositioned(0.51, 0.185, "bosque", 1),
              crearPositioned(0.35, 0.265, "desierto", 2),
              crearPositioned(0.15, 0.45, "oceano", 3),
              crearPositioned(0.51, 0.415, "cielo", 4),
              crearPositioned(0.55, 0.59, "abismo", 5),
            ],
          )
        ],
      ),
    );
  }
}
