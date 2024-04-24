part of 'karmachariwordpress_cubit.dart';

abstract class KarmachariwordpressState extends Equatable {
  const KarmachariwordpressState();

  @override
  List<Object> get props => [];
}

class KarmachariwordpressInitial extends KarmachariwordpressState {}

class KarmachariwordpressLoaded extends KarmachariwordpressState {
  final List<PratinidhiModelWordpress> pratinidhiModel;
  const KarmachariwordpressLoaded(this.pratinidhiModel);
}

class KarmachariwordpressError extends KarmachariwordpressState {
  final String? message;
  const KarmachariwordpressError(this.message);
}

class KarmachariwordpressLoading extends KarmachariwordpressState {}
