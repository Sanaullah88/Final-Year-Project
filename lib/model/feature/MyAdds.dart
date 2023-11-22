class AllAds {
  String? msg;
  List<Data>? data;

  AllAds({this.msg, this.data});

  AllAds.fromJson(Map<String, dynamic> json) {
    msg = json['Msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? category;
  String? title;
  String? quantity;
  String? price;
  String? description;
  int? userid;
  String? status;
  String? date;
  Null? location;
  List<String>? image;

  Data(
      {this.id,
      this.category,
      this.title,
      this.quantity,
      this.price,
      this.description,
      this.userid,
      this.status,
      this.date,
      this.location,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    quantity = json['quantity'];
    price = json['price'];
    description = json['description'];
    userid = json['userid'];
    status = json['status'];
    date = json['date'];
    location = json['location'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['description'] = this.description;
    data['userid'] = this.userid;
    data['status'] = this.status;
    data['date'] = this.date;
    data['location'] = this.location;
    data['image'] = this.image;
    return data;
  }
}
