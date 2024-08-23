import 'package:flutter_babe/pages/about/about_us_page.dart';
import 'package:flutter_babe/pages/auth/sign_in_page.dart';
import 'package:flutter_babe/pages/auth/sign_up_page.dart';
import 'package:flutter_babe/pages/contact/contact_page.dart';
import 'package:flutter_babe/pages/history_booked/detail/history_bookroom_detail.dart';
import 'package:flutter_babe/pages/history_booked/detail/history_booktable_detail.dart';
import 'package:flutter_babe/pages/history_booked/history_booked.dart';
import 'package:flutter_babe/pages/home/home_page.dart';
import 'package:flutter_babe/pages/home/menu_page.dart';
import 'package:flutter_babe/pages/language/languages_page.dart';
import 'package:flutter_babe/pages/news/news_detail/news_detail.dart';
import 'package:flutter_babe/pages/news/news_page.dart';
import 'package:flutter_babe/pages/notification/notification_page.dart';
import 'package:flutter_babe/pages/places/bookroom/book_room_page.dart';
import 'package:flutter_babe/pages/places/place_detail.dart';
import 'package:flutter_babe/pages/places/place_page.dart';
import 'package:flutter_babe/pages/places/roomDetail/room_detail_page.dart';
import 'package:flutter_babe/pages/profile/profile_page.dart';
import 'package:flutter_babe/pages/restaurant/book_table/book_table_page.dart';
import 'package:flutter_babe/pages/restaurant/dishes_detail/dish_detail_page.dart';
import 'package:flutter_babe/pages/restaurant/restaurant_detail.dart';
import 'package:flutter_babe/pages/restaurant/restaurant_page.dart';
import 'package:flutter_babe/pages/search/search_page.dart';
import 'package:flutter_babe/pages/splash/splash_page.dart';
import 'package:flutter_babe/pages/tour/tour_detail/tour_detail.dart';
import 'package:flutter_babe/pages/tour/tour_page.dart';
import 'package:flutter_babe/pages/tourist_attraction/tourist_attraction_page.dart';
import 'package:flutter_babe/pages/tourist_attraction/tourist_attraction_detail.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String menuPage = "/menu-page";
  static const String homePage = "/home-page";
  static const String language = '/language';
  static const String mapPage = "/map-page";
  static const String signInPage = "/signIn-page";
  static const String signUpPage = "/signUp-page";
  static const String notificationPage = "/notification-page";
  static const String aboutUsPage = "/aboutUs-page";
  static const String newsPage = "/news-page";
  static const String searchPage = "/search-page";
  static const String tourPage = "/tour-page";
  static const String contactPage = "/contact-page";
  static const String tourDetailPage = "/tourDetail-page";
  static const String newsDetailPage = "/newsDetail-page";
  static const String touristAttractionPage = "/touristAttraction-page";
  static const String touristAttractionDetailPage =
      "/touristAttractionDetail-page";
  static const String placeDetail = "/placeDatail-page";
  static const String restaurantDetail = "/restaurantDetail-page";
  static const String profile = "/profile-page";
  static const String roomDetail = "/roomDetail-page";
  static const String dishDetail = "/dishDetail-page";
  static const String bookRoom = "/bookRoom-page";
  static const String bookTable = "/bookTable-page";
  static const String history_book = "/historyBook-page";
  static const String detail_history_book_room = "/detailHistoryBookRoom-page";
  static const String detail_history_book_table =
      "/detailHistoryBookTable-page";
  static const String place_page = "/place-page";
  static const String restaurant_page = "/restaurant_page";

  static String getSplashPage() => '$splashPage';
  static String getMenuPage() => '$menuPage';
  static String getHomePage() => '$homePage';
  static String getSignInPage() => '$signInPage';
  static String getSignUpPage() => '$signUpPage';
  static String getNotificationPage() => '$notificationPage';
  static String getLanguageRoute(bool displayAppBar) =>
      '$language?display=$displayAppBar';
  static String getAboutUsPage() => '$aboutUsPage';
  static String getNewsPage() => '$newsPage';
  static String getSearchPage() => '$searchPage';
  static String getTourPage() => '$tourPage';
  static String getContactPage() => '$contactPage';
  static String getPlacePage() => '$place_page';
  static String getRestaurantPage() => '$restaurant_page';
  static String getTourDetailPage(int tourID, String pageID) =>
      '$tourDetailPage?tourID=$tourID&pageID=$pageID';
  static String getNewsDetailPage(int postID, String pageID) =>
      '$newsDetailPage?postID=$postID&pageID=$pageID';
  static String getTouristAttractionPage() => '$touristAttractionPage';
  static String getTouristAttractionDetailPage(
          int tourAttractionID, String pageID) =>
      '$touristAttractionDetailPage?tourAttractionID=$tourAttractionID&pageID=$pageID';
  static String getPlaceDetail(int placeID, String pageID) =>
      '$placeDetail?placeID=$placeID&pageID=$pageID';
  static String getRestaurantDetail(int restaurantID, String pageID) =>
      '$restaurantDetail?restaurantID=$restaurantID&pageID=$pageID';
  static String getProfile() => '$profile';
  static String getRoomDetail(int roomID, String pageID) =>
      '$roomDetail?roomID=$roomID&pageID=$pageID';
  static String getDishDetail(int dishID, String pageID) =>
      '$dishDetail?dishID=$dishID&pageID=$pageID';
  static String getBookRoomPage(int placeID, String pageID) =>
      '$bookRoom?placeID=$placeID&pageID=$pageID';
  static String getBookTablePage(int restaurantID, String pageID) =>
      '$bookTable?restaurantID=$restaurantID&pageID=$pageID';
  static String getHistoryBook() => '$history_book';
  static String getDetailHistoryBookRoom(int bookRoomID, String pageID) =>
      '$detail_history_book_room?bookRoomID=$bookRoomID&pageID=$pageID';
  static String getDetailHistoryBookTable(int bookTableID, String pageID) =>
      '$detail_history_book_table?bookTableID=$bookTableID&pageID=$pageID';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: menuPage, page: () => MenuPage()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: signInPage, page: () => SignInPage()),
    GetPage(name: signUpPage, page: () => SignUpPage()),
    GetPage(name: notificationPage, page: () => NotificationPage()),
    GetPage(name: aboutUsPage, page: () => AboutUsPage()),
    GetPage(name: newsPage, page: () => NewPage()),
    GetPage(name: newsPage, page: () => SearchPage()),
    GetPage(name: tourPage, page: () => TourPage()),
    GetPage(name: contactPage, page: () => ContactPage()),
    GetPage(name: profile, page: () => ProfilePage()),
    GetPage(name: history_book, page: () => HistoryBooked()),
    GetPage(name: place_page, page: () => PlacePage()),
    GetPage(name: restaurant_page, page: () => RestaurantPage()),
    GetPage(
        name: bookRoom,
        page: () {
          var placeID = Get.parameters['placeID'];
          var pageID = Get.parameters['pageID'];
          return BookRoomPage(placeID: int.parse(placeID!), pageID: pageID!);
        }),
    GetPage(
        name: detail_history_book_room,
        page: () {
          var bookRoomID = Get.parameters['bookRoomID'];
          var pageID = Get.parameters['pageID'];
          return HistoryBookRoomDetail(
              bookRoomID: int.parse(bookRoomID!), pageID: pageID!);
        }),
    GetPage(
        name: bookTable,
        page: () {
          var restaurantID = Get.parameters['restaurantID'];
          var pageID = Get.parameters['pageID'];
          return BookTablePage(
              restaurantID: int.parse(restaurantID!), pageID: pageID!);
        }),
    GetPage(
        name: detail_history_book_table,
        page: () {
          var bookTableID = Get.parameters['bookTableID'];
          var pageID = Get.parameters['pageID'];
          return HistoryBookTableDetail(
              bookTableId: int.parse(bookTableID!), pageID: pageID!);
        }),
    GetPage(
        name: roomDetail,
        page: () {
          var roomID = Get.parameters['roomID'];
          var pageID = Get.parameters['pageID'];
          return RoomDetailPage(roomID: int.parse(roomID!), pageID: pageID!);
        }),
    GetPage(
        name: dishDetail,
        page: () {
          var dishID = Get.parameters['dishID'];
          var pageID = Get.parameters['pageID'];
          return DishDetailPage(dishID: int.parse(dishID!), pageID: pageID!);
        }),
    GetPage(
        name: tourDetailPage,
        page: () {
          var tourID = Get.parameters['tourID'];
          var pageID = Get.parameters['pageID'];
          return TourDetail(tourID: int.parse(tourID!), pageID: pageID!);
        }),
    GetPage(
        name: newsDetailPage,
        page: () {
          var postID = Get.parameters['postID'];
          var pageID = Get.parameters['pageID'];
          return NewsDetail(postID: int.parse(postID!), pageID: pageID!);
        }),
    GetPage(name: touristAttractionPage, page: () => TouristAttractionPage()),
    GetPage(
        name: touristAttractionDetailPage,
        page: () {
          var tourAttractionID = Get.parameters['tourAttractionID'];
          var pageID = Get.parameters['pageID'];
          return TouristAttractionDetailPage(
            tourAttractionID: int.parse(tourAttractionID!),
            pageID: pageID!,
          );
        }),
    GetPage(
        name: restaurantDetail,
        page: () {
          var restaurantID = Get.parameters['restaurantID'];
          var pageID = Get.parameters['pageID'];
          return RestaurantDetail(
            restaurantID: int.parse(restaurantID!),
            pageID: pageID!,
          );
        }),
    GetPage(
        name: placeDetail,
        page: () {
          var placeID = Get.parameters['placeID'];
          var pageID = Get.parameters['pageID'];
          return PlaceDetail(
            placeID: int.parse(placeID!),
            pageID: pageID!,
          );
        }),
    GetPage(
        name: language,
        page: () {
          var display = Get.parameters['display'];
          return LanguagePage(
            appBarDisplay: bool.parse(display!),
          );
        })
  ];
}
