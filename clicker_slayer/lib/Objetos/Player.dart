// ignore_for_file: unnecessary_this, prefer_initializing_formals

import 'package:clicker_slayer/Pages/Inicio.dart';

class Player {
  // Variables BBDD
  String nombre = "";
  String password = "";
  String correo = "";
  int oro = 0;
  String nivelObjetos = "";
  String numUnidades = "";

  // Otras variables
  int vidaMax = 0;
  int vida = 0;

  int lvlEspada = 0;
  int lvlMana = 0;
  int lvlArmadura = 0;

  // Constructor
  Player(String nombre, String password, String correo, int oro,
      String nivelObjetos, String numUnidades) {
    this.nombre = nombre;
    this.password = password;
    this.correo = correo;
    this.oro = oro;
    this.nivelObjetos = nivelObjetos;
    this.numUnidades = numUnidades;

    this.vidaMax = 100;
    this.vida = vidaMax;

    // Separamos el dato de la BBDD y lo parseamos a lista de int
    List<String> lvlObjetos = nivelObjetos.split(',');
    List<int> lintObjetos = lvlObjetos.map(int.parse).toList();

    // El dato es adjudicado a su variable correspondiente
    this.lvlArmadura = lintObjetos[0];
    this.lvlMana = lintObjetos[1];
    this.lvlEspada = lintObjetos[2];

    // Separamos el dato de la BBDD y lo parseamos a lista de int
    List<String> cantUnidades = numUnidades.split(',');
    List<int> lintUnidades = cantUnidades.map(int.parse).toList();

    // El dato es adjudicado a su variable correspondiente
    for (int x = 0; x < unidades.length; x++) {
      unidades[x].cantidad = lintUnidades[x];
    }
  }

  // Metodos de juego
  double calcularDamageCorte() {
    double tmp = 1;

    for (int x = 0; x < lvlEspada; x++) {
      tmp *= 1.25;
    }

    return tmp;
  }

  double calcularDamageHabilidad() {
    double multiplicador = 2;

    for (int x = 0; x < lvlMana; x++) {
      multiplicador *= 1.25;
    }

    double dmgHabilidad = calcularDamageCorte() * multiplicador.round();
    return dmgHabilidad;
  }

  int calcularVida() {
    double tmp = 100;
    for (int x = 0; x < lvlArmadura; x++) {
      tmp *= 1.1;
    }

    return tmp.round();
  }
}
