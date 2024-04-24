part of 'sifarish_form_cubit.dart';

abstract class SifarishFormState extends Equatable {
  const SifarishFormState();

  @override
  List<Object> get props => [];
}

class SifarishFormCubitInitial extends SifarishFormState {}

class SifarishBuildFormState extends SifarishFormState {
  final List<SifarishFieldModel> sifarishFields;
  final List<SifarishFieldModel> sifarishDocuments;
  final String title;
  final String formId;
  final FormGroup formGroup;
  final int currentStep;
  final bool isChildSifarish;

  const SifarishBuildFormState({
    required this.currentStep,
    required this.sifarishFields,
    required this.sifarishDocuments,
    required this.formGroup,
    required this.title,
    required this.formId,
    required this.isChildSifarish,
  });

  @override
  List<Object> get props => [
        currentStep,
        sifarishFields,
        sifarishDocuments,
        title,
        formId,
        formGroup,
        isChildSifarish
      ];
}

class SifarishSubmissionErrorState extends SifarishFormState {
  final String message;
  const SifarishSubmissionErrorState({
    required this.message,
  });
  @override
  List<Object> get props => [UniqueKey()];
}

class SifarishFormCompletedState extends SifarishFormState {}
