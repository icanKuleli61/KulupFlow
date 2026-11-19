import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MySplashScreen();
  }
}

class _MySplashScreen extends State<MySplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _buyumeDegeri;
  late Animation<double> _yaziOpaklik;
  late Animation<Offset> _yaziKayma;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    );

    _buyumeDegeri = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _yaziOpaklik = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.30, 0.55, curve: Curves.easeIn),
      ),
    );

    _yaziKayma = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.30, 0.55, curve: Curves.easeOut),
          ),
        );

    _controller.addStatusListener((status) {
      if(status ==  AnimationStatus.completed){
        print("Animasyon bitti");
      }
    },);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final logoSize = (screenWidth * 0.45).clamp(130.0, 190.0);
    final logoTextBosluk = screenWidth * 0.045;
    final textlerArasiBosluk = screenWidth * 0.02;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/images/splash_backgroud.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _buyumeDegeri,
                  child: Image.asset(
                    "lib/images/splash_ikonu.png",
                    width: logoSize,
                    height: logoSize,
                  ),
                ),

                SizedBox(height: logoTextBosluk),

                FadeTransition(
                  opacity: _yaziOpaklik,
                  child: SlideTransition(
                    position: _yaziKayma,
                    child: Text(
                      "KulupFlow",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7136C8),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: textlerArasiBosluk),

                FadeTransition(
                  opacity: _yaziOpaklik,
                  child: Text(
                    "Kampüsün, kulüplerin, senin!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF51416B),
                    ),
                  ),
                ),

                SizedBox(height: textlerArasiBosluk),

                FadeTransition(
                  opacity: _yaziOpaklik,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.10,
                    ),
                    child: Text(
                      "Üniversite kulüplerini keşfet, etkinliklere katıl ve kampüs hayatını birlikte yaşa.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF796A8D),
                        height: 1.5,
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
}
