import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shoes_store/presentation/auth/pages/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseHistoryPage extends StatefulWidget {
  @override
  _PurchaseHistoryPageState createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {
  List<dynamic> _purchaseHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPurchaseHistory();
  }

  Future<void> _fetchPurchaseHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final response = await http.get(Uri.parse('${Config.baseUrl}/api/purchase-history/$userId'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _purchaseHistory = jsonData;
        _isLoading = false; // Set loading to false when data is fetched
      });
    } else {
      print('Failed to load purchase history');
      setState(() {
        _isLoading = false; // Set loading to false on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase History'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _purchaseHistory.isEmpty
              ? Center(
                  child: Text('No purchase history available'),
                )
              : ListView.builder(
                  itemCount: _purchaseHistory.length,
                  itemBuilder: (context, index) {
                    final purchase = _purchaseHistory[index];
                    // Parsing tanggal dan waktu dari format string
                    DateTime createdAt = DateTime.parse(purchase['created_at']);
                    // Format tanggal dan waktu
                    String formattedDateTime =
                        '${createdAt.day}/${createdAt.month}/${createdAt.year} ${createdAt.hour}:${createdAt.minute}';
                    return ListTile(
                      title: Text(formattedDateTime),
                      subtitle: Text('Total: ${purchase['total_amount']}'),
                    );
                  },
                ),
    );
  }
}
