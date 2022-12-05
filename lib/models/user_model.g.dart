// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      profile: fields[4] as String?,
      uid: fields[5] as String?,
      fullName: fields[6] as String?,
      joinedDate: fields[7] as String?,
      categories: (fields[8] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.profile)
      ..writeByte(5)
      ..write(obj.uid)
      ..writeByte(6)
      ..write(obj.fullName)
      ..writeByte(7)
      ..write(obj.joinedDate)
      ..writeByte(8)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}