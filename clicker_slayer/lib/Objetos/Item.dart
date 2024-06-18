// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals

import 'package:flutter/material.dart';

class Item {
  String nombre = "";
  double posicionX = 0;
  double posicionY = 0;
  int precio = 0;
  int cantidad = 0;
  AssetImage imagen = AssetImage("");

  Item(String nombre, double posicionX, double posicionY, AssetImage imagen,
      int precio) {
    this.nombre = nombre;
    this.posicionX = posicionX;
    this.posicionY = posicionY;
    this.imagen = imagen;
    this.precio = precio;
  }
}
