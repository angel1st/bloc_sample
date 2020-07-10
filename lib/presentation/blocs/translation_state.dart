import 'dart:ui';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

/// States
/// Initial - no language loaded
/// Success - language loaded
/// Failed - not able to load language
/// LoadInProgress - while translations are loading

abstract class TranslationState extends Equatable {
  const TranslationState();

  @override
  List<Object> get props => [];
}

class TranslationStateInitial extends TranslationState {}

class TranslationStateSuccess extends TranslationState {
  final Locale locale;

  const TranslationStateSuccess({@required this.locale});

  @override
  List<Object> get props => [locale];

  @override
  String toString() => "TranslationSuccessState { locale: $locale }";
}

class TranslationStateLoadInProgress extends TranslationState {}

class TranslationStateFailed extends TranslationState {}
