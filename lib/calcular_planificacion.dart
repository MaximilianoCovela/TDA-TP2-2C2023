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

  final cantidad = cronograma.length;
  final ultimoIndice = cantidad - 1;

  final planificacion = List.filled(cantidad, PlanDia.entrenamiento);

  final (matriz, indicesMaximosPorDia) = rellenarMatriz(cronograma);

  int ultimoEntrenamiento = ultimoIndice;
  while (ultimoEntrenamiento >= 0) {
    // Cuantos días entrené desde el último descanso
    final llevoEntrenando = indicesMaximosPorDia[ultimoEntrenamiento];
    final proximoDescanso = ultimoEntrenamiento - llevoEntrenando - 1;

    if (proximoDescanso < 0) {
      break;
    }

    planificacion[proximoDescanso] = PlanDia.descanso;

    ultimoEntrenamiento = ultimoEntrenamiento - llevoEntrenando - 2;
  }

  return (
    planificacion,
    matriz[ultimoIndice][indicesMaximosPorDia[ultimoIndice]],
  );
}

(List<List<int>> matriz, List<int> indicesMaximosPorDia) rellenarMatriz(
    Cronograma cronograma) {
  final cantidad = cronograma.length;

  // Generamos la matriz con forma de triangulo
  final matriz = List.generate(cantidad, (index) => List.filled(index + 1, 0));

  final indicesMaximosPorDia =
      List.filled(cantidad, 0); // Máxima ganancia posbile hasta cada día

  for (int dia = 0; dia < cantidad; dia++) {
    for (int cansancio = 0; cansancio < matriz[dia].length; cansancio++) {
      // Ganancia de la posicion actual
      matriz[dia][cansancio] = min(
        cronograma[dia].esfuerzo,
        cronograma[cansancio].energia,
      );

      // Si es la primera columna sumamos el valor máximo posible del día previo al descanso
      if (cansancio == 0 && dia > 1) {
        matriz[dia][cansancio] +=
            matriz[dia - 2][indicesMaximosPorDia[dia - 2]];
      }
      // Si hay cansancio, sumamos el valor que conseguimos el dia anterior
      else if (cansancio > 0) {
        matriz[dia][cansancio] += matriz[dia - 1][cansancio - 1];
      }

      // Guardamos el máximo de cada fila
      if (matriz[dia][cansancio] > matriz[dia][indicesMaximosPorDia[dia]]) {
        indicesMaximosPorDia[dia] = cansancio;
      }
    }
  }

  return (matriz, indicesMaximosPorDia);
}
