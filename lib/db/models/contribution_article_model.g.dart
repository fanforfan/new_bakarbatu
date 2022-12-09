// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contribution_article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContributionArticleAdapter extends TypeAdapter<ContributionArticle> {
  @override
  final int typeId = 1;

  @override
  ContributionArticle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContributionArticle(
      collectionKey: fields[0] as String?,
      filename: fields[1] as String?,
      timeSchedule: fields[2] as String?,
      judulIndonesia: fields[3] as String?,
      captionIndonesia: fields[4] as String?,
      deskripsiIndonesia: fields[5] as String?,
      tagKabupaten: fields[6] as String?,
      tagKampung: fields[7] as String?,
      tagDistrik: fields[8] as String?,
      hideAuthor: fields[9] as bool?,
      jenisFile: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ContributionArticle obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.collectionKey)
      ..writeByte(1)
      ..write(obj.filename)
      ..writeByte(2)
      ..write(obj.timeSchedule)
      ..writeByte(3)
      ..write(obj.judulIndonesia)
      ..writeByte(4)
      ..write(obj.captionIndonesia)
      ..writeByte(5)
      ..write(obj.deskripsiIndonesia)
      ..writeByte(6)
      ..write(obj.tagKabupaten)
      ..writeByte(7)
      ..write(obj.tagKampung)
      ..writeByte(8)
      ..write(obj.tagDistrik)
      ..writeByte(9)
      ..write(obj.hideAuthor)
      ..writeByte(10)
      ..write(obj.jenisFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContributionArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
