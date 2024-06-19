import 'package:flutter/material.dart';
import 'package:shoes_store/core/theme/theme.dart';
import 'package:shoes_store/presentation/routes/app_pages.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({Key? key});

  PreferredSizeWidget header() {
    return AppBar(
      backgroundColor: backgroundColor1,
      centerTitle: true,
      title: Text(
        'Checkout Berhasil!',
      ),
      elevation: 0,
    );
  }

  Widget content(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon_emptycart.png',
            width: 80,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Kamu Telah Melakukan Transaksi!',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Tunggu dirumah selagi kami menyiapkan sepatu idamanmu!',
            style: secondaryTextStyle,
            textAlign: TextAlign.center,
          ),
          Container(
            width: 196,
            height: 44,
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, Routes.main());
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Pesan Sepatu Lainnya',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
          Container(
            width: 196,
            height: 44,
            margin: EdgeInsets.only(
              top: 12,
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff39374B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Lihat Pesanan Saya',
                style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                    color: Color(0xffB7B86BF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(context),
    );
  }
}
