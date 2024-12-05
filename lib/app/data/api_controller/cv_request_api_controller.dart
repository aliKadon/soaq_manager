import 'dart:convert';

import 'package:soaqman/app/data/api_helper.dart';
import 'package:soaqman/models/cv_req_model.dart';
import 'package:http/http.dart' as http;

import '../../../models/api_response.dart';

class CvRequestApiController with ApiHelper {
  Future<List<CvReqModel>> getCvRequest() async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/requestForCV');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<CvReqModel>.from(jsonData['data'].map((x) => CvReqModel.fromJson(x)));
    }
    return [];
  }

  Future<ApiResponse> makeAsRead({required int id}) async {
    var url = Uri.parse('http://soaq.a2hosted.com/v1/requestForCV/$id');
    var response = await http.put(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return ApiResponse(message: jsonData["status"], status: 200);
    }
    return failedResponse;
  }
}
