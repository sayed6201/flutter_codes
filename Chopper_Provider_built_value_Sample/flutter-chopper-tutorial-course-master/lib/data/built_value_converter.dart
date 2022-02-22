import 'package:chopper/chopper.dart';
import 'package:chopper_tutorial/model/serializers.dart';
import 'package:built_collection/built_collection.dart';

class BuiltValueConverter extends JsonConverter {
  @override
  Request convertRequest(Request request) {
    return super.convertRequest(
      request.replace(
        body: serializers.serializeWith(
          serializers.serializerForType(request.body.runtimeType), # request.body.runtimeType -> BuiltPost() is the runtimtype
          request.body,
        ),
      ),
    );
  }

  @override
  Response<BodyType> convertResponse<BodyType, SingleItemType>( #BodyType, SingleItemType -> first one could be list, second one list itewm
    Response response,
  ) {
    final Response dynamicResponse = super.convertResponse(response);
    final BodyType customBody =
        _convertToCustomObject<SingleItemType>(dynamicResponse.body);
    return dynamicResponse.replace<BodyType>(body: customBody);
  }

  dynamic _convertToCustomObject<SingleItemType>(dynamic element) {
    if (element is SingleItemType) return element;

    if (element is List)
      return _deserializeListOf<SingleItemType>(element); #if the data is list
    else
      return _deserialize<SingleItemType>(element); #if the data is Map<String.dynamic>
  }

  BuiltList<SingleItemType> _deserializeListOf<SingleItemType>(
    List dynamicList,
  ) {
    return BuiltList<SingleItemType>(
      dynamicList.map((element) => _deserialize<SingleItemType>(element)),
    );
  }

  SingleItemType _deserialize<SingleItemType>(
    Map<String, dynamic> value,
  ) {
    return serializers.deserializeWith(
      serializers.serializerForType(SingleItemType),
      value,
    );
  }
}
