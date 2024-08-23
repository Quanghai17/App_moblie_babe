import 'package:flutter_babe/data/repository/post_repo.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController implements GetxService {
  final PostRepo postRepo;
  SharedPreferences sharedPreferences;
  PostController({required this.postRepo, required this.sharedPreferences});
  List<Post> _postList = [];
  List<Post> get postList => _postList;

  List<Post> _postListFilter = [];
  List<Post> get postListFilter => _postListFilter;

  List<Post> _featurePostList = [];
  List<Post> get featurePostList => _featurePostList;

  // List<Post> _filterDayPostList = [];
  // List<Post> get filterdayPostList => _filterDayPostList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  Future<void> getAllPostList(int? paginate, int? page) async {
    _isLoading = true;
    if (paginate == null) {
      paginate = 8;
    }
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "";
    try {
      Response response = await postRepo.getAllPostInfor(
          locale: language, paginate: paginate, page: page);
      if (response.statusCode == 200) {
        _isLoaded = true;
        List<dynamic> dataList = response.body["results"];
        if (dataList.isEmpty) {
          _isLastPage = true;
        } else {
          if (page == 1) {
            _postList.clear();
            _isLastPage = false;
          }
          dataList.forEach((postData) {
            Post post = Post.fromJson(postData);
            _postList.add(post);
          });

          if (dataList.length < paginate) {
            _hasNextPage = false;
          } else {
            _hasNextPage = true;
          }
        }
        _isLoading = false;
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getAllPostList: $e");
    }
  }

  Future<void> getPostListByFilter(
      String filter, int? paginate, int? page) async {
    if (paginate == null) {
      paginate = 8;
    }
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await postRepo.getAllPostInfor(
          locale: language, filter: filter, paginate: paginate, page: page);
      if (response.statusCode == 200) {
        _isLoaded = true;
        List<dynamic> dataList = response.body["results"];
        if (dataList.isEmpty) {
          //_postListFilter.clear();
          _isLastPage = true;
        } else {
          if (page == 1) {
            _postListFilter.clear();
            _isLastPage = false;
          }
          dataList.forEach((postData) {
            Post post = Post.fromJson(postData);
            _postListFilter.add(post);
          });

          if (dataList.length < paginate) {
            _hasNextPage = false;
          } else {
            _hasNextPage = true;
          }
        }
        _isLoading = false;
        update();
      } else {
        // Handle the case when the response status code is not 200
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getPostListByFilter: $e");
    }
    _isLoading = false;
    update();
  }

  void clearFutureList() {
    _postListFilter.clear();
  }

  Future<void> getFeaturePostList() async {
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await postRepo.getAllPostInfor(locale: language, paginate: 16);
      if (response.statusCode == 200) {
        _featurePostList.clear();
        update();
        List<dynamic> dataList = response.body["results"];
        dataList.forEach((postData) async {
          Post post = Post.fromJson(postData);
          if (post.featured == 1) {
            _featurePostList.add(post);
          }
          //print("check data: " + _featurePostList.toString());
        });
        update();
      } else {}
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getFeaturePostList: $e");
    }
    _isLoading = false;
    update();
  }

  Future<Post?> getPostDetail(int postID) async {
    _isLoading = true;
    Post? post;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await postRepo.getPostDetail(postID: postID, language: language);
      if (response.statusCode == 200) {
        Map<String, dynamic> postDetail = response.body["results"];
        post = Post.fromJson(postDetail);
      } else {
        print("Error at postcontroller: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in get Post detail: $e");
    }
    _isLoading = false;
    update();
    return post;
  }
}
