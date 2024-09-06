// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 0;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      title: fields[2] as String,
      releaseDate: fields[3] as String,
      path: fields[5] as String,
      vote: fields[4] as String,
      movieId: fields[0] as String,
      id: fields[1] as String,
      uid: fields[7] as String,
      isInDatabase: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.releaseDate)
      ..writeByte(4)
      ..write(obj.vote)
      ..writeByte(5)
      ..write(obj.path)
      ..writeByte(6)
      ..write(obj.isInDatabase)
      ..writeByte(7)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MovieModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId ==other.typeId;
}