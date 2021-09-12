// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'ofensor.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
//
// import 'package:hive/hive.dart';
//
// class OfensorHiveModelAdapter extends TypeAdapter<OfensorHiveModel> {
//   @override
//   final int typeId = 1;
//
//   @override
//   OfensorHiveModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return OfensorHiveModel()
//       ..id = fields[0] as String
//       ..name = fields[1] as String
//       ..description = fields[2] as String
//       ..category = fields[3] as String
//       ..tipo = (fields[4] as List)?.cast<String>()
//       ..image = fields[5] as String
//       ..images = (fields[6] as List)?.cast<String>()
//       ..fase = (fields[7] as List)?.cast<String>()
//       ..tempoDuracaoFase = (fields[8] as List)?.cast<String>();
//   }
//
//   @override
//   void write(BinaryWriter writer, OfensorHiveModel obj) {
//     writer
//       ..writeByte(9)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(2)
//       ..write(obj.description)
//       ..writeByte(3)
//       ..write(obj.category)
//       ..writeByte(4)
//       ..write(obj.tipo)
//       ..writeByte(5)
//       ..write(obj.image)
//       ..writeByte(6)
//       ..write(obj.images)
//       ..writeByte(7)
//       ..write(obj.fase)
//       ..writeByte(8)
//       ..write(obj.tempoDuracaoFase);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is OfensorHiveModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
