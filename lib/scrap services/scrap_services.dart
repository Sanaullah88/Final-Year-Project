import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp/chatlist.dart';
import 'package:fyp/home/home.dart';
import 'package:fyp/scrap services/scrap_upload.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/model/feature/banner_slider_model.dart';
import 'package:fyp/model/feature/product_model.dart';
import 'package:fyp/model/feature/scrap_model.dart';
import 'package:fyp/user%20profile/user_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class Debris_services extends StatefulWidget {
  Debris_services({Key? key}) : super(key: key);

  @override
  _Debris_services createState() => _Debris_services();
}

class _Debris_services extends State<Debris_services> {
  int _currentIndex = 0;
  NavItem _currentNavItem = NavItem.home;
  void _onNavItemTapped(NavItem navItem) {
    setState(
      () {
        _currentNavItem = navItem;
      },
    );
  }

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

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _value1;
    var _bannerData = [];
    List<ScrapModel> _getSuggestions(String query) {
      List<ScrapModel> matches = [];
      matches.addAll(scrapData);
      matches.retainWhere(
          (data) => data.name.toLowerCase().contains(query.toLowerCase()));
      return matches;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Recycle Now',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.06,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
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
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 300),
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
                  top: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.width * 0.5,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                                      const UploadScreen(category: 'Metal')),
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
                                                0.005,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/selling_icon/metal.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.07, // Adjust the multiplier as needed
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightGreen,
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.040,
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
                                      builder: (context) => const UploadScreen(
                                          category: 'metal')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: Text(
                                'Metal',
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
                                      const UploadScreen(category: 'E-Waste')),
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
                                                0.005,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/selling_icon/ewaste.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.07, // Adjust the multiplier as needed
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightGreen,
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.040,
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
                                      builder: (context) => const UploadScreen(
                                          category: 'E-Waste')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: Text(
                                'E-Waste',
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
                                      const UploadScreen(category: 'E-Waste')),
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
                                                0.005,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/selling_icon/palastic.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.07, // Adjust the multiplier as needed
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightGreen,
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.040,
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
                                      builder: (context) => const UploadScreen(
                                          category: 'Palastic')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: Text(
                                'Palastic',
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
                  ],
                ),
              ),
              SizedBox(
                height: 200,
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
                                      const UploadScreen(category: 'Fabrics')),
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
                                                0.005,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/selling_icon/clothes.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.07, // Adjust the multiplier as needed
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightGreen,
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.040,
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
                                      builder: (context) => const UploadScreen(
                                          category: 'Fabrics')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: Text(
                                'Fabrics',
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
                                      const UploadScreen(category: 'Glass')),
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
                                                0.005,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/selling_icon/glass2.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightGreen,
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.040,
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
                                      builder: (context) => const UploadScreen(
                                          category: 'Glass')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: Text(
                                'Glass',
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
                                      const UploadScreen(category: 'Papers')),
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
                                                0.005,
                                        color: const Color.fromARGB(
                                            255, 180, 175, 175)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/selling_icon/paper.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.07, // Adjust the multiplier as needed
                                  height:
                                      MediaQuery.of(context).size.width * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightGreen,
                                  ),
                                  child: Icon(
                                    Icons.recycling,
                                    color: Colors.black,
                                    size: MediaQuery.of(context).size.width *
                                        0.040,
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
                                      builder: (context) => const UploadScreen(
                                          category: 'Papers')),
                                );
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                              child: Text(
                                'Papers',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
