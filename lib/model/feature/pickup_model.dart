import 'package:fyp/config/constant.dart';

class PickupModel {
  late int id;
  late String name;
  late double price;
  late String image;
  late double rating;
  late int review;
  late int sale;
  late String location;

  PickupModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.rating,
      required this.review,
      required this.sale,
      required this.location});
}

List<PickupModel> PickupData = [
  PickupModel(
      id: 1,
      name: 'New Material',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  PickupModel(
      id: 2,
      name: 'E-waste',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  PickupModel(
      id: 2,
      name: 'Palastic',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  PickupModel(
      id: 2,
      name: 'Fabrics',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  PickupModel(
      id: 2,
      name: 'Glass',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  PickupModel(
      id: 2,
      name: 'Papers',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
];
