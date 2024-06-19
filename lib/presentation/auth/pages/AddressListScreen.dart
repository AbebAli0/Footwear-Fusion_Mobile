import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoes_store/presentation/auth/pages/config.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List<Address> addresses = [];
  late Future<void> futureAddresses;

  @override
  void initState() {
    super.initState();
    futureAddresses = fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    final response = await http.get(
      Uri.parse('${Config.baseUrl}/api/addresses/$userId'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<Address> fetchedAddresses = jsonResponse
          .map((data) => Address.fromJson(data))
          .toList();

      setState(() {
        addresses = fetchedAddresses;
      });
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<void> deleteAddress(int id) async {
    final response = await http.delete(
      Uri.parse('${Config.baseUrl}/api/addresses/$id'),
    );

    if (response.statusCode == 200) {
      // Refresh list after successful delete
      await fetchAddresses();
    } else {
      throw Exception('Failed to delete address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addresses'),
      ),
      body: addresses.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(addresses[index].alamat),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Address'),
                                content:
                                    Text('Are you sure you want to delete this address?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () async {
                                      await deleteAddress(addresses[index].id);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.2,
                      height: 0,
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAddressScreen()),
          ).then((value) {
            if (value == true) {
              futureAddresses = fetchAddresses();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addAddress(_alamatController.text);
                  }
                },
                child: Text('Add Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addAddress(String alamat) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('userId');

    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/addresses'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'customer_id': userId, 'alamat': alamat}),
    );

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add address')),
      );
    }
  }

  @override
  void dispose() {
    _alamatController.dispose();
    super.dispose();
  }
}

class Address {
  final int id;
  final int customerId;
  final String alamat;

  Address({required this.id, required this.customerId, required this.alamat});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      customerId: json['customer_id'],
      alamat: json['alamat'],
    );
  }
}
