import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fyp/scrap%20services/scrap_seller_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ProductDetails extends StatefulWidget {
  final int productId;

  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Recycle Now',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: ProductDetail(
            productid: widget.productId), // Pass productId to ProductDetails
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  final int productid;

  const ProductDetail({super.key, required this.productid});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Map<String, dynamic> inventoryData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
    print("Product Id");
    print(widget.productid);
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://10.0.2.2:8000/getsingleadds');

    final Map<String, dynamic> requestBody = {
      'id': widget.productid,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );
    print("Response ${response}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<String> imagePaths = (data['data']['images'] as List<dynamic>)
          .map((item) => item.toString())
          .toList();
      setState(() {
        inventoryData = data;
        inventoryData['data']['images'] = imagePaths;
        print("Inventory data $inventoryData");
        print(inventoryData['data']['title']);
      });
    } else if (response.statusCode == 404) {
      throw Exception("Item does not exist");
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }

  final String image = 'assets/images/selling_item/bike.png';

  final String description =
      'The bike is in a worn-out condition and may require repairs or restoration.\n Components: The bike comes with various components, including the frame, wheels, handlebars, pedals, and gears. Some parts may need replacement or refurbishment. ';

  @override
  Widget build(BuildContext context) {
    if (inventoryData == null || inventoryData['data'] == null) {
      // Show a message when there's no data
      return Center(
        child: Text('No inventory data available'),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: (inventoryData['data']['images'] as List<String>)
                  .map((imagePath) {
                return Container(
                  child: Image.network(
                    'http://10.0.2.2:8000' + imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      inventoryData['data']['title'] ?? 'No Title Available',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rs : ' + (inventoryData['data']['price'] ?? ''),
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Date :' +
                              (inventoryData != null &&
                                      inventoryData['data'] != null &&
                                      inventoryData['data']['date'] != null
                                  ? DateFormat('d MMM yyyy').format(
                                      DateTime.parse(
                                          inventoryData['data']['date']))
                                  : ''),
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey, size: 12),
                        Text(
                          inventoryData['data']['location'] ?? 'Loading',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    inventoryData['data']['title'] ?? 'No Title Available',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    inventoryData['data']['description'] ??
                        'No Title Available',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            Container(
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: inventoryData['data']['user_image'] != null
                                  ? Image.network(
                                      'http://10.0.2.2:8000/' +
                                          inventoryData['data']['user_image'],
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.account_circle,
                                      size: 120,
                                      color: Colors.grey,
                                    ),
                            ),
                          )),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 140, top: 40),
                            child: Text(
                                inventoryData['data']['user_name'] ??
                                    'No Title Available',
                                style: Theme.of(context).textTheme.headline5),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 140),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScrapContactUsPage(
                                        userid: inventoryData['data']
                                            ['userid']),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    'See Profile',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(height: 5),
            Text(inventoryData['data']['description'] ?? ''),
            const Divider(
              color: Colors.grey,
            ),
            Column(
              children: [
                SizedBox(
                  height: 150, // Adjust the height to your desired size
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(33.6844,
                          73.0479), // Provide your desired initial map location
                      zoom: 15, // Adjust the zoom level as needed
                    ),
                    markers: Set<Marker>.of([
                      Marker(
                        markerId: MarkerId("marker_1"),
                        position: LatLng(
                            37.422, -122.084), // Provide the marker position
                        // Add more options for the marker if needed
                      ),
                    ]),
                  ),
                ),
                // Other widgets below if necessary
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.blue,
                        size: 30.0,
                      ),
                      const SizedBox(width: 2.0),
                      TextButton(
                        onPressed: navigateToCall,
                        child: const Text(
                          "Call",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone_android_outlined,
                        color: Colors.blue,
                        size: 30.0,
                      ),
                      const SizedBox(width: 2.0),
                      TextButton(
                        onPressed: navigateToWhatsApp,
                        child: const Text(
                          "WhatsApp",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.message_rounded,
                        color: Colors.blue,
                        size: 30.0,
                      ),
                      const SizedBox(width: 3.0),
                      TextButton(
                        onPressed: navigateToSMS,
                        child: const Text(
                          "SMS",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void navigateToCall() async {
    var phoneNumber = 'tel://${inventoryData?['data']?['user_phone'] ?? ''}';

    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void navigateToWhatsApp() async {
    var whatsappNumber =
        'https://wa.me/${inventoryData?['data']?['user_phone'] ?? ''}';
    if (await canLaunch(whatsappNumber)) {
      await launch(whatsappNumber);
    } else {
      throw 'Could not launch $whatsappNumber';
    }
  }

  void navigateToSMS() async {
    var smsNumber = 'sms://${inventoryData?['data']?['user_phone'] ?? ''}';
    if (await canLaunch(smsNumber)) {
      await launch(smsNumber);
    } else {
      throw 'Could not launch $smsNumber';
    }
  }
}
