import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> initNotifications() async {
    // Yêu cầu quyền thông báo
    await requestNotificationPermission();

    // Đăng ký vào topic 'global'
    try {
      await _firebaseMessaging.subscribeToTopic('global');
      print("Subscribed to topic 'global'");
    } catch (e) {
      print("Failed to subscribe to topic: $e");
    }

    // Lắng nghe thông báo khi ứng dụng đang chạy ở foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Xử lý thông báo khi ứng dụng ở background hoặc khi ứng dụng đã bị tắt
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }
}
