part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}
class NewsLoading extends NewsState {}
class NewsFetched extends NewsState {
  List<NewsNoticeModelWordpress> model;
  NewsFetched({required this.model });
}
class NewsFetchError extends NewsState {
  String error;
  NewsFetchError({required this.error});
}
