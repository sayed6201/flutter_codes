// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    street: json['street'] as String,
    landmark: json['landmark'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'landmark': instance.landmark,
      'city': instance.city,
      'state': instance.state,
    };
