import 'dart:math';

import 'package:test/test.dart';
import 'package:tp2/calcular_planificacion.dart';

void main() {
  // Transformar output prueba de volumen a lista de valores para copiar y pegar a excel:
  // 1. Copiar y pegar output en un archivo de texto (solo de esa prueba)
  // Usar regex para reemplazar: Cantidad [0-9]+, tiempo: ([0-9]+)\.([0-9]+)..
  // Reemplazar por: $1,$2
  test('volumen', () {
    final cantidades = List.generate(30, (index) => (index + 1) * 1000);
    for (final cantidad in cantidades) {
      int total = 0;

      for (int i = 0; i <= 20; i++) {
        final datos = generarDatosVolumen(cantidad);
        final stopwatch = Stopwatch();

        stopwatch.start();
        calcular(datos);
        stopwatch.stop();

        total += stopwatch.elapsedMicroseconds;
      }
      final promedio = total / 20;
      print("Cantidad $cantidad, tiempo: $promedioµs");
    }
  });
}

Cronograma generarDatosVolumen(int size) {
  final Cronograma cronograma = List.filled(size, (esfuerzo: 0, energia: 0));

  final random = Random();

  int proximaEnergia = 100;

  for (int i = 0; i < size; i++) {
    final esfuerzo = random.nextInt(100) + 1;
    cronograma[i] = (esfuerzo: esfuerzo, energia: proximaEnergia);

    final salto = random.nextInt(((100 / size) * 2).ceil()) + 1;

    proximaEnergia -= salto;
    if (proximaEnergia < 1) proximaEnergia = 1;
  }

  return cronograma;
}
