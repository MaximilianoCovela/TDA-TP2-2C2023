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
    final cronograma = await leerCronogramaDesdeArchivo('test_data/3.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 7);
  });

  test('Provistos (10) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/10.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 380);
  });

  test('Provistos (10 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/10_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 523);
  });

  test('Provistos (10 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/10_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 523);
  });

  test('Provistos (10 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/10_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 523);
  });

  test('Provistos (50) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/50.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 1870);
  });

  test('Provistos (50 bis) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/50_bis.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 2136);
  });

  test('Provistos (100) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/100.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 5325);
  });

  test('Provistos (500) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/500.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 27158);
  });

  test('Provistos (1000) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/1000.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 54021);
  });

  test('Provistos (5000) ', () async {
    final cronograma = await leerCronogramaDesdeArchivo('test_data/5000.txt');
    final (_, ganancia) = calcular(cronograma);
    expect(ganancia, 279175);
  });

  // * Pruebas de volumen:
  // Para correrlas ejecutar el comando: dart test test/tp2_test_volume.dart
  // Estas estan en un archivo diferente para poder ejecutar las pruebas principales
  // Y no tener que esperar a que terminen las pruebas de volumen (que tardan bastante).
}
