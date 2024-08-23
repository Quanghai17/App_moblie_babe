class BookTableModel {
  String? name;
  String? phone;
  String? date;
  String? time;
  String? people;
  String? number_table;
  List<DishesSelected>? dishesSelected;

  BookTableModel({
    this.name,
    this.phone,
    this.date,
    this.time,
    this.people,
    this.number_table,
    this.dishesSelected,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['date'] = this.date;
    data['time'] = this.time;
    data['people'] = this.people;
    data['number_table'] = this.number_table;
    if (this.dishesSelected != null) {
      data['dished'] =
          this.dishesSelected!.map((v) => v.toJson()).toList().toString();
    }
    return data;
  }
}

class DishesSelected {
  int? id;
  String? nameDish;
  String? quantity;
  String? price;

  DishesSelected({this.id, this.nameDish, this.quantity, this.price});

  DishesSelected.fromJson(Map<String, dynamic> json) {
    nameDish = json['name'];
    quantity = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['\"name\"'] = '\"$nameDish\"';
    data['\"price\"'] = '\"$price\"';
    data['\"quantity\"'] = '\"$quantity\"';
    //data['\"number\"'] = this.number;
    return data;
  }
}
