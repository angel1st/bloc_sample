import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class NameState extends Equatable {
  const NameState();

  @override
  List<Object> get props => [];
}

class NameStateInitial extends NameState {}

class NameStateSuccess extends NameState {
  final String name;

  const NameStateSuccess({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => "NameStateSuccess { name: $name }";
}

class NameStateInvalid extends NameState {}

class NameStateFailed extends NameState {}
