import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Api/MyAdds.dart';
import 'package:fyp/buyer/auth/login.dart';
import 'package:fyp/chat.dart';
import 'package:fyp/destination.dart';
import 'package:fyp/inventory/inventory_tab.dart';
import 'package:fyp/model/feature/MyAdds.dart';
import 'package:fyp/model/feature/product_model.dart';
import 'package:fyp/notification/notification.dart';
import 'package:fyp/scrap%20services/scrap_item_details.dart';
import 'package:fyp/setting.dart';
import 'package:fyp/ui/reusable/global_function.dart';
import 'package:fyp/ui/reusable/global_widget.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/user profile/user_profile.dart';
import 'package:fyp/scrap services/scrap_services.dart';
import 'package:fyp/model/feature/banner_slider_model.dart';
import 'package:fyp/pickup services/pickup_category.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shared_preferences/shared_preferences.dart';

const tDefaultSize = 30.0;
const tProfile = 'Profile';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum NavItem { home, notifications, messages, profile }

class _HomePageState extends State<HomePage> {
  AllAds? allads;
  List<Data>? mydata;
  AdsApi adsapi = new AdsApi();

  Future<void> fetchAds() async {
    final data = await adsapi.fetchads();
    print("data is ${data}");
    if (data != null) {
      setState(() {
        allads = data;
        mydata = data.data;
        print(mydata);
      });
    }
  }

  int _currentImageSlider = 0;

  int _currentIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    Debris_services(),
    Chat1Page(),
    ProfileScreen(),
  ];

  List<IconData> _icons = [
    Icons.home,
    Icons.notifications,
    Icons.message,
    Icons.person,
  ];

  Icon getPageIcon(int index) {
    return Icon(
      _icons[index],
      color: _currentIndex == index ? Colors.green : Colors.black,
    );
  }

  void navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  void initState() {
    newvalues();
    fetchAds();
    setState(() {
      newvalues();
    });
    _bannerData.add(
      BannerSliderModel(id: 5, image: GLOBAL_URL + '/images/home_banner/5.jpg'),
    );
    _bannerData.add(
      BannerSliderModel(id: 4, image: GLOBAL_URL + '/home_banner/4.jpg'),
    );
    _bannerData.add(
      BannerSliderModel(
          id: 1, image: GLOBAL_URL + '/images/home_banner/recycle.png'),
    );
    _bannerData.add(
      BannerSliderModel(id: 2, image: GLOBAL_URL + '/home_banner/2.jpg'),
    );
    _bannerData.add(
      BannerSliderModel(id: 3, image: GLOBAL_URL + '/home_banner/3.jpg'),
    );
  }

  final _globalWidget = GlobalWidget();
  final _globalFunction = GlobalFunction();

  List<ProductModel> _getSuggestions(String query) {
    List<ProductModel> matches = [];
    matches.addAll(productData);
    matches.retainWhere(
        (data) => data.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<BannerSliderModel> _bannerData = [];
  List<ProductModel> _productData = [];
  String? username;
  String? email;
  String? image;
  late GoogleMapController mapController;
  final LatLng initialPosition = LatLng(37.7749, -122.4194);
  String googleApikey = "AIzaSyCkH9s2teNLu81sYK1z_vDwBv1WW7UhiUc";
  // GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(33.6844, 73.0479);
  String location = "Location"; // Initial map position
  Future<void> newvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    email = prefs.getString('email');
    setState(() {
      image = prefs.getString('image');
    });
    image = prefs.getString('image');
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _value1;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Container(
                alignment: Alignment.center,
                child: ClipOval(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.18,
                    backgroundImage:
                        NetworkImage('http://10.0.2.2:8000/$image'),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            const Divider(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
              },
            ),
          ],
        ),
      ),
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
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.05,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.notification_add,
                  size: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () async {
                  var place = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: googleApikey,
                    mode: Mode.overlay,
                    types: [],
                    strictbounds: false,
                    components: [
                      Component(Component.country, 'pk'),
                    ],
                    onError: (err) {
                      print(err);
                    },
                  );

                  if (place != null) {
                    setState(
                      () {
                        location = place.description.toString();
                      },
                    );

                    //form google_maps_webservice package
                    final plist = GoogleMapsPlaces(
                      apiKey: googleApikey,
                      apiHeaders: await GoogleApiHeaders().getHeaders(),
                      //from google_api_headers package
                    );
                    String placeid = place.placeId ?? "0";
                    final detail = await plist.getDetailsByPlaceId(placeid);
                    final geometry = detail.result.geometry!;
                    final lat = geometry.location.lat;
                    final lang = geometry.location.lng;
                    var newlatlang = LatLng(lat, lang);

                    //move map camera to selected place with animation
                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: newlatlang, zoom: 17),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListTile(
                          leading:
                              const Icon(Icons.location_on, color: Colors.grey),
                          title: Text(
                            location,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          dense: true,
                        ),
                      ),
                      const Divider(
                        height: 5,
                        color: Colors.grey,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Product',
                              hintStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                color: Colors.grey, // Set your desired color
                              ),
                              prefixIcon: Icon(Icons.search),
                            ),
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
                                    DestinationPage(productData: suggestion),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Column(
                children: [
                  CarouselSlider(
                    items: [
                      Image.asset(
                        'assets/images/slider_image/banner1.jpg',
                      ),
                      Image.asset(
                        'assets/images/slider_image/banner2.jpg',
                      ),
                      Image.asset(
                        'assets/images/recycle.png',
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
                        setState(
                          () {
                            _currentImageSlider = index;
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _bannerData.map(
                      (item) {
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
                      },
                    ).toList(),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.6),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Debris_services(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: _mediaQuery.size.width * 0.45,
                          height: _mediaQuery.size.height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.width * 0.2,
                                child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.025,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.delete,
                                    color: const Color.fromARGB(
                                        255, 110, 108, 108),
                                    size: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Debris_services(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Scrap Selling',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickupCategory(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: _mediaQuery.size.width * 0.45,
                      height: _mediaQuery.size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.025,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.local_shipping,
                                color: const Color.fromARGB(255, 110, 108, 108),
                                size: MediaQuery.of(context).size.width * 0.15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PickupCategory(),
                                ),
                              );
                            },
                            child: Text(
                              'PickUp Service',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              _createAllProduct(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
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
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventoryTab(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _createAllProduct() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: const Text(
            'News Feed',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: (mydata != null ? (mydata!.length / 2).ceil() : 0),
          itemBuilder: (context, rowIndex) {
            final int index1 = rowIndex * 2;
            final int index2 = index1 + 1;
            if (mydata!.length <= 0) {
              return Center(
                child: Text("No Data Found"),
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: _buildProductCard(index1),
                ),
                if (index2 < mydata!.length)
                  Expanded(
                    child: _buildProductCard(index2),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildProductCard(int index) {
    final product = mydata![index];
    bool isActive = true;
    return SizedBox(
      width: 250,
      height: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(productId: product.id!),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  'http://10.0.2.2:8000/${product.image![0]}',
                  height: 150, // Set the image height
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs ' + product.price.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        // Icon(
                        //   Icons.circle,
                        //   color: isActive ? Colors.green : Colors.grey,
                        //   size: 12,
                        // ),
                        // Text(

                        //   product..toString(),
                        //   style: TextStyle(
                        //     fontSize: 11,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 12,
                        ),
                        Text(
                          product.location.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          product.date.toString(),
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
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
    );
  }

  Widget _buildItem(index) {
    final double boxImageSize =
        ((MediaQuery.of(context).size.width) - 24) / 2 - 12;
    return Container(
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
                child: Image.asset('assets/images/glass.png')),
            Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'hi',
                    style: TextStyle(fontSize: 12, color: Colors.black12),
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
                                fontSize: 13, fontWeight: FontWeight.bold)),
                        Text('20' + ' ' + 'Sale',
                            style: TextStyle(fontSize: 11, color: Colors.grey))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.grey, size: 12),
                        Text(
                          'Islamabad ',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
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
    );
  }
}
