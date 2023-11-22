import 'package:flutter/material.dart';
import 'package:fyp/inventory/inventory_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PendingProduct extends StatefulWidget {
  const PendingProduct({super.key});

  @override
  State<PendingProduct> createState() => _PendingProductState();
}

class _PendingProductState extends State<PendingProduct> {
  Map<String, dynamic> inventoryData = {}; // Updated to a Map
  String? username;
  int? userid;
  String? email;

  @override
  void initState() {
    super.initState();
    initValues();
  }

  Future<void> initValues() async {
    await newvalues(); // Await this function to ensure userid is initialized
    fetchData();
  }

  Future<void> newvalues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userId');
    username = prefs.getString('username');
    email = prefs.getString('email');
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://10.0.2.2:8000/getpendingitem');

    final Map<String, dynamic> requestBody = {
      'userid': userid,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        inventoryData = data;
      });
    } else if (response.statusCode == 404) {
      throw Exception("Item does not exist");
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }

  Future<void> deleteAdd(int productid) async {
    final url = Uri.parse('http://10.0.2.2:8000/deleteitem');

    final Map<String, dynamic> requestBody = {
      'userid': userid,
      'productid': productid,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        inventoryData = data;
      });
    } else if (response.statusCode == 404) {
      throw Exception("Item does not exist");
    } else {
      throw Exception("Failed to delete item: ${response.statusCode}");
    }
  }

  String data = 'NO Items Found';

  @override
  Widget build(BuildContext context) {
    if (inventoryData == null ||
        inventoryData.isEmpty ||
        inventoryData['data'] == null) {
      setState(() {
        fetchData();
      });
      return Center(
        child: Text('No items found.'),
      );
    } else {
      return Container(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          itemCount: inventoryData['data'].length,
          itemBuilder: (context, index) {
            final item = inventoryData['data'][index];
            return Card(
              elevation: 5,
              child: Container(
                height: 100.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 100.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'http://10.0.2.2:8000/' + item['images'][0]),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 150,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    'Name: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item['title'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Quantity: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item['quantity'].toString(),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Price: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Rs ${item['price']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Description: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item['description'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirmation'),
                                  content:
                                      Text('Do you want to delete the ad?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        deleteAdd(item['id']);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
