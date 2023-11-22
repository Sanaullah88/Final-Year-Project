import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:fyp/user%20profile/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  final int? id;
  final String? username;
  final String? email;
  final String? image;
  final String? phone;
  const UpdateProfileScreen(
      {Key? key, this.username, this.email, this.image, this.id, this.phone})
      : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    name = TextEditingController(text: widget.username);
    email = TextEditingController(text: widget.email);
    phone = TextEditingController(text: widget.phone);

    // TODO: implement initState
    super.initState();
  }

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource
            .gallery); // You can change the source to ImageSource.camera for capturing an image.
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _sendData() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8000/updateuser'));

    if (_image != null) {
      // Add the new image to the request if it exists.
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    request.fields['userid'] = widget.id.toString();
    request.fields['username'] = name.text;
    request.fields['email'] = email.text;
    request.fields['phone_number'] = phone.text;
    request.fields['password'] = password.text;

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', jsonResponse['user']['username']);
      prefs.setString('email', jsonResponse['user']['email']);
      prefs.setString('image', jsonResponse['user']['image'] ?? widget.image);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      ));
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Account', style: TextStyle(fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _image != null
                          ? Image.file(_image!)
                          : Image.network(
                              'http://10.0.2.2:8000/${widget.image}',
                              filterQuality: FilterQuality.high,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.yellow),
                      child: IconButton(
                        icon: Icon(LineAwesomeIcons.camera,
                            color: Colors.black, size: 20),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          label: Text(widget.username.toString()),
                          prefixIcon: Icon(LineAwesomeIcons.user)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          label: Text(widget.email.toString()),
                          prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phone,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          label: Text('03201907266'),
                          prefixIcon: Icon(LineAwesomeIcons.phone)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                            icon: const Icon(LineAwesomeIcons.eye_slash),
                            onPressed: () {}),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () {
                          _sendData();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Edit Profile',
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: 'Joined 1 May',
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: '2023',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text('Delete'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
