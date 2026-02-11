import 'dart:async';

import 'package:bloc/bloc.dart';

abstract class BaseBloc<E, S, Effect> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  final _effectController = StreamController<Effect>.broadcast();

  Stream<Effect> get effectStream => _effectController.stream;

  void emitEffect(Effect effect) {
    if (!_effectController.isClosed) {
      _effectController.add(effect);
    }
  }

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}
