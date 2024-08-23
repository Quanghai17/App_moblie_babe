class HistoryBookRoomModel {
  int? id;
  String? name;
  int? phone;
  String? checkin;
  String? checkout;
  int? adults;
  int? children;
  int? numberRoom;
  String? createdAt;
  String? updatedAt;
  int? customerId;
  String? status;
  int? ownerId;
  String? namePlace;
  int? numberDays;
  String? discount;
  List<RoomsInHistoryBook>? rooms;

  HistoryBookRoomModel(
      {this.id,
      this.name,
      this.phone,
      this.checkin,
      this.checkout,
      this.adults,
      this.children,
      this.numberRoom,
      this.createdAt,
      this.updatedAt,
      this.customerId,
      this.status,
      this.ownerId,
      this.namePlace,
      this.numberDays,
      this.discount,
      this.rooms});

  HistoryBookRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    adults = json['adults'];
    children = json['children'];
    numberRoom = json['number_room'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    status = json['status'];
    ownerId = json['owner_id'];
    namePlace = json['name_place'];
    numberDays = json['number_days'];
    discount = json['discount'];
    if (json['rooms'] != null) {
      rooms = <RoomsInHistoryBook>[];
      json['rooms'].forEach((v) {
        rooms!.add(new RoomsInHistoryBook.fromJson(v));
      });
    }
  }
}

class RoomsInHistoryBook {
  int? id;
  String? room;
  int? price;
  int? quantity;
  int? total;
  int? bookRoomId;
  String? createdAt;
  String? updatedAt;

  RoomsInHistoryBook(
      {this.id,
      this.room,
      this.price,
      this.quantity,
      this.total,
      this.bookRoomId,
      this.createdAt,
      this.updatedAt});

  RoomsInHistoryBook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    room = json['room'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    bookRoomId = json['book_room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room'] = this.room;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['book_room_id'] = this.bookRoomId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
