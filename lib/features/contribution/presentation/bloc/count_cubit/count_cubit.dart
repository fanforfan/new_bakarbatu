import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/contribution_usecase.dart';

part 'count_state.dart';

class CountCubit extends Cubit<CountState> {
  final ContributionUsecase contributionUsecase;
  CountCubit({required this.contributionUsecase}) : super(const CountState());

  void getCount() async {
    emit(state.copyWith(
        status: CountStatus.loading
    ));

    var response = await contributionUsecase.getCountArticle();

    if(response != null){
      if(response.data['data_newsroom'] != null){
        emit(state.copyWith(
            status: CountStatus.success,
            approved: response.data['count_data']['approved'],
            waiting: response.data['count_data']['waiting'],
            totalDataSubmit: response.data['count_data']['total_data_submit']
        ));
      }else{
        emit(state.copyWith(
            status: CountStatus.success,
            approved: 0,
            waiting: 0,
            totalDataSubmit: 0
        ));
      }
    }
  }
}
