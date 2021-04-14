import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/constants/firestore_keys.dart';
import 'package:flutter_instagram/models/firestore/user_model.dart';
import 'package:flutter_instagram/repo/helper/transformers.dart';

class UserNetworkRepository with Transformers {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    // 유저 로그인 시 생성여부 확인 후 생성.

    final DocumentReference userRef =
        Firestore.instance.collection(COLLECTION_USERS).document(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.setData(UserModel.getMapForCreateUser(email));
    }
  }
  
  Stream<UserModel>getUserModelStream(String userKey){
    return Firestore.instance
        .collection(COLLECTION_USERS)
        .document(userKey)
        .snapshots().transform(toUser);
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();

/**
    class UserNetworkRepository{
    Future<void>sendData(){
    return Firestore.instance.collection('Users').document('123123123').setData(
    {'email': 'testing@gamil.com', 'username': 'myUserName'});
    }

    void getData(){
    Firestore.instance.collection('Users').document('123123123').get().then((docSnapshot)=> print(docSnapshot.data));

    }
    }
 */
