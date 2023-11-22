import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/destination.dart';
import 'package:fyp/model/feature/banner_slider_model.dart';
import 'package:fyp/model/feature/product_model.dart';

import '../scrap services/scrap_item_details.dart';

class Buyerpage extends StatefulWidget {
  const Buyerpage({super.key});

  @override
  State<Buyerpage> createState() => _BuyerpageState();
}

class _BuyerpageState extends State<Buyerpage> {
  int _currentImageSlider = 0;

  @override
  void initState() {
    _bannerData.add(BannerSliderModel(
        id: 5, image: GLOBAL_URL + '/images/home_banner/5.jpg'));
    _bannerData.add(
        BannerSliderModel(id: 4, image: GLOBAL_URL + '/home_banner/4.jpg'));
    _bannerData.add(BannerSliderModel(
        id: 1, image: GLOBAL_URL + '/images/home_banner/recycle.png'));
    _bannerData.add(
        BannerSliderModel(id: 2, image: GLOBAL_URL + '/home_banner/2.jpg'));
    _bannerData.add(
        BannerSliderModel(id: 3, image: GLOBAL_URL + '/home_banner/3.jpg'));
  }

  List<BannerSliderModel> _bannerData = [];
  List<ProductModel> _productData = [];
  int _currentIndex = 0;

  List<ProductModel> _getSuggestions(String query) {
    List<ProductModel> matches = [];
    matches.addAll(productData);
    matches.retainWhere(
        (data) => data.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Search Product'),
                    ),
                    suggestionsCallback: (pattern) {
                      return _getSuggestions(pattern);
                    },
                    itemBuilder: (context, ProductModel suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                      );
                    },
                    onSuggestionSelected: (ProductModel suggestion) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DestinationPage(productData: suggestion)));
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: _mediaQuery.size.width * 0.10,
                height: _mediaQuery.size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Column(
          children: [
            CarouselSlider(
              items: [
                Container(
                  child: Image.asset(
                    'assets/images/slider_image/banner1.jpg',
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/slider_image/banner2.jpg',
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/recycle.png',
                  ),
                ),
              ],
              options: CarouselOptions(
                aspectRatio: 6 / 3,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 6),
                autoPlayAnimationDuration: Duration(milliseconds: 300),
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageSlider = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _bannerData.map((item) {
                int index = _bannerData.indexOf(item);
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: _currentImageSlider == index ? 16.0 : 8.0,
                  height: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _currentImageSlider == index
                        ? Colors.amber
                        : Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        Container(
          child: _createAllProduct(),
        ),
      ],
    )));
  }

  Widget _createAllProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: const Text('News Feed',
              style: TextStyle(
                fontSize: 30,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                              productId: 123,
                            )),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/images/selling_item/bike.png",
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'hi',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    '\Rs 6000',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: const [
                                  Icon(Icons.location_on,
                                      color: Colors.grey, size: 12),
                                  Text(
                                    'i14, Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetails(
                              productId: 124,
                            )),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.asset(
                          "assets/images/selling_item/washing.jpg",
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'hi',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    '\Rs 3500',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: const [
                                  Icon(Icons.location_on,
                                      color: Colors.grey, size: 12),
                                  Text(
                                    'Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/book.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text(
                                  'Islamabad ',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/washing.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text('Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/clothes.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text(
                                  'Islamabad ',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/m1.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text('Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/book.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text(
                                  'Islamabad ',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/clothes.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text('Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/bike.png',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text(
                                  'Islamabad ',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/fan.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text('Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/m1.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text(
                                  'Islamabad ',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/fan.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text('Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/washing.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text(
                                  'Islamabad ',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        child: Image.asset(
                          'assets/images/selling_item/washing.jpg',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hi',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('\Rs 220',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text('5' + ' ' + 'May',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 12),
                                Text('Islamabad ',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
