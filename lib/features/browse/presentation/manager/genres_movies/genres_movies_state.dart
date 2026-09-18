part of 'genres_movies_cubit.dart';

@immutable
sealed class GenresMoviesState {}

final class GenresMoviesInitial extends GenresMoviesState {}
final class GenresMoviesLoading extends GenresMoviesState {}
final class GenresMoviesSuccess extends GenresMoviesState {}
final class GenresMoviesEmpty extends GenresMoviesState {}
final class GenresMoviesFailed extends GenresMoviesState {

  final String errorMessage;
  GenresMoviesFailed(this.errorMessage);
}
