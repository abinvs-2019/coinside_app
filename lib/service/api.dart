import 'dart:convert';

import 'package:calicut/model/model.dart';

import 'package:http/http.dart' as http;

class API_Provider {
  Future<List<Modal>> getStudents() async {
    var client = http.Client();
    print('api hit');
    var response = await client
        .get(Uri.parse('https://api.mocklets.com/p68289/screentime'));
    print(response.body);
    var jsonString = response.body;
    print("3");
    var newModel = modalFromMap(jsonString);

    return newModel;
  }
}
