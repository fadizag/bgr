import 'package:bgr/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows Arabic BGR home screen', (tester) async {
    await tester.pumpWidget(const BgrApp());

    expect(find.text('BGR'), findsOneWidget);
    expect(find.text('خلي المنتج يبرز'), findsOneWidget);
    expect(find.text('إزالة الخلفية'), findsOneWidget);
    expect(find.text('اختيار من المعرض'), findsOneWidget);
  });
}
