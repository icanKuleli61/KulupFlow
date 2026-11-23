
import 'package:flutter/material.dart';

class MainSayfaAppBar extends StatelessWidget {
  final bool okunmamisBildirimVar;
  final double ekranGenisligi;
  final double ekranYuksekligi;

  const MainSayfaAppBar({
    super.key,
    required this.okunmamisBildirimVar,
    required this.ekranGenisligi,
    required this.ekranYuksekligi,
  });

  @override
  Widget build(BuildContext context) {

    final double baslikBoyutu = (ekranGenisligi * 0.065).clamp(22.0, 28.0);
    final double ikonBoyutu = (ekranGenisligi * 0.07).clamp(25.0, 30.0);
    final double sagBosluk = (ekranGenisligi * 0.025).clamp(8.0, 14.0);

    return AppBar(
      backgroundColor: const Color(0xFF54258F),
      elevation: 0,

      title: Text(
        "KulupFlow",
        style: TextStyle(
          color: Colors.white,
          fontSize: baslikBoyutu,
          fontWeight: FontWeight.bold,
        ),
      ),

      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                // Bildirim sayfasına geçiş yapılacak.
              },
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: ikonBoyutu,
              ),
            ),

            if (okunmamisBildirimVar)
              Positioned(
                right: 9,
                top: 8,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),

        Padding(
          padding: EdgeInsets.only(right: sagBosluk),
          child: IconButton(
            onPressed: () {
              // Profil sayfasına geçiş yapılacak.
            },
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: ikonBoyutu,
            ),
          ),
        ),
      ],
    );
  }
}
