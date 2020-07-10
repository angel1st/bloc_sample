import 'package:meta/meta.dart';
import 'package:bloc_sample_app/local_data_sources/local_data_sources.dart';

class PlantRepository {
  final PlantsDao plantsDao;
  const PlantRepository({@required this.plantsDao}) : assert(plantsDao != null);
}
