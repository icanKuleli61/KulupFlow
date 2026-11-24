
import 'package:flutter/material.dart';

class Klupkesfet extends StatelessWidget {
  Klupkesfet({super.key});

  // Şimdilik örnek veriler.
  // Daha sonra backend'den gelecek.
  final List<Map<String, String>> klupler = [
    {
      "ad": "Yazılım Kulübü",
      "resim": "",
    },
    {
      "ad": "IEEE Kulübü",
      "resim": "",
    },
    {
      "ad": "Spor Kulübü",
      "resim": "",
    },
    {
      "ad": "Kültür ve Sanat Kulübü",
      "resim": "",
    },
    {
      "ad": "Girişimcilik Kulübü",
      "resim": "",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;

    final double yatayBosluk =
        (ekranGenisligi * 0.05).clamp(16.0, 24.0);

    final double kartAraligi =
        (ekranGenisligi * 0.035).clamp(10.0, 16.0);

    final double baslikBoyutu =
        (ekranGenisligi * 0.055).clamp(19.0, 23.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FB),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(yatayBosluk),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kulüpleri Keşfet",
                style: TextStyle(
                  fontSize: baslikBoyutu,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF25202D),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Üniversitendeki kulüpleri keşfet ve aralarına katıl.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20),

              // Arama alanı
              TextField(
                decoration: InputDecoration(
                  hintText: "Kulüp ara...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Kulüp sayısı
              Text(
                "Kulüpler (${klupler.length})",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              // Dinamik kulüp kartları
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: klupler.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: kartAraligi,
                  mainAxisSpacing: kartAraligi,
                  childAspectRatio: 0.88,
                ),

                itemBuilder: (context, index) {
                  final kulup = klupler[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // Daha sonra kulüp detay sayfasına gidecek.
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.06),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kulüp resmi
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),

                              child: kulup["resim"]!.isNotEmpty
                                  ? Image.network(
                                      kulup["resim"]!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stack) {
                                        return const KulupResimPlaceholder();
                                      },
                                    )
                                  : const KulupResimPlaceholder(),
                            ),
                          ),

                          // Kulüp adı
                          Padding(
                            padding: const EdgeInsets.all(12),

                            child: Text(
                              kulup["ad"]!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Resim bulunamadığında gösterilecek alan.
class KulupResimPlaceholder extends StatelessWidget {
  const KulupResimPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFEDE5FA),
      alignment: Alignment.center,
      child: const Icon(
        Icons.groups_outlined,
        size: 48,
        color: Color(0xFF9257E8),
      ),
    );
  }
}
