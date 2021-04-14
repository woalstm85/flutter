import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_instagram/models/firestore/user_model.dart';

class UserModelState extends ChangeNotifier{
  UserModel _userModel;
  StreamSubscription<UserModel> _currentStreamSub;
  UserModel get userModel=>_userModel;

  set userModel(UserModel userModel){
    _userModel = userModel;
    notifyListeners();
  }

  set currentStreamSub(StreamSubscription<UserModel> currentSteramSub) => _currentStreamSub = currentSteramSub;

  clear(){
    if(_currentStreamSub != null)
      _currentStreamSub.cancel();
    _currentStreamSub = null;
    _userModel = null;
  }
}