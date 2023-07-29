import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:users_app/models/User.dart';

class UserRepository extends GetConnect {
  final String _baseUrl = 'https://64c12fdbfa35860baea0300e.mockapi.io/api/v1/';

  Future<List<User>> fetchUsers(int page, int limit) async {
    var header = {'Content-Type' : "application/json"};
    final response = await get("${_baseUrl}users?page=$page&limit=$limit");

    final data = response.body();
    return List<User>.from(data.map((e) => User.fromJson(e)));
  }

  Future<User> deleteUsers(String id) async {
    final response = await delete("${_baseUrl}users/$id");
    final data = response.body;
    debugPrint(data);
    return User.fromJson(data);
  }

}