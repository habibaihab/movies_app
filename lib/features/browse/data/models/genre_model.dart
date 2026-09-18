import 'package:movies_app/features/browse/domin/entities/genre_entity.dart';

class GenreModel extends GenreEntity{
  const GenreModel({required super.id, required super.name});

  factory GenreModel.fromJson(Map<String,dynamic>json){
    return GenreModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? ""
    );
  }


}