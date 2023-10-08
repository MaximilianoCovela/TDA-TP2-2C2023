import 'dart:math' show min;

import 'package:tp2/calcular_planificacion.dart';

// * Este algoritmo no es optimo, pero se acerca un poco
Planificacion calcularPlanificacion(Cronograma cronograma) {
  final cantidad = cronograma.length;

  final planificacion = List.filled(cantidad, PlanDia.entrenamiento);

  int conDescanso = 0;
  int sinDescanso = min(cronograma[0].esfuerzo, cronograma[0].energia);
  int cansancio = 1;

  for (int i = 1; i < cantidad; i++) {
    // Si antes no se descansó
    final sinPrevioDescanso = sinDescanso + min<int>(cronograma[cansancio].energia, cronograma[i].esfuerzo);

    // Si antes se descansó
    final conPrevioDescanso = conDescanso + min<int>(cronograma[0].energia, cronograma[i].esfuerzo);

    // Si se descansa este día es porque el anterior no se descansó y se copia ese valor
    conDescanso = sinDescanso;

    if (sinPrevioDescanso >= conPrevioDescanso) {
      sinDescanso = sinPrevioDescanso;
      // Ya es entrenamiento por defecto
      // planificacion[i - 1] = PlanDia.entrenamiento;
      cansancio++;
    } else {
      sinDescanso = conPrevioDescanso;
      planificacion[i - 1] = PlanDia.descanso;
      cansancio = 1;
    }
  }

  return planificacion;
}

int calcularGanancia(Cronograma cronograma, Planificacion planificacion) {
  int cansancio = 0;
  int ganancia = 0;
  for (int i = 0; i < planificacion.length; i++) {
    final plan = planificacion[i];
    if (plan == PlanDia.descanso) {
      cansancio = 0;
    } else {
      ganancia += min(cronograma[cansancio].energia, cronograma[i].esfuerzo);
      cansancio++;
    }
  }

  return ganancia;
}
