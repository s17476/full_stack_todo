import 'package:dio/dio.dart';
import 'package:failures/failures.dart';
import 'package:fullstack_todo/core/network/exceptions/dio_network_exception.dart';
import 'package:fullstack_todo/core/utils/logger.dart';

class NetworkErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e(err);

    const genericInternetIssue =
        'Please check your internet connection and try again';

    try {
      if (err.response == null) {
        throw Exception();
      }

      final errorJson = err.response!.data as Map<String, dynamic>;

      final failureFromServer = NetworkFailure.fromJson({
        ...errorJson,
        'status_code': err.response!.statusCode,
      });

      throw DioNetworkException(
        message: failureFromServer.message,
        response: Response(
          requestOptions: err.requestOptions,
          statusCode: err.response!.statusCode ?? failureFromServer.statusCode,
        ),

        errors: failureFromServer.errors,
        requestOptions: err.requestOptions,
      );
    } on DioNetworkException catch (e) {
      handler.reject(e);
    } catch (e) {
      handler.reject(
        DioNetworkException(
          message: genericInternetIssue,
          response: Response(
            requestOptions: err.requestOptions,
            statusCode: 500,
          ),
          requestOptions: err.requestOptions,
          errors: {},
        ),
      );
    }
  }
}
