// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:clicker_slayer/Objetos/Unidad.dart';
import 'package:clicker_slayer/Pages/Expedicion.dart';
import 'package:clicker_slayer/Pages/Inicio.dart';
import 'package:flutter/material.dart';

Unidad unidadSeleccionada = Unidad("", "", "", "", 0, 0);

// Funciones generales
double calcularImpacto(Unidad unidad) {
  double impacto = 0;
  double total = 0;

  for (int x = 0; x < unidades.length; x++) {
    total += unidades[x].cantidad * unidades[x].damage;
  }

  impacto = unidad.cantidad * unidad.damage / total * 100;

  return impacto;
}

double calcularDPS() {
  double dps = 0;

  for (Unidad unidad in unidades) {
    dps += (unidad.cantidad * unidad.damage);
  }

  if (timerBlessingBuff > 0) {
    dps *= 1.5;
  }

  return dps;
}

String mostrarTexto(int num) {
  String numString = "";

  if (num < 1000000) {
    numString = num.toString();
  } else if (num < 1000000000) {
    numString = (num / 1000000).toStringAsFixed(1) + "M";
  } else {
    numString = (num / 1000000000).toStringAsFixed(1) + "B";
  }

  return numString;
}

// Funciones de salto de Page
mostrarMenu(BuildContext context) {
  Navigator.of(context).pushNamed("/menu");
}

class Gremio extends StatefulWidget {
  @override
  Content createState() => Content();
}

class Content extends State<Gremio> {
  @override
  Widget build(BuildContext context) {
    // Funciones generales

    Color procesarColor(Unidad unidad) {
      Color color;
      if (unidad.precioBase > player.oro) {
        color = Color.fromARGB(255, 116, 114, 114);
      } else {
        color = Color.fromARGB(255, 255, 208, 147).withOpacity(0.7);
      }
      return color;
    }

    crearUnidad(Unidad unidad) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: procesarColor(unidad),
            border: Border.all(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () => setState(() {
            unidadSeleccionada = unidad;
          }),
          onDoubleTap: () => setState(() {
            unidadSeleccionada = unidad;

            if (unidadSeleccionada.precioBase <= player.oro) {
              unidadSeleccionada.cantidad++;
              player.oro -= unidadSeleccionada.precioBase;
              unidadSeleccionada.precioBase =
                  (unidadSeleccionada.precioBase * 1.1).round();
            }
          }),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  // Imagen
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(unidad.urlIcon), fit: BoxFit.fill)),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  // Texto nombre
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.28,
                      top: 12.5),
                  child: Text(
                    unidad.nombre,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  // Texto contratados
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03,
                    left: MediaQuery.of(context).size.width * 0.28,
                  ),
                  child: Text(
                    "Contratados: " + unidad.cantidad.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  // Texto impacto
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.28,
                      bottom: MediaQuery.of(context).size.height * 0.005),
                  child: Text(
                    "Impacto: " +
                        calcularImpacto(unidad).toStringAsFixed(2) +
                        "%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // Precio
                  width: MediaQuery.of(context).size.width * 0.2,
                  margin: EdgeInsets.only(top: 14),
                  child: Text(
                    mostrarTexto(unidad.precioBase),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // Imagen moneda
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.1,
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Miscelaneo/moneda.png"))),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Metodo encargado de crear y controlar la mejora del examen
    crearMejoraExamen(Unidad unidad) {
      // Variables
      bool disponible = false;
      int unidadesCompradas = 0;
      double mejorasExamenDisponibles = 0;

      // Calculamos las unidades que tiene compradas el usuario (¡Solo suman a la cuenta aquellas que no son mejora de examen!)
      for (Unidad unidad in unidades) {
        unidadesCompradas += unidad.cantidad;
      }
      unidadesCompradas -= unidades[unidades.length - 1].cantidad;

      // Calculamos las mejoras de examen que deberia tener disponible el jugador en relacion a las unidades compradas
      for (int x = 1; x <= unidadesCompradas; x++) {
        if (x % 5 == 0) {
          mejorasExamenDisponibles++;
        }
      }

      // Hacemos que la mejora este habilitada solo si tiene las unidades compradas necesarias y si tiene el oro necesario para comprar la mejora
      if (mejorasExamenDisponibles - unidades[unidades.length - 1].cantidad >=
              1 &&
          player.oro > unidades[unidades.length - 1].precioBase) {
        disponible = true;
      }

      // Si la mejora esta disponible la devolvemos con color crema y las propiedades onTap() y onDoubleTap() habilitadas
      if (disponible) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 208, 147).withOpacity(0.7),
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => setState(() {
              unidadSeleccionada = unidad;
            }),
            onDoubleTap: () => setState(() {
              unidadSeleccionada = unidad;

              if (unidadSeleccionada.precioBase <= player.oro) {
                unidadSeleccionada.cantidad++;
                player.oro -= unidadSeleccionada.precioBase;
                unidadSeleccionada.precioBase =
                    (unidadSeleccionada.precioBase * 1.1).round();
              }

              unidadSeleccionada = Unidad("", "", "", "", 0, 0);
            }),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    // Imagen
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(unidad.urlIcon),
                            fit: BoxFit.fill)),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    // Texto nombre
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.28,
                        top: 12.5),
                    child: Text(
                      unidad.nombre,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    // Texto contratados
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      left: MediaQuery.of(context).size.width * 0.28,
                    ),
                    child: Text(
                      "Contratados: " + unidad.cantidad.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    // Texto impacto
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.28,
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    child: Text(
                      "Impacto: " +
                          calcularImpacto(unidad).toStringAsFixed(2) +
                          "%",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    // Precio
                    width: MediaQuery.of(context).size.width * 0.2,
                    margin: EdgeInsets.only(top: 14),
                    child: Text(
                      mostrarTexto(unidad.precioBase),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    // Imagen moneda
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.1,
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Miscelaneo/moneda.png"))),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        // Si la mejora no esta disponible la devolvemos con color gris y las propiedades onTap() y onDoubleTap() deshabilitadas
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 116, 114, 114),
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => setState(() {}),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    // Imagen
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(unidad.urlIcon),
                            fit: BoxFit.fill)),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    // Texto nombre
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.28,
                        top: 12.5),
                    child: Text(
                      unidad.nombre,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    // Texto contratados
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                      left: MediaQuery.of(context).size.width * 0.28,
                    ),
                    child: Text(
                      "Contratados: " + unidad.cantidad.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    // Texto impacto
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.28,
                        bottom: MediaQuery.of(context).size.height * 0.005),
                    child: Text(
                      "Impacto: " +
                          calcularImpacto(unidad).toStringAsFixed(2) +
                          "%",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    // Precio
                    width: MediaQuery.of(context).size.width * 0.2,
                    margin: EdgeInsets.only(top: 14),
                    child: Text(
                      mostrarTexto(unidad.precioBase),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    // Imagen moneda
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.1,
                    margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Miscelaneo/moneda.png"))),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: Container(
        // Imagen de fondo
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Marcos/gremio.png"),
                fit: BoxFit.fill)),
        child: Stack(
          children: [
            Container(
              // Pantalla 1
              height: MediaQuery.of(context).size.height * 0.28,
              width: MediaQuery.of(context).size.width * 0.923,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.022,
                left: MediaQuery.of(context).size.width * 0.04,
              ),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(color: Colors.black, width: 1.5)),
              child: Stack(
                children: [
                  Align(
                    // GIF
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(unidadSeleccionada.urlGif)),
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Align(
                    // Contratar
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.035,
                      width: MediaQuery.of(context).size.width * 0.2,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.023,
                        right: MediaQuery.of(context).size.width * 0.4,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (unidadSeleccionada.precioBase <= player.oro) {
                              unidadSeleccionada.cantidad++;
                              player.oro -= unidadSeleccionada.precioBase;
                              unidadSeleccionada.precioBase =
                                  (unidadSeleccionada.precioBase * 1.1).round();
                            }

                            unidadSeleccionada = Unidad("", "", "", "", 0, 0);
                          });
                        },
                        child: Center(
                          child: Text(
                            "CONTRATAR",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    // Descripcion
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.135,
                      width: MediaQuery.of(context).size.width * 0.35,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.065,
                        right: MediaQuery.of(context).size.width * 0.55,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        unidadSeleccionada.descripcion,
                        style: TextStyle(color: Colors.white, fontSize: 14.5),
                      ),
                    ),
                  ),
                  Align(
                    // Oro
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.35,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.02,
                          left: MediaQuery.of(context).size.width * 0.0075),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.085),
                            child: Text(
                              mostrarTexto(player.oro) + " -",
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 18),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.1,
                            margin: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.width * 0.235),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/Miscelaneo/moneda.png"))),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // Pantalla 2
              height: MediaQuery.of(context).size.height * 0.62,
              width: MediaQuery.of(context).size.width * 0.86,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.3525,
                left: MediaQuery.of(context).size.width * 0.0695,
              ),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(color: Colors.black, width: 1.5)),
              child: ListView(
                children: [
                  for (int x = 0; x < unidades.length - 1; x++)
                    crearUnidad(unidades[x]),
                  crearMejoraExamen(unidades[unidades.length - 1])
                ],
              ),
            ),
            // Imagen volver
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.12,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.885,
                    right: MediaQuery.of(context).size.width * 0.785),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Miscelaneo/volver.png"))),
                child: InkWell(onTap: () {
                  unidadSeleccionada = Unidad("", "", "", "", 0, 0);
                  mostrarMenu(context);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
