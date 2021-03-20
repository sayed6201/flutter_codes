
=============================================================================================
JsonSerializable Documentations
-------------------------------
	1)  https://flutter.dev/docs/development/data-and-backend/json
=============================================================================================

----------------------------------------------------------------
Terminal run: 
----------------------------------------------------------------
flutter pub run build_runner build


----------------------------------------------------------------
User Data model
----------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String name, phone, email;
  bool subscription;
  Address address;

  User({this.name, this.phone, this.email, this.subscription, this.address});

  factory User.fromJson(Map<String,dynamic> data) => _$UserFromJson(data);

  Map<String,dynamic> toJson() => _$UserToJson(this);

}



----------------------------------------------------------------
Address Data model
----------------------------------------------------------------
import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  String street,landmark,city,state;

  Address({this.street,this.landmark,this.city,this.state});

  factory Address.fromJson(Map<String,dynamic> data) => _$AddressFromJson(data);

  Map<String,dynamic> toJson() => _$AddressToJson(this);

}