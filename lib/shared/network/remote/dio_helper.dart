import 'package:dio/dio.dart';

class DioHelperMovie {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      receiveDataWhenStatusError: true,
      headers: {'lang': 'en-US'},
    ));
  }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en-US',
  }) async {
    dio.options.headers = {'lang': lang,};
    return await dio.get(
      url,
      queryParameters: {
        "api_key": "4d5a7bc077aef7bcd4729c5327edbca5"
      },
    );
  }

  static Future<Response> getDataUseId({
    required String url,
    required int id,
    Map<String, dynamic>? query,
    String lang = 'en-US',
  }) async {
    dio.options.headers = {'lang': lang};
    return await dio.get(
      url,
      queryParameters: {
        'page':1,
        'with_genres':id,
        "api_key": "4d5a7bc077aef7bcd4729c5327edbca5"
      },
    );
  }

  static Future<Response> getDataMovieId({
    required String url,
    required int id,
    Map<String, dynamic>? query,
    String lang = 'en-US',
  }) async {
    dio.options.headers = {'lang': lang};
    return await dio.get(
      url+"/$id",
      queryParameters: {
        "api_key": "4d5a7bc077aef7bcd4729c5327edbca5"
      },
    );
  }
  static Future<Response> getDataCastId({
    required String url,
    required int id,
    Map<String, dynamic>? query,
    String lang = 'en-US',
  }) async {
    dio.options.headers = {'lang': lang};
    return await dio.get(
      url+"/$id/credits",
      queryParameters: {
        'page':1,
        "api_key": "4d5a7bc077aef7bcd4729c5327edbca5"
      },
    );
  }

  static Future<Response> getDataSimilarId({
    required String url,
    required int id,
    Map<String, dynamic>? query,
    String lang = 'en-US',
  }) async {
    dio.options.headers = {'lang': lang};
    return await dio.get(
      url+"/$id/similar",
      queryParameters: {
        'page':1,
        "api_key": "4d5a7bc077aef7bcd4729c5327edbca5"
      },
    );
  }


  static Future<Response> getDataVideo({
    required String url,
    required int id,
    Map<String, dynamic>? query,
    String lang = 'en-US',
  }) async {
    dio.options.headers = {'lang': lang};
    return await dio.get(
      url+"/$id/videos",
      queryParameters: {
        "api_key": "4d5a7bc077aef7bcd4729c5327edbca5"
      },
    );
  }


  static Future<Response> getDataSearch({
    required String url,
    required String movie,
    Map<String, dynamic>? query,
    String lang = 'en-US',
  }) async {
    dio.options.headers = {'lang': lang};
    return await dio.get(
      url,
      queryParameters: {
        "api_key": "4d5a7bc077aef7bcd4729c5327edbca5",
        "query":movie,
        "page":1
      },
    );
  }


}
