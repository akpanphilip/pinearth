import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinearth/backend/application/servicies/localstorage/hive.local_storage.service.dart';
import 'package:pinearth/utils/constants/local_storage_keys.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../../domain/services/i_local_storage_service.dart';
import 'i_api.service.dart';

class DioApiService implements IApiService {
  final _dio = Dio(BaseOptions(
    baseUrl: dotenv.maybeGet('baseUrl') ?? "https://backends.pinearth.com/",
    headers: {'responseType': 'application/json'},
  ));

  final ILocalStorageService localStorage;
  // final AppRoute appRouter;

  DioApiService(this.localStorage) {
    print("DioApiServiceInitialized:::");
    _dio.interceptors.add(InternetConnectivityInterceptor());
    _dio.interceptors.add(PrettyDioLogger(
      error: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      logPrint: (object) {
        if (!kReleaseMode) {
          // print(object);
        }
      },
    ));
    // _dio.interceptors.add(TokenRefreshInterceptor(localStorage, this));
    _dio.interceptors.add(TokenInterceptor(localStorage));
  }

  @override
  Future<ApiResponse> delete(String endpoint,
      {bool requireToken = true}) async {
    try {
      final res = await _dio.delete(endpoint,
          options: Options(headers: {'requireToken': requireToken}));
      return _handleResponse(res.data);
    } on DioException catch (error) {
      return _handleError(error);
    } catch (error) {
      return ApiResponse(message: "Error: $error", status: false);
    }
  }

  @override
  Future<ApiResponse> get(String endpoint, {bool requireToken = true}) async {
    try {
      print("GetEndpointCalled:::");
      final res = await _dio.get(endpoint,
          options: Options(headers: {'requireToken': requireToken}));
      return _handleResponse(res.data);
    } on DioException catch (error) {
      return _handleError(error);
    } catch (error) {
      return ApiResponse(message: "Error: $error", status: false);
    }
  }

  @override
  Future<ApiResponse> patch(String endpoint, dynamic data,
      {bool requireToken = true,
      bool useFormData = true,
      Map<String, dynamic> extraHeader = const {}}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> post(String endpoint, dynamic data,
      {bool requireToken = true,
      bool useFormData = false,
      Map<String, dynamic> extraHeader = const {}}) async {
    try {
      final res = await _dio.post(endpoint,
          data: useFormData ? FormData.fromMap(data) : data,
          options:
              Options(headers: {'requireToken': requireToken, ...extraHeader}));
      // print("${res.headers}");
      // print("${res.realUri}");
      // print("${res.statusCode}");

      return _handleResponse(res.data, statusCode: res.statusCode);
    } on DioException catch (error) {
      return _handleError(
        error,
      );
    } catch (error) {
      return ApiResponse(message: "Error: $error", status: false);
    }
  }

  @override
  Future<ApiResponse> put(String endpoint, dynamic data,
      {bool requireToken = true,
      bool useFormData = false,
      Map<String, dynamic> extraHeader = const {}}) async {
    try {
      final res = await _dio.put(endpoint,
          data: useFormData ? FormData.fromMap(data) : data,
          options:
              Options(headers: {'requireToken': requireToken, ...extraHeader}));
      print("ApiResponse ::: ${res.data}");
      return _handleResponse(res.data);
    } on DioException catch (error) {
      return _handleError(error);
    } catch (error) {
      return ApiResponse(message: "Error: $error", status: false);
    }
  }

  ApiResponse _handleResponse(data, {int? statusCode}) {
    return ApiResponse.fromJson(
        {'data': data, 'status': true, "statusCode": statusCode});
  }

  ApiResponse _handleError(DioException error, {int? statCode}) {
    if (error.type == DioExceptionType.unknown) {
      return ApiResponse(
          status: false,
          message: error.error!.toString(),
          statusCode: statCode);
    }
    print("CatchedDioException: ${error.type}");

    final statusCode = error.response!.statusCode.toString();

    if (statusCode.contains('401')) {
      // appRouter.replaceAll([const LoginBaseRoute()]);
      // if(error.response != null) {
      //   if (error.response!.data != null) {
      //     return ApiResponse(
      //       status: false,
      //       message: error.response!.data!['message']
      //     );
      //   }
      // }
      return ApiResponse(status: false, message: "Unauthorized");
    }

    if (error.message!.toLowerCase().contains('400')) {
      print(error.response!.data.runtimeType);
      if (error.response!.data != null) {
        if (error.response!.data.runtimeType.toString().contains("Map")) {
          final err = Map.from(error.response!.data);
          String message = "";
          err.forEach((k, v) {
            if (v.runtimeType.toString().contains("Map")) {
              print("ErrorMap:: $v");
              final map2 = Map.from(v);
              map2.forEach((key, value) {
                message = "$value\n$message";
              });
            } else if (v.runtimeType.toString().contains("List")) {
              print("ErrorList:: $v");
              message = "${List.from(v).join("\n")}$message";
            } else if (v.runtimeType.toString().contains("String")) {
              print("ErrorString:: $v");
              message = "$v\n$message";
            }
          });
          return ApiResponse(status: false, message: message.trim());
        }
      }
      return ApiResponse(
          status: false, message: error.response!.data['message']);
    }

    if (statusCode.startsWith('5')) {
      print(error.response!.data);
      return ApiResponse(
          status: false, message: "Service not available at the moment.");
    }

    return ApiResponse(status: false, message: error.message);
  }
}

class TokenInterceptor extends Interceptor {
  final ILocalStorageService localStorage;

  TokenInterceptor(this.localStorage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("TokenInterceptor:::OnRequest");
    print("requires token ${options.headers['requireToken']}");

    /// check for token requirement
    if (options.headers.containsKey('requireToken')) {
      if (options.headers['requireToken'] == true) {
        final token = await localStorage.getItem(userDataBoxKey, userTokenKey,
            defaultValue: null);
        print(token);
        if (token == null) {
          final error =
              DioException(requestOptions: options, error: "Unauthenticated");
          // super.onError(error, handler);
          return handler.reject(error);
        }
        final tokenString = "JWT $token";
        options.headers['Authorization'] = tokenString;

        print(options.headers);
        options.headers.remove("requireToken");
      }
    }
    // return options;
    return super.onRequest(options, handler);
  }
}

class TokenRefreshInterceptor extends Interceptor {
  final ILocalStorageService localStorage;
  final IApiService apiService;

  TokenRefreshInterceptor(this.localStorage, this.apiService);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("TokenInterceptor:::OnRequest");

    /// check for token requirement
    if (options.headers.containsKey('requireToken')) {
      if (options.headers['requireToken'] == true) {
        // call end point to refresh token
        final refreshToken = await localStorage
            .getItem(userDataBoxKey, userRefreshTokenKey, defaultValue: null);
        if (refreshToken != null) {
          final res = await apiService
              .post("user/token/refresh/", {'refresh': refreshToken});
        } else {
          final error =
              DioException(requestOptions: options, error: "Unauthenticated");
          // super.onError(error, handler);
          return handler.reject(error);
        }
      }
    }
    // return options;
    return super.onRequest(options, handler);
  }
}

class InternetConnectivityInterceptor extends Interceptor {
  InternetConnectivityInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // print("InternetConnectivityInterceptor:::OnRequest");
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (![
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
      ConnectivityResult.other
    ].contains(connectivityResult)) {
      // I am connected to a mobile network.
      final error = DioException(
          requestOptions: options,
          error: "Please connect to an internet connection");
      // super.onError(error, handler);
      return handler.reject(error);
    }
    // return options;
    return super.onRequest(options, handler);
  }
}

final dioApiService = Provider<IApiService>(
    (ref) => DioApiService(ref.read(hiveLocalStorageService)));
