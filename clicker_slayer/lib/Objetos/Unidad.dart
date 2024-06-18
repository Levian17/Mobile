// ignore_for_file: prefer_initializing_formals, unnecessary_this

class Unidad {
  String nombre = "";
  String descripcion = "";
  String urlIcon = "";
  String urlGif = "";
  int cantidad = 0;
  int precioBase = 0;
  double damage = 0;

  Unidad(String nombre, String descripcion, String urlIcon, String urlGif,
      int precioBase, double damage) {
    this.nombre = nombre;
    this.descripcion = descripcion;
    this.urlIcon = urlIcon;
    this.urlGif = urlGif;
    this.precioBase = precioBase;
    this.damage = damage;
  }
}
