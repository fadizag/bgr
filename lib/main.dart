import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const BgrApp());
}

class BgrApp extends StatelessWidget {
  const BgrApp({super.key});

  @override
  Widget build(BuildContext context) {
    const olive = Color(0xFF59633A);
    const cream = Color(0xFFF7F4EC);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BGR - إزالة الخلفية',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: olive, surface: cream),
        scaffoldBackgroundColor: cream,
        appBarTheme: const AppBarTheme(
          backgroundColor: cream,
          foregroundColor: Color(0xFF292B22),
          centerTitle: false,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: olive,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  Future<void> _pickImages() async {
    final images = await _picker.pickMultiImage(imageQuality: 100);
    if (!mounted || images.isEmpty) return;
    setState(() => _selectedImages = images);
  }

  void _showEngineNotReady() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم تجهيز اختيار مجموعة صور. ربط محرك إزالة الخلفية هو الخطوة التالية.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasImages = _selectedImages.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.auto_fix_high_rounded, size: 27),
            SizedBox(width: 10),
            Text('BGR', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'حول التطبيق',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'BGR',
              applicationVersion: '0.1.0',
              applicationLegalese: 'تطبيق لإزالة خلفية الصور',
            ),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'خلي المنتج يبرز',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'اختر عدة صور مرة واحدة، وجهّزها لخلفية بيضاء أو شفافة.',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              constraints: const BoxConstraints(minHeight: 260),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE5E1D6)),
              ),
              clipBehavior: Clip.antiAlias,
              child: hasImages
                  ? Column(
                      children: [
                        SizedBox(
                          height: 260,
                          width: double.infinity,
                          child: Image.file(
                            File(_selectedImages.first.path),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const Icon(Icons.photo_library_outlined),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'تم اختيار ${_selectedImages.length} صورة',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => setState(
                                  () => _selectedImages = [],
                                ),
                                child: const Text('مسح'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 82,
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: _pickImages,
                      child: const Padding(
                        padding: EdgeInsets.all(28),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 64,
                              color: Color(0xFF737A5B),
                            ),
                            SizedBox(height: 18),
                            Text(
                              'أضف صور المنتجات',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'اختر صورة واحدة أو مجموعة صور من المعرض',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.photo_library_outlined),
              label: Text(
                hasImages ? 'إضافة صور / تغيير المجموعة' : 'اختيار الصور',
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                foregroundColor: const Color(0xFF454D2F),
                side: const BorderSide(color: Color(0xFF9BA184)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: hasImages ? _showEngineNotReady : null,
              icon: const Icon(Icons.auto_fix_high_rounded),
              label: Text(
                hasImages
                    ? 'إزالة الخلفية من ${_selectedImages.length} صورة'
                    : 'إزالة الخلفية',
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lock_outline_rounded, size: 19),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ستبقى الصور الأصلية كما هي. حفظ النتائج ومعالجة الدفعات سيُفعّلان بعد ربط محرك الإزالة.',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
