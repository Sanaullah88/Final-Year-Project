import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var _value1 = '-1';
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String selectedValue = 'islamabad';

  Future<void> signup() async {
    final url = Uri.parse('http://10.0.2.2:8000/adduser');
    final request = http.MultipartRequest('POST', url);

    request.fields['username'] = usernameController.text;
    request.fields['email'] = emailController.text;
    request.fields['password'] = passwordController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['city'] = selectedValue;

    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', _image!.path),
      );
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        usernameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmpasswordController.clear();
        phoneController.clear();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        print('Failed to register user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  void initState() {
    super.initState();
  }

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Account',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: mediaQuery.size.width * 0.7,
                  height: mediaQuery.size.width * 0.7,
                  child: Image.asset(
                    'assets/images/logo.png',
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Center(
                  child: Column(
                    children: [
                      // Center(
                      //   child: Column(
                      //     children: <Widget>[
                      //       if (_image != null)
                      //         Image.file(
                      //           _image!,
                      //           width: 100,
                      //           height: 100,
                      //         )
                      //       else
                      //         GestureDetector(
                      //           onTap: _pickImage,
                      //           child: Container(
                      //             width: 100,
                      //             height: 100,
                      //             decoration: BoxDecoration(
                      //               color: Colors.grey[200],
                      //               borderRadius: BorderRadius.circular(50),
                      //             ),
                      //             child: Center(
                      //               child: Icon(
                      //                 Icons.add_a_photo,
                      //                 size: 40,
                      //                 color: Colors.grey[600],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.020,
                      // ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Color of the shadow
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 5, // The blur amount
                                offset: Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[],
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Color of the shadow
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 5, // The blur amount
                                offset: Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Color of the shadow
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 5, // The blur amount
                                offset: Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField(
                            value: _value1,
                            items: const [
                              DropdownMenuItem(
                                child: Text(
                                  'Select city',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23),
                                ),
                                value: '-1',
                              ),
                              DropdownMenuItem(
                                child: Text('Islamabad'),
                                value: '1',
                              ),
                              DropdownMenuItem(
                                child: Text('Karachi'),
                                value: '2',
                              ),
                              DropdownMenuItem(
                                child: Text('Rawalpindi'),
                                value: '3',
                              ),
                              DropdownMenuItem(
                                child: Text('Lahore'),
                                value: '4',
                              ),
                              DropdownMenuItem(
                                child: Text('Peshawar'),
                                value: '5',
                              ),
                            ],
                            onChanged: (v) {},
                            decoration: InputDecoration(
                              hintText: 'Address',
                              prefixIcon: Icon(Icons.location_city),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Color of the shadow
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 5, // The blur amount
                                offset: Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: phoneController,
                            decoration: InputDecoration(
                              hintText: 'Phone No',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                              prefixIcon: const Icon(Icons.phone_android),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Color of the shadow
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 5, // The blur amount
                                offset: Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                              prefixIcon: const Icon(Icons.lock),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey, // Color of the shadow
                                spreadRadius: 2, // How far the shadow spreads
                                blurRadius: 5, // The blur amount
                                offset: Offset(0, 3), // Offset of the shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: confirmpasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Conform Password',
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                              prefixIcon: const Icon(Icons.lock),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: () {
                              if (usernameController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please enter username",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                    backgroundColor: Colors.red);
                              } else if (phoneController.text.isEmpty ||
                                  phoneController.text.length != 11) {
                                Fluttertoast.showToast(
                                    msg: "Phone Number is not correct",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                    backgroundColor: Colors.red);
                              } else if (selectedValue.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please select City",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                    backgroundColor: Colors.red);
                              } else if (emailController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please enter correct email",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                    backgroundColor: Colors.red);
                              } else if (passwordController.text.isEmpty ||
                                  passwordController.text !=
                                      confirmpasswordController.text) {
                                Fluttertoast.showToast(
                                    msg: "Enter Same Password",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                    backgroundColor: Colors.red);
                              } else {
                                signup();
                              }
                            },
                            child: const Text(
                              'Signup',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.email,
                                  size:
                                      MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Login with Gmail',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1,
                              vertical:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already Register?',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Text(
                              'Signin',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: TextButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
