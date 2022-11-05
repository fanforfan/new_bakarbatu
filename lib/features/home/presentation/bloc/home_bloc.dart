import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_bakarbatu/features/home/domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecase homeUsecase;

  HomeBloc({required this.homeUsecase}) : super(const HomeState()) {
    on<HomeGotoWebview>(goToWebview);
  }

  goToWebview(HomeGotoWebview event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      status: HomeStateStatus.loading
    ));

    try{
      final response = await homeUsecase.goToWebView();

      emit(state.copyWith(
        status: HomeStateStatus.success,
        urlWebview: response
      ));

    } catch(error) {
      emit(state.copyWith(
        message: '$error',
        status: HomeStateStatus.error
      ));
    }

    // if(event.urlWebview.isEmpty){
    //   debugPrint('URL GA ADA');
    // }else{
    //   debugPrint('URL ADA ${event.urlWebview}');
    // }
  }
}
