part of 'get_movies_cubit.dart';

@immutable
sealed class GetMoviesState {}

final class GetMoviesInitial extends GetMoviesState {}
final class SuccessGetMovies extends GetMoviesState {}
final class LoadingGetMovies extends GetMoviesState {}
final class ErrorGetMovies extends GetMoviesState {
  final String errorMessage;

  ErrorGetMovies(this.errorMessage);
}
