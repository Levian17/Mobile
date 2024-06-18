// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

bool primeraEjecucion = true;

// Listas urls (Se recomienda minimizar)
List<String> urlBase = [
  "assets/Iconos/gremio.png",
  "assets/Iconos/inventario.png",
  "assets/Iconos/forja.png",
  "assets/Iconos/expedicion.png",
  "assets/Iconos/guardar.png",
  "assets/Iconos/bestiario.png",
  "assets/Iconos/ajustes.png",
];
List<String> urlHover = [
  "assets/Iconos/gremioHover.png",
  "assets/Iconos/inventarioHover.png",
  "assets/Iconos/forjaHover.png",
  "assets/Iconos/expedicionHover.png",
  "assets/Iconos/guardarHover.png",
  "assets/Iconos/bestiarioHover.png",
  "assets/Iconos/ajustesHover.png",
];
List<String> urlShow = [
  "assets/Iconos/gremio.png",
  "assets/Iconos/inventario.png",
  "assets/Iconos/forja.png",
  "assets/Iconos/expedicion.png",
  "assets/Iconos/guardar.png",
  "assets/Iconos/bestiario.png",
  "assets/Iconos/ajustes.png",
];

class Menu extends StatefulWidget {
  @override
  Content createState() => Content();
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

// Funciones de salto de Page
mostrarExpedicion(BuildContext context) {
  Navigator.of(context).pushReplacementNamed("/selector");
}

mostrarGremio(BuildContext context) {
  Navigator.of(context).pushReplacementNamed("/gremio");
}

mostrarForja(BuildContext context) {
  Navigator.of(context).pushReplacementNamed("/forja");
}

mostrarDerrota(BuildContext context) {
  Navigator.of(context).pushReplacementNamed("/derrota");
}

mostrarInventario(BuildContext context) {
  Navigator.of(context).pushReplacementNamed("/inventario");
}

class Content extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    // Funciones generales
    crearBotones(String url) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        padding: const EdgeInsets.all(8),
        child: Image.asset(url),
      );
    }

    return Scaffold(
        body: Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage("assets/Animaciones/fondoMenu.gif"),
          fit: BoxFit.fill,
        ))),
        Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: const Color.fromARGB(255, 255, 213, 87)),
                borderRadius: BorderRadius.circular(20))),
        BackButton(),
        Container(
          padding: EdgeInsets.only(top: 75, bottom: 75, right: 50, left: 50),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      mostrarGremio(context);
                    },
                    onHover: (isHovered) {
                      setState(() {
                        if (isHovered) {
                          urlShow[0] = urlHover[0];
                        } else {
                          urlShow[0] = urlBase[0];
                        }
                      });
                    },
                    child: crearBotones(urlShow[0]),
                  ),
                  Spacer()
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      mostrarInventario(context);
                    },
                    onHover: (isHovered) {
                      setState(() {
                        if (isHovered) {
                          urlShow[1] = urlHover[1];
                        } else {
                          urlShow[1] = urlBase[1];
                        }
                      });
                    },
                    child: crearBotones(urlShow[1]),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      mostrarForja(context);
                    },
                    onHover: (isHovered) {
                      setState(() {
                        if (isHovered) {
                          urlShow[2] = urlHover[2];
                        } else {
                          urlShow[2] = urlBase[2];
                        }
                      });
                    },
                    child: crearBotones(urlShow[2]),
                  ),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      mostrarExpedicion(context);
                    },
                    onHover: (isHovered) {
                      setState(() {
                        if (isHovered) {
                          urlShow[3] = urlHover[3];
                        } else {
                          urlShow[3] = urlBase[3];
                        }
                      });
                    },
                    child: crearBotones(urlShow[3]),
                  ),
                  Spacer()
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        
                        showSnackBar(context, "La base de datos ha sido actualizada.", Colors.green);
                      });
                    },
                    onHover: (isHovered) {
                      setState(() {
                        if (isHovered) {
                          urlShow[4] = urlHover[4];
                        } else {
                          urlShow[4] = urlBase[4];
                        }
                      });
                    },
                    child: crearBotones(urlShow[4]),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    onHover: (isHovered) {
                      setState(() {
                        if (isHovered) {
                          urlShow[5] = urlHover[5];
                        } else {
                          urlShow[5] = urlBase[5];
                        }
                      });
                    },
                    child: crearBotones(urlShow[5]),
                  ),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      mostrarDerrota(context);
                    },
                    onHover: (isHovered) {
                      setState(() {
                        if (isHovered) {
                          urlShow[6] = urlHover[6];
                        } else {
                          urlShow[6] = urlBase[6];
                        }
                      });
                    },
                    child: crearBotones(urlShow[6]),
                  ),
                  Spacer()
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }
}
