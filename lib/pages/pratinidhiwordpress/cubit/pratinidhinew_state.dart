part of 'pratinidhinew_cubit.dart';

abstract class PratinidhinewState extends Equatable {
  const PratinidhinewState();

  @override
  List<Object> get props => [];
}

class PratinidhinewInitial extends PratinidhinewState {}

class PratinidhinewLoaded extends PratinidhinewState {
  final List<PratinidhiModelWordpress> pratinidhiModel;
  const PratinidhinewLoaded(this.pratinidhiModel);
}

class PratinidhinewLoading extends PratinidhinewState {}

class PratinidhinewError extends PratinidhinewState {
  final String? message;
  const PratinidhinewError(this.message);
}
