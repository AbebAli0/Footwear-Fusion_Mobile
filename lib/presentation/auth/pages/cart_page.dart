import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shoes_store/presentation/auth/pages/AddressListScreen.dart';
import 'package:shoes_store/presentation/auth/pages/config.dart';

class PaymentMethod {
  final String name;
  final IconData iconData;
  final String description;

  PaymentMethod({
    required this.name,
    required this.iconData,
    required this.description,
  });
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic>? cartProducts;
  String _address = '';
  List<Address> addresses = [];
  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
    _getCartProducts();
    _loadUserData();
  }

  Future<void> fetchAddresses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/addresses/$userId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<Address> fetchedAddresses =
          jsonResponse.map((data) => Address.fromJson(data)).toList();

      setState(() {
        addresses = fetchedAddresses;
        selectedAddress = addresses.isNotEmpty ? addresses[0] : null; // Set default selected address
      });
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<void> _getCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/carts/$userId'),
    );

    if (response.statusCode == 200) {
      setState(() {
        cartProducts = jsonDecode(response.body);
      });
    } else {
      print('Failed to load cart products');
    }
  }

  Future<void> _updateQuantity(int productId, String action) async {
    final response = await http.put(
      Uri.parse('${Config.baseUrl}/api/carts/$productId/$action'),
    );

    if (response.statusCode == 200) {
      _getCartProducts();
    } else {
      print('Failed to update quantity');
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _address = 'jln veteran';
    });
  }

  Future<void> _removeProductFromCart(int productId) async {
    final response = await http.delete(
      Uri.parse('${Config.baseUrl}/api/carts/$productId'),
    );

    if (response.statusCode == 200) {
      _getCartProducts();
    } else {
      print('Failed to remove product from cart');
    }
  }

  Future<void> _checkout(String paymentMethod) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/checkout'),
      body: {
        'customer_id': userId.toString(),
        'payment_method': paymentMethod,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        cartProducts = null;
      });
      print('Checkout successful');
    } else {
      print('Failed to checkout');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartProducts == null || cartProducts!.isEmpty
          ? Center(
              child: Text('Cart is empty'),
            )
          : ListView.builder(
              itemCount: cartProducts!.length,
              itemBuilder: (context, index) {
                final product = cartProducts![index];
                final String productName = product['product_name'];
                final int quantity = product['quantity'];
                final int productId = product['id'];
                final String price = product['price'].toString();
                final String imageUrl = product['image'];

                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: '${Config.baseUrl}/images/$imageUrl',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(productName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: $quantity'),
                      Text('Price: Rp.$price'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          _updateQuantity(productId, 'decrease');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _updateQuantity(productId, 'increase');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeProductFromCart(productId);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: cartProducts == null || cartProducts!.isEmpty
          ? null
          : BottomAppBar(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _showPaymentMethodDialog(context);
                  },
                  child: Text('Checkout'),
                ),
              ),
            ),
    );
  }

  Future<void> _showPaymentMethodDialog(BuildContext context) async {
    await fetchAddresses();
    final selectedMethod = await showDialog<Address>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Payment Method'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, Address(alamat: 'Cash on Delivery'));
              },
              child: ListTile(
                leading: Icon(Icons.money),
                title: Text('Cash on Delivery'),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<Address>(
                      decoration: InputDecoration(
                        labelText: 'Select Address',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedAddress,
                      items: addresses.map((Address address) {
                        return DropdownMenuItem<Address>(
                          value: address,
                          child: Text(address.alamat),
                        );
                      }).toList(),
                      onChanged: (Address? value) {
                        setState(() {
                          selectedAddress = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressListScreen(),
                        ),
                      );
                    },
                    child: Text('+ Add'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    if (selectedMethod != null) {
      // Perform checkout or any other action based on selectedMethod
      _checkout(selectedMethod.alamat); // Assuming alamat is the address string to checkout
    }
  }
}

class Address {
  final String alamat;

  Address({required this.alamat});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      alamat: json['alamat'],
    );
  }
}
