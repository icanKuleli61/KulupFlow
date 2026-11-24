
import 'package:flutter/material.dart';

class Kluplerim extends StatelessWidget {
  Kluplerim({super.key});

  final List<Map<String, dynamic>> klupler = [
    {
      "ad": "Yazılım Kulübü",
      "universite": "Kocaeli Üniversitesi",
      "resim": null,
      "gorevSayisi": 12,
      "etkinlikSayisi": 3,
    },
    {
      "ad": "Tarih Kulübü",
      "universite": "Kocaeli Üniversitesi",
      "resim": null,
      "gorevSayisi": 4,
      "etkinlikSayisi": 2,
    },
    {
      "ad": "Müzik Kulübü",
      "universite": "Kocaeli Üniversitesi",
      "resim": null,
      "gorevSayisi": 0,
      "etkinlikSayisi": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double ekranGenisligi = constraints.maxWidth;

          final double logoBoyutu =
              (ekranGenisligi * 0.165).clamp(55.0, 65.0);

          final double butonGenisligi =
              (ekranGenisligi * 0.20).clamp(70.0, 80.0);

          final double yatayBosluk =
              (ekranGenisligi * 0.025).clamp(8.0, 12.0);

          if (klupler.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.groups_outlined,
                    size: 60,
                    color: Colors.black38,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Henüz bir kulübe üye değilsin.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 6),
            itemCount: klupler.length,
            itemBuilder: (context, index) {
              final klup = klupler[index];

              final String klupAdi = klup["ad"];
              final String universite = klup["universite"];
              final String? resimUrl = klup["resim"];

              final int gorevSayisi = klup["gorevSayisi"];
              final int etkinlikSayisi = klup["etkinlikSayisi"];

              return InkWell(
                onTap: () {
                  debugPrint("$klupAdi tıklandı");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: yatayBosluk,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      // Kulüp logosu
                      Container(
                        width: logoBoyutu,
                        height: logoBoyutu,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE5FA),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: resimUrl != null && resimUrl.isNotEmpty
                            ? Image.network(
                                resimUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.groups_outlined,
                                    color: Colors.deepPurple,
                                    size: 34,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.groups_outlined,
                                color: Colors.deepPurple,
                                size: 34,
                              ),
                      ),

                      SizedBox(width: yatayBosluk),

                      // Kulüp bilgileri
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              klupAdi,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              universite,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE3F3E6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "Üye",
                                    style: TextStyle(
                                      color: Color(0xFF278344),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    "$gorevSayisi görev · $etkinlikSayisi etkinlik",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: yatayBosluk),

                      // Kulübe git
                      SizedBox(
                        width: butonGenisligi,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.black54,
                              size: 26,
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "Kulübe git",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
