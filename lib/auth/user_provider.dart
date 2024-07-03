import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;
  updateUser(UserModel userModel) {
  currentUser = userModel;
    notifyListeners();
  }
}
