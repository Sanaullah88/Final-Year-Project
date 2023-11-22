import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp/chatlist.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/home/home.dart';
import 'package:fyp/model/feature/banner_slider_model.dart';
import 'package:fyp/model/feature/pickup_model.dart';
import 'package:fyp/pickup%20services/driver_registration_form.dart';
import 'package:fyp/pickup_destination.dart';
import 'package:fyp/pickup services/pickup_drivers.dart';
import 'package:fyp/user%20profile/user_profile.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fyp/model/feature/product_model.dart';

class PickupCategory extends StatefulWidget {
  const PickupCategory({super.key});

  @override
  State<PickupCategory> createState() => _PickupCategoryState();
}

class _PickupCategoryState extends State<PickupCategory> {
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

  List<PickupModel> _getSuggestions(String query) {
    List<PickupModel> matches = [];
    matches.addAll(PickupData);
    matches.retainWhere(
        (data) => data.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _value1;
    var _bannerData = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Pickup Service ',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.06,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Column(
                children: [
                  CarouselSlider(
                    items: [
                      Image.asset(
                        'assets/images/slider_image/banner3.jpg',
                      ),
                      Image.asset(
                        'assets/images/slider_image/banner4.jpg',
                      ),
                      Image.asset(
                        'assets/images/slider_image/banner5.jpg',
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
                        duration: const Duration(milliseconds: 200),
                        width: _currentImageSlider == index ? 16.0 : 8.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 4.0),
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
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.6,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DriverContact(vehicle: 'Truck')),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.004,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Image.asset(
                                      'assets/images/Drivers/dump.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DriverContact(
                                          vehicle: 'Truck')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              child: Text(
                                'Dump Truk',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DriverContact(vehicle: 'Tralley')),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.004,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(1),
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Image.asset(
                                      'assets/images/Drivers/tractor.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DriverContact(
                                          vehicle: 'Tralley')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: const Text(
                                'Tralley',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DriverContact(
                                      vehicle: 'Mini truck')),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.004,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Image.asset(
                                    'assets/images/Drivers/mini_truck.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DriverContact(
                                          vehicle: 'Mini truck')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: const Text(
                                'Mini truck',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DriverContact(vehicle: 'Mazda')),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.004,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(1),
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Image.asset(
                                      'assets/images/Drivers/mazda.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DriverContact(
                                          vehicle: 'Mazda')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              child: Text(
                                'Mazda',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DriverContact(vehicle: 'Loader')),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.004,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Image.asset(
                                      'assets/images/Drivers/dump.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DriverContact(
                                          vehicle: 'Loader')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                              child: const Text(
                                'SiwaLoader',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DriverContact(
                                      vehicle: 'Mini tralley')),
                            );
                          },
                          child: Stack(
                            children: [
                              ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.004,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Image.asset(
                                    'assets/images/Drivers/mini.jpg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DriverContact(
                                          vehicle: 'Mini tralley')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                              child: const Text(
                                'mini tralley',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DriverRegistrationPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Driver'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatListPage(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
