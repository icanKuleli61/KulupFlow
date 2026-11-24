import 'package:flutter/material.dart';
import 'package:kulup_flow/Sayfalar/Anasayfa.dart';
import 'package:kulup_flow/Sayfalar/klupKesfet.dart';
import 'package:kulup_flow/Sayfalar/kluplerim.dart';
import 'package:kulup_flow/mainSayfaAppBar.dart';

class MainNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainNavigatorState();
  }
}

class _MainNavigatorState extends State<MainNavigator> {
  int secilenIndex = 0;
  var sayfalar = [Anasayfa(),Klupkesfet(),Kluplerim()];
  @override
  Widget build(BuildContext context) {
    final Size ekranBoyutu = MediaQuery.of(context).size;
    final double ekranGenisligi = ekranBoyutu.width;
    final double ekranYuksekligi = ekranBoyutu.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MainSayfaAppBar(
          okunmamisBildirimVar: true,
          ekranGenisligi: ekranGenisligi,
          ekranYuksekligi: ekranYuksekligi,
        ),
      ),
      body: sayfalar[secilenIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF54258F),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFFC8B5E3),

        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),

        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,size: 24,),
            label: "Anasayfa",
            tooltip: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "Kulüpleri Keşfet",
            tooltip: "Kulüpleri Keşfet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: "Kulüplerim",
            tooltip: "Kulüplerim",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
            tooltip: "Profil",
          ),
        ],
        currentIndex: secilenIndex,
        onTap: (value) {
          setState(() {
            secilenIndex = value;
          });
        },
      ),
    );
  }
}
