import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'scroll_event.dart';
part 'scroll_state.dart';

class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  AlignmentDirectional draging = AlignmentDirectional.topCenter;

  bool isActive = false;

  ScrollBloc() : super(DragedState()) {
    on<DragingEvent>((event, emit) {
      if (event.alignment != null) {
        draging = event.alignment!;
      }

      emit(DragedState());
    });

    on<ActiveItemEvent>((event, emit) {
      isActive = event.isActive;
      emit(ActiveItemState());
    });
  }
}
