import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:bloc_sample_app/local_data_sources/app_database.dart';

abstract class PlantEvent extends Equatable {
  const PlantEvent();
}

class PlantEventNewName extends PlantEvent {
  final String name;
  const PlantEventNewName({@required this.name});

  @override
  List<Object> get props => [name];
}

class PlantEventNewImage extends PlantEvent {
  final String fileName;
  const PlantEventNewImage({@required this.fileName});

  @override
  List<Object> get props => [fileName];
}

class PlantEventSave extends PlantEvent {
  final PlantsCompanion plantsCompanion;
  const PlantEventSave({@required this.plantsCompanion});
  @override
  List<Object> get props => [plantsCompanion];
}
