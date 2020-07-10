import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc_sample_app/local_data_sources/app_database.dart';

abstract class PlantState extends Equatable {
  final PlantsCompanion plantsCompanion;
  const PlantState({@required this.plantsCompanion});
}

class PlantStateInitial extends PlantState {
  PlantStateInitial() : super(plantsCompanion: PlantsCompanion());
  @override
  List<Object> get props => [plantsCompanion];
}

class PlantStateNameSet extends PlantState {
  const PlantStateNameSet({@required PlantsCompanion plantsCompanion})
      : super(plantsCompanion: plantsCompanion);
  @override
  List<Object> get props => [plantsCompanion.name];
}

class PlantStateImageSet extends PlantState {
  const PlantStateImageSet({@required PlantsCompanion plantsCompanion})
      : super(plantsCompanion: plantsCompanion);
  @override
  List<Object> get props => [plantsCompanion.image];
}

class PlantStateImageIsLoading extends PlantState {
  const PlantStateImageIsLoading({@required PlantsCompanion plantsCompanion})
      : super(plantsCompanion: plantsCompanion);
  @override
  List<Object> get props => [plantsCompanion.image];
}

class PlantStateIsSaving extends PlantState {
  const PlantStateIsSaving({@required PlantsCompanion plantsCompanion})
      : super(plantsCompanion: plantsCompanion);
  @override
  List<Object> get props => [];
}

class PlantStateSaved extends PlantState {
  const PlantStateSaved({@required PlantsCompanion plantsCompanion})
      : super(plantsCompanion: plantsCompanion);
  @override
  List<Object> get props => [];
}
