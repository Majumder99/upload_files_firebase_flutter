import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import '../models/post_mode.dart';

class PostServices {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var res = await client.get(uri);
    if (res.statusCode == 200) {
      var json = res.body;
      return postFromJson(json);
    }
  }
}
