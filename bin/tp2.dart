import 'package:tp2/calcular_planificacion.dart';
import 'package:tp2/leer_archivo.dart';

void main(List<String> arguments) async {
  final archivo = arguments.isNotEmpty ? arguments[0] : null;

  if (archivo == null) {
    print("No se leyó ningún archivo");
    return;
  }

  final cronograma = await leerCronogramaDesdeArchivo(archivo);

  final (planificacion, ganancia) = calcular(cronograma);

  for (final plan in planificacion) {
    print(plan == PlanDia.entrenamiento ? 'Entrenamiento' : 'Descanso');
  }

  print("Ganancia máxima: $ganancia");
}
