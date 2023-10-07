import 'dart:math' show min;

typedef ValoresDia = ({int esfuerzo, int energia});

typedef Cronograma = List<ValoresDia>;

enum PlanDia { entrenamiento, descanso }

typedef Planificacion = List<PlanDia>;

/*
  - No puede haber dos descansos juntos,
  - El último siempre es entrenamiento
  - El primero puede ser o no descanso
*/

(Planificacion planificacion, int maximaGanancia) calcular(
    Cronograma cronograma) {
  if (cronograma.isEmpty) {
    return ([], 0);
  }

  final cantidadDias = cronograma.length;
  final indiceUltimoDia = cantidadDias - 1;

  final planificacion = List.filled(cantidadDias, PlanDia.entrenamiento);

  final (matriz, indicesMaximosPorDia) = rellenarMatriz(cronograma);

  int indiceUltimoDiaEntrenado = indiceUltimoDia;
  while (indiceUltimoDiaEntrenado >= 0) {
    // Cuantos días entrené desde el último descanso
    final diasCorridosEntrenando =
        indicesMaximosPorDia[indiceUltimoDiaEntrenado];
    final proximoDescanso =
        indiceUltimoDiaEntrenado - diasCorridosEntrenando - 1;

    if (proximoDescanso < 0) {
      break;
    }

    planificacion[proximoDescanso] = PlanDia.descanso;

    indiceUltimoDiaEntrenado =
        indiceUltimoDiaEntrenado - diasCorridosEntrenando - 2;
  }

  return (
    planificacion,
    matriz[indiceUltimoDia][indicesMaximosPorDia[indiceUltimoDia]],
  );
}

(List<List<int>> matriz, List<int> indicesMaximosPorDia) rellenarMatriz(
    Cronograma cronograma) {
  final cantidadDias = cronograma.length;

  // Generamos la matriz con forma de triángulo
  final matriz =
      List.generate(cantidadDias, (index) => List.filled(index + 1, 0));

  final indicesMaximosPorDia = List.filled(cantidadDias,
      0); // Índices de energía con la máxima ganancia posible de cada día

  for (int indiceDia = 0; indiceDia < cantidadDias; indiceDia++) {
    for (int indiceEnergia = 0;
        indiceEnergia < matriz[indiceDia].length;
        indiceEnergia++) {
      // Ganancia de la posicion actual
      matriz[indiceDia][indiceEnergia] = min(
        cronograma[indiceDia].esfuerzo,
        cronograma[indiceEnergia].energia,
      );

      // Si tiene toda la energía posible sumamos la ganancia máxima posible del día previo al descanso
      if (indiceEnergia == 0 && indiceDia > 1) {
        matriz[indiceDia][indiceEnergia] +=
            matriz[indiceDia - 2][indicesMaximosPorDia[indiceDia - 2]];
      }
      // Si hay cansancio, sumamos la ganancia del día anterior
      else if (indiceEnergia > 0) {
        matriz[indiceDia][indiceEnergia] +=
            matriz[indiceDia - 1][indiceEnergia - 1];
      }

      // Guardamos la ganancia máxima posible para ese día
      if (matriz[indiceDia][indiceEnergia] >
          matriz[indiceDia][indicesMaximosPorDia[indiceDia]]) {
        indicesMaximosPorDia[indiceDia] = indiceEnergia;
      }
    }
  }

  return (matriz, indicesMaximosPorDia);
}
