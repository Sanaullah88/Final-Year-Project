import 'package:flutter/material.dart';

class Customer {
  String name;
  String email;
  List<Product> products;

  Customer({required this.name, required this.email, required this.products});
}

class Product {
  String name;
  String photoUrl;
  String description;
  String status;
  double price;

  Product({required this.name, required this.photoUrl, required this.description, required this.status, required this.price});
}

class CustomerInventory extends StatefulWidget {
  const CustomerInventory({Key? key}) : super(key: key);

  @override
  State<CustomerInventory> createState() => _CustomerInventoryState();
}

class _CustomerInventoryState extends State<CustomerInventory> {
  List<Customer> _customers = [
    Customer(
      name: 'John Doe',
      email: 'johndoe@gmail.com',
      products: [
        Product(
          name: 'Product 1',
          photoUrl: 'assets/product1.jpg',
          description: 'Description 1',
          status: 'Sold',
          price: 100,
        ),
        Product(
          name: 'Product 2',
          photoUrl: 'assets/product2.jpg',
          description: 'Description 2',
          status: 'Pending',
          price: 50,
        ),
        Product(
          name: 'Product 3',
          photoUrl: 'assets/product3.jpg',
          description: 'Description 3',
          status: 'Sold',
          price: 75,
        ),
      ],
    ),
    Customer(
      name: 'Jane Smith',
      email: 'janesmith@gmail.com',
      products: [
        Product(
          name: 'Product 4',
          photoUrl: 'assets/product4.jpg',
          description: 'Description 4',
          status: 'Sold',
          price: 200,
        ),
        Product(
          name: 'Product 5',
          photoUrl: 'assets/product5.jpg',
          description: 'Description 5',
          status: 'Pending',
          price: 125,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Inventory'),
      ),
      body: ListView.builder(
        itemCount: _customers.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _customers[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _customers[index].email,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  for (var product in _customers[index].products)
                    ListTile(
                      leading: Image.asset(
                        product.photoUrl,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.description),
                          Text('Status: ${product.status}'),
                          Text('Price: ${product.price}'),
                        ],
                      ),
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
