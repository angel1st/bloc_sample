import 'package:moor/moor.dart';
import 'package:bloc_sample_app/local_data_sources/plant_table.dart';
import 'app_database.dart';

part 'plants_dao.g.dart';

@UseDao(tables: [Plants])
class PlantsDao extends DatabaseAccessor<AppDatabase> with _$PlantsDaoMixin {
  final AppDatabase db;
  PlantsDao(this.db) : super(db);

  Future<List<Plant>> getAll() => select(plants).get();
  Stream<List<Plant>> watchAll() => select(plants).watch();
  Future insertPlant(Insertable<Plant> plant) => into(plants).insert(plant);
  Future updatePlant(Insertable<Plant> plant) => update(plants).replace(plant);
  Future deletePlant(Insertable<Plant> plant) => delete(plants).delete(plant);
}