// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable, unnecessary_new, unused_local_variable

import 'package:clicker_slayer/Objetos/Player.dart';
import 'package:clicker_slayer/Objetos/Unidad.dart';
import 'package:flutter/material.dart';

Player player = new Player(creacionNombre, creacionContra,
          creacionCorreo, 0, "0,0,0", "0,0,0,0,0,0,0,0,0");

// Variables
String nombre = "";
String password = "";
String correo = "";
int oro = 0;
String lvlObjetos = "";
String numUnidades = "";

List<Unidad> unidades = [
  Unidad(
      "Soldado",
      "Soldado estandar dentro de los batallones, hace uso de su espada para abrirse paso entre los enemigos. Destaca por el uso de fuerza bruta y agilidad.",
      "assets/Iconos/soldado.png",
      "assets/Animaciones/soldado.gif",
      10,
      0.1),
  Unidad(
      "Arquero",
      "Expertos en el uso de arcos y flechas, mantienen la distancia mientras acribillan al enemigo con una lluvia de proyectiles.",
      "assets/Iconos/arquero.png",
      "assets/Animaciones/arquero.gif",
      100,
      1),
  Unidad(
      "Asesino",
      "Una unidad de élite especializada en asesinar desde las sombras. Sus dagas y habilidades de camuflaje los hacen letales dentro del campo de batalla.",
      "assets/Iconos/asesino.png",
      "assets/Animaciones/asesino.gif",
      1000,
      10),
  Unidad(
      "Jinete",
      "Un maestro jinete, hábil en el arte de la equitación y la guerra montada. Su destreza táctica lo convierten en una fuerza imparable en el fragor de la batalla.",
      "assets/Iconos/jinete.png",
      "assets/Animaciones/jinete.gif",
      10000,
      100),
  Unidad(
      "Mago",
      "Un mago experto, controla los misterios arcanos con habilidad letal. Sus hechizos y dominio de la magia lo elevan por encima del resto de mercenarios.",
      "assets/Iconos/mago.png",
      "assets/Animaciones/mago.gif",
      100000,
      1000),
  Unidad(
      "Acorazado",
      "Un caballero completamente equipado en armadura impenetrable cuya lanza es capaz de partir soldados en dos. Acostumbran a liderar batallones.",
      "assets/Iconos/acorazado.png",
      "assets/Animaciones/acorazado.gif",
      1000000,
      10000),
  Unidad(
      "J.Pegaso",
      "Su destreza en la equitación aérea y sus precisos ataques desde el aire lo convierten en una figura legendaria en el campo de batalla.",
      "assets/Iconos/pegaso.png",
      "assets/Animaciones/pegaso.gif",
      10000000,
      100000),
  Unidad(
      "Archimago",
      "Mago de poder inigualable, cuyo dominio de los arcanos desafía los límites de la comprensión humana. Su hechizos rasgan el mismo tejido del universo.",
      "assets/Iconos/archimago.png",
      "assets/Animaciones/archimago.gif",
      100000000,
      1000000),
  Unidad(
      "J.Wyvern",
      "Tiene un fokin dragon, se la mama todo.",
      "assets/Iconos/dragon.png",
      "assets/Animaciones/dragon.gif",
      1000000000,
      10000000),
];

// Variables BD
String inicioNombre = "";
String inicioContra = "";

String creacionNombre = "";
String creacionCorreo = "";
String creacionContra = "";
String creacionContraRep = "";

String mensajeError = "";
final formkey = GlobalKey<FormState>();

// Variables UI
bool isHoverGreen = false;
bool isHoverBlue = false;

// FUNCION PARA MOSTRAR DATOS CONTACTO
mostrarMenu(BuildContext context) {
  Navigator.of(context).pushNamed("/menu");
}

// Muestra un SnackBar
showSnackBar(BuildContext context, String mensaje, MaterialColor color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: Duration(milliseconds: 1000),
      content: Text(
        mensaje,
        style: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      )));
}

class Inicio extends StatefulWidget {
  @override
  Content createState() => Content();
}

class Content extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: Image.asset("assets/Marcos/fondoInicio.jpg").image,
          fit: BoxFit.fill,
        )),
        child: Column(
          // Imagen logo
          children: [
            Center(
                child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Image.asset(
                "assets/titulo.png",
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.4,
              ),
            )),
            Container(
              // Linea
              height: 5,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.4),
              decoration: BoxDecoration(
                  color: Colors.black, border: Border.all(color: Colors.black)),
            ),
            InkWell(
              onHover: (val) {
                setState(() {
                  isHoverGreen = val;
                });
              },
              onTap: () => setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: AlertDialog(
                            title: Text(
                              "Inicio de Sesión",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 30),
                            ),
                            content: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  Container(
                                    height: 3,
                                    color: Colors.green,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Usuario / Cuenta",
                                    ),
                                    onSaved: (value) {
                                      inicioNombre = value!;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Contraseña",
                                    ),
                                    onSaved: (value) {
                                      inicioContra = value!;
                                    },
                                    obscureText: true,
                                  ),
                                  if (mensajeError.isNotEmpty)
                                    Text(
                                      mensajeError,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  Spacer(),
                                  Container(
                                    height: 1,
                                    color: Colors.green,
                                  ),
                                  TextButton(
                                      onPressed: () => Navigator.of(context).popAndPushNamed("/menu"),
                                      child: Text(
                                        "Iniciar",
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 22),
                                      )),
                                ],
                              ),
                            )),
                      );
                    });
              }),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: isHoverGreen
                        ? Colors.green.withOpacity(0.7)
                        : Colors.green.withOpacity(0.25),
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  "Iniciar Sesion",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            ),
            InkWell(
              onHover: (val) {
                setState(() {
                  isHoverBlue = val;
                });
              },
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: AlertDialog(
                            title: Text(
                              "Creación de cuenta",
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 30),
                            ),
                            content: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 3,
                                      color: Colors.orange,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Nombre Usuario",
                                      ),
                                      onSaved: (value) {
                                        creacionNombre = value!;
                                      },
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Correo electrónico",
                                      ),
                                      onSaved: (value) {
                                        creacionCorreo = value!;
                                      },
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Contraseña",
                                      ),
                                      onSaved: (value) {
                                        creacionContra = value!;
                                      },
                                      obscureText: true,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Repetir contraseña",
                                      ),
                                      onSaved: (value) {
                                        creacionContraRep = value!;
                                      },
                                      obscureText: true,
                                    ),
                                    Spacer(),
                                    if (mensajeError.isNotEmpty)
                                      Text(
                                        mensajeError,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    Container(
                                      height: 1,
                                      color: Colors.orange,
                                    ),
                                    TextButton(
                                        onPressed: () => {
                                          showSnackBar(context, "Cuenta Registrada.", Colors.orange,),
                                          Navigator.of(context).pop()
                                        },
                                        child: Text(
                                          "Confirmar",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 22),
                                        )),
                                  ],
                                ))),
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: isHoverBlue
                        ? Colors.orange.withOpacity(0.7)
                        : Colors.orange.withOpacity(0.3),
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  "Crear Cuenta",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
