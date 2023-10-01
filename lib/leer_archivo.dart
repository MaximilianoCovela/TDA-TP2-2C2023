import 'dart:io';

import 'package:tp2/calcular_planificacion.dart';

Future<Cronograma> leerCronogramaDesdeArchivo(String nombre) async {
  final contenido = await File(nombre).readAsString();

  final lineas = contenido.split('\n');

  final cantidad = int.parse(lineas.removeAt(0));

  final Cronograma cronograma = List.filled(
    cantidad,
    (esfuerzo: 0, energia: 0),
  );

  for (int i = 0; i < cantidad; i++) {
    cronograma[i] = (
      esfuerzo: int.parse(lineas[i]),
      energia: int.parse(lineas[i + cantidad]),
    );
  }

  return cronograma;
}
