import 'dart:io';

import 'package:new_bakarbatu/core/usecases/usecase_contribution.dart';
import 'package:new_bakarbatu/features/contribution/domain/repositories/contribution_repository.dart';

class ContributionUsecase implements UsecaseContribution {
  final ContributionRepository repository;

  ContributionUsecase(this.repository);

  @override
  Future<File?> getPhotoFile() async {
    return await repository.getPhotoFile();
  }

  @override
  Future<File?> getVideoFile() async {
    return await repository.getVideoFile();
  }

}