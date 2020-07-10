import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  @override
  NameState get initialState => NameStateInitial();

  @override
  Stream<NameState> mapEventToState(NameEvent event) async* {
    if (event is NameEventNew) {
      try {
        if (event.name.isEmpty)
          yield NameStateInvalid();
        else
          yield NameStateSuccess(name: event.name);
      } catch (_) {
        yield NameStateFailed();
      }
    }
  }
}
