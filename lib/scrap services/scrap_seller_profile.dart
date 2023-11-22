import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/ui/reusable/cache_image_network.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ScrapContactUsPage extends StatefulWidget {
  final int userid;

  const ScrapContactUsPage({super.key, required this.userid});
  @override
  State<ScrapContactUsPage> createState() => _ScrapContactUsPageState();
}

class _ScrapContactUsPageState extends State<ScrapContactUsPage> {
 
 Map<String, dynamic> userData = {};

  Color _color1 = Color.fromARGB(255, 17, 167, 67);
  Color _color2 = Color(0xFF333333);
  Color _color3 = Color(0xFF666666);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://10.0.2.2:8000/getsingleuser');

    final Map<String, dynamic> requestBody = {
      'id': widget.userid,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );
    print(response);

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        userData = data;
        print(userData);
      });
    } else if (response.statusCode == 404) {
      throw Exception("Item does not exist");
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color1,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        centerTitle: true,
        title: const Text('User Profile',
            style: TextStyle(
              fontSize: 18,
            )),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: [
          Center(
            child: GestureDetector(
                child: ClipOval(
              child: Image.network(
                userData != null && userData['data'] != null
                    ? 'http://10.0.2.2:8000/' +
                        (userData['data']['image'] ?? 'defaultImageURL')
                    : 'https://www.shutterstock.com/image-vector/img-vector-icon-design-on-260nw-2164648583.jpg', // Replace 'defaultImageURL' with your default image URL
                width: 200,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.account_circle_outlined,
                    size: 170,
                  ); // Replace with your desired icon
                },
              ),
            )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            alignment: Alignment.center,
            child: Text(
                userData != null && userData['data'] != null
                    ? userData['data']['username']
                    : '',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: _color2)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name',
                    style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                SizedBox(height: 4),
                Text(
                    userData != null && userData['data'] != null
                        ? userData['data']['username']
                        : '',
                    style: TextStyle(
                        color: _color3,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                // SizedBox(height: 16),
                // Text('Address',
                //     style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                // SizedBox(height: 4),
                // Text('i14, Islamabad',
                //     style: TextStyle(
                //         color: _color3,
                //         fontSize: 15,
                //         fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Phone Number',
                    style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                SizedBox(height: 4),
                Text(
                  userData != null && userData['data'] != null
                      ? userData['data']['phone_number']
                      : '',
                  style: TextStyle(
                      color: _color3,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(height: 16),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  updateOnDrag: false, // Disable updating the rating on drag
                  tapOnlyMode: true, // Disable tapping to update the rating
                  ignoreGestures:
                      true, // Disable all gestures on the rating bar
                  onRatingUpdate: (rating) {
                    // This callback is required, but you can leave it empty as it won't be triggered
                  },
                )
              ],
            ),
          ),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Container(
          //         margin: const EdgeInsets.only(top: 110),
          //         width: 120,
          //         height: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10.0),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.5),
          //               spreadRadius: 3,
          //               blurRadius: 5,
          //               offset: Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           children: [
          //             const Icon(
          //               Icons.phone,
          //               color: Colors.blue,
          //               size: 30.0,
          //             ),
          //             const SizedBox(width: 2.0),
          //             TextButton(
          //                 onPressed: () {},
          //                 child: const Text(
          //                   "Call",
          //                   style: TextStyle(
          //                     fontSize: 20.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ))
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.only(top: 110),
          //         width: 120,
          //         height: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10.0),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.5),
          //               spreadRadius: 3,
          //               blurRadius: 5,
          //               offset: Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           children: [
          //             const Icon(
          //               Icons.phone_android_outlined,
          //               color: Colors.blue,
          //               size: 30.0,
          //             ),
          //             const SizedBox(width: 2.0),
          //             TextButton(
          //                 onPressed: () {},
          //                 child: const Text(
          //                   "Whatsapp",
          //                   style: TextStyle(
          //                     fontSize: 15.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ))
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.only(top: 110),
          //         width: 120,
          //         height: 80,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10.0),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.5),
          //               spreadRadius: 3,
          //               blurRadius: 5,
          //               offset: Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           children: [
          //             const Icon(
          //               Icons.message_rounded,
          //               color: Colors.blue,
          //               size: 30.0,
          //             ),
          //             const SizedBox(width: 3.0),
          //             TextButton(
          //                 onPressed: () {},
          //                 child: const Text(
          //                   "SMS",
          //                   style: TextStyle(
          //                     fontSize: 20.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ))
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
