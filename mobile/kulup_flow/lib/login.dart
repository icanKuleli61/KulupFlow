import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ePosta = TextEditingController();
  final TextEditingController _sifre = TextEditingController();
  late final TapGestureRecognizer _kayitTapRecognizer;
  bool _sifreGizli = true;

  @override
  void initState() {
    super.initState();
    _kayitTapRecognizer = TapGestureRecognizer()..onTap =() {
      print("Kayıt ol Tıklandı.");
    };
  }

  @override
  void dispose() {
    _ePosta.dispose();
    _sifre.dispose();
    _kayitTapRecognizer.dispose();
    super.dispose();
  }

  void _girisYap() {
    if (_formKey.currentState!.validate()) {
      final email = _ePosta.text.trim();
      final password = _sifre.text;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Giriş deneniyor: $email")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size ekranBoyutu = MediaQuery.of(context).size;
    final double ekranGenisligi = ekranBoyutu.width;
    final double ekranYuksekligi = ekranBoyutu.height;
    final double ustGuvenliBosluk = MediaQuery.of(context).padding.top;

    // Ekran boyutuna göre dinamik ölçüler
    final double yatayPadding = ekranGenisligi * 0.06;
    final double logoBoyutu = (ekranGenisligi * 0.27).clamp(84.0, 136.0);
    final double baslikBoyutu = (ekranGenisligi * 0.065).clamp(22.0, 30.0);
    final double butonYuksekligi = (ekranYuksekligi * 0.065).clamp(46.0, 58.0);
    final double alanArasiBosluk = ekranYuksekligi * 0.02;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "lib/images/login_ekran.png",
            width: ekranGenisligi,
            height: ekranYuksekligi,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: yatayPadding,
                vertical: ekranYuksekligi * 0.025,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      ekranYuksekligi -
                      ustGuvenliBosluk -
                      (ekranYuksekligi * 0.05),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/images/splash_ikonu.png",
                      width: logoBoyutu,
                      height: logoBoyutu,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: ekranYuksekligi * 0.02),
                    Text(
                      "Tekrar Hoş Geldin! 👋",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: baslikBoyutu,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF39245C),
                      ),
                    ),
                    SizedBox(height: ekranYuksekligi * 0.01),
                    Text(
                      "Kulüp hayatına kaldığın yerden devam et.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (ekranGenisligi * 0.038).clamp(13.0, 17.0),
                        color: const Color(0xFF796A8D),
                      ),
                    ),
                    SizedBox(height: ekranYuksekligi * 0.006),
                    Text(
                      "Üniversite hayatını birlikte keşfet!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (ekranGenisligi * 0.041).clamp(14.0, 18.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF7136C8),
                      ),
                    ),
                    SizedBox(height: ekranYuksekligi * 0.035),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _ePosta,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "E-posta adresi boş bırakılamaz";
                              }
                              if (!value.contains("@")) {
                                return "Geçerli bir e-posta adresi giriniz";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "E-posta",
                              hintText: "E-mail Adresinizi Giriniz",
                              prefixIcon: const Icon(Icons.email_outlined),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blue.shade400,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red.shade400,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red.shade400,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: alanArasiBosluk),
                          TextFormField(
                            controller: _sifre,
                            obscureText: _sifreGizli,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _girisYap(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Şifre boş bırakılamaz";
                              }
                              if (value.length < 6) {
                                return "Şifre en az 6 karakter olmalı";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Şifre",
                              hintText: "Şifrenizi Giriniz",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _sifreGizli = !_sifreGizli;
                                  });
                                },
                                icon: Icon(
                                  _sifreGizli
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.blue.shade400,
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red.shade400,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  ekranGenisligi * 0.025,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red.shade400,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: ekranYuksekligi * 0.03),
                          SizedBox(
                            width: ekranGenisligi,
                            height: butonYuksekligi,
                            child: ElevatedButton(
                              onPressed: _girisYap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7136C8),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    ekranGenisligi * 0.025,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Giriş Yap",
                                style: TextStyle(
                                  fontSize: (ekranGenisligi * 0.043).clamp(
                                    15.0,
                                    19.0,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: ekranYuksekligi * 0.03),

                          Text.rich(
                            TextSpan(
                              text: "Kayıtlı Değil misin ? ",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF796A8D),
                              ),
                              children: [
                                TextSpan(
                                  text: "Kayıt ol",
                                  style: const TextStyle(
                                    color: Color(0xFF7136C8),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFF7136C8),
                                  ),
                                  recognizer: _kayitTapRecognizer,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
