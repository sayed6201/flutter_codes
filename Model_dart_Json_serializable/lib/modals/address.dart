import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  String street,landmark,city,state;

  Address({this.street,this.landmark,this.city,this.state});

  factory Address.fromJson(Map<String,dynamic> data) => _$AddressFromJson(data);

  Map<String,dynamic> toJson() => _$AddressToJson(this);

}