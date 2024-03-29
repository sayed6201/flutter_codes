import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_library_tut/counter_event.dart';
import 'package:bloc_library_tut/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  void onIncrement() {
    dispatch(IncrementEvent());
  }

  void onDecrement() {
    dispatch(DecrementEvent());
  }

  @override
  CounterState get initialState => CounterState.initial();

  @override
  Stream<CounterState> mapEventToState(
      CounterState currentState, CounterEvent event) async *{
    // TODO: implement mapEventToState
    final _currentState = currentState;
    if (event is IncrementEvent) {
      yield CounterState(counter: _currentState.counter + 1);
    } else if (event is DecrementEvent) {
      yield CounterState(counter: _currentState.counter - 1);
    }
  }


}
