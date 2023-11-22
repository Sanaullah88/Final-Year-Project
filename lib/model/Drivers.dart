class Driver {
  List<Drivers>? drivers;

  Driver({this.drivers});

  Driver.fromJson(Map<String, dynamic> json) {
    if (json['drivers'] != null) {
      drivers = <Drivers>[];
      json['drivers'].forEach((v) {
        drivers!.add(new Drivers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.drivers != null) {
      data['drivers'] = this.drivers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drivers {
  String? name;
  String? phoneNumber;
  String? address;
  String? carNumber;
  String? driverImage;
  String? carImage;
  String? type;
  int? price;

  Drivers({
    this.name,
    this.phoneNumber,
    this.address,
    this.carNumber,
    this.driverImage,
    this.carImage,
    this.type,
    this.price,
  });

  Drivers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    carNumber = json['car_number'];
    driverImage = json['driver_image'];
    carImage = json['car_image'];
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['car_number'] = this.carNumber;
    data['driver_image'] = this.driverImage;
    data['car_image'] = this.carImage;
    data['type'] = this.type;
    data['price'] = this.price;

    return data;
  }
}
