import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  // final _firebaseMessaging = FirebaseMessaging.instance;

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  getToken() async {
    String? token = await messaging.getToken();
    print(token);
    return token;
  }
}
