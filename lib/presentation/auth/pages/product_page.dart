import 'dart:ffi';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shoes_store/core/theme/theme.dart';
import 'package:shoes_store/presentation/auth/pages/config.dart';
import 'package:shoes_store/presentation/auth/pages/constants.dart';
import 'package:shoes_store/presentation/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductPage extends StatefulWidget {
  final int idProduct;

  ProductPage({required this.idProduct});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Map<String, dynamic>? product;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    fetchAndPrintProduct(widget.idProduct);
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> _addToCart(BuildContext context) async {
    // Ambil ID user dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    // print(product?['id']);
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID not found. Please login first.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/carts'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'customer_id': userId,
        'product_id': product?['id'], // Asumsikan `product` memiliki `id`
        'quantity': 1, // Anda bisa menggantinya dengan quantity yang dipilih
      }),
    );
    // print(userId);
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added to cart!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product to cart.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> fetchAndPrintProduct(int id) async {
    try {
      final response =
          await http.get(Uri.parse('${Constants.baseUrl}api/products/$id'));

      if (response.statusCode == 200 && _isMounted) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse.toString()); // Print raw data from API

        // Check if the response is a map with product details
        if (jsonResponse is Map<String, dynamic>) {
          if (_isMounted) {
            setState(() {
              product = jsonResponse;
            });
          }
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        if (_isMounted) {
          print('Failed to load product: ${response.statusCode}');
          throw Exception('Failed to load product: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (_isMounted) {
        print('Error fetching product: $e');
        throw Exception('Failed to load product: $e');
      }
    }
  }

  final List<String> images = [
    'assets/image_shoes2.png',
  ];

  List familiarShoes = [
    'assets/image_shoes2.png',
  ];

  int currentIndex = 0;
  bool isWishlist = false;

  @override
  Widget build(BuildContext context) {
    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: backgroundColor3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        'assets/icon_close.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/icon_success.png',
                    width: 100,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Berhasil!',
                    style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Item Berhasil Ditambahkan!',
                    style: secondaryTextStyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Keranjang',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    Widget familiarShoesCard(String imageUrl) {
      return Container(
        width: 54,
        height: 54,
        margin: EdgeInsets.only(
          right: 16,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      );
    }

    Widget header() {
      int index = -1;

      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, Routes.main());
                  },
                  icon: Image.asset(
                    'assets/icon_back.png',
                    width: 22,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, Routes.cart());
                  },
                  icon: Image.asset(
                    'assets/icon_bag.png',
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: [
              Image.network(
                '${Constants.baseUrl}' + product!['thumb_image'],
                width: MediaQuery.of(context).size.width,
                height: 310,
                fit: BoxFit.cover,
              ),
            ],
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget content() {
      if (product == null) {
        return Center(child: CircularProgressIndicator());
      }

      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            // Note: Header
            Container(
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!['name'],
                          style: primaryTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: semiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isWishlist = !isWishlist;
                      });

                      if (isWishlist) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: secondaryColor,
                            content: Text(
                              'Item Telah Ditambahkan ke Wishlist!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: alertColor,
                            content: Text(
                              'Item Telah Dihapus dari Wishlist!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: Image.asset(
                      isWishlist
                          ? 'assets/button_wishlist.png'
                          : 'assets/button_wishlist2.png',
                      width: 46,
                    ),
                  ),
                ],
              ),
            ),
            // Note : Price

            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 20,
                left: defaultMargin,
                right: defaultMargin,
              ),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Harga Mulai Dari',
                    style: primaryTextStyle,
                  ),
                  Text(
                    'Rp. ${product!['price']}',
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            // Note : Description
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    product!['long_description'],
                    style: subtitleTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            // Note: Familiar Shoes
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                    ),
                    child: Text(
                      'Sepatu Serupa',
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: familiarShoes.map((image) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: image == familiarShoes.first
                                ? defaultMargin
                                : 0,
                          ),
                          child: familiarShoesCard(image),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Note: Buttons

            Container(
              width: double.infinity,
              margin: EdgeInsets.all(defaultMargin),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, Routes.chat());
                    },
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/button_chat.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      height: 54,
                      child: TextButton(
                        onPressed: () {
                          _addToCart(context);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: primaryColor,
                        ),
                        child: Text(
                          'Add to Cart',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor6,
      body: product == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                header(),
                content(),
              ],
            ),
    );
  }
}
