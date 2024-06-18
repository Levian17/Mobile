// ignore_for_file: empty_constructor_bodies, prefer_initializing_formals, unnecessary_this

class Enemigo {
  // Atributos
  double hp = 0;
  int maxHp = 0;
  String nombre = "";
  String urlImagen = "";

  // Constructores
  Enemigo(double hp, String nombre, String imagen) {
    this.hp = hp;
    this.maxHp = hp.round();
    this.nombre = nombre;
    urlImagen = imagen;
  }

  // Getters y Setters
  get getHp => this.hp;

  set setHp(hp) => this.hp = hp;

  get getMaxHp => this.maxHp;

  set setMaxHp(maxHp) => this.maxHp = maxHp;

  get getNombre => this.nombre;

  set setNombre(nombre) => this.nombre = nombre;

  get getUrlImagen => this.urlImagen;

  set setUrlImagen(urlImagen) => this.urlImagen = urlImagen;
}
