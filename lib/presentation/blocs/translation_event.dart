import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TranslationEvent extends Equatable {
  const TranslationEvent();

  @override
  List<Object> get props => [];
}

class TranslationEventChangeLanguage extends TranslationEvent {
  final String language;

  const TranslationEventChangeLanguage({@required this.language});

  @override
  List<Object> get props => [language];

  @override
  String toString() => "TranslationLanguageChanged { language: $language }";
}

class TranslationEventLoadLanguage extends TranslationEvent {}
