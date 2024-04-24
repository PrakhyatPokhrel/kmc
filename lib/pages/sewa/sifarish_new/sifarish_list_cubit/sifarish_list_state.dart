part of 'package:kmc/pages/sewa/sifarish_new/sifarish_list_cubit/sifarish_list_cubit.dart';

abstract class SifarishState extends Equatable {
  const SifarishState();

  @override
  List<Object> get props => [];
}

class SifarishInitial extends SifarishState {}

class SifarishFetching extends SifarishState {}

class SifarishFetchSuccess extends SifarishState {
  final List<SifarishFormModel> sifarishFormList;
  final bool showEnglish;
  final bool showLanguageButton;

  const SifarishFetchSuccess({
    required this.sifarishFormList,
    required this.showEnglish,
    required this.showLanguageButton,
  });
  @override
  List<Object> get props => [sifarishFormList, showEnglish, showLanguageButton];
}

class SifarishFetchFailure extends SifarishState {
  final CustomException exception;
  const SifarishFetchFailure(
    this.exception,
  );

  @override
  List<Object> get props => [exception];
}
