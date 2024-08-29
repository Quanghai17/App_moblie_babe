// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_babe/data/repository/notification_repo.dart';
import 'package:flutter_babe/models/notification_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationsRepo notificationsRepo;
  final SharedPreferences sharedPreferences;

  NotificationController({
    required this.notificationsRepo,
    required this.sharedPreferences,
  });

  // Danh sách thông báo
  List<Notifications> _notificationList = [];
  List<Notifications> get notificationList => _notificationList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  @override
  void onInit() {
    super.onInit();
    getAllNotifications(null, 1); // Load dữ liệu ban đầu
  }

  // Method để lấy danh sách thông báo
  Future<void> getAllNotifications(int? limit, int? page) async {
    if (limit == null) {
      limit = 10; // Số lượng thông báo mỗi trang mặc định
    }
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await notificationsRepo.getAllNotifications(
        locale: language,
        page: page,
        limit: limit,
      );
      if (response.statusCode == 200) {
        List<dynamic> dataList = response.body["results"];
        if (dataList.isEmpty) {
          _isLastPage = true;
          update();
        } else {
          if (page == 1) {
            _notificationList.clear(); // Xóa danh sách nếu là trang đầu tiên
            _isLastPage = false;
          }
          dataList.forEach((notificationData) {
            Notifications notification =
                Notifications.fromJson(notificationData);
            _notificationList.add(notification);
          });

          if (dataList.length < limit) {
            _isLastPage = true;
          } else {
            _hasNextPage = true;
          }
          _isLoaded = true;
          update();
        }
      } else {
        // Xử lý khi phản hồi không phải là 200 OK
        print(
            "Failed to load notifications, status code: ${response.statusCode}");
      }
    } catch (e) {
      // Xử lý lỗi hoặc ngoại lệ
      print("Error in getAllNotifications: $e");
    }
  }
}
