
import 'package:flutter/material.dart';

class Anasayfa extends StatelessWidget {
  const Anasayfa({super.key});

  // Şimdilik örnek kullanıcı bilgisi
  final String ad = "İlyas";

  // Örnek kulüp verileri
  final List<KulupModel> kulupler = const [
    KulupModel(
      ad: "Yazılım Kulübü",
      gorevSayisi: 3,
      ikon: Icons.code,
      yoneticiMi: true,
    ),
    KulupModel(
      ad: "IEEE Kulübü",
      gorevSayisi: 1,
      ikon: Icons.memory,
    ),
    KulupModel(
      ad: "Spor Kulübü",
      gorevSayisi: 0,
      ikon: Icons.emoji_events_outlined,
    ),
    KulupModel(
      ad: "Girişimcilik",
      gorevSayisi: 2,
      ikon: Icons.lightbulb_outline,
    ),
  ];

  // Örnek görev verileri
  final List<GorevModel> gorevler = const [
    GorevModel(
      baslik: "Etkinlik afişini hazırla",
      kulupAdi: "Yazılım Kulübü",
      durum: "Devam ediyor",
      tamamlandi: false,
    ),
    GorevModel(
      baslik: "Toplantı notlarını yükle",
      kulupAdi: "IEEE Kulübü",
      durum: "Tamamlandı",
      tamamlandi: true,
    ),
  ];

  // Örnek etkinlik verileri
  final List<EtkinlikModel> etkinlikler = const [
    EtkinlikModel(
      baslik: "Yazılım Geliştirme Atölyesi",
      kulupAdi: "Yazılım Kulübü",
      tarih: "28 Kasım",
      saat: "14.00",
      konum: "B-203",
    ),
    EtkinlikModel(
      baslik: "Kariyer Buluşması",
      kulupAdi: "IEEE Kulübü",
      tarih: "02 Aralık",
      saat: "13.00",
      konum: "Konferans Salonu",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Cihazın ekran ölçülerini alıyoruz.
    final Size ekranBoyutu = MediaQuery.of(context).size;
    final double ekranGenisligi = ekranBoyutu.width;
    final double ekranYuksekligi = ekranBoyutu.height;

    // Ekran boyutuna göre kontrollü boşluk ve yükseklikler.
    final double yatayBosluk = (ekranGenisligi * 0.05).clamp(16.0, 24.0);
    final double bolumAraligi = (ekranYuksekligi * 0.025).clamp(16.0, 26.0);
    final double kartAraligi = (ekranGenisligi * 0.03).clamp(10.0, 14.0);

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: bolumAraligi),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hoş geldin alanı
          HosgeldinBolumu(ad: ad),

          SizedBox(height: bolumAraligi),

          // İstatistikler
          IstatistikKartlari(
            kulupSayisi: kulupler.length,
            gorevSayisi: gorevler.where((g) => !g.tamamlandi).length,
          ),

          SizedBox(height: bolumAraligi),

          // Kulüplerim
          if (kulupler.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
              child: BolumBasligi(
                baslik: "Kulüplerim",
                butonMetni: "Tümünü gör",
                onTap: () {},
              ),
            ),
            SizedBox(height: kartAraligi),

            SizedBox(
              height: (ekranYuksekligi * 0.16).clamp(120.0, 155.0),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
                scrollDirection: Axis.horizontal,
                itemCount: kulupler.length,
                separatorBuilder: (_, __) =>
                    SizedBox(width: kartAraligi),
                itemBuilder: (context, index) {
                  return KulupKarti(kulup: kulupler[index]);
                },
              ),
            ),
          ] else
            const BosDurumMesaji(
              baslik: "Henüz bir kulübe katılmadın",
              aciklama:
                  "İlgi alanına uygun kulüpleri keşfederek kampüs hayatına katılabilirsin.",
              ikon: Icons.groups_outlined,
            ),

          SizedBox(height: bolumAraligi),

          // Görevlerim: ana sayfada yalnızca tamamlanmamış görevleri göster.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
            child: BolumBasligi(
              baslik: "Görevlerim",
              butonMetni: "Tümünü gör",
              onTap: () {},
            ),
          ),
          SizedBox(height: kartAraligi),

          if (gorevler.where((gorev) => !gorev.tamamlandi).isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
              child: Column(
                children: gorevler
                    .where((gorev) => !gorev.tamamlandi)
                    .map((gorev) => Padding(
                          padding: EdgeInsets.only(bottom: kartAraligi * 0.75),
                          child: GorevKarti(gorev: gorev),
                        ))
                    .toList(),
              ),
            )
          else
            BosDurumMesaji(
              baslik: gorevler.isEmpty
                  ? "Henüz sana görev atanmadı"
                  : "Şu anda bekleyen görevin yok",
              aciklama: gorevler.isEmpty
                  ? "Kulüp yöneticileri sana görev atadığında burada görüntüleyebilirsin."
                  : "Harika! Tamamlaman gereken aktif bir görev bulunmuyor.",
              ikon: Icons.task_alt,
            ),

          SizedBox(height: bolumAraligi * 0.75),

          // Yaklaşan etkinlikler
          Padding(
            padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
            child: BolumBasligi(
              baslik: "Yaklaşan Etkinlikler",
              butonMetni: "Tümünü gör",
              onTap: () {},
            ),
          ),
          SizedBox(height: kartAraligi),

          if (etkinlikler.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
              child: Column(
                children: etkinlikler
                    .map((etkinlik) => Padding(
                          padding: EdgeInsets.only(bottom: kartAraligi * 0.75),
                          child: EtkinlikKarti(etkinlik: etkinlik),
                        ))
                    .toList(),
              ),
            )
          else
            const BosDurumMesaji(
              baslik: "Yaklaşan etkinlik yok",
              aciklama: "Kulüplerinin yeni etkinlikleri burada görünecek.",
              ikon: Icons.event_available,
            ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// 1. MODELLER
// --------------------------------------------------

class KulupModel {
  final String ad;
  final int gorevSayisi;
  final IconData ikon;
  final bool yoneticiMi;

  const KulupModel({
    required this.ad,
    required this.gorevSayisi,
    required this.ikon,
    this.yoneticiMi = false,
  });
}

class GorevModel {
  final String baslik;
  final String kulupAdi;
  final String durum;
  final bool tamamlandi;

  const GorevModel({
    required this.baslik,
    required this.kulupAdi,
    required this.durum,
    required this.tamamlandi,
  });
}

class EtkinlikModel {
  final String baslik;
  final String kulupAdi;
  final String tarih;
  final String saat;
  final String konum;

  const EtkinlikModel({
    required this.baslik,
    required this.kulupAdi,
    required this.tarih,
    required this.saat,
    required this.konum,
  });
}

// --------------------------------------------------
// 2. HOŞ GELDİN BÖLÜMÜ
// --------------------------------------------------

class HosgeldinBolumu extends StatelessWidget {
  final String ad;

  const HosgeldinBolumu({
    super.key,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    final Size ekranBoyutu = MediaQuery.of(context).size;
    final double yukseklik =
        (ekranBoyutu.height * 0.20).clamp(145.0, 190.0);
    final double yatayBosluk =
        (ekranBoyutu.width * 0.05).clamp(16.0, 24.0);
    final double baslikBoyutu =
        (ekranBoyutu.width * 0.058).clamp(20.0, 25.0);

    return SizedBox(
      height: yukseklik,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "lib/images/giris_anasayfa.png",
            fit: BoxFit.cover,
          ),

          Container(
            padding: EdgeInsets.all(yatayBosluk),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF54258F).withOpacity(0.90),
                  const Color(0xFF54258F).withOpacity(0.55),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(yatayBosluk),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Merhaba, ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: baslikBoyutu,
                    ),
                    children: [
                      TextSpan(
                        text: "$ad 👋",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: (ekranBoyutu.height * 0.01).clamp(6.0, 10.0)),
                Text(
                  "Kulüp çalışmalarına kaldığın yerden devam et.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (ekranBoyutu.width * 0.034).clamp(12.0, 15.0),
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

// --------------------------------------------------
// 3. İSTATİSTİK KARTLARI
// --------------------------------------------------

class IstatistikKartlari extends StatelessWidget {
  final int kulupSayisi;
  final int gorevSayisi;

  const IstatistikKartlari({
    super.key,
    required this.kulupSayisi,
    required this.gorevSayisi,
  });

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double yatayBosluk = (ekranGenisligi * 0.05).clamp(16.0, 24.0);
    final double kartAraligi = (ekranGenisligi * 0.03).clamp(10.0, 14.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
      child: Row(
        children: [
          Expanded(
            child: IstatistikKarti(
              baslik: "Kulüplerim",
              sayi: kulupSayisi,
              ikon: Icons.groups_outlined,
              renk: const Color(0xFF8B5CF6),
              arkaPlan: const Color(0xFFEDE5FA),
            ),
          ),
          SizedBox(width: kartAraligi),
          Expanded(
            child: IstatistikKarti(
              baslik: "Aktif görevim",
              sayi: gorevSayisi,
              ikon: Icons.assignment_outlined,
              renk: const Color(0xFFC18A20),
              arkaPlan: const Color(0xFFF8F2E3),
            ),
          ),
        ],
      ),
    );
  }
}

class IstatistikKarti extends StatelessWidget {
  final String baslik;
  final int sayi;
  final IconData ikon;
  final Color renk;
  final Color arkaPlan;

  const IstatistikKarti({
    super.key,
    required this.baslik,
    required this.sayi,
    required this.ikon,
    required this.renk,
    required this.arkaPlan,
  });

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double icBosluk = (ekranGenisligi * 0.04).clamp(12.0, 18.0);

    return Container(
      padding: EdgeInsets.all(icBosluk),
      decoration: BoxDecoration(
        color: arkaPlan,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: renk, size: (ekranGenisligi * 0.065).clamp(23.0, 29.0)),
          SizedBox(height: (ekranGenisligi * 0.025).clamp(8.0, 11.0)),
          Text(
            sayi.toString(),
            style: TextStyle(
              fontSize: (ekranGenisligi * 0.067).clamp(24.0, 30.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: (ekranGenisligi * 0.01).clamp(3.0, 5.0)),
          Text(
            baslik,
            style: TextStyle(
              color: Colors.black54,
              fontSize: (ekranGenisligi * 0.031).clamp(11.0, 14.0),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// 4. BÖLÜM BAŞLIĞI
// --------------------------------------------------

class BolumBasligi extends StatelessWidget {
  final String baslik;
  final String? butonMetni;
  final VoidCallback? onTap;

  const BolumBasligi({
    super.key,
    required this.baslik,
    this.butonMetni,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double baslikBoyutu = (ekranGenisligi * 0.047).clamp(17.0, 20.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          baslik,
          style: TextStyle(
            fontSize: baslikBoyutu,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (butonMetni != null)
          TextButton(
            onPressed: onTap,
            child: Text(
              "$butonMetni →",
              style: TextStyle(
                color: Color(0xFF8B5CF6),
                fontSize: (ekranGenisligi * 0.032).clamp(12.0, 14.0),
              ),
            ),
          ),
      ],
    );
  }
}

// --------------------------------------------------
// 5. KULÜP KARTI
// --------------------------------------------------

class KulupKarti extends StatelessWidget {
  final KulupModel kulup;

  const KulupKarti({
    super.key,
    required this.kulup,
  });

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double kartGenisligi = (ekranGenisligi * 0.38).clamp(140.0, 190.0);
    final double icBosluk = (ekranGenisligi * 0.032).clamp(10.0, 14.0);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        // İleride kulüp detay sayfasına gidecek.
      },
      child: Container(
        width: kartGenisligi,
        padding: EdgeInsets.all(icBosluk),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  kulup.ikon,
                  color: const Color(0xFF8B5CF6),
                  size: (ekranGenisligi * 0.065).clamp(23.0, 29.0),
                ),
                if (kulup.yoneticiMi)
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: (ekranGenisligi * 0.043).clamp(16.0, 19.0),
                  ),
              ],
            ),
            SizedBox(height: (ekranGenisligi * 0.025).clamp(8.0, 11.0)),
            Text(
              kulup.ad,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (ekranGenisligi * 0.032).clamp(12.0, 14.0),
              ),
            ),
            SizedBox(height: (ekranGenisligi * 0.012).clamp(4.0, 6.0)),
            Text(
              "${kulup.gorevSayisi} aktif görev",
              style: TextStyle(
                color: Colors.black54,
                fontSize: (ekranGenisligi * 0.028).clamp(10.0, 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------
// 6. GÖREV KARTI
// --------------------------------------------------

class GorevKarti extends StatelessWidget {
  final GorevModel gorev;

  const GorevKarti({
    super.key,
    required this.gorev,
  });

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double icBosluk = (ekranGenisligi * 0.04).clamp(12.0, 16.0);
    final Color durumRengi = gorev.tamamlandi
        ? Colors.green
        : Colors.deepOrange;

    return Container(
      padding: EdgeInsets.all(icBosluk),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gorev.baslik,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: (ekranGenisligi * 0.038).clamp(14.0, 16.0),
            ),
          ),
          SizedBox(height: (ekranGenisligi * 0.025).clamp(8.0, 11.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  gorev.kulupAdi,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: (ekranGenisligi * 0.03).clamp(11.0, 13.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: durumRengi.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  gorev.durum,
                  style: TextStyle(
                    color: durumRengi,
                    fontSize: (ekranGenisligi * 0.028).clamp(10.0, 12.0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// 7. ETKİNLİK KARTI
// --------------------------------------------------

class EtkinlikKarti extends StatelessWidget {
  final EtkinlikModel etkinlik;

  const EtkinlikKarti({
    super.key,
    required this.etkinlik,
  });

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double icBosluk = (ekranGenisligi * 0.037).clamp(12.0, 16.0);
    final double ikonBoyutu = (ekranGenisligi * 0.065).clamp(23.0, 29.0);

    return Container(
      padding: EdgeInsets.all(icBosluk),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all((ekranGenisligi * 0.025).clamp(8.0, 11.0)),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE5FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event_outlined,
              color: Color(0xFF8B5CF6),
              size: ikonBoyutu,
            ),
          ),
          SizedBox(width: (ekranGenisligi * 0.03).clamp(10.0, 14.0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  etkinlik.baslik,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: (ekranGenisligi * 0.035).clamp(13.0, 15.0),
                  ),
                ),
                SizedBox(height: (ekranGenisligi * 0.012).clamp(4.0, 6.0)),
                Text(
                  "${etkinlik.kulupAdi} · ${etkinlik.konum}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: (ekranGenisligi * 0.028).clamp(10.0, 12.0),
                  ),
                ),
                SizedBox(height: (ekranGenisligi * 0.01).clamp(3.0, 5.0)),
                Text(
                  "${etkinlik.tarih} · ${etkinlik.saat}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
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

// --------------------------------------------------
// 8. BOŞ DURUM MESAJI
// --------------------------------------------------

class BosDurumMesaji extends StatelessWidget {
  final String baslik;
  final String aciklama;
  final IconData ikon;

  const BosDurumMesaji({
    super.key,
    required this.baslik,
    required this.aciklama,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double yatayBosluk = (ekranGenisligi * 0.05).clamp(16.0, 24.0);
    final double icBosluk = (ekranGenisligi * 0.05).clamp(16.0, 22.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: yatayBosluk),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(icBosluk),
        decoration: BoxDecoration(
          color: const Color(0xFFF3EFF9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(
              ikon,
              size: (ekranGenisligi * 0.075).clamp(28.0, 34.0),
              color: const Color(0xFF8B5CF6),
            ),
            SizedBox(height: (ekranGenisligi * 0.02).clamp(6.0, 9.0)),
            Text(
              baslik,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: (ekranGenisligi * 0.037).clamp(14.0, 16.0),
              ),
            ),
            SizedBox(height: (ekranGenisligi * 0.012).clamp(4.0, 6.0)),
            Text(
              aciklama,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: (ekranGenisligi * 0.03).clamp(11.0, 13.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
