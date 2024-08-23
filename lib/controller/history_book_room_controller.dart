import 'package:flutter_babe/data/repository/history_book_room_repo.dart';
import 'package:flutter_babe/models/history_book_room_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryBookRoomController extends GetxController implements GetxService {
  final HistoryBookRoomRepo historyBookRoomRepo;
  SharedPreferences sharedPreferences;

  HistoryBookRoomController(
      {required this.historyBookRoomRepo, required this.sharedPreferences});

  List<HistoryBookRoomModel> _historyBookRoomList = [];
  List<HistoryBookRoomModel> get historyBookRoomList => _historyBookRoomList;

  List<RoomsInHistoryBook> _roomsListInBookedList = [];
  List<RoomsInHistoryBook> get roomsListInBookedList => _roomsListInBookedList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HistoryBookRoomModel? _historyBookRoomModel;
  HistoryBookRoomModel? get historyBookRoomModel => _historyBookRoomModel;

  Future<void> getDataHistoryBookRoom() async {
    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
    try {
      Response response =
          await historyBookRoomRepo.getHistoryBookRoom(locale: language);
      if (response.statusCode == 200) {
        _historyBookRoomList.clear();
        List<dynamic> data = response.body["results"];
        var dataReversed = data.reversed;
        dataReversed.forEach((element) {
          HistoryBookRoomModel historyBookRoomModel =
              HistoryBookRoomModel.fromJson(element);
          _historyBookRoomList.add(historyBookRoomModel);
        });

        _isLoading = false;
        update();
      }
      //print(_historyBookTableList[0].dishes!.map((e) => print(e.title)));
    } catch (e) {
      print("fail when system is getting data at history table controller: $e");
    }
  }

  Future<HistoryBookRoomModel?> getDetailHistoryBookTable(int id) async {
    HistoryBookRoomModel? historyBookRoomModel;

    _isLoading = true;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
    try {
      Response response = await historyBookRoomRepo.getDetailHistoryBookRoom(
          book_room_id: id, language: language);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.body["results"];
        historyBookRoomModel = HistoryBookRoomModel.fromJson(data);

        // Handle rooms data
        List<dynamic> roomsData = data['rooms'];
        _roomsListInBookedList.clear();

        roomsData.forEach((roomData) {
          RoomsInHistoryBook roomsInHistoryBook =
              RoomsInHistoryBook.fromJson(roomData);
          _roomsListInBookedList.add(roomsInHistoryBook);
        });

        _isLoading = false;
        update();
      }
    } catch (e) {
      print(
          "fail when system is getting data detail at history table controller: $e");
    }
    return historyBookRoomModel;
  }
}
