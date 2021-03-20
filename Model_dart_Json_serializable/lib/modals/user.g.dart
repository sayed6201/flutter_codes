// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    subscription: json['subscription'] as bool,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'subscription': instance.subscription,
      'address': instance.address?.toJson(),
    };
