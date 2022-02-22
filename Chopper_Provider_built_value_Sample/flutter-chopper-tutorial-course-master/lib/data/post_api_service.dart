import 'package:chopper/chopper.dart';
import 'package:chopper_tutorial/model/built_post.dart';
import 'package:built_collection/built_collection.dart';

import 'built_value_converter.dart';
import 'mobile_data_interceptor.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  // Headers (e.g. for Authentication) can be added in the HTTP method constructor
// or also as parameters of the Dart method itself.
//@Get(headers: {'Constant-Header-Name': 'Header-Value'})
//Future<Response> getPosts([
  // Parameter headers are suitable for ones which values need to change
  //@Header('Changeable-Header-Name') String headerValue,
    //]);

    @Get(path: '/{id}')
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  // @Put & @Patch requests are specified the same way - they must contain the @Body
  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() <BuiltPost> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [(),

        _$PostApiService(),
      ],
      converter: BuiltValueConverter(), #JsonConverter(), BuiltValueConverter -> is custom class
      interceptors: [

      HeadersInterceptor({'Cache-Control': 'no-cache'})

      HttpLoggingInterceptor(),  #check _setupLogging() in main.dart

      #Separate classs
      MobileDataInterceptor(),

      #Anonymous class interceptor
      (Request request) async {
        if (request.method == HttpMethod.Post) {
          chopperLogger.info('Performed a POST request');
        }
        return request;
      },
      (Response response) async {
        if (response.statusCode == 404) {
          chopperLogger.severe('404 NOT FOUND');
        }
        return response;
      },

      ],
    );
    return _$PostApiService(client);
  }
}


//RUN: flutter packages pub run build_runner watch  -> to generate the post_api_service_chopper.dart codes