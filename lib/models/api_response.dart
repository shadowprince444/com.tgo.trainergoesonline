import 'package:machine_test_tgo/utils/enums_and_constants/enums.dart';

class ApiResponse<T> {
  late T? data;
  late String? message;
  late APiResponseStatus status;
  ApiResponse.completed(this.data) : status = APiResponseStatus.completed;
  ApiResponse.unauthenticated(this.message) : status = APiResponseStatus.unauthenticated;
  ApiResponse.error(this.message) : status = APiResponseStatus.error;
}
