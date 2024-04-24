// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'woda_jankari_cubit.dart';

abstract class WodaJankariState extends Equatable {
  const WodaJankariState();

  @override
  List<Object> get props => [];
}

class WodaJankariInitial extends WodaJankariState {}

class WodaJankariFetched extends WodaJankariState {
  final List<WodaJanakaridata> wodajankaridata;
  const WodaJankariFetched(this.wodajankaridata);
}

class WodaJankariLoading extends WodaJankariState {}
class WodaJankariFailure extends WodaJankariState {
  String error;
  WodaJankariFailure({
    required this.error,
  });
  
}
