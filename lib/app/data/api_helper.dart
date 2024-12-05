
import 'dart:io';

import '../../models/api_response.dart';

mixin ApiHelper {
  ApiResponse get failedResponse =>
      ApiResponse(message: 'something went wrong, try again!', status: 500);


  Map<String, String> get headers {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      // HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
    };
  }

}
