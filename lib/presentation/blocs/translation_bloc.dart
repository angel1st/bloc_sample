import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_sample_app/utils/global_translations.dart';
import 'bloc.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  @override
  TranslationState get initialState => TranslationStateInitial();

  @override
  Stream<TranslationState> mapEventToState(TranslationEvent event) async* {
    if (event is TranslationEventLoadLanguage) {
      try {
        yield TranslationStateLoadInProgress();
        yield TranslationStateSuccess(
          locale: await allTranslations.loadDefaultLanguage(),
        );
      } catch (_) {
        yield TranslationStateFailed();
      }
    }
    if (event is TranslationEventChangeLanguage &&
        event.language != allTranslations.currentLanguage) {
      try {
        yield TranslationStateLoadInProgress();
        yield TranslationStateSuccess(
          locale: await allTranslations.setNewLanguage(event.language),
        );
      } catch (_) {
        yield TranslationStateFailed();
      }
    }
  }
}
