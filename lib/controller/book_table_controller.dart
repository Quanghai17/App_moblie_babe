import 'package:flutter/material.dart';
import 'package:flutter_babe/data/repository/book_table_repo.dart';
import 'package:flutter_babe/models/book_room_model.dart';
import 'package:flutter_babe/models/book_table_model.dart';
import 'package:flutter_babe/models/response_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:get/get.dart';

class BookTableController extends GetxController implements GetxService {
  final BookTableRepo bookTableRepo;

  BookTableController({required this.bookTableRepo});

  int _people = 6;
  int _table = 1;

  int get people => _people;
  int get table => _table;

  BookTableModel? _bookTableModel;
  BookTableModel? get bookTableModel => _bookTableModel;

  List<DishesSelected> _dishesSelectedList = [];
  List<DishesSelected> get dishesSelectedList => _dishesSelectedList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> bookTable(BookTableModel bookTableModel) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    try {
      Response response = await bookTableRepo.bookTableInRepo(bookTableModel);
      print("Check status code at book room controller " +
          response.body.toString());
      if (response.statusCode == 200) {
        print("success!");
        print(response.body);
        responseModel = ResponseModel(true, response.body["message"]);
      } else {
        responseModel = ResponseModel(false, response.body["message"]);
      }

      _isLoading = false;
      update();
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      _isLoading = false;
      Get.offNamed(RouteHelper.getSignInPage());
    }

    return responseModel;
  }

  void clearDishesSelected() {
    _dishesSelectedList.clear();
    update();
  }

  DishesSelected? getDishInSelectedbyID(int id) {
    for (DishesSelected dishes in _dishesSelectedList) {
      if (dishes.id == id) {
        return dishes;
      }
    }
    return null;
  }

  void addDishToSelection(int id, String name, String price, String quantity) {
    bool isDishExist = _dishesSelectedList.any((dish) => dish.id == id);
    print(isDishExist);
    if (!isDishExist) {
      _dishesSelectedList.add(DishesSelected(
          id: id, nameDish: name, price: price, quantity: quantity));
    }
    update();
  }

  void removeDishesFromSelection(int id) {
    _dishesSelectedList.removeWhere((dish) => dish.id == id);
    update();
  }

  void updateQuantityDishes(int id, String name, String price, String number) {
    for (int i = 0; i < _dishesSelectedList.length; i++) {
      if (_dishesSelectedList[i].id == id) {
        _dishesSelectedList[i] = DishesSelected(
            id: id, nameDish: name, price: price, quantity: number.toString());
        break;
      }
    }
    update();
  }

  void updateQuantityPeople(int number, BuildContext context) {
    if (_people + number < 1) {
      _showAlertDialog(context, "warning_content_number_people".tr);
    } else {
      _people += number;
      update();
    }
  }

  void updateQuantityTable(int number, BuildContext context) {
    if (_table + number < 1) {
      _showAlertDialog(context, "warning_content_number_table".tr);
    } else {
      _table += number;
      update();
    }
  }

  void setQuantityPeople(int quantity, BuildContext context) {
    if (quantity <= 0) {
      _showAlertDialog(context, "number_of_people_greater_0".tr);
      _people = 0;
    } else {
      _people = quantity;
      update();
    }
  }

  void setQuantityTable(int quantity, BuildContext context) {
    if (quantity <= 0) {
      _showAlertDialog(context, "number_of_table_greater_0".tr);
      _table = 0;
    } else {
      _table = quantity;
      update();
    }
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('warning'.tr)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
