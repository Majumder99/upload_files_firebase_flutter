import "package:http/http.dart" as http;

String baseUrl = "https://6405b385eed195a99f89ec63.mockapi.io/api/";

class FetchClient {
  var client = http.Client();
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    // var _headers = {
    //   "Authorization": "Bearer f34234234=",
    // };

    var response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //handle exception
    }
  }

  Future<dynamic> post(String Api) async {}
  Future<dynamic> put(String Api) async {}
  Future<dynamic> delet(String Api) async {}
}
