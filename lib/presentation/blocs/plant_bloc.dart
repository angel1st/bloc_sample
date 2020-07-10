import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moor/moor.dart';
import 'package:bloc_sample_app/local_data_sources/app_database.dart';
import 'package:bloc_sample_app/repositories/repositories.dart';
import './bloc.dart';
import 'dart:io';
import 'package:image/image.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  final PlantRepository plantRepository;
  PlantBloc({@required this.plantRepository}) : assert(plantRepository != null);

  Uint8List _makeThumbnail(Uint8List byteImage, {int width = 120}) {
    Image img = decodeImage(byteImage);
    Image thumbnail = copyResize(img, width: 120);
    return encodePng(thumbnail);
  }

  @override
  PlantState get initialState => PlantStateInitial();

  @override
  Stream<PlantState> mapEventToState(
    PlantEvent event,
  ) async* {
    if (event is PlantEventNewName) {
      yield PlantStateNameSet(
        plantsCompanion: state.plantsCompanion.copyWith(
          name: Value(event.name),
        ),
      );
    }
    if (event is PlantEventNewImage) {
      yield PlantStateImageIsLoading(plantsCompanion: state.plantsCompanion);
      //await Future.delayed(Duration(milliseconds: 500));
      File imageFile = File(event.fileName);
      Uint8List byteImage = await imageFile.readAsBytes();
      Uint8List byteThumbnail = _makeThumbnail(byteImage);
      PlantsCompanion plant = state.plantsCompanion.copyWith(
        image: Value(
          byteImage,
        ),
        thumbnail: Value(
          byteThumbnail,
        ),
      );
      yield PlantStateImageSet(
        plantsCompanion: plant,
      );
    }
    if (event is PlantEventSave) {
      yield PlantStateIsSaving(plantsCompanion: event.plantsCompanion);
      await Future.delayed(Duration(milliseconds: 500));
      plantRepository.plantsDao.insertPlant(event.plantsCompanion);
      yield PlantStateSaved(plantsCompanion: event.plantsCompanion);
    }
  }
}
