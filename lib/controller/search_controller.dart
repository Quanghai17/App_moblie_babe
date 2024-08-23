import 'package:flutter_babe/data/repository/search_repo.dart';
import 'package:flutter_babe/models/places_model.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultController extends GetxController {
  final SearchResultRepo searchResutlRepo;
  final SharedPreferences sharedPreferences;

  SearchResultController({
    required this.searchResutlRepo,
    required this.sharedPreferences,
  });

  List<Tour> _tours = [];
  List<Tour> get tours => _tours;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  List<Places> _places = [];
  List<Places> get places => _places;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _type;
  String? get type => _type;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  Future<void> getResultSearch(
      String type, String keyword, int paginate, int page) async {
    try {
      _isLoading = true;
      update();

      String language =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
      _type = type;

      Response response = await searchResutlRepo.search(
        locale: language,
        type: type,
        keyword: keyword,
        page: page,
        paginate: paginate,
      );

      if (response.statusCode == 200) {
        _isLoaded = true;
        List<dynamic> dataList = response.body['results'];

        if (page == 1) {
          _clearLists(); // Clear lists only on first page
        }

        if (dataList.isEmpty) {
          _isLastPage = true;
        } else {
          if (type == 'tours') {
            _tours.addAll(dataList.map((e) => Tour.fromJson(e)).toList());
          } else if (type == 'news') {
            _posts.addAll(dataList.map((e) => Post.fromJson(e)).toList());
          } else if (type == 'places') {
            _places.addAll(dataList.map((e) => Places.fromJson(e)).toList());
          }

          if (dataList.length < paginate) {
            _isLastPage = true;
          } else {
            _hasNextPage = true;
          }
        }
      }
    } catch (e) {
      print("Error in getResultSearch: $e");
    } finally {
      _isLoading = false;
      update();
    }
  }

  void _clearLists() {
    _tours.clear();
    _posts.clear();
    _places.clear();
    _isLastPage = false;
    _hasNextPage = false;
  }
}
