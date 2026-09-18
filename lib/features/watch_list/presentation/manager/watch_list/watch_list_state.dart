part of 'watch_list_cubit.dart';

@immutable
sealed class WatchListState {}

final class WatchListInitial extends WatchListState {}

final class WatchListLoading extends WatchListState {}

final class WatchListSuccess extends WatchListState {}

final class WatchListEmpty extends WatchListState {}

final class WatchListError extends WatchListState {
  final String errorMessage;

  WatchListError(this.errorMessage);
}
