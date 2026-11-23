import 'package:flutter/material.dart';
import 'package:kulup_flow/mainSayfaAppBar.dart';

class MainNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainNavigatorState();
  }
}

class _MainNavigatorState extends State<MainNavigator> {
  int secilenIndex = 0;
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
      body: Center(),
   
    );
  }
}
