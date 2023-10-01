import 'dart:math';

import 'package:test/test.dart';
import 'package:tp2/calcular_planificacion.dart';
import 'package:tp2/leer_archivo.dart';

void main() {
  test('Cronograma vacio', () {
    final (planificacion, ganancia) = calcular([]);

    expect(planificacion.length, 0);
    expect(ganancia, 0);
  });

  test('Cronograma de un día', () {
    final Cronograma cronograma = [(esfuerzo: 10, energia: 20)];

    final (planificacion, ganancia) = calcular(cronograma);

    expect(planificacion[0], PlanDia.entrenamiento);
    expect(ganancia, 10);
  });

  test('Cronograma dos días sin descanso', () {
    final Cronograma cronograma = [
      (esfuerzo: 20, energia: 10),
      (esfuerzo: 10, energia: 5),
    ];

    final (planificacion, ganancia) = calcular(cronograma);

    expect(planificacion[0], PlanDia.entrenamiento);
    expect(planificacion[1], PlanDia.entrenamiento);
    expect(ganancia, 15);
  });

  test('Cronograma dos días con un descanso', () {
    final Cronograma cronograma = [
      (esfuerzo: 2, energia: 10),
      (esfuerzo: 10, energia: 5),
    ];

    final (planificacion, ganancia) = calcular(cronograma);

    expect(planificacion[0], PlanDia.descanso);
    expect(planificacion[1], PlanDia.entrenamiento);
    expect(ganancia, 10);
  });

  test('Cronograma tres días sin descanso', () {
    final Cronograma cronograma = [
      (esfuerzo: 20, energia: 15),
      (esfuerzo: 10, energia: 12),
      (esfuerzo: 15, energia: 11),
    ];

    final (planificacion, ganancia) = calcular(cronograma);

    expect(planificacion[0], PlanDia.entrenamiento);
    expect(planificacion[1], PlanDia.entrenamiento);
    expect(planificacion[2], PlanDia.entrenamiento);
    expect(ganancia, 15 + 10 + 11);
  });

  test('Cronograma cinco días con dos descansos', () {
    final Cronograma cronograma = [
      (esfuerzo: 20, energia: 15),
      (esfuerzo: 10, energia: 10),
      (esfuerzo: 15, energia: 5),
      (esfuerzo: 4, energia: 4),
      (esfuerzo: 10, energia: 3),
    ];

    final (planificacion, ganancia) = calcular(cronograma);

    expect(planificacion[0], PlanDia.entrenamiento);
    expect(planificacion[1], PlanDia.descanso);
    expect(planificacion[2], PlanDia.entrenamiento);
    expect(planificacion[3], PlanDia.descanso);
    expect(planificacion[4], PlanDia.entrenamiento);
    expect(ganancia, 15 + 15 + 10);
  });

  test('Provistos (3) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/3.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 7);
  });

  test('Provistos (10) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/10.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 380);
  });

  test('Provistos (10 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/10_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 523);
  });

  test('Provistos (10 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/10_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 523);
  });

  test('Provistos (10 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/10_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 523);
  });

  test('Provistos (50) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/50.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 1870);
  });

  test('Provistos (50 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/50_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 2136);
  });

  test('Provistos (100) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/100.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 5325);
  });

  test('Provistos (500) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/500.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 27158);
  });

  test('Provistos (1000) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/1000.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 54021);
  });

  test('Provistos (5000) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test/5000.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 279175);
  });

  test('volumen', () {
    final cantidades = List.generate(20, (index) => index * 1000);
    for (final cantidad in cantidades) {
      int total = 0;

      for (int i = 0; i < 20; i++) {
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
