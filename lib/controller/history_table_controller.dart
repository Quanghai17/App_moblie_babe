import 'package:flutter_babe/data/repository/history_table_repo.dart';
import 'package:flutter_babe/models/history_book_table_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryBookTableController extends GetxController implements GetxService {
  final HistoryBookTableRepo historyBookTableRepo;
  SharedPreferences sharedPreferences;

  HistoryBookTableController(
      {required this.historyBookTableRepo, required this.sharedPreferences});

  List<HistoryBookTableModel> _historyBookTableList = [];
  List<HistoryBookTableModel> get historyBookTableList => _historyBookTableList;

  List<DishesInHistoryBookTableModel> _dishesListInBookedList = [];
  List<DishesInHistoryBookTableModel> get dishesListInBookedList =>
      _dishesListInBookedList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HistoryBookTableModel? _historyBookTable;
  HistoryBookTableModel? get historyBookTable => _historyBookTable;

  Future<void> getDataHistoryTable() async {
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
    try {
      Response response =
          await historyBookTableRepo.getHistoryBookTable(locale: language);
      if (response.statusCode == 200) {
        _historyBookTableList.clear();
        List<dynamic> data = response.body["results"];
        var dataReversed = data.reversed;
        dataReversed.forEach((element) {
          HistoryBookTableModel historyBookTable =
              HistoryBookTableModel.fromJson(element);
          _historyBookTableList.add(historyBookTable);
        });
        _isLoading = false;
        update();
      }
      //print(_historyBookTableList[0].dishes!.map((e) => print(e.title)));
    } catch (e) {
      print("fail when system is getting data at history table controller: $e");
    }
  }

  Future<HistoryBookTableModel?> getDetailHistoryBookTable(int id) async {
    HistoryBookTableModel? historyBookTableModel;
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
    try {
      Response response =
          await historyBookTableRepo.getDetailHistoryBookTableInRepo(
              book_table_id: id, language: language);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.body['results'];

        historyBookTableModel = HistoryBookTableModel.fromJson(data);

        List<dynamic> dishesData = data['dishes'];
        _dishesListInBookedList.clear();

        dishesData.forEach((dishData) {
          DishesInHistoryBookTableModel dishesInHistoryBookTableModel =
              DishesInHistoryBookTableModel.fromJson(dishData);
          _dishesListInBookedList.add(dishesInHistoryBookTableModel);
        });

        _isLoading = false;
        update();
      }
    } catch (e) {
      print("fail when system is getting data at history table controller: $e");
    }
    return historyBookTableModel;
  }
}
