import 'dart:io';

import 'package:tp2/calcular_planificacion.dart';

Future<Cronograma> leerCronogramaDesdeArchivo(String nombre) async {
  final contenido = await File(nombre).readAsString();

  final lineas = contenido.split('\n');

  final cantidadDias = int.parse(lineas.removeAt(0));

  final Cronograma cronograma = List.filled(
    cantidadDias,
    (esfuerzo: 0, energia: 0),
  );

  for (int i = 0; i < cantidadDias; i++) {
    cronograma[i] = (
      esfuerzo: int.parse(lineas[i]),
      energia: int.parse(lineas[i + cantidadDias]),
    );
  }

  return cronograma;
}
