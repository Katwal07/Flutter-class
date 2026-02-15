import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();

    _initializeNotification();
    _requestPermission();
    _setupMessageHandler();
  }

  /// Setup how notification appears on Android or ios.
  /// Globally Initialize.
  /// Facebook -> Multiple notification -> Multiple Settings.
  void _initializeNotification() async {
    const androidSetting = AndroidInitializationSettings(
      "mipmap/ic_launcher.png",
    );
    const iosSetting = DarwinInitializationSettings();

    await _localNotificationsPlugin.initialize(
      settings: InitializationSettings(
        android: androidSetting,
        iOS: iosSetting,
      ),

      /// What happens when i tap notification.
      /// Get.to(home_screen);
      onDidReceiveNotificationResponse: (details) {
        print("Notification tapped");
      },
    );
  }

  /// Requesting a permission.
  void _requestPermission() async {
    await messaging.requestPermission(alert: true, badge: true, sound: true);
  }

  /// Message Handler.
  void _setupMessageHandler() {
    /// FirebaseMessage.onMessage -> Trigger , when a noti. arrives while the app is open.
    /// FirebaseMessage.onMessageOpenApp -> Triggers when the user taps the noti.
    ///
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      /// Target Screen-> Live Class.
      /// Live class ko noti-> Live class.
    });
  }

  /// Mutiple Notification
  /// -> Some sound
  /// -> Priority -> high , medium,
  /// Settings -> Notification -> Mutiple Notification Opition
  /// Snapchat -> Headsup notification

  void _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Channel",
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    /// Android Detais / IOS Details.
    /// Flutter Local Notification -> Single Object.

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotificationsPlugin.show(
      id: message.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: notificationDetails,
      payload: message.data.toString(),
    );
  }
}
