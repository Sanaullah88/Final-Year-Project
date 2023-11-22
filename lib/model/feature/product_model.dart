import 'package:fyp/config/constant.dart';

class ProductModel {
  late int id;
  late String name;
  late double price;
  late String image;

  late int sale;
  late String location;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.sale,
      required this.location});
}

List<ProductModel> productData = [
  ProductModel(
      id: 1,
      name: 'Metal',
      price: 200,
      image: 'https://glescrap.com/wp-content/uploads/2022/08/Scrap-metal.jpg',
      sale: 310,
      location: 'i14 islamabad'),
  ProductModel(
      id: 2,
      name: 'E-waste',
      price: 2212,
      image: GLOBAL_URL + '/apps/ecommerce/product/43.jpg',
      sale: 3700,
      location: 'Rawalpindi'),
  ProductModel(
      id: 3,
      name: 'Palastic',
      price: 1643,
      image: GLOBAL_URL + '/apps/ecommerce/product/44.jpg',
      sale: 3,
      location: 'g12 islamabad'),
  ProductModel(
      id: 4,
      name: 'Fabrics',
      price: 120,
      image: GLOBAL_URL + '/apps/ecommerce/product/19.jpg',
      sale: 6,
      location: 'f6 islamabad'),
  ProductModel(
      id: 5,
      name: 'Glass',
      price: 62,
      image: GLOBAL_URL + '/apps/ecommerce/product/46.jpg',
      sale: 69,
      location: '6th road'),
  ProductModel(
      id: 6,
      name: 'Papers',
      price: 751,
      image: GLOBAL_URL + '/apps/ecommerce/product/30.jpg',
      sale: 17,
      location: 'chakri road rawalpindi'),
  ProductModel(
      id: 7,
      name: 'Garmin Instinct Tactical - Black',
      price: 290,
      image: GLOBAL_URL + '/apps/ecommerce/product/47.jpg',
      sale: 23,
      location: 'faiz abad'),
];
