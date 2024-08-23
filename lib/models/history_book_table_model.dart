class HistoryBookTableModel {
  int? id;
  String? name;
  int? phone;
  String? date;
  String? time;
  int? people;
  int? numberTable;
  String? createdAt;
  String? updatedAt;
  int? customerId;
  String? status;
  int? ownerId;
  String? nameRestaurant;
  List<DishesInHistoryBookTableModel>? dishes;

  HistoryBookTableModel(
      {this.id,
      this.name,
      this.phone,
      this.date,
      this.time,
      this.people,
      this.numberTable,
      this.createdAt,
      this.updatedAt,
      this.customerId,
      this.status,
      this.ownerId,
      this.nameRestaurant,
      this.dishes});

  HistoryBookTableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    date = json['date'];
    time = json['time'];
    people = json['people'];
    numberTable = json['number_table'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    status = json['status'];
    ownerId = json['owner_id'];
    nameRestaurant = json['name_restaurant'];
    if (json['dishes'] != null) {
      dishes = <DishesInHistoryBookTableModel>[];
      json['dishes'].forEach((v) {
        dishes!.add(new DishesInHistoryBookTableModel.fromJson(v));
      });
    }
  }
}

class DishesInHistoryBookTableModel {
  int? id;
  String? dish;
  int? price;
  int? quantity;
  String? total;
  String? createdAt;
  String? updatedAt;
  int? bookTableId;

  DishesInHistoryBookTableModel(
      {this.id,
      this.dish,
      this.price,
      this.quantity,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.bookTableId});

  DishesInHistoryBookTableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dish = json['dish'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bookTableId = json['book_table_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dish'] = this.dish;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['book_table_id'] = this.bookTableId;
    return data;
  }
}
