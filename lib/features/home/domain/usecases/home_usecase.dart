import 'package:new_bakarbatu/core/usecases/usecase.dart';
import 'package:new_bakarbatu/core/usecases/usecase_home.dart';
import 'package:new_bakarbatu/features/home/domain/repositories/home_repository.dart';

class HomeUsecase implements UsecaseHome {
  final HomeRepository repository;

  HomeUsecase(this.repository);

  @override
  Future goToWebView(String? urlWebView) async {
    return await repository.goToWebView(urlWebView);
  }
}