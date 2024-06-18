// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';
import 'dart:math';
import 'package:clicker_slayer/Pages/Gremio.dart';
import 'package:clicker_slayer/Pages/Inicio.dart';
import 'package:clicker_slayer/Pages/Selector.dart';
import 'package:flutter/material.dart';
import '../Objetos/Enemigo.dart';

class Expedicion extends StatefulWidget {
  @override
  Content createState() => Content();
}

// Variables generales
bool iniciando = true;
bool des = true;
String bonoType = "";
List<int> objetos = [0, 0, 0];

// EXAMEN
int mejoraExamen = unidades[unidades.length - 1].cantidad;

// Variables numericas
int vidaMax = player.calcularVida();
int vida = vidaMax;
int cargaHabilidad = 0;
int enemigoDerrotados = 0;
int oro = 0;
int cooldownRetirada = 0;
int cooldownBonos = 100;
int timerSpeedbuff = 0;
int timerBlessingBuff = 0;
double bonoX = 0;
double bonoY = 0;

double damageCorte = player.calcularDamageCorte();
double damageHabilidad = player.calcularDamageHabilidad();
double dps = calcularDPS();

// Variables de animación
bool stateCorte = false;
bool clicando = false;
DecorationImage bioma = crearBioma();
Enemigo enemigo = crearEnemigo();
AssetImage cortes = AssetImage('');
AssetImage habilidad = AssetImage('');
AssetImage blackFire = AssetImage('');
AssetImage speedBuff = AssetImage('');
AssetImage blessing = AssetImage('');
AssetImage bono = AssetImage('');
AssetImage botonRetirada = AssetImage("assets/Miscelaneo/volver.png");

// Variables url fijas
String fondo = "assets/Marcos/expedicion.png";
String boton = "assets/Animaciones/boton.gif";
AssetImage protagonista = AssetImage("assets/Animaciones/prota.gif");

// Funciones y metodos generales
int randomInt(int min, int max) {
  // Genera un entero aleatorio entre dos parametros numericos
  Random tmp = Random();
  int random = min + tmp.nextInt(max - min);
  return random;
}

AssetImage gestorCortes() {
  // Devuelve una imagen para la animación de corte
  AssetImage corte;

  if (!stateCorte) {
    corte = AssetImage("assets/Animaciones/corte1.gif");
    stateCorte = !stateCorte;
  } else {
    corte = AssetImage("assets/Animaciones/corte2.gif");
    stateCorte = !stateCorte;
  }

  cortes.evict();
  return corte;
}

AssetImage gestorEnergia(int id) {
  // Controla las imagenes de las barras de carga de energia,  id 1 para la derecha, 2 para la izquierda.
  List<String> urlDerecha = [
    "",
    "assets/Energia/iaMyyLU.png",
    "assets/Energia/1ytlBRR.png",
    "assets/Energia/GEznf8c.png",
    "assets/Energia/sCqoe9h.png",
    "assets/Energia/5Txq7th.png",
    "assets/Energia/SXUbsSS.png",
    "assets/Energia/xDY0mwD.png",
    "assets/Energia/jYERZl2.png",
    "assets/Energia/5cPddUY.png",
    "assets/Energia/Ptb4BSQ.png",
  ];
  List<String> urlIzquierda = [
    "",
    "assets/Energia/3LsWB5k.png",
    "assets/Energia/31S59ON.png",
    "assets/Energia/gLsicEE.png",
    "assets/Energia/FwO5eI4.png",
    "assets/Energia/jgj5Lkv.png",
    "assets/Energia/4z4h0Ff.png",
    "assets/Energia/elcfqOA.png",
    "assets/Energia/lyYpcCM.png",
    "assets/Energia/zBkJH2P.png",
    "assets/Energia/3JGyy7l.png",
  ];

  AssetImage imagen = AssetImage("");

  switch (id) {
    case 1:
      if (cargaHabilidad < 10) {
        imagen = AssetImage(urlDerecha[cargaHabilidad]);
      } else {
        imagen = AssetImage(urlDerecha[10]);
      }

      break;
    case 2:
      if (cargaHabilidad > 10) {
        imagen = AssetImage(urlIzquierda[cargaHabilidad - 10]);
      } else {
        imagen = AssetImage(urlIzquierda[0]);
      }
      break;
  }

  return imagen;
}

Color gestorColorRetirada() {
  Color color;
  if (cooldownRetirada > 0) {
    color = Colors.white;
  } else {
    color = Colors.transparent;
  }
  return color;
}

DecorationImage crearBioma() {
  // Devuelve una imagen con un bioma aleatorio basandose en la elección de area del usuario
  List<String> UrlsBackground = [
    "assets/Backgrounds/Ic9gY9g.png",
    "assets/Backgrounds/Eiebtic.png",
    "assets/Backgrounds/41RkIiU.png",
    "assets/Backgrounds/s04Hl0m.png",
    "assets/Backgrounds/Rf5bAxf.png",
    "assets/Backgrounds/TF4poRs.png",
    "assets/Backgrounds/UASYwo5.png",
    "assets/Backgrounds/q01H92x.png",
    "assets/Backgrounds/ACHfjNT.png",
    "assets/Backgrounds/shNFdFJ.png",
    "assets/Backgrounds/mtPeSwN.png",
    "assets/Backgrounds/CLWweGI.png",
    "assets/Backgrounds/5h1FYLX.png",
    "assets/Backgrounds/C7a4slP.png",
    "assets/Backgrounds/lCvLebC.png",
    "assets/Backgrounds/414lGnW.png",
    "assets/Backgrounds/ym0zE9a.png"
  ];

  DecorationImage imagen = DecorationImage(image: AssetImage(""));

  switch (areaSeleccionada) {
    case "tutorial":
      imagen = DecorationImage(
          image: AssetImage(UrlsBackground[randomInt(0, 3)]), fit: BoxFit.fill);
    case "desierto":
      imagen = DecorationImage(
          image: AssetImage(UrlsBackground[randomInt(3, 6)]), fit: BoxFit.fill);
    case "bosque":
      imagen = DecorationImage(
          image: AssetImage(UrlsBackground[randomInt(6, 8)]), fit: BoxFit.fill);
    case "cielo":
      imagen = DecorationImage(
          image: AssetImage(UrlsBackground[randomInt(8, 11)]),
          fit: BoxFit.fill);
    case "oceano":
      imagen = DecorationImage(
          image: AssetImage(UrlsBackground[randomInt(11, 14)]),
          fit: BoxFit.fill);
    case "abismo":
      imagen = DecorationImage(
          image: AssetImage(UrlsBackground[randomInt(14, 17)]),
          fit: BoxFit.fill);
  }

  return imagen;
}

Enemigo crearEnemigo() {
  // Genera un objeto Enemigo aleatorio según el area seleccionada y el escalado de vida.
  double hp = (10 * enemigoDerrotados) * 1;
  String nombre = "";
  String imagen = "";

  switch (areaSeleccionada) {
    case "tutorial":
      switch (randomInt(0, 4)) {
        case 0:
          nombre = "Lobo";
          imagen = "assets/Enemigos/irz04em.png";
          break;
        case 1:
          nombre = "Tigre";
          imagen = "assets/Enemigos/Ye9xCyx.png";
          break;
        case 2:
          nombre = "Serpiente";
          imagen = "assets/Enemigos/faiQuZ4.png";
          break;
        case 3:
          nombre = "Ciervo";
          imagen = "assets/Enemigos/lB0VxNH.png";
          break;
      }
      break;

    case "bosque":
      switch (randomInt(0, 4)) {
        case 0:
          nombre = "Simio";
          imagen = "assets/Enemigos/aXQEFRi.png";
          break;
        case 1:
          nombre = "Mono";
          imagen = "assets/Enemigos/zuFgzWh.png";
          break;
        case 2:
          nombre = "Insecto";
          imagen = "assets/Enemigos/UBKJzHw.png";
          break;
        case 3:
          nombre = "Planta";
          imagen = "assets/Enemigos/Oy7a4CN.png";
          break;
      }

      break;

    case "desierto":
      switch (randomInt(0, 4)) {
        case 0:
          nombre = "Bicho";
          imagen = "assets/Enemigos/JEuOxY8.png";
          break;
        case 1:
          nombre = "Chacal";
          imagen = "assets/Enemigos/ZqffF7h.png";
          break;
        case 2:
          nombre = "Larva";
          imagen = "assets/Enemigos/fNYciC0.png";
          break;
        case 3:
          nombre = "Mamut";
          imagen = "assets/Enemigos/wsztO5i.png";
          break;
      }

      break;

    case "oceano":
      switch (randomInt(0, 4)) {
        case 0:
          nombre = "Masa marina";
          imagen = "assets/Enemigos/fM84fJS.png";
          break;
        case 1:
          nombre = "Megalodon";
          imagen = "assets/Enemigos/VOSwHnU.png";
          break;
        case 2:
          nombre = "Kraken";
          imagen = "assets/Enemigos/jk5myzB.png";
          break;
        case 3:
          nombre = "Iguana";
          imagen = "assets/Enemigos/jfjUsJO.png";
          break;
      }

      break;

    case "cielo":
      switch (randomInt(0, 5)) {
        case 0:
          nombre = "Buho";
          imagen = "assets/Enemigos/t5NPsPi.png";
          break;
        case 1:
          nombre = "Cabra Voladora";
          imagen = "assets/Enemigos/kb3ZN5f.png";
          break;
        case 2:
          nombre = "Dragon de Plumas";
          imagen = "assets/Enemigos/EUWnhI9.png";
          break;
        case 3:
          nombre = "Dragon de Vacio";
          imagen = "assets/Enemigos/zy1u7pu.png";
          break;
        case 4:
          nombre = "Gargola";
          imagen = "assets/Enemigos/FaFky11.png";
          break;
      }

      break;

    case "abismo":
      switch (randomInt(0, 5)) {
        case 0:
          nombre = "Cabra Frenetica";
          imagen = "assets/Enemigos/rhYulJ8.png";
          break;
        case 1:
          nombre = "Chacal Corrupto";
          imagen = "assets/Enemigos/j07Y31y.png";
          break;
        case 2:
          nombre = "Esqueleto Cuadrupedo";
          imagen = "assets/Enemigos/hbMJWUj.png";
          break;
        case 3:
          nombre = "Golem Espiritual";
          imagen = "assets/Enemigos/stHdsk0.png";
          break;
        case 4:
          nombre = "Buho Corrupto";
          imagen = "assets/Enemigos/jid3yd5.png";
          break;
      }

      break;
  }

  print("Creando..." + nombre);
  return Enemigo(hp, nombre, imagen);
}

Enemigo crearBoss() {
  print("Enemigos derrotados: " +
      enemigoDerrotados.toString() +
      " , creando Boss");

  double hp = (10 * enemigoDerrotados) * 1;
  String nombre = "";
  String imagen = "";

  switch (areaSeleccionada) {
    case "tutorial":
      nombre = "Rey Lagarto";
      imagen = "assets/Enemigos/U2n4SGx.png";
      break;

    case "bosque":
      nombre = "Dragon Forestal";
      imagen = "assets/Enemigos/grMDDJm.png";
      break;

    case "desierto":
      nombre = "Dragon Infernal";
      imagen = "assets/Enemigos/clmKLkl.png";
      break;

    case "oceano":
      nombre = "Dragon Marino";
      imagen = "assets/Enemigos/R0tG2z7.png";
      break;

    case "cielo":
      nombre = "Fenix de Hielo";
      imagen = "assets/Enemigos/DS4XZ6R.png";
      break;

    case "abismo":
      nombre = "Reina del Caos";
      imagen = "assets/Enemigos/KTAXyFX.png";
      break;
  }

  return Enemigo(hp, nombre, imagen);
}

actualizarZonas(String areaSeleccionada) {
  switch (areaSeleccionada) {
    case "tutorial":
      zonasBloqueadas[0] = 2;
      if (zonasBloqueadas[1] == 0) {
        zonasBloqueadas[1] = 1;
      }
      break;

    case "bosque":
      zonasBloqueadas[1] = 2;
      if (zonasBloqueadas[2] == 0) {
        zonasBloqueadas[2] = 1;
      }
      break;
    case "desierto":
      zonasBloqueadas[2] = 2;
      if (zonasBloqueadas[3] == 0) {
        zonasBloqueadas[3] = 1;
      }
      break;
    case "oceano":
      zonasBloqueadas[3] = 2;
      if (zonasBloqueadas[4] == 0) {
        zonasBloqueadas[4] = 1;
      }
      break;

    case "cielo":
      zonasBloqueadas[4] = 2;
      if (zonasBloqueadas[5] == 0) {
        zonasBloqueadas[5] = 1;
      }
      break;

    case "abismo":
      zonasBloqueadas[5] = 2;
      break;
  }
}

statsEnemigo(BuildContext context) {
  // Muestra un AlertDialog con las estadisticas del enemigo actual
  Color color = Color.fromARGB(255, 226, 174, 95);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
          child: AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.7),
              title: Text(
                "Estadísticas ${enemigo.nombre}",
                style: TextStyle(color: color),
              ),
              content: Stack(
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(color: color),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Vida actual -" +
                          enemigo.getHp.round().toString() +
                          "/" +
                          enemigo.getMaxHp.toString(),
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Text(
                      "Daño de ataque - ${(enemigo.getMaxHp / 10).toString()}",
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90),
                    child: Text(
                      "Nivel - $enemigoDerrotados",
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    child: Text(
                      "Oro asesinato - [ ${(enemigo.getMaxHp / 10).round() - (enemigo.getMaxHp / 100).round()} / ${(enemigo.getMaxHp / 10).round() + (enemigo.getMaxHp / 100).round()}" +
                          " ]",
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                ],
              )),
        );
      });
}

statsEquipo(BuildContext context) {
  // Muestra un AlertDialog con las estadisticas del equipo
  Color color = Color.fromARGB(255, 226, 174, 95);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
          child: AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.7),
              title: Text(
                "Estadísticas Equipo",
                style: TextStyle(color: color),
              ),
              content: Stack(
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(color: color),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Vida actual - $vida / $vidaMax",
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Text(
                      "Daño de corte - " +
                          damageCorte.toStringAsFixed(2).toString(),
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 90),
                    child: Text(
                      "Daño habilidad - " +
                          damageHabilidad.toStringAsFixed(2).toString(),
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    child: Text(
                      "DPS pasivo aliados - ${dps.toStringAsFixed(2)} / seg",
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ),
                ],
              )),
        );
      });
}

class Content extends State<Expedicion> {
  // Funcion de muerte
  muerte(BuildContext context) {
    enemigoDerrotados = 0;
    tresSegundos.cancel();
    unSegundo.cancel();
    milisegundos.cancel();
    oro = (oro / 2).round();
    areaSeleccionada = "";
    Navigator.of(context).pushNamed(
      "/derrota",
    );
  }

  // Funcion de retirada
  retirada(BuildContext context, String modo) {
    if (modo == "final") {
      tresSegundos.cancel();
      unSegundo.cancel();
      milisegundos.cancel();
      Navigator.of(context).pushNamed("/regreso", arguments: enemigoDerrotados);
    } else if (modo == "retirada") {
      if (cooldownRetirada < 1) {
        if (randomInt(0, 2) == 0) {
          tresSegundos.cancel();
          unSegundo.cancel();
          milisegundos.cancel();
          Navigator.of(context)
              .pushNamed("/regreso", arguments: enemigoDerrotados);
        } else {
          print("Fallo en la huida...");
          setState(() {
            botonRetirada = AssetImage("assets/Miscelaneo/fallo.png");
          });
          cooldownRetirada = 3;
        }
      }
    }
  }

  // Funcion de inicio
  start() {
    setState(() {
      vida = vidaMax;
      cargaHabilidad = 0;
      enemigoDerrotados++;
      bioma = crearBioma();
      enemigo = crearEnemigo();
    });
  }

  // Funcion crear bono
  generarBono() {
    print("Generando bono ...");
    bonoX = randomInt(10, 90) / 100;
    bonoY = randomInt(0, 80) / 100;
    des = true;
    switch (randomInt(0, 3)) {
      case 0: // Blackfire
        print("Bono: Blackfire");
        bonoType = "blackfire";
        if (bonoX < 0.45) {
          bono = AssetImage("assets/Miscelaneo/hadaMalaIzq.png");
        } else {
          bono = AssetImage("assets/Miscelaneo/hadaMalaDer.png");
        }
        break;
      case 1: // Speedbuff
        print("Bono: Speedbuff");
        bonoType = "speedbuff";
        if (bonoX < 0.45) {
          bono = AssetImage("assets/Miscelaneo/hadaIzq.png");
        } else {
          bono = AssetImage("assets/Miscelaneo/hadaDer.png");
        }
        break;
      case 2: // Blessing
        print("Bono: Blessing");
        bonoType = "blessing";
        if (bonoX < 0.45) {
          bono = AssetImage("assets/Miscelaneo/hadaIzq.png");
        } else {
          bono = AssetImage("assets/Miscelaneo/hadaDer.png");
        }
        break;
    }
  }

  // Funcion para calcular si se dropea un objeto
  generarDrop() {
    if (areaSeleccionada == "bosque" ||
        areaSeleccionada == "oceano" ||
        areaSeleccionada == "cielo") {
      if (randomInt(0, 3) == 0) {
        objetos[randomInt(0, 2)]++;
      }
    } else {
      if (randomInt(0, 3) == 0) {
        objetos[randomInt(0, 3)]++;
      }
    }
  }

  // Temporizadores
  Timer milisegundos = Timer(Duration(), () {});
  Timer unSegundo = Timer(Duration(), () {});
  Timer tresSegundos = Timer(Duration(), () {});
  @override
  void initState() {
    super.initState();

    milisegundos = Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      setState(() {
        // Eliminamos monstruos hasta que hayan muerto los mismos que el nivel de la habilidad examen.
        if (mejoraExamen > 0) {
          enemigo.setHp = 0;
          mejoraExamen--;
        }

        enemigo.hp -= dps / 100;

        if (enemigo.getHp <= 0) {
          int tmp = (enemigo.getMaxHp / 10).round();
          oro += tmp;
          print(
              "Enemigos derrotados: $enemigoDerrotados -> ${enemigoDerrotados + 1}");
          enemigoDerrotados++;
          generarDrop();
          if (enemigoDerrotados == 31) {
            actualizarZonas(areaSeleccionada);
            retirada(context, "final");
          } else {
            bioma = crearBioma();
            if (enemigoDerrotados == 30) {
              enemigo = crearBoss();
            } else {
              enemigo = crearEnemigo();
            }
          }
        }
      });
    });

    unSegundo = Timer.periodic(Duration(seconds: 1), (Timer t) {
      // Reducir cooldowns
      cooldownRetirada--;
      timerBlessingBuff--;
      timerSpeedbuff--;

      dps = calcularDPS();

      if (cooldownBonos < 0) {
        cooldownBonos = 100;
      } else {
        cooldownBonos--;
      }

      setState(() {
        if (cooldownRetirada == 0) {
          botonRetirada = AssetImage("assets/Miscelaneo/volver.png");
        }

        if (cooldownBonos % 45 == 0) {
          generarBono();
        }

        if (!clicando) {
          protagonista.evict();
          protagonista = AssetImage("assets/Miscelaneo/prota.png");
        }
      });
    });

    tresSegundos = Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        int tmp = (enemigo.getMaxHp / 10).round(); // Bajar vida
        vida -= tmp;
        if (vida <= 0) {
          // Comprobar muerte
          muerte(context);
          tresSegundos.cancel();
        }
        clicando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (iniciando) {
      print("Iniciando");
      start();
      iniciando = false;
    }

    return Scaffold(
      body: Stack(children: [
        // Bioma
        Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(image: bioma)),
        // Marco escena
        Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(fondo), fit: BoxFit.fill)),
        ),
        // Enemigo
        Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.6,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.055,
                left: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(enemigo.urlImagen)))),
        // ButtonIcon Enemigo
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: MediaQuery.of(context).size.width * 0.18),
              height: MediaQuery.of(context).size.height * 0.105,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 10, color: Colors.black),
                  borderRadius: BorderRadius.circular(50)),
              child: CircularProgressIndicator(
                strokeWidth: 8,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.red),
                value: enemigo.getHp / enemigo.getMaxHp,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.14,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4175,
                  left: MediaQuery.of(context).size.width * 0.21),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Iconos/iconMonster.png")),
                borderRadius: BorderRadius.circular(50),
              ),
              child: InkWell(
                onTap: () => statsEnemigo(context),
              ),
            )
          ],
        ),
        // Protagonista
        Container(
            height: MediaQuery.of(context).size.height * 0.125,
            width: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.17,
              left: MediaQuery.of(context).size.width * 0.55,
            ),
            decoration:
                BoxDecoration(image: DecorationImage(image: protagonista))),
        // ButtonIcon Party
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
                left: MediaQuery.of(context).size.width * 0.65,
              ),
              height: MediaQuery.of(context).size.height * 0.105,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 10, color: Colors.black),
                  borderRadius: BorderRadius.circular(50)),
              child: CircularProgressIndicator(
                strokeWidth: 8,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(
                    const Color.fromARGB(255, 141, 218, 54)),
                value: vida / vidaMax,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.14,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.42,
                  left: MediaQuery.of(context).size.width * 0.68),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/Iconos/iconTeam.png")),
                borderRadius: BorderRadius.circular(50),
              ),
              child: InkWell(
                onTap: () {
                  statsEquipo(context);
                },
              ),
            )
          ],
        ),
        // Corte
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.4,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.085,
              left: MediaQuery.of(context).size.width * 0.15),
          decoration: BoxDecoration(
            image: DecorationImage(image: cortes),
          ),
        ),
        // Speed Buff
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.3,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.165,
              left: MediaQuery.of(context).size.width * 0.525),
          decoration: BoxDecoration(image: DecorationImage(image: speedBuff)),
        ),
        // Blessing
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.3,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.135,
              left: MediaQuery.of(context).size.width * 0.55),
          decoration: BoxDecoration(image: DecorationImage(image: blessing)),
        ),
        // Habilidad
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.55,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.085,
              left: MediaQuery.of(context).size.width * 0.1),
          decoration: BoxDecoration(
            image: DecorationImage(image: habilidad),
          ),
        ),
        // BlackFire
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.4,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.055,
              left: MediaQuery.of(context).size.width * 0.15),
          decoration: BoxDecoration(
            image: DecorationImage(image: blackFire),
          ),
        ),
        // Barras habilidad especial
        Stack(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: gestorEnergia(1)))),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/Energia/lvTqDs8.png")))),
                )
              ],
            ),
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(image: gestorEnergia(2)))),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/Energia/1kTfgyV.png")))),
                )
              ],
            ),
          ],
        ),
        // Panel oro
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width * 0.55,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.05),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              border: Border.all(
                  width: 2,
                  color: Color.fromARGB(255, 221, 192, 111).withOpacity(0.5)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.35),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Miscelaneo/moneda.png"))),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.15),
                  child: Text(
                    " - $oro",
                    style: TextStyle(color: Colors.amber, fontSize: 26),
                  ),
                ),
              ],
            ),
          ),
        ),
        //  Bonos
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.height * 0.2,
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * bonoY,
              left: MediaQuery.of(context).size.width * bonoX),
          decoration: BoxDecoration(image: DecorationImage(image: bono)),
          child: des
              ? InkWell(
                  onTap: () {
                    setState(() {
                      switch (bonoType) {
                        case "blackfire":
                          blackFire =
                              AssetImage("assets/Animaciones/blackfire.gif");
                          blackFire.evict();
                          enemigo.setHp = enemigo.getHp / 2;
                          break;
                        case "speedbuff":
                          speedBuff =
                              AssetImage("assets/Animaciones/speed.gif");
                          speedBuff.evict();
                          timerSpeedbuff = 10;
                          damageCorte *= 2;
                          break;
                        case "blessing":
                          blessing =
                              AssetImage("assets/Animaciones/blessing.gif");
                          blessing.evict();
                          timerBlessingBuff = 30;
                          break;
                      }
                      des = false;

                      bono = AssetImage("");
                    });
                  },
                )
              : Container(),
        ),
        // Boton
        Center(
          child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              height: MediaQuery.of(context).size.height * 0.125,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  image: DecorationImage(
                    image: AssetImage(boton),
                  )),
              child: InkWell(
                onTap: () {
                  setState(() {
                    cargaHabilidad++;
                    clicando = true;
                    protagonista = AssetImage("assets/Animaciones/prota.gif");
                    if (cargaHabilidad > 20) {
                      habilidad =
                          AssetImage("assets/Animaciones/habilidad.gif");
                      habilidad.evict();
                      cargaHabilidad = 0;
                      enemigo.setHp = enemigo.getHp - damageHabilidad;
                    } else {
                      cortes = gestorCortes();
                      enemigo.setHp = enemigo.getHp - damageCorte;
                    }
                  });

                  if (enemigo.getHp <= 0) {
                    setState(() {
                      int tmp = (enemigo.getMaxHp / 5).round();
                      oro += tmp;
                      print(
                          "Enemigos derrotados: $enemigoDerrotados -> ${enemigoDerrotados + 1}");
                      enemigoDerrotados++;
                      generarDrop();

                      if (enemigoDerrotados == 31) {
                        actualizarZonas(areaSeleccionada);
                        retirada(context, "final");
                      } else {
                        bioma = crearBioma();
                        if (enemigoDerrotados == 30) {
                          enemigo = crearBoss();
                        } else {
                          enemigo = crearEnemigo();
                        }
                      }
                    });
                  }
                },
              )),
        ),
        // Boton retirada
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.15,
            // right: MediaQuery.of(context).size.width * 0.3
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.18,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(image: DecorationImage(image: botonRetirada)),
            child: InkWell(
              onTap: () => retirada(context, "retirada"),
              child: Text(
                cooldownRetirada.toString(),
                style: TextStyle(color: gestorColorRetirada(), fontSize: 28),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
