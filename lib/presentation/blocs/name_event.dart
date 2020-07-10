import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NameEvent extends Equatable {
  const NameEvent();

  @override
  List<Object> get props => [];
}

class NameEventNew extends NameEvent {
  final String name;

  const NameEventNew({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => "NameEventNew { name: $name }";
}
