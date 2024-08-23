import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_room_controller.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/models/book_room_model.dart';
import 'package:flutter_babe/models/places_model.dart';
import 'package:flutter_babe/pages/places/bookroom/list_room.dart';
import 'package:flutter_babe/pages/places/bookroom/room_selected.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookRoomPage extends StatefulWidget {
  int placeID;
  String pageID;
  BookRoomPage({super.key, required this.placeID, required this.pageID});

  @override
  State<BookRoomPage> createState() => _BookRoomPageState();
}

class _BookRoomPageState extends State<BookRoomPage> {
  final PlacesController placesController = Get.find<PlacesController>();
  final BookRoomController bookRoomController = Get.find<BookRoomController>();
  //late UserController userController;

  TextEditingController adultsController = TextEditingController();
  TextEditingController childrenController = TextEditingController();

  Places? places;

  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();

  DateTime checkIn = DateTime.now();
  DateTime checkOut = DateTime.now().add(Duration(days: 1));

  @override
  void initState() {
    super.initState();
    // userController = Get.find<UserController>();
    // userController.getUserInfo();
    //bookRoomController = Get.find<BookRoomController>();
    adultsController.text = bookRoomController.adults.toString();
    childrenController.text = bookRoomController.children.toString();
    checkInController.text = DateFormat("yyyy-MM-dd").format(checkIn);
    checkOutController.text = DateFormat("yyyy-MM-dd").format(checkOut);

    placesController.getPlaceDetail(widget.placeID).then((result) {
      setState(() {
        places = result;
      });
    });
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("book_room".tr),
        centerTitle: true,
        backgroundColor: AppColors.colorAppBar,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //clear data in room selected list
            bookRoomController.clearRoomsSelected();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: places != null
          ? GetBuilder<BookRoomController>(builder: (controller) {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BigText(
                        text: places!.title!,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      SmallText(
                        text: "address".tr + ": " + places!.address!,
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
                            text: places!.phone != null
                                ? places!.phone.toString()
                                : 'updating'.tr,
                            size: Dimensions.font16,
                            color: Theme.of(context).disabledColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      ListRooms(
                          ownerID: places!.ownerId!, pageID: "bookRoomPage"),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      /** Room selected */
                      RoomSelected(),

                      //form information
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
                              //fullname
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
                                controller: checkInController,
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
                                      checkIn = pickedDate;
                                    });
                                    if (pickedDate.isBefore(DateTime.now())) {
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
                                        checkInController.text = formattedDate;
                                      });
                                    }
                                  }
                                },
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              //checkout
                              Text("check_out".tr),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              TextField(
                                controller: checkOutController,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.calendar_month)),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDateCheckOut =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2041),
                                  );
                                  if (pickedDateCheckOut != null) {
                                    setState(() {
                                      checkOut = pickedDateCheckOut;
                                    });
                                    if (checkOutController != null &&
                                        pickedDateCheckOut.isBefore(checkIn)) {
                                      _dialogBuilder(context, false);
                                    } else {
                                      String formattedDate =
                                          DateFormat("yyyy-MM-dd")
                                              .format(pickedDateCheckOut);
                                      setState(() {
                                        checkOutController.text = formattedDate;
                                      });
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
                                        controller.updateQuantityAdults(
                                            -1, context);
                                        setState(() {
                                          adultsController.text =
                                              controller.adults.toString();
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
                                          controller: adultsController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (adultsController
                                                      .text.isEmpty ||
                                                  adultsController.text ==
                                                      "0") {
                                                controller.setQuantityAdults(
                                                    0, context);
                                                // adultsController.text =
                                                //     controller.adults
                                                //         .toString();
                                              } else {
                                                controller.setQuantityAdults(
                                                    int.parse(
                                                        adultsController.text),
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
                                        controller.updateQuantityAdults(
                                            1, context);
                                        setState(() {
                                          adultsController.text =
                                              controller.adults.toString();
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
                                      text: "adults".tr,
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
                                        controller.updateQuantityChildren(
                                            -1, context);
                                        setState(() {
                                          childrenController.text =
                                              controller.children.toString();
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
                                          controller: childrenController,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              if (childrenController
                                                      .text.isEmpty ||
                                                  childrenController.text ==
                                                      "0") {
                                                controller.setQuantityChildren(
                                                    0, context);
                                                // childrenController.text =
                                                //     controller.children
                                                //         .toString();
                                              } else {
                                                controller.setQuantityChildren(
                                                    int.parse(childrenController
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
                                        controller.updateQuantityChildren(
                                            1, context);
                                        setState(() {
                                          childrenController.text =
                                              controller.children.toString();
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
                                      text: "children".tr,
                                      size: Dimensions.font16,
                                      color: Colors.black87,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              //button
                              Center(
                                child: ElevatedButton(
                                  child: Text('book_room'.tr),
                                  onPressed: () {
                                    _bookRoom();
                                    print("you have just clicked on Đặt phòng");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.colorButton,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 10),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      //list room of hotel
                      // RoomInBookRoom(owner_id: places!.ownerId!),
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

  void _bookRoom() {
    String name = fullNameController.text.trim();
    String phone = phoneController.text.trim();
    String checkIn = checkInController.text.trim();
    String checkOut = checkOutController.text.trim();
    String numberOfAdults = bookRoomController.adults.toString();
    String numberOfChildren = bookRoomController.children.toString();
    List<RoomsSelected> roomsSelectedList =
        bookRoomController.roomsSelectedList;

    if (name.isEmpty) {
      CustomSnackBar("enter_your_name".tr, title: "fullname".tr);
    } else if (phone.isEmpty) {
      CustomSnackBar("enter_your_phone".tr, title: "phone".tr);
    } else if (!phone.isPhoneNumber) {
      CustomSnackBar("enter_your_valid_phone".tr, title: "phone".tr);
    } else if (roomsSelectedList.isEmpty) {
      CustomSnackBar("at_least_a_room".tr, title: "room".tr);
    } else if (numberOfAdults.isEmpty || numberOfAdults == "0") {
      CustomSnackBar("adults_validate".tr, title: "adults".tr);
    } else {
      BookRoomModel bookRoomModel = BookRoomModel(
          name: name,
          phone: phone,
          checkin: checkIn,
          checkout: checkOut,
          adults: numberOfAdults,
          children: numberOfChildren,
          numberRoom: "1",
          roomsSelected: roomsSelectedList);
      print(bookRoomModel.toJson());
      bookRoomController.bookRoom(bookRoomModel).then((status) {
        if (status.isSuccess) {
          print("ok");
          CustomSnackBar("thanks_for_your_booking".tr,
              isError: false, title: "success".tr);
          bookRoomController.clearRoomsSelected();
          Get.offNamed(RouteHelper.getMenuPage());
        } else {
          CustomSnackBar(status.message!);
        }
      });
    }
  }
}
