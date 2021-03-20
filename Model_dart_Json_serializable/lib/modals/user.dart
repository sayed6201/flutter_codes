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
