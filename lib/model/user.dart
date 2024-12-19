import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String? _userId;
  String? _email;

  String? get userId => _userId;
  String? get email => _email;

  void setUserData(String userId, String email) {
    _userId = userId;
    _email = email;
    notifyListeners();
  }
}
