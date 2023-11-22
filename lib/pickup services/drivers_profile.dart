import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/config/constant.dart';
import 'package:fyp/ui/reusable/cache_image_network.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs2Page extends StatefulWidget {
  final String? image;
  final String? name;
  final String? address;
  final String? phone;
  ContactUs2Page({
    required this.image,
    required this.name,
    required this.address,
    required this.phone,
  });
  @override
  _ContactUs2PageState createState() => _ContactUs2PageState();
}

class _ContactUs2PageState extends State<ContactUs2Page> {
  Color _color1 = Color.fromARGB(255, 17, 167, 67);
  Color _color2 = Color(0xFF333333);
  Color _color3 = Color(0xFF666666);

  @override
  void initState() {
    print("object${widget.image} ${widget.name}");
    super.initState();
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
        title: Text('User Profile',
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
                child: buildCacheNetworkImage(
                    width: 200,
                    height: 200,
                    url: widget.image != null
                        ? 'http://10.0.2.2:8000${widget.image}'
                        : ''),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            alignment: Alignment.center,
            child: Text(widget.name.toString(),
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: _color2)),
          ),
          Container(
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name',
                    style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                SizedBox(height: 4),
                Text(widget.name.toString(),
                    style: TextStyle(
                        color: _color3,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Address',
                    style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                SizedBox(height: 4),
                Text(widget.address.toString(),
                    style: TextStyle(
                        color: _color3,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text('Phone Number',
                    style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                SizedBox(height: 4),
                Text(
                  widget.phone.toString(),
                  style: TextStyle(
                      color: _color3,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 15,
                  height: 100,
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
          )
        ],
      ),
    );
  }

  void navigateToCall() async {
    var phoneNumber = 'tel://${widget.phone}';

    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void navigateToWhatsApp() async {
    var whatsappNumber = 'https://wa.me/${widget.phone}';
    if (await canLaunch(whatsappNumber)) {
      await launch(whatsappNumber);
    } else {
      throw 'Could not launch $whatsappNumber';
    }
  }

  void navigateToSMS() async {
    var smsNumber = 'sms://${widget.phone}';
    if (await canLaunch(smsNumber)) {
      await launch(smsNumber);
    } else {
      throw 'Could not launch $smsNumber';
    }
  }
}
