// ignore_for_file: use_key_in_widget_constructors

import 'package:clicker_slayer/Pages/Regreso.dart';
import 'package:flutter/material.dart';
import 'Pages/Derrota.dart';
import 'Pages/Expedicion.dart';
import 'Pages/Forja.dart';
import 'Pages/Gremio.dart';
import 'Pages/Inventario.dart';
import 'Pages/Menu.dart';
import 'Pages/Selector.dart';
import 'Pages/Inicio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Clicker Slayer",

      initialRoute: "/inicio", // DEFINIMOS RUTAS
      routes: {
        "/inicio": (BuildContext context) => Inicio(),
        "/menu": (BuildContext context) => Menu(),
        "/selector": (BuildContext context) => Selector(),
        "/expedicion": (BuildContext context) => Expedicion(),
        "/derrota": (BuildContext context) => Derrota(),
        "/regreso": (BuildContext context) => Regreso(),
        "/gremio": (BuildContext context) => Gremio(),
        "/forja": (BuildContext context) => Forja(),
        "/inventario": (BuildContext context) => Inventario(),
      },
    );
  }
}
