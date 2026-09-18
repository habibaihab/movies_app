part of 'new_releases_cubit.dart';

@immutable
sealed class NewReleasesState {}

final class NewReleasesInitial extends NewReleasesState {}
final class SuccessNewReleasesMovies extends NewReleasesState {}
final class LoadingNewReleasesMovies extends NewReleasesState {}
final class ErrorNewReleasesMovies extends NewReleasesState {
  final String errorMessage;

  ErrorNewReleasesMovies(this.errorMessage);
}