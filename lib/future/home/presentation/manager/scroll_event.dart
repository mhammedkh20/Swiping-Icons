part of 'scroll_bloc.dart';

class ScrollEvent {}

class DragingEvent extends ScrollEvent {
  AlignmentDirectional? alignment;
  DragingEvent(this.alignment);
}

class ActiveItemEvent extends ScrollEvent {
  bool isActive;
  ActiveItemEvent(this.isActive);
}
