
import 'package:flutter/material.dart';

class KayitSayfasi extends StatefulWidget {
  const KayitSayfasi({super.key});

  @override
  State<KayitSayfasi> createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController adSoyad = TextEditingController();
  final TextEditingController takmaIsim = TextEditingController();
  final TextEditingController ePosta = TextEditingController();
  final TextEditingController sifre = TextEditingController();
  final TextEditingController sifreTekrar = TextEditingController();

  // Şimdilik test verisi. İleride API'den gelecek.
  final List<String> universiteler = [
    "Kocaeli Üniversitesi",
    "Kocaeli Sağlık ve Teknoloji Üniversitesi",
    "Sakarya Üniversitesi",
    "İstanbul Üniversitesi",
    "İstanbul Teknik Üniversitesi",
    "Marmara Üniversitesi",
    "Ankara Üniversitesi",
    "Hacettepe Üniversitesi",
    "Bursa Uludağ Üniversitesi",
    "Eskişehir Osmangazi Üniversitesi",
  ];

  String? universiteAdi;

  bool sifreGizli = true;
  bool sifreTekrarGizli = true;
  bool kosullariKabulEttiMi = false;

  @override
  void dispose() {
    adSoyad.dispose();
    takmaIsim.dispose();
    ePosta.dispose();
    sifre.dispose();
    sifreTekrar.dispose();

    super.dispose();
  }

  // Ortak input tasarımı
  InputDecoration alanDekorasyonu({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.9),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blue.shade400,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red.shade400,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.red.shade400,
          width: 2,
        ),
      ),
    );
  }

  // Üniversite arama ekranını aç
  Future<String?> universiteSec() async {
    return showSearch<String?>(
      context: context,
      delegate: UniversiteArama(universiteler),
    );
  }

  // Kayıt işlemi
  void _kayitOl() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (sifre.text != sifreTekrar.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Şifreler birbiriyle eşleşmiyor!"),
        ),
      );
      return;
    }

    if (!kosullariKabulEttiMi) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Kullanım koşullarını kabul etmelisin.",
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Form doğrulaması başarılı!"),
      ),
    );

    // İleride Spring Boot API'sine kayıt isteği göndereceğiz.
  }

  @override
  Widget build(BuildContext context) {
    final Size ekranBoyutu = MediaQuery.of(context).size;

    final double ekranGenisligi = ekranBoyutu.width;
    final double ekranYuksekligi = ekranBoyutu.height;

    final double logoBoyutu =
        (ekranGenisligi * 0.20).clamp(65.0, 90.0).toDouble();

    final double baslikBoyutu =
        (ekranGenisligi * 0.065).clamp(23.0, 30.0).toDouble();

    final double formGenisligi =
        (ekranGenisligi * 0.88).clamp(0.0, 440.0).toDouble();

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Stack(
        children: [
          // Arka plan
          Positioned.fill(
            child: Image.asset(
              "lib/images/login_ekran.png",
              fit: BoxFit.cover,
            ),
          ),

          // Sayfa içerikleri
          SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,

              padding: EdgeInsets.symmetric(
                horizontal: ekranGenisligi * 0.06,
                vertical: ekranYuksekligi * 0.025,
              ),

              child: Center(
                child: SizedBox(
                  width: formGenisligi,

                  child: Column(
                    children: [
                      // Logo
                      Image.asset(
                        "lib/images/splash_ikonu.png",
                        height: logoBoyutu,
                        width: logoBoyutu,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 12),

                      // Başlık
                      Text(
                        "Aramıza Katıl! 🎓",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: baslikBoyutu,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF39245C),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Açıklama
                      Text(
                        "Kulüp hayatına katılmak için hesabını oluştur.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: (ekranGenisligi * 0.038)
                              .clamp(13.0, 17.0)
                              .toDouble(),
                          color: const Color(0xFF796A8D),
                        ),
                      ),

                      SizedBox(
                        height: ekranYuksekligi * 0.035,
                      ),

                      // Kayıt formu
                      Form(
                        key: _formKey,

                        child: Column(
                          children: [
                            // Ad Soyad
                            TextFormField(
                              controller: adSoyad,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,

                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return "Ad Soyad alanı boş bırakılamaz";
                                }

                                if (value.trim().length < 5) {
                                  return "En az 5 karakter girmelisin";
                                }

                                return null;
                              },

                              decoration: alanDekorasyonu(
                                label: "Ad Soyad",
                                hint: "Ad ve soyadınızı giriniz",
                                icon: Icons.person_outline,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Takma ad
                            TextFormField(
                              controller: takmaIsim,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,

                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return "Takma ad alanı boş bırakılamaz";
                                }

                                return null;
                              },

                              decoration: alanDekorasyonu(
                                label: "Takma Ad",
                                hint: "Benzersiz kullanıcı adınız",
                                icon: Icons.alternate_email,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Üniversite seçimi
                            FormField<String>(
                              initialValue: universiteAdi,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Lütfen üniversiteni seç";
                                }

                                return null;
                              },

                              builder: (field) {
                                return InkWell(
                                  borderRadius:
                                      BorderRadius.circular(10),

                                  onTap: () async {
                                    FocusScope.of(context).unfocus();

                                    final String? secim =
                                        await universiteSec();

                                    if (!mounted || secim == null) {
                                      return;
                                    }

                                    setState(() {
                                      universiteAdi = secim;
                                    });

                                    field.didChange(secim);
                                  },

                                  child: InputDecorator(
                                    decoration: alanDekorasyonu(
                                      label: "Üniversiteni Seç",
                                      hint: "Üniversitenizi seçiniz",
                                      icon: Icons.school_outlined,
                                    ).copyWith(
                                      errorText: field.errorText,
                                    ),

                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            universiteAdi ??
                                                "Üniversitenizi seçiniz",

                                            style: TextStyle(
                                              fontSize: 16,
                                              color: universiteAdi == null
                                                  ? Colors.grey
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ),

                                        const Icon(
                                          Icons.arrow_drop_down,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 12),

                            // E-posta
                            TextFormField(
                              controller: ePosta,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,

                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return "E-posta alanı boş bırakılamaz";
                                }

                                if (!RegExp(
                                  r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                ).hasMatch(value.trim())) {
                                  return "Geçerli bir e-posta giriniz";
                                }

                                return null;
                              },

                              decoration: alanDekorasyonu(
                                label: "Üniversite E-postası",
                                hint: "E-posta adresinizi giriniz",
                                icon: Icons.email_outlined,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Şifre
                            TextFormField(
                              controller: sifre,
                              obscureText: sifreGizli,
                              textInputAction: TextInputAction.next,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Şifre alanı boş bırakılamaz";
                                }

                                if (value.length < 8) {
                                  return "Şifre en az 8 karakter olmalı";
                                }

                                return null;
                              },

                              decoration: alanDekorasyonu(
                                label: "Şifre",
                                hint: "Şifrenizi oluşturunuz",
                                icon: Icons.lock_outline,
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      sifreGizli = !sifreGizli;
                                    });
                                  },

                                  icon: Icon(
                                    sifreGizli
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Şifre Tekrarı
                            TextFormField(
                              controller: sifreTekrar,
                              obscureText: sifreTekrarGizli,
                              textInputAction: TextInputAction.done,

                              onFieldSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Şifrenizi tekrar giriniz";
                                }

                                if (value != sifre.text) {
                                  return "Şifreler birbiriyle eşleşmiyor";
                                }

                                return null;
                              },

                              decoration: alanDekorasyonu(
                                label: "Şifre Tekrarı",
                                hint: "Şifrenizi tekrar giriniz",
                                icon: Icons.lock_outline,
                              ).copyWith(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      sifreTekrarGizli =
                                          !sifreTekrarGizli;
                                    });
                                  },

                                  icon: Icon(
                                    sifreTekrarGizli
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Kullanım koşulları
                            CheckboxListTile(
                              value: kosullariKabulEttiMi,
                              contentPadding: EdgeInsets.zero,

                              controlAffinity:
                                  ListTileControlAffinity.leading,

                              activeColor: const Color(0xFF7136C8),

                              onChanged: (value) {
                                setState(() {
                                  kosullariKabulEttiMi =
                                      value ?? false;
                                });
                              },

                              title: const Text(
                                "Kullanım Koşulları ve Gizlilik Politikası'nı okudum, kabul ediyorum.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF51416B),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Kayıt butonu
                            SizedBox(
                              width: double.infinity,
                              height: 54,

                              child: ElevatedButton(
                                onPressed: _kayitOl,

                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF7136C8),
                                  foregroundColor: Colors.white,

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                ),

                                child: const Text(
                                  "Hesap Oluştur",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Giriş sayfasına dönüş
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },

                              child: const Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    color: Color(0xFF796A8D),
                                  ),

                                  children: [
                                    TextSpan(
                                      text: "Zaten hesabın var mı? ",
                                    ),

                                    TextSpan(
                                      text: "Giriş Yap",
                                      style: TextStyle(
                                        color: Color(0xFF7136C8),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
          ),
        ],
      ),
    );
  }
}

// Üniversite arama ekranı
class UniversiteArama extends SearchDelegate<String?> {
  final List<String> universiteler;

  UniversiteArama(this.universiteler);

  @override
  String get searchFieldLabel => "Üniversite ara...";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return universiteListesi();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return universiteListesi();
  }

  Widget universiteListesi() {
    final List<String> sonuclar = universiteler.where((universite) {
      return universite.toLowerCase().contains(
            query.trim().toLowerCase(),
          );
    }).toList();

    if (sonuclar.isEmpty) {
      return const Center(
        child: Text("Üniversite bulunamadı"),
      );
    }

    return ListView.builder(
      itemCount: sonuclar.length,

      itemBuilder: (context, index) {
        final String universite = sonuclar[index];

        return ListTile(
          leading: const Icon(
            Icons.school_outlined,
            color: Color(0xFF7136C8),
          ),

          title: Text(universite),

          onTap: () {
            close(context, universite);
          },
        );
      },
    );
  }
}
