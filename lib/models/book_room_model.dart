class BookRoomModel {
  String? name;
  String? phone;
  String? checkin;
  String? checkout;
  String? adults;
  String? children;
  List<RoomsSelected>? roomsSelected;
  String? numberRoom;

  BookRoomModel({
    this.name,
    this.phone,
    this.checkin,
    this.checkout,
    this.adults,
    this.children,
    this.roomsSelected,
    this.numberRoom,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['adults'] = this.adults;
    data['children'] = this.children;
    data['number_room'] = this.numberRoom;
    if (this.roomsSelected != null) {
      data['rooms'] =
          this.roomsSelected!.map((v) => v.toJson()).toList().toString();
    }
    return data;
  }
}

class RoomsSelected {
  int? id;
  String? name;
  String? price;
  String? quantity;

  RoomsSelected({this.id, this.name, this.price, this.quantity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\"name\"'] = '\"$name\"';
    data['\"price\"'] = '\"$price\"';
    data['\"quantity\"'] = '\"$quantity\"';
    return data;
  }
}
