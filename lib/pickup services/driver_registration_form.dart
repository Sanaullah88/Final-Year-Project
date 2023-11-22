import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fyp/pickup%20services/pickup_drivers.dart';

class DriverRegistrationPage extends StatefulWidget {
  @override
  _DriverRegistrationPageState createState() => _DriverRegistrationPageState();
}

class _DriverRegistrationPageState extends State<DriverRegistrationPage> {
  File? driverImage;
  File? carImage;
  String? selectedVehicleType;

  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TextEditingController pricePerKmController = TextEditingController();

  final List<String> vehicleTypes = [
    'Truck',
    'Tralley',
    'Mini truck',
    'Mazda',
    'Loader',
    'Mini tralley'
  ];
  final List<String> cityOptions = [
    'Islamabad',
    'Karachi',
    'Rawalpindi',
    'Lahore',
    'Peshawar'
  ];

// Define a variable to store the selected city
  String? selectedCity;

  Future<void> _getImage(ImageSource source, bool isDriverImage) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (isDriverImage) {
          driverImage = File(pickedFile.path);
        } else {
          carImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> sendDriverData() async {
    // Define the API endpoint URL where you want to send the data.
    final apiUrl = Uri.parse('http://10.0.2.2:8000/registerdriver');

    // Create a multipart request to send data with images.
    var request = http.MultipartRequest('POST', apiUrl);

    // Add driver image to the request.
    if (driverImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('driver_image', driverImage!.path));
    }

    // Add car image to the request.
    if (carImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('car_image', carImage!.path));
    }
    if (selectedCity != null) {
      request.fields['city'] = selectedCity!;
    }
    // Add other form fields to the request.
    request.fields['name'] = nameController.text;
    request.fields['phone_number'] = phoneController.text;
    request.fields['address'] = addressController.text;
    request.fields['car_number'] = carNumberController.text;

    if (selectedVehicleType != null) {
      request.fields['vehicle_type'] = selectedVehicleType!;
    }
    if (pricePerKmController.text.isNotEmpty) {
      request.fields['ppk'] = pricePerKmController.text;
    }

    // Send the request to the API.
    var response = await request.send();

    if (response.statusCode == 201) {
      print("Successful response received."); // Add this for debugging
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DriverContact(),
      ));
      nameController.clear();
      phoneController.clear();
      addressController.clear();
      carNumberController.clear();

      setState(() {
        driverImage = null;
        carImage = null;
        selectedVehicleType = null;
      });
    } else {
      print(
          "Response status code is not 200: ${response.statusCode}"); // Add this for debugging
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _getImage(ImageSource.gallery, true),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: driverImage != null
                              ? Image.file(
                                  driverImage!,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.grey[800],
                                ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Upload Driver Image',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => _getImage(ImageSource.gallery, false),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: carImage != null
                              ? Image.file(
                                  carImage!,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.grey[800],
                                ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Upload Car Image',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedCity,
              hint: Text('Select City'),
              items: cityOptions.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: carNumberController,
              decoration: InputDecoration(
                labelText: 'Car Number',
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedVehicleType,
              hint: Text('Select Vehicle Type'),
              items: vehicleTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedVehicleType = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            Divider(),
            TextField(
              controller: pricePerKmController, // Step 2
              keyboardType: TextInputType.number, // Allowing only numeric input
              decoration: InputDecoration(
                labelText: 'Price per km',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                sendDriverData();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
