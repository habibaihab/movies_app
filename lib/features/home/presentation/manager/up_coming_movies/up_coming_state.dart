part of 'up_coming_cubit.dart';

@immutable
sealed class UpComingState {}

final class UpComingInitial extends UpComingState {}
final class UpComingLoading extends UpComingState {}
final class UpComingSuccess extends UpComingState {}
final class UpComingFailed extends UpComingState {
  final String errorMessage;

  UpComingFailed(this.errorMessage);
}
