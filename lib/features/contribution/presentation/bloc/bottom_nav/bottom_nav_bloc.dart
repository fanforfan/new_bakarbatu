import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState()) {
    on<ChangeBottomNav>(changeBottomNav);
  }

  changeBottomNav(ChangeBottomNav event, Emitter<BottomNavState> emit) {
    emit(state.copyWith(
      statusMenu: event.statusMenu,
      idMenu: event.idMenu
    ));
  }
}
