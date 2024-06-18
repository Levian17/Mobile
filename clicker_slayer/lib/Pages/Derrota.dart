// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:clicker_slayer/Pages/Expedicion.dart';
import 'package:flutter/material.dart';

// Variables
bool isHoverGreen = false;
bool isHoverBlue = false;

// Funciones de salto de Page
mostrarMenu(BuildContext context) {
  enemigoDerrotados = 0;
  Navigator.of(context).pushNamed("/menu", arguments: "");
}

mostrarSelector(BuildContext context) {
  enemigoDerrotados = 0;
  Navigator.of(context).pushNamed("/selector", arguments: "");
}

class Derrota extends StatefulWidget {
  @override
  Content createState() => Content();
}

class Content extends State<Derrota> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Imagen de fondo
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Marcos/derrota.png"),
                fit: BoxFit.fill)),
        child: Stack(
          children: [
            // Texto 1
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.65),
                child: Center(
                    child: Text(
                  "Has muerto, tu codicia te llevó a ser derrotado.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )),
              ),
            ),
            // Texto 2
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.6),
                child: Text(
                  "El precio por recuperar tu vida es la mitad del oro que portas.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            // Imagen moneda
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.2),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Miscelaneo/moneda.png"))),
              ),
            ),
            // Texto oro
            Container(
              alignment: Alignment.center,
              child: Text(
                (oro * 2).toString() + "   ->   " + oro.toString(),
                style: TextStyle(color: Colors.amber, fontSize: 26),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: InkWell(
                onHover: (val) {
                  setState(() {
                    isHoverGreen = val;
                  });
                },
                onTap: () => {mostrarSelector(context)},
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                  ),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: isHoverGreen
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
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
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
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                  ),
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
      ),
    );
  }
}
