import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shoes_store/core/theme/theme.dart';
import 'package:shoes_store/presentation/auth/pages/constants.dart';
import 'package:shoes_store/presentation/auth/widget/product_card.dart';
import 'package:shoes_store/presentation/auth/widget/product_tile.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> products = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.baseUrl}api/products'));

      if (!mounted) return; // Check if the widget is still mounted

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        setState(() {
          products = jsonResponse.cast<Map<String, dynamic>>();
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load products: ${response.statusCode}';
        });
      }
    } catch (e) {
      if (!mounted) return; // Check if the widget is still mounted
      setState(() {
        errorMessage = 'Failed to load products: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.only(top: 20),
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${widget.username}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${widget.username}',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image_profile.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categories() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor,
                ),
                child: Text(
                  'All Shoes',
                  style: primaryTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: medium,
                  ),
                ),
              ),
              // Add other categories here
            ],
          ),
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        padding: EdgeInsets.only(top: 20),
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Text(
          'Popular Products',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: EdgeInsets.only(top: 14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              Row(
                children: products.map((product) {
                  return ProductCard(
                    idProduct: product['id'],
                    username: product['name'],
                    image: product['thumb_image'],
                    price: product['price'] != null ? '${product['price']}' : '',
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }

    Widget newArrivalsTitle() {
      return Container(
        padding: EdgeInsets.only(top: 20),
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Text(
          'New Arrivals',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      if (errorMessage.isNotEmpty) {
        return Center(
          child: Text(errorMessage, style: TextStyle(color: Colors.red)),
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: 14),
          child: Column(
            children: products.map((product) {
              return ProductTile(
                idProduct: product['id'],
                username: product['name'],
                image: product['thumb_image'],
                price: product['price'] != null ? '${product['price']}' : '',
              );
            }).toList(),
          ),
        );
      }
    }

    return ListView(
      children: [
        header(),
        categories(),
        popularProductsTitle(),
        popularProducts(),
        newArrivalsTitle(),
        newArrivals(),
      ],
    );
  }
}
