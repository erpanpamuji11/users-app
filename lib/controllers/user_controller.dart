import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/models/User.dart';
import 'package:users_app/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final int _limit = 10;
  int _page = 1;
  var hasMore = true.obs;
  var users = <User>[].obs;

  Future getUser() async {
    try {
      List<User> response = await _userRepository.fetchUsers(_page, _limit);
      if (response.length < _limit) {
        hasMore.value = false;
      }

      users.addAll(response);
      _page++;
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refreshData() async {
    _page = 1;
    hasMore.value = true;
    users.value = [];

    await getUser();
  }

  Future deleteUser(String id) async {
    try {
      var response = await _userRepository.deleteUsers(id);
      if (!response.isNull) {
        showDialog(
          context: Get.context!,
          builder: (context) => const SimpleDialog(
            title: Text("Delete Success"),
          ),
        );
      }

      debugPrint("data $response");
      await getUser();

    } catch (e) {
      debugPrint("$e $id");
    }
  }

  // Future deleteUser2(String id) async {
  //   try {
  //     var header = {'Content-Type' : "application/json"};
  //
  //     http.Response response = await http.delete(
  //         Uri.parse("$_baseUrl/$id"),
  //         headers: header
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var reslut
  //     }
  //
  //   } catch (e){
  //
  //   }

}