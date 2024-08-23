import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/models/book_table_model.dart';
import 'package:flutter_babe/models/restaurant_model.dart';
import 'package:flutter_babe/pages/restaurant/book_table/dish_selected.dart';
import 'package:flutter_babe/pages/restaurant/book_table/list_dishes.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookTablePage extends StatefulWidget {
  int restaurantID;
  String pageID;
  BookTablePage({super.key, required this.restaurantID, required this.pageID});

  @override
  State<BookTablePage> createState() => _BookTablePageState();
}

class _BookTablePageState extends State<BookTablePage> {
  final RestaurantController restaurantController =
      Get.find<RestaurantController>();
  final BookTableController bookTableController =
      Get.find<BookTableController>();

  Restaurant? restaurant;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController numberTableController = TextEditingController();
  TextEditingController numberOfPeopleController = TextEditingController();

  DateTime date = DateTime.now();
  TimeOfDay timeNow = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    dateController.text = DateFormat("yyyy-MM-dd").format(date);
    timeController.text =
        '${timeNow.hour.toString().padLeft(2, '0')}:${timeNow.minute.toString().padLeft(2, '0')}';

    numberOfPeopleController.text = bookTableController.people.toString();
    numberTableController.text = bookTableController.table.toString();

    restaurantController
        .getRestaurantDetail(widget.restaurantID)
        .then((result) {
      setState(() {
        restaurant = result;
      });
    });
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("book_table".tr),
        centerTitle: true,
        backgroundColor: AppColors.colorAppBar,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //clear data in room selected list
            bookTableController.clearDishesSelected();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: restaurant != null
          ? GetBuilder<BookTableController>(builder: (controller) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: restaurant!.title!,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      SmallText(
                        text: "address".tr + ": " + restaurant!.address!,
                        size: Dimensions.font16,
                        color: Theme.of(context).disabledColor,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: "phone".tr + ": ",
                            size: Dimensions.font16,
                            color: Theme.of(context).disabledColor,
                          ),
                          SmallText(
                            text: restaurant!.phone != null
                                ? restaurant!.phone.toString()
                                : 'updating'.tr,
                            size: Dimensions.font16,
                            color: Theme.of(context).disabledColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      ListDishes(
                          ownerID: restaurant!.ownerId!,
                          pageID: "bookTablePage"),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      DishSelected(),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        //height: 450,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 211, 201, 201),
                              offset: const Offset(
                                1.5,
                                1.5,
                              ),
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("fullname".tr),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            TextField(
                              keyboardType: TextInputType.name,
                              controller: fullNameController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    //borderRadius: BorderRadius.circular(5),
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            //phone
                            Text("phone".tr),
                            SizedBox(
                              height: 5,
                            ),
                            TextField(
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            //checkin
                            Text("check_in".tr),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            TextField(
                              controller: dateController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_month)),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2041),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    date = pickedDate;
                                  });
                                  if (pickedDate.isBefore(DateTime.now()
                                      .subtract(Duration(days: 1)))) {
                                    _dialogBuilder(context, true);
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //       content: Text(
                                    //           "Ngày nhận không thể trước ngày hôm nay!")),
                                    // );
                                  } else {
                                    print(pickedDate.toString());
                                    String formattedDate =
                                        DateFormat("yyyy-MM-dd")
                                            .format(pickedDate);
                                    print(formattedDate);
                                    setState(() {
                                      //checkIn = pickedDate;
                                      dateController.text = formattedDate;
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            //time
                            Text("time".tr),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            TextField(
                              controller: timeController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.timer),
                              ),
                              readOnly: true,
                              onTap: () async {
                                TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                );

                                if (time != null) {
                                  // Get the current time
                                  final now = DateTime.now();
                                  final currentTime =
                                      TimeOfDay.fromDateTime(now);
                                  print(
                                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}');
                                  // Convert both times to DateTime for comparison
                                  final currentDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    currentTime.hour,
                                    currentTime.minute,
                                  );

                                  final selectedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    time.hour,
                                    time.minute,
                                  );

                                  // Check if the selected time after the current time
                                  if (selectedDateTime
                                      .isAfter(currentDateTime)) {
                                    setState(() {
                                      timeController.text =
                                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                    });
                                  } else {
                                    // Show an error message if the selected time is not valid
                                    _dialogBuilder(context, false);
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            //number
                            Text("select_number".tr),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            //adults
                            Container(
                              padding: EdgeInsets.only(),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.updateQuantityTable(
                                          -1, context);
                                      setState(() {
                                        numberTableController.text =
                                            controller.table.toString();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Icon(
                                        Icons.remove,
                                        size: Dimensions.iconSize24,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10 * 2,
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10 * 10,
                                    height: Dimensions.height10 * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: numberTableController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            if (numberTableController
                                                    .text.isEmpty ||
                                                numberTableController.text ==
                                                    "0") {
                                              // numberTableController.text =
                                              //     controller.table.toString();
                                            } else {
                                              controller.setQuantityTable(
                                                  int.parse(
                                                      numberTableController
                                                          .text),
                                                  context);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10 * 2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.updateQuantityTable(
                                          1, context);
                                      setState(() {
                                        numberTableController.text =
                                            controller.table.toString();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Icon(
                                        Icons.add,
                                        size: Dimensions.iconSize24,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20,
                                  ),
                                  SmallText(
                                    text: "table".tr,
                                    size: Dimensions.font16,
                                    color: Colors.black87,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.font20,
                            ),
                            //children
                            Container(
                              padding: EdgeInsets.only(),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.updateQuantityPeople(
                                          -1, context);
                                      setState(() {
                                        numberOfPeopleController.text =
                                            controller.people.toString();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Icon(
                                        Icons.remove,
                                        size: Dimensions.iconSize24,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10 * 2,
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10 * 10,
                                    height: Dimensions.height10 * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: numberOfPeopleController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            if (numberOfPeopleController
                                                    .text.isEmpty ||
                                                numberOfPeopleController.text ==
                                                    "0") {
                                              controller.setQuantityPeople(
                                                  0, context);
                                            } else {
                                              controller.updateQuantityPeople(
                                                  int.parse(
                                                      numberOfPeopleController
                                                          .text),
                                                  context);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10 * 2,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.updateQuantityPeople(
                                          1, context);
                                      setState(() {
                                        numberOfPeopleController.text =
                                            controller.people.toString();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Icon(
                                        Icons.add,
                                        size: Dimensions.iconSize24,
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width20,
                                  ),
                                  SmallText(
                                    text: "people".tr,
                                    size: Dimensions.font16,
                                    color: Colors.black87,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Center(
                              child: ElevatedButton(
                                child: Text('book_table'.tr),
                                onPressed: () {
                                  _bookTable();
                                  //   print("you have just clicked on Đặt phòng");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber[700],
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //FoodInBookTable(owner_id: restaurant!.ownerId!)
                    ],
                  ),
                ),
              );
            })
          : CustomLoader(),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, bool isCheckIn) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('select_datetime_valid'.tr),
          content: isCheckIn
              ? Text(
                  'checkin_validate'.tr,
                )
              : Text('checkout_validate'.tr),
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

  void _bookTable() {
    String name = fullNameController.text.trim();
    String phone = phoneController.text.trim();
    String date = dateController.text.trim();
    String time = timeController.text.trim();
    String numberOfTable = numberTableController.text.trim();
    String numberOfPeople = numberOfPeopleController.text.trim();
    List<DishesSelected> dishesSelectedList =
        bookTableController.dishesSelectedList;

    if (name.isEmpty) {
      CustomSnackBar("enter_your_name".tr, title: "fullname".tr);
    } else if (phone.isEmpty) {
      CustomSnackBar("enter_your_phone".tr, title: "phone".tr);
    } else if (!phone.isPhoneNumber) {
      CustomSnackBar("enter_your_valid_phone".tr, title: "phone".tr);
    } else if (dishesSelectedList.isEmpty) {
      CustomSnackBar("at_least_a_dish".tr, title: "dish".tr);
    } else if (numberOfTable.isEmpty || numberOfTable == "0") {
      CustomSnackBar("number_of_table_greater_0".tr, title: "table".tr);
    } else if (numberOfPeople.isEmpty || numberOfPeople == "0") {
      CustomSnackBar("number_of_people_greater_0".tr, title: "people".tr);
    } else {
      BookTableModel bookTableModel = BookTableModel(
          name: name,
          phone: phone,
          date: date,
          time: time,
          number_table: numberOfTable,
          people: numberOfPeople,
          dishesSelected: dishesSelectedList);
      print(bookTableModel.toJson());
      bookTableController.bookTable(bookTableModel).then((status) {
        if (status.isSuccess) {
          print("ok");
          CustomSnackBar("thanks_for_your_booking".tr,
              isError: false, title: "success".tr);
          bookTableController.clearDishesSelected();
          Get.offNamed(RouteHelper.getMenuPage());
        } else {
          CustomSnackBar(status.message);
        }
      });
    }
  }
}
