import 'package:flutter/material.dart';
import 'package:flutter_babe/pages/history_booked/widget/history_bookroom.dart';
import 'package:flutter_babe/pages/history_booked/widget/history_booktable.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:get/get.dart';

class HistoryBooked extends StatefulWidget {
  const HistoryBooked({Key? key}) : super(key: key);

  @override
  State<HistoryBooked> createState() => _HistoryBookedState();
}

class _HistoryBookedState extends State<HistoryBooked>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Load initial data
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("booking_history".tr),
        centerTitle: true,
        backgroundColor: AppColors.colorAppBar,
      ),
      body: Container(
        child: Column(
          children: [
            TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: _tabController.indexIsChanging
                      ? Colors.black
                      : Colors.blue,
                ),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.black),
              tabs: [
                Tab(text: 'room_booking_history'.tr),
                Tab(text: 'table_booking_history'.tr),
              ],
              controller: _tabController,
            ),
            SizedBox(height: Dimensions.height20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        HistoryBookRoomWidget(),
                        HistoryBookTableWidget(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
