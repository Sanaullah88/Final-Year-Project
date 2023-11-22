import 'package:fyp/config/constant.dart';

class ScrapModel {
  late int id;
  late String name;
  late double price;
  late String image;
  late double rating;
  late int review;
  late int sale;
  late String location;

  ScrapModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.rating,
      required this.review,
      required this.sale,
      required this.location});
}

List<ScrapModel> scrapData = [
  ScrapModel(
      id: 1,
      name: 'Metal',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  ScrapModel(
      id: 2,
      name: 'E-waste',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  ScrapModel(
      id: 2,
      name: 'Palastic',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  ScrapModel(
      id: 2,
      name: 'Fabrics',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  ScrapModel(
      id: 2,
      name: 'Glass',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
  ScrapModel(
      id: 2,
      name: 'Papers',
      price: 433,
      image: GLOBAL_URL + '/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'Brooklyn'),
];
