part of 'get_movies_by_genre_id_cubit.dart';

@immutable
sealed class GetMoviesByGenreIdState {}

final class GetMoviesByGenreIdInitial extends GetMoviesByGenreIdState {}

final class GetMoviesByGenreIdLoading extends GetMoviesByGenreIdState {}
final class GetMoviesByGenreIdSuccess extends GetMoviesByGenreIdState {}
final class GetMoviesByGenreIdEmpty extends GetMoviesByGenreIdState {}
final class GetMoviesByGenreIdFailed extends GetMoviesByGenreIdState {

  final String errorMessage;
  GetMoviesByGenreIdFailed(this.errorMessage);
}
